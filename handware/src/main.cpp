/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2024-11-27 21:58:30
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-22 10:38:18
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
#define GPX_RX 16            // 4G模块 接收引脚
#define GPX_TX 17            // 4G模块 发送引脚

const int8_t G_RXD = 32;           // GPS 接收引脚
const int8_t G_TXD = 33;           // GPS 发送引脚
#define MODEM_BAUD 115200          // 4G模块波特率
EspSoftwareSerial::UART GPS_RX_TX; // GPS数据的收发

#define RESET_BTN_PIN 0    // 重置按钮引脚，使用GPIO0（通常是ESP32开发板上的BOOT按钮）
#define RESET_TIMEOUT 3000 // 长按重置时间（毫秒）
#define GPS_BAUDRATE 9600  // GPS 波特率

WiFiManager wifiManager;                // 实例化全局WiFi管理器对象
uint64_t deviceID = getDeviceID();      // 获取设备唯一标识符

// TCP服务器配置
const char *SERVER_IP = "47.109.129.174"; // 替换为实际服务器IP
const int SERVER_PORT = 8782;             // 替换为实际端口
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




/**
 * 向 4G 模块发送 AT 命令并等待响应
 * @param command AT 命令
 * @param timeout 超时时间(ms)
 * @param expected_reply 期望的回复(默认为 "OK")
 * @return true:命令成功执行, false:命令执行失败
 */
bool sendATCommand(const char *command, unsigned long timeout, const char *expected_reply)
{
    Serial.print("Sending AT command: ");
    Serial.print(command);
    Serial.print(" with expected reply: ");
    Serial.print(expected_reply);
    Serial.print(" and timeout: ");
    Serial.println(timeout);
    String response = ""; // 用于存储响应

    NET_4G_RX_TX.println(command);

    unsigned long startTime = millis();
    bool responseReceived = false;

    // 清除之前可能残留的数据
    while (NET_4G_RX_TX.available())
    {
        NET_4G_RX_TX.read();
    }

    delay(100); // 给模块一点响应时间

    // 读取所有响应，直到超时
    while (millis() - startTime < timeout)
    {
        if (NET_4G_RX_TX.available())
        {
            responseReceived = true;
            char c = NET_4G_RX_TX.read();
            response += c;

            // 如果收到完整响应（通常以OK或ERROR结尾），可以提前退出
            if (response.endsWith(expected_reply) ||
                response.endsWith("OK\r\n") ||
                response.endsWith("ERROR\r\n"))
            {
                break;
            }
        }

        // 如果有数据但暂时没有更多数据，等待一小段时间
        if (responseReceived && !NET_4G_RX_TX.available())
        {
            delay(50);
            // 如果等待后仍无数据，认为响应结束
            if (!NET_4G_RX_TX.available())
            {
                break;
            }
        }
    }

    // 打印完整响应
    if (response.length() > 0)
    {
        Serial.println("Modem Response:");
        Serial.println(response);
    }
    else
    {
        Serial.println("No response from modem");
    }

    // 检查是否收到期望的回复
    if (response.indexOf(expected_reply) >= 0 || response.indexOf("OK") >= 0)
    {
        return true;
    }

    return false;
}

/**
 * @brief 设置4G网络连接
 */
void setupNetwork()
{
    sendATCommand("AT");       // 测试
    sendATCommand("ATE0");     // 检查SIM卡状态
    sendATCommand("ATI");      // 查询模块信息
    sendATCommand("AT+ICCID"); // 查询SIM卡ICCID
    sendATCommand("AT+QICSGP=1,1,\"\",\"\",\"\""); // 开启APN
    sendATCommand("AT+NETOPEN"); // 打开网络连接
    sendATCommand("AT+NETOPEN?"); // 查询网络是否连接
    sendATCommand("AT+QNTP=1,\"tms.dynamicode.com.cn\",123,1"); // 同步时间功能
}

// 初始化设备
void setup()
{
    Serial.begin(115200);
    Serial.println("\n\n===== ESP32 GPS Device Start =====");

    // 初始化 GPS 串口
    GPS_RX_TX.begin(GPS_BAUDRATE, EspSoftwareSerial::SWSERIAL_8N1, G_RXD, G_TXD);
    Serial.println("GPS Module Initialized");
    Serial.println("\n\n===== ESP32 4G Device Start =====");
    // 初始化 4G 模块串口
    delay(1000); // 等待GPS模块稳定
    NET_4G_RX_TX.begin(MODEM_BAUD, SERIAL_8N1, GPX_RX, GPX_TX);
    setupNetwork();

    // 设置重置按钮为输入上拉模式
    wifiManager.begin(RESET_BTN_PIN, RESET_TIMEOUT); // 初始化WiFi管理器，设置重置按钮引脚和超时时间
    Serial.println("WiFi Manager Initialized");
}

// 主循环
void loop()
{
    // 始终处理Web服务器请求（无论是配置模式还是正常模式）
    wifiManager.handle(); // 处理WiFi管理器的Web请求

    // 等待1秒
    delay(1000);

    // 读取4G模块数据并上传
    if (NET_4G_RX_TX.available()) // 仅在非配置模式下读取4G模块数据
    {
        String modemData = NET_4G_RX_TX.readStringUntil('\n');
        Serial.print("Modem Data: ");
        Serial.println(modemData);
    }
}
