/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2024-11-27 21:58:30
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-29 21:17:48
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

// 定义网络信号状态灯，当网络连接时常亮，否则闪烁
#define LED_PIN 2 // LED引脚，通常是GPIO2

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
    pinMode(LED_PIN, OUTPUT); // 设置引脚为输出模式

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

    if (!net_work_is_tcp_connected())
    {
        // led 长亮
        digitalWrite(LED_PIN, HIGH); // 网络连接异常时LED常亮
    }


    // 读取GPS数据
    if (GPS_RX_TX.available())
    {
        // 给GPS数据一些累积时间
        delay(100);

        // 读取完整的NMEA语句
        String gpsData = "";
        while (GPS_RX_TX.available())
        {
            char c = GPS_RX_TX.read();
            if (c == '$') // NMEA语句始终以$开头
            {
                // 新语句开始，清空之前的数据
                gpsData = "$";
            }
            else if (gpsData.length() > 0) // 已经开始收集一条语句
            {
                gpsData += c;

                // 检查是否到了语句结尾（NMEA语句以\r\n结束）
                if (c == '\n' && gpsData.indexOf('\r') != -1)
                {
                    // 完整的NMEA语句已获取
                    gpsData.trim(); // 去除首尾空格和换行符

                    // 进行简单的数据有效性检查
                    if (gpsData.length() > 10 && gpsData.startsWith("$"))
                    {
                        // 添加设备ID并发送
                        String dataToSend = String(deviceID) + "," + gpsData;
                        // 使用正确的发送函数而不是直接写入串口
                        NET_4G_RX_TX.println(dataToSend);
                        Serial.print("Sending GPS Data: ");
                        Serial.println(dataToSend);
                        NET_4G_RX_TX.flush();
                        // 查看4G串口是否有回复数据
                        String response = "";
                        unsigned long startTime = millis();
                        while (millis() - startTime < 2000) // 等待2秒
                        {
                            if (NET_4G_RX_TX.available())
                            {
                                char responseChar = NET_4G_RX_TX.read();
                                response += responseChar;
                            }
                        }
                        if (response.length() > 0)
                        {
                            Serial.print("Response from 4G Module: ");
                            Serial.println(response);
                        }
                        // 当服务断开连接的时候 DISCONNECTED:0
                        if (response.indexOf("DISCONNECTED:0") != -1)
                        {
                            Serial.println("4G Module disconnected, attempting to reconnect...");
                            // 重新连接网络
                            resetMoudule();
                        }

                    }

                    // 重置，准备接收下一条语句
                    gpsData = "";
                    break;
                }
            }
        }
    }
}
