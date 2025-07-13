
#include "MQTTManager.h"

// 构造函数
MQTTManager::MQTTManager() : _client(_wifiClient) {
    memset(&_config, 0, sizeof(MQTTConfig));
    
}


// 初始化MQTT配置
void MQTTManager::begin(const char* server, int port, const char* user, const char* password, const char* topic) {
    strncpy(_config.mqtt_server, server, sizeof(_config.mqtt_server) - 1);
    _config.mqtt_port = port;
    strncpy(_config.mqtt_user, user, sizeof(_config.mqtt_user) - 1);
    strncpy(_config.mqtt_password, password, sizeof(_config.mqtt_password) - 1);
    strncpy(_config.topic, topic, sizeof(_config.topic) - 1);

    _client.setServer(_config.mqtt_server, _config.mqtt_port);
    _client.setCallback([this](char* topic, uint8_t* payload, unsigned int length) {
        if (_callback) {
            _callback(topic, payload, length);
        }
    });

    _connectToMQTT();

}

// 处理MQTT任务，需要在loop中调用
void MQTTManager::handle() {
    if (!_client.connected()) {
        _connectToMQTT();
    }
    _client.loop();
}

// 发布消息
bool MQTTManager::publish(const char* message) {
    if (!_client.connected()) {
        _connectToMQTT();
    }
    if (_client.publish(_config.topic, message)) {
        Serial.printf("Published message: %s to topic: %s\n", message, _config.topic);
        return true;
    } else {
        Serial.printf("Failed to publish message: %s to topic: %s\n", message, _config.topic);
        return false;
    }
}

// 订阅主题
bool MQTTManager::subscribe(const char* topic) {
    if (!_client.connected()) {
        _connectToMQTT();
    }
    if (_client.subscribe(topic)) {
        Serial.printf("Subscribed to topic: %s\n", topic);
        return true;
    } else {
        Serial.printf("Failed to subscribe to topic: %s\n", topic);
        return false;
    }
}

// 内部方法：连接到MQTT服务器
void MQTTManager::_connectToMQTT() {
    Serial.printf("Connecting to MQTT server: %s:%d\n", _config.mqtt_server, _config.mqtt_port);
    if (_client.connect(_config.mqtt_user, _config.mqtt_user, _config.mqtt_password)) {
        Serial.println("Connected to MQTT server");
        // 订阅主题
        if (_client.subscribe(_config.topic)) {
            Serial.printf("Subscribed to topic: %s\n", _config.topic);
        } else {
            Serial.printf("Failed to subscribe to topic: %s\n", _config.topic);
        }
    } else {
        Serial.printf("Failed to connect to MQTT server: %s:%d, state: %d\n", _config.mqtt_server, _config.mqtt_port, _client.state());
    }
}
// 获取MQTT配置
MQTTConfig MQTTManager::getConfig() {
    return _config;
}

// 清除MQTT配置
void MQTTManager::clearConfig() {
    memset(&_config, 0, sizeof(MQTTConfig));
    Serial.println("MQTT configuration cleared.");
    // 断开连接

    _client.disconnect();
    Serial.println("Disconnected from MQTT server.");
}

// 加载配置（如果需要，可以实现从EEPROM或文件加载）
bool MQTTManager::_loadConfig() {
    // 这里可以实现从EEPROM或文件加载配置
    // 目前返回true表示加载成功
    Serial.println("Loading MQTT configuration...");
    // 假设加载成功
    return true;
}
// 保存配置（如果需要，可以实现保存到EEPROM或文件）
bool MQTTManager::_saveConfig() {
    // 这里可以实现保存配置到EEPROM或文件
    Serial.println("Saving MQTT configuration...");
    // 假设保存成功
    return true;
}
// 设置回调函数
void MQTTManager::setCallback(std::function<void(char*, uint8_t*, unsigned int)> callback) {
    _callback = callback;
    _client.setCallback([this](char* topic, uint8_t* payload, unsigned int length) {
        if (_callback) {
            _callback(topic, payload, length);
        }
    });
    Serial.println("MQTT callback function set.");
}
// 获取连接状态
bool MQTTManager::isConnected() {
    return _client.connected();
}
