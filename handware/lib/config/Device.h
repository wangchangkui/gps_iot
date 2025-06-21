/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-17 20:44:23
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-17 20:46:20
 * @FilePath: \handware\lib\config\device.h
 * @Description: 获取设备唯一的id
 */
#ifndef DEVICE_H
#define DEVICE_H

#include <Arduino.h>
#include <WiFi.h>


/**
 * 获取设备唯一标识符
 */
uint64_t getDeviceID();


#endif