/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-17 20:41:51
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-29 17:39:16
 * @FilePath: \handware\lib\config\config.h
 * @Description: 默认配置文件
 */
// config.h
#ifndef CONFIG_H
#define CONFIG_H


// MQTT 配置
#define MQTT_BROKER "mqtt.example.com"
#define MQTT_PORT 1883
#define MQTT_CLIENT_ID "esp32_client"
#define MQTT_USERNAME "mqtt_user"
#define MQTT_PASSWORD "mqtt_password"
#define MQTT_TOPIC "esp32/data"

// 其他设置
#define UPDATE_INTERVAL 60
#define SENSOR_PIN 4

// TCP服务器配置
#define SERVER_IP  "admcc.cn" // 替换为实际服务器IP
#define SERVER_PORT 8782             // 替换为实际端口

#endif // CONFIG_H