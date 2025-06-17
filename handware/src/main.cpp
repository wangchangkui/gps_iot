/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2024-11-27 21:58:30
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-17 15:10:45
 * @FilePath: \esp32demo\src\main.cpp
 * @Description: ESP32 GPS数据采集上传系统
 */

#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include "WiFiManager.h"


#define GPS_SERIAL Serial2 // 使用 Serial2 作为 GPS 串口
#define GPX_RX 16 // GPS 接收引脚
#define GPX_TX 17 // GPS 发送引脚
#define RESET_BTN_PIN 0    // 重置按钮引脚，使用GPIO0（通常是ESP32开发板上的BOOT按钮）
#define RESET_TIMEOUT 3000 // 长按重置时间（毫秒）
#define GPS_BAUDRATE 9600 // GPS 波特率


boolean isConfigMode = true;            // true=配置模式，false=正常工作模式
unsigned long lastReconnectAttempt = 0; // 上次重连时间
const int reconnectInterval = 30000;    // 自动重连间隔（毫秒）

WiFiManager wifiManager; // 实例化全局WiFi管理器对象


// JSON 转义函数
String escapeJson(const String &input) {
    String output;
    output.reserve(input.length() * 2); // 预留足够空间
    
    for (size_t i = 0; i < input.length(); ++i) {
        char c = input.charAt(i);
        switch (c) {
            case '\"': output += "\\\""; break;
            case '\\': output += "\\\\"; break;
            case '\b': output += "\\b"; break;
            case '\f': output += "\\f"; break;
            case '\n': output += "\\n"; break;
            case '\r': output += "\\r"; break;
            case '\t': output += "\\t"; break;
            default:
                if (c < ' ') {
                    // 忽略其他控制字符
                } else {
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
        http.begin(url+"/data/upload"); 

        http.addHeader("Content-Type", "application/json");
        String esData = escapeJson(data); // 转义 JSON 字符串
        // 创建 JSON 数据
        String jsonData = "{\"value\":\"" + esData + "\"}";
        Serial.println("发送数据: " + jsonData);
        // 发送 POST 请求
        int httpResponseCode = http.POST(jsonData);

        if (httpResponseCode > 0)
        {
            String response = http.getString();
           
            Serial.println("响应内容: " + response);
        }
        else
        {
            Serial.println("发送失败: " + String(httpResponseCode));
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



// 初始化设备
void setup()
{
    Serial.begin(115200);
    Serial.println("\n\n===== ESP32 GPS Device Start =====");

    // 初始化 GPS 串口
    GPS_SERIAL.begin(GPS_BAUDRATE, SERIAL_8N1, GPX_RX, GPX_TX);
    Serial.println("GPS Module Initialized");

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
    if (GPS_SERIAL.available() && !isConfigMode) // 仅在非配置模式下读取GPS数据
    {
        String gpsData = GPS_SERIAL.readStringUntil('\n');
        sendDataToServer(gpsData, wifiManager.getServerUrl());
        delay(1000); // 等待1秒
    }
}
