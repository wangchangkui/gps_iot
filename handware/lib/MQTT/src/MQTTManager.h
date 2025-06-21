#ifndef MQTT_MANAGER_H
#define MTQQ_MANAGER_H
#include <Arduino.h>
#include <PubSubClient.h>
#include <WiFi.h>

// MQTT配置结构体
struct MQTTConfig {
    char mqtt_server[64];
    int mqtt_port;
    char mqtt_user[32];
    char mqtt_password[32];
    char topic[64];
};

class MQTTManager {
public:
    // 构造函数
    MQTTManager();

    // 初始化MQTT管理器
    void begin(const char* server, int port, const char* user, const char* password, const char* topic);

    // 处理MQTT任务，需要在loop中调用
    void handle();

    // 发布消息
    bool publish(const char* message);

    // 订阅主题
    bool subscribe(const char* topic);

    // 获取连接状态
    bool isConnected() { return _client.connected(); }
    // 设置回调函数
    void setCallback(std::function<void(char*, uint8_t*, unsigned int)> callback) {
        _client.setCallback(callback);
    }
    // 获取MQTT配置
    MQTTConfig getConfig() {
        return _config;
    }
    // 清除MQTT配置
    void clearConfig() {
        memset(&_config, 0, sizeof(MQTTConfig));
    }
private:
    // 内部方法
    bool _loadConfig();
    bool _saveConfig();
    void _connectToMQTT();

    // MQTT客户端
    WiFiClient _wifiClient;
    PubSubClient _client;

    // MQTT配置
    MQTTConfig _config;

    // 回调函数
    std::function<void(char*, uint8_t*, unsigned int)> _callback;
};


#endif
