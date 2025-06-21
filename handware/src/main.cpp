/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2024-11-27 21:58:30
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-21 23:00:35
 * @FilePath: \esp32demo\src\main.cpp
 * @Description: ESP32 GPS数据采集上传系统
 */

#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include "WiFiManager.h"
#include "SoftwareSerial.h"
#include "Device.h"

// 4G 模块串口配置,定义虚拟串口


#define NET_4G_RX_TX Serial2 // 使用 Serial2 作为 4G模块 串口
#define GPX_RX 16          // 4G模块 接收引脚
#define GPX_TX 17          // 4G模块 发送引脚


const int8_t G_RXD = 32;  // GPS 接收引脚
const int8_t G_TXD = 33;  // GPS 发送引脚
#define MODEM_BAUD 115200 // 4G模块波特率
EspSoftwareSerial::UART GPS_RX_TX; // GPS数据的收发


#define RESET_BTN_PIN 0    // 重置按钮引脚，使用GPIO0（通常是ESP32开发板上的BOOT按钮）
#define RESET_TIMEOUT 3000 // 长按重置时间（毫秒）
#define GPS_BAUDRATE 9600  // GPS 波特率

boolean isConfigMode = true;            // true=配置模式，false=正常工作模式
unsigned long lastReconnectAttempt = 0; // 上次重连时间
const int reconnectInterval = 30000;    // 自动重连间隔（毫秒）
WiFiManager wifiManager;                // 实例化全局WiFi管理器对象
uint64_t deviceID = getDeviceID();      // 获取设备唯一标识符

// TCP服务器配置
const char *SERVER_IP = "47.109.129.174"; // 替换为实际服务器IP
const int SERVER_PORT = 8782;             // 替换为实际端口
const int RETRY_DELAY = 5000;             // 失败重试间隔
const char *APN = "";                     // 替换为实际APN
#define MODEM_TIMEOUT 10000               // AT指令超时时间（毫秒）

/**
 * @brief 设置4G网络连接
 * 向 4G 模块发送 AT 命令并等待响应
 * @param command AT 命令
 * @param timeout 超时时间(ms)
 * @param expected_reply 期望的回复(默认为 "OK")
 * @return true:命令成功执行, false:命令执行失败
 */
bool sendATCommand(const char *command, unsigned long timeout = MODEM_TIMEOUT, const char *expected_reply = "OK");

/**
 * @brief 开启4G网口连接
 */
void setupNetwork();

// GPS数据缓存
String gpsData = "";
unsigned long lastGPSTime = 0;

// JSON 转义函数
String escapeJson(const String &input)
{
    String output;
    output.reserve(input.length() * 2); // 预留足够空间

    for (size_t i = 0; i < input.length(); ++i)
    {
        char c = input.charAt(i);
        switch (c)
        {
        case '\"':
            output += "\\\"";
            break;
        case '\\':
            output += "\\\\";
            break;
        case '\b':
            output += "\\b";
            break;
        case '\f':
            output += "\\f";
            break;
        case '\n':
            output += "\\n";
            break;
        case '\r':
            output += "\\r";
            break;
        case '\t':
            output += "\\t";
            break;
        default:
            if (c < ' ')
            {
                // 忽略其他控制字符
            }
            else
            {
                output += c;
            }
        }
    }
    return output;
}

// 发送数据到服务器
void sendDataToServer(String data, String url)
{
    // 检查 WiFi 是否连接
    if (WiFi.status() == WL_CONNECTED)
    {
        HTTPClient http;

        // 配置请求
        http.begin(url + "/data/upload");

        http.addHeader("Content-Type", "application/json");
        String esData = escapeJson(data); // 转义 JSON 字符串
        // 创建 JSON 数据
        String jsonData = "{\"value\":\"" + esData + "\", \"deviceId\":\"" + String(deviceID) + "\"}";
        Serial.println("发送数据: " + jsonData);
        // 发送 POST 请求
        int httpResponseCode = http.POST(jsonData);

        if (httpResponseCode > 0)
        {
            String response = http.getString();
        }
        http.end();
    }
    else if (!isConfigMode)
    {
        // 如果是正常模式但WiFi断开，尝试重连
        unsigned long currentTime = millis();
        if (currentTime - lastReconnectAttempt > reconnectInterval)
        {
            lastReconnectAttempt = currentTime;
            Serial.println("WiFi断开，尝试重连...");
            wifiManager.reconnectWifi();
        }
    }
}

/**
 * 向 4G 模块发送 AT 命令并等待响应
 * @param command AT 命令
 * @param timeout 超时时间(ms)
 * @param expected_reply 期望的回复(默认为 "OK")
 * @return true:命令成功执行, false:命令执行失败
 */
bool sendATCommand(const char *command, unsigned long timeout, const char *expected_reply)
{
    Serial.print("semd command: ");
    Serial.println(command);

    GPS_RX_TX.println(command);

    unsigned long start_time = millis();
    String response = "";

    // 等待并读取响应
    if (GPS_RX_TX.available())
    {
        char c = GPS_RX_TX.read();
        response += c;

        // 检查是否包含预期的回复
        if (response.indexOf(expected_reply) != -1)
        {
            Serial.print("recive: ");
            Serial.println(response);
            return true;
        }

        // 检查是否有错误回复
        if (response.indexOf("ERROR") != -1)
        {
            Serial.print("serror: ");
            Serial.println(response);
            return false;
        }
    }
    delay(100);
    return false;
}

/**
 * @brief 设置4G网络连接
 */
void setupNetwork()
{
    // Serial.println("正在初始化 4G 模块...");

    // delay(1000);

    // // 测试 AT 命令是否工作
    // if (!sendATCommand("AT", 3000))
    // {
    //     Serial.println("4G 模块不响应!");
    // }

    // // 检查 SIM 卡状态
    // if (!sendATCommand("AT+CPIN?", 5000, "READY"))
    // {
    //     Serial.println("SIM 卡不可用!");
    // }

    // // 等待网络注册
    // delay(2000);
    // if (!sendATCommand("AT+CREG?", 5000, "+CREG: 0,1"))
    // {
    //     Serial.println("网络注册失败!");
    // }

    // // 配置 APN
    // char apn_cmd[100];
    // snprintf(apn_cmd, sizeof(apn_cmd), "AT+QICSGP=1,1,\"%s\",\"%s\",\"%s\"", APN, "", "");
    // if (!sendATCommand(apn_cmd, 5000))
    // {
    //     Serial.println("APN 配置失败!");
    // }

    // // 开启移动网络连接
    // if (!sendATCommand("AT+NETOPEN", 10000))
    // {
    //     Serial.println("网络连接失败!");
    // }

    // // 查询网络状态
    // if (!sendATCommand("AT+NETOPEN?", 5000, "+NETOPEN: 1"))
    // {
    //     Serial.println("网络连接未成功!");
    // }

    // // 获取分配的 IP 地址
    // sendATCommand("AT+IPADDR", 5000);

    // Serial.println("4G 网络连接成功!");
}

// 初始化设备
void setup()
{
    Serial.begin(115200);
    Serial.println("\n\n===== ESP32 GPS Device Start =====");

    //  确保串口输出稳定
    // delay(5000);

    // 初始化 GPS 串口
    // GPS_SERIAL.begin(GPS_BAUDRATE, SERIAL_8N1, GPX_RX, GPX_TX);
    GPS_RX_TX.begin(GPS_BAUDRATE,EspSoftwareSerial::SWSERIAL_8N1,G_RXD,G_TXD);
    Serial.println("GPS Module Initialized");


    // 初始化 4G 模块串口
    NET_4G_RX_TX.begin(MODEM_BAUD, SERIAL_8N1, GPX_RX, GPX_TX);
    // if (NET_4G_RX_TX)
    // {
        
    //     Serial.println("4G Module Serial Port Initialized");
    // }
    // else
    // {
    //     Serial.println("Failed to initialize 4G Module Serial Port");
    // }

    // 设置重置按钮为输入上拉模式
    wifiManager.begin(RESET_BTN_PIN, RESET_TIMEOUT); // 初始化WiFi管理器，设置重置按钮引脚和超时时间
    
}

// 主循环
void loop()
{
    // 始终处理Web服务器请求（无论是配置模式还是正常模式）
    // server.handleClient();
    wifiManager.handle(); // 处理WiFi管理器的Web请求
    // 检查是否处于配置模式
    isConfigMode = wifiManager.isConfigMode();

    // 读取GPS数据并上传
    if (GPS_RX_TX.available() && !isConfigMode) // 仅在非配置模式下读取GPS数据
    {
        String gpsData = GPS_RX_TX.readStringUntil('\n');
        Serial.print("GPS Data: ");
        Serial.println(gpsData);
        
    }

    // 读取4G模块数据并上传
    if (NET_4G_RX_TX.available() ) // 仅在非配置模式下读取4G模块数据
    {
        String modemData = NET_4G_RX_TX.readStringUntil('\n');
        Serial.print("Modem Data: ");
        Serial.println(modemData);
    }
    delay(5000); // 等待1秒


}
