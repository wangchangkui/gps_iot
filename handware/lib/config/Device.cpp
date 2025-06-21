#include "device.h"


uint64_t getDeviceID() {
    // 获取设备唯一标识符
    uint64_t deviceID = 0;
    
    // 使用 ESP32 的 MAC 地址作为设备唯一标识符
    uint8_t mac[6];
    esp_read_mac(mac, ESP_MAC_WIFI_STA);
    
    // 将 MAC 地址转换为 64 位整数
    for (int i = 0; i < 6; i++) {
        deviceID |= ((uint64_t)mac[i] << (8 * (5 - i)));
    }
    
    return deviceID;
}