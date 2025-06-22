
#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include "WiFiManager.h"
#include "Device.h"
unsigned long _lastReconnectAttempt = 0; // 上次重连时间
boolean _isConfigMode = true;            // true=配置模式，false=正常工作模式
const int _reconnectInterval = 30000;    // 自动重连间隔（毫秒）
uint64_t _deviceID = getDeviceID();      // 获取设备唯一标识符


// JSON 转义函数
String escapeJson(const String &input)
{
    String output;
    output.reserve(input.length() * 2); // 预留足够空间

    for (size_t i = 0; i < input.length(); ++i)
    {
        char c = input.charAt(i);
        switch (c)
        {
        case '\"':
            output += "\\\"";
            break;
        case '\\':
            output += "\\\\";
            break;
        case '\b':
            output += "\\b";
            break;
        case '\f':
            output += "\\f";
            break;
        case '\n':
            output += "\\n";
            break;
        case '\r':
            output += "\\r";
            break;
        case '\t':
            output += "\\t";
            break;
        default:
            if (c < ' ')
            {
                // 忽略其他控制字符
            }
            else
            {
                output += c;
            }
        }
    }
    return output;
}

// 发送数据到服务器
void sendDataToServer(String data, String url)
{
    // 检查 WiFi 是否连接
    if (WiFi.status() == WL_CONNECTED)
    {
        HTTPClient http;

        // 配置请求
        http.begin(url + "/data/upload");

        http.addHeader("Content-Type", "application/json");
        String esData = escapeJson(data); // 转义 JSON 字符串
        // 创建 JSON 数据
        String jsonData = "{\"value\":\"" + esData + "\", \"deviceId\":\"" + String(_deviceID) + "\"}";
        Serial.println("发送数据: " + jsonData);
        // 发送 POST 请求
        int httpResponseCode = http.POST(jsonData);

        if (httpResponseCode > 0)
        {
            String response = http.getString();
        }
        http.end();
    }
    else if (!_isConfigMode)
    {
        // 如果是正常模式但WiFi断开，尝试重连
        unsigned long currentTime = millis();
        if (currentTime - _lastReconnectAttempt > _reconnectInterval)
        {
            _lastReconnectAttempt = currentTime;
            Serial.println("WiFi断开，尝试重连...");
            wifiManager.reconnectWifi();
        }
    }
}