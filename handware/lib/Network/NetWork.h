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
#include <base64.h>




/**
 * @brief 发送命令
 */
bool AT_CMD(String data,char * keyword ,int num);

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
 * * @brief 发送 AT 命令，支持匹配多个预期关键字
 * @param command AT 命令
 *
 * @param timeout 超时时间 (ms)
 * @param expected_reply 期望的回复数组
 * @param expected_count 期望回复的数量
 * @return true:命令成功执行, false:命令执行失败
 */
bool sendATCommandMatchAny(const char *command, unsigned long timeout, const char *expected_reply[], size_t expected_count);
/**
 * @brief 开启4G网口连接
 */
void setupNetwork();


/**
 * 获取TCP连接状态
 * @return true:TCP已连接, false:TCP未连接
 */
boolean net_work_is_tcp_connected();


/**
 * 重启设备
 */
void resetMoudule();


/**
 * 建立MQTT客户端
 */
void connectToMQTTClient();

/**
 * 建立MQTTServer
 */
void connectToMQTTServer();


/**
 * 发送MQTT连接
 */
void connectMqtt();


/**
 * 订阅主题
 */
void subScribeMqttTopic();


/**
 * 启动MQTT
 */
void startMQTT();
/**
 * 发布MQTT消息
 */
void publishMqttMessage(const String &message);


/**
 * @brief 关闭MQTT连接
 * 释放MQTT资源
 */
void closeMqttConnection();
#endif