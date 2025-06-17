/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-16 10:15:30
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-15 16:07:47
 * @FilePath: \esp32demo\include\wifi_manager\WiFiManager.h
 * @Description: WiFi管理器头文件
 */

#ifndef WIFI_MANAGER_H
#define WIFI_MANAGER_H

#include <Arduino.h>
#include <WiFi.h>
#include <WebServer.h>
#include <EEPROM.h>

// 配置结构体
struct WiFiConfig {
    char wifi_ssid[32];
    char wifi_password[32];
    char server_url[128] = "http://admcc.cn/api"; // 默认服务器地址
};



class WiFiManager {
public:
    // 构造函数
    WiFiManager();
    
    // 初始化WiFi管理器
    void begin(int resetBtnPin = 0, int resetTimeout = 3000);
    
    // 处理WiFi管理器任务，需要在loop中调用
    void handle();
    
    // 获取当前模式
    bool isConfigMode() { return _isConfigMode; }
    
    // 获取服务器地址
    String getServerUrl() { return String(_config.server_url); }
    
    // 获取WiFi连接状态
    bool isConnected() { return WiFi.status() == WL_CONNECTED; }
    
    // 清除WiFi配置
    void clearConfig();
    
    // 手动重连WiFi
    bool reconnectWifi();
    
    // 获取WebServer实例
    WebServer* getWebServer() { return &_server; }



    const char* getHtmlPage() {
        return _htmlTemplate;
    }

private:
    // 内部方法
    bool _loadConfig();
    bool _saveConfig();
    bool _connectToWifi();
    bool _isConfigValid();
    void _setupWebServer();
    void _handleRoot();
    void _handleScanWifi();
    void _handleSave();    // 内部变量
    WiFiConfig _config;
    WebServer _server;
    bool _isConfigMode;
    int _resetBtnPin;
    int _resetTimeout;
    unsigned long _lastReconnectAttempt;
    unsigned long _scheduledConnectAttempt;  // 新增：延迟连接尝试的时间戳
    bool _hasPendingConnect;                // 新增：是否有待处理的连接请求
    String _defaultServerUrl;               // 默认服务器地址
    const int _reconnectInterval = 30000;
    const char* _apName = "GPS_CONFIG";
    const char* _apPassword = "12345678";
    // HTML页面模板
    const char* _htmlTemplate;

};

extern WiFiManager wifiManager;

#endif // WIFI_MANAGER_H
