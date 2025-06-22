#ifndef NETWORK_H
#define NETWORK_H

// 4G 模块串口配置,定义虚拟串口
#define NET_4G_RX_TX Serial2 // 使用 Serial2 作为 4G模块 串口
#define GPX_RX 16            // 4G模块 接收引脚
#define GPX_TX 17            // 4G模块 发送引脚
#define MODEM_BAUD 115200          // 4G模块波特率


// TCP服务器配置
const char *SERVER_IP = "47.109.129.174"; // 替换为实际服务器IP
const int SERVER_PORT = 8782;             // 替换为实际端口
#define MODEM_TIMEOUT 10000               // AT指令超时时间（毫秒）


#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include "WiFiManager.h"
#include "SoftwareSerial.h"
#include "Device.h"



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



#endif