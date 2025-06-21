/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-17 16:20:09
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-17 16:22:04
 * @FilePath: \handware\lib\MQTT\src\MQTTManager.cpp
 * @Description: MQTT管理器实现
 */
#include "MQTTManager.h"

// 构造函数
MQTTManager::MQTTManager() : _client(_wifiClient) {
    memset(&_config, 0, sizeof(MQTTConfig));
    
}