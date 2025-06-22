/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2024-11-27 21:58:30
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-22 16:18:10
 * @FilePath: \esp32demo\src\main.cpp
 * @Description: ESP32 GPS数据采集上传系统
 */

#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include "WiFiManager.h"
#include "SoftwareSerial.h"
#include "Device.h"
#include "Network.h"

const int8_t G_RXD = 32;           // GPS 接收引脚
const int8_t G_TXD = 33;           // GPS 发送引脚
#define MODEM_BAUD 115200          // 4G模块波特率
EspSoftwareSerial::UART GPS_RX_TX; // GPS数据的收发

#define RESET_BTN_PIN 0    // 重置按钮引脚，使用GPIO0（通常是ESP32开发板上的BOOT按钮）
#define RESET_TIMEOUT 3000 // 长按重置时间（毫秒）
#define GPS_BAUDRATE 9600  // GPS 波特率

WiFiManager wifiManager;           // 实例化全局WiFi管理器对象
uint64_t deviceID = getDeviceID(); // 获取设备唯一标识符

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
    delay(1000); 
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

    // 读取GPS数据
    if (GPS_RX_TX.available())
    {
        String gpsData = GPS_RX_TX.readStringUntil('\n'); // 读取GPS数据直到换行符
        gpsData.trim();                                   // 去除首尾空格

        if (gpsData.length() > 0)
        {
               // 或设备ID，并且拼接到GPS数据前
                gpsData = String(deviceID) + "," + gpsData; // 将设备ID添加
                sendDataToServer(gpsData.c_str());
        }
    }
}
