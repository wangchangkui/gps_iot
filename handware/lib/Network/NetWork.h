#ifndef NETWORK_H
#define NETWORK_H

// 4G 模块串口配置,定义虚拟串口
#define NET_4G_RX_TX Serial2 // 使用 Serial2 作为 4G模块 串口
#define GPX_RX 16            // 4G模块 接收引脚
#define GPX_TX 17            // 4G模块 发送引脚
#define MODEM_BAUD 115200          // 4G模块波特率
#define MODEM_TIMEOUT 3000               // AT指令超时时间（毫秒）


#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include "WiFiManager.h"
#include "SoftwareSerial.h"
#include "Device.h"
#include "Config.h"




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
 * 安全读取4G模块数据（非阻塞式）
 */
void pollModemData(); 


/**
 * @brief 发送数据到服务器
 * @param data 要发送的数据
 * @return 发送成功返回true，失败返回false
 */
bool sendDataToServer(const String &data);



/**
 * 获取TCP连接状态
 * @return true:TCP已连接, false:TCP未连接
 */
boolean net_work_is_tcp_connected();


/**
 * tcp 重新连接
 */
void connectTcp();


/**
 * 重启设备
 */
void resetMoudule();
#endif