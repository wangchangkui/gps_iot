/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-22 10:36:45
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-15 16:43:02
 * @FilePath: \handware\lib\Network\NetWork.cpp
 * @Description: 网络模块实现 1，连接MQTT 2，发送数据 3，重启设备
 */
#include "NetWork.h"

boolean isTcpConnected = false; // TCP连接状态

int SEND_FAIL_COUNT = 0; // 发送失败次数

bool AT_CMD(String data, char *keyword, int num)
{
    while (NET_4G_RX_TX.available())
        NET_4G_RX_TX.read();
    Serial.println("AT: " + data); // 发送AT指令
    int i = 0;
    char inchar;
    char UNO_RECV[256] = {0};
    NET_4G_RX_TX.write(data.c_str()); // 发送AT指令
    num = num / 10;

    while (num--)
    {

        delay(10);
        while (NET_4G_RX_TX.available())
        {
            UNO_RECV[i++] = NET_4G_RX_TX.read();
            Serial.print(UNO_RECV[i]);
        }

        if (strstr(UNO_RECV, keyword) != NULL)
        {
            while (NET_4G_RX_TX.available())
                NET_4G_RX_TX.read();
            Serial.println("true\r\n");
            return true;
        }
    }
    return false;
}

/**
 * 向 4G 模块发送 AT 命令并等待响应
 * @param command AT 命令
 * @param timeout 超时时间(ms)
 * @param expected_reply 期望的回复(默认为 "OK")
 * @return true:命令成功执行, false:命令执行失败
 */
bool sendATCommand(const char *command, unsigned long timeout, const char *expected_reply)
{
    // 先清空缓冲区
    while (NET_4G_RX_TX.available())
        NET_4G_RX_TX.read();

    NET_4G_RX_TX.write(command);
    NET_4G_RX_TX.write("\r\n");
    Serial.printf("[AT] SEND: %s\r\n", command);

    String response;
    unsigned long start = millis();
    unsigned long last_data_time = millis();

    while (millis() - start < timeout)
    {
        if (NET_4G_RX_TX.available())
        {
            char c = NET_4G_RX_TX.read();
            last_data_time = millis();
            response += c;

            if (response.indexOf(expected_reply) != -1)
            {
                Serial.printf("[AT] RECV: %s\n", response.c_str());
                return true;
            }
        }
        // 可选：若超过 500ms 没有新数据则提前结束
        if (millis() - last_data_time > 500)
        {
            break;
        }
    }

    if (!response.isEmpty())
    {
        Serial.printf("[AT] RECV: %s\n", response.c_str());
    }

    return strlen(expected_reply) == 0 ? true : response.indexOf(expected_reply) != -1;
}

/**
 * 发送 AT 命令，支持匹配多个预期关键字
 * @param command AT 命令
 * @param timeout 超时时间 (ms)
 * @param expected_reply 关键字数组
 * @param expected_count 关键字个数
 */
bool sendATCommandMatchAny(const char *command, unsigned long timeout, const char *expected_reply[], size_t expected_count)
{
    // 清空缓冲区
    while (NET_4G_RX_TX.available())
    {
        NET_4G_RX_TX.read();
    }

    NET_4G_RX_TX.write(command);
    NET_4G_RX_TX.write("\r\n");
    Serial.printf("[AT TX] %s\r\n", command);

    String response;
    unsigned long start = millis();
    unsigned long last_data_time = millis();

    while (millis() - start < timeout)
    {
        if (NET_4G_RX_TX.available())
        {
            char c = NET_4G_RX_TX.read();
            last_data_time = millis();
            response += c;

            // 检查所有关键字
            for (size_t i = 0; i < expected_count; i++)
            {
                if (response.indexOf(expected_reply[i]) != -1)
                {
                    Serial.printf("[AT] RECV: %s\n", response.c_str());
                    return true;
                }
            }
        }

        if (millis() - last_data_time > 500)
        {
            break;
        }
    }

    if (!response.isEmpty())
    {
        Serial.printf("[AT] RECV: %s\n", response.c_str());
    }

    return false;
}

/**
 * @brief 发送数据到服务器
 * @param data 要发送的数据
 * @return 发送成功返回true，失败返回false
 */
bool sendDataToServer(const String &data)
{
    int dataLen = data.length();

    // 2. 发送数据长度声明
    String sendCmd = "AT+CIPSEND=1," + String(dataLen);
    if (!sendATCommand(sendCmd.c_str(), 3000, ">"))
    {
        Serial.println("Failed to enter data mode");
        return false;
    }

    // 3. 发送实际数据
    NET_4G_RX_TX.print(data); // 直接发送字符串
    delay(500);               // 确保数据完整发送

    // 4. 检查发送结果
    if (sendATCommand("", 3000, "SUCCESS"))
    { // 空指令检查响应
        Serial.println("Data sent successfully");
        return true;
    }
    else
    {
        Serial.println("Data send failed");
        return false;
    }
}

/**
 * @brief 设置4G网络连接
 */
void setupNetwork()
{
    NET_4G_RX_TX.begin(MODEM_BAUD, SERIAL_8N1, GPX_RX, GPX_TX);
    Serial.println("[4G] Initializing network...");
    // 检查模块是否响应
    closeMqttConnection(); // 确保之前的连接被关闭
    delay(1500);
    // 1. 检查模块是否响应联网
    // 获取ICCD
    while (!sendATCommand("AT+ICCID", 2000, "ICCID:"))
    {
        delay(1000); // 等待500毫秒
    };

    // 设置APN
    while (!sendATCommand("AT+QICSGP=1,1,\"\",\"\",\"\"", 5000, "OK"))
    {
        delay(500); // 等待500毫秒
        /* code */
        Serial1.println("QICSGP Loading, ...");
    }

    // 检查网络
    const char *AT_NETOPEN = "AT+NETOPEN";

    int retryCount = 0;
    while (!sendATCommand(AT_NETOPEN, 7000, "NETOPEN:SUCCESS"))
    {
        retryCount++;
        delay(2000); // 等待1秒
        if (sendATCommand(AT_NETOPEN, 7000, "ERROR: 902"))
        {
            delay(500);
            break;
        }
        Serial.println("AT+NETOPEN Loading, current retry count: " + String(retryCount));
        // 如果重试次数超过15次，则重启设备

        if (retryCount > 15)
        {
            // 重启模块ss
            // sendATCommand("AT+RESET", 5000, "OK");
            delay(3000);
            ESP.restart(); // 重启设备
        }
    }
    isTcpConnected = true; // 连接成功
    startMQTT();
    delay(1000);
}

void startMQTT()
{
    // 检查MQTT是否以及连接
    if (sendATCommand("AT+MQTTSTATU", 3000, " +MQTTSTATU: 0"))
    {
        // 配置MQTT客户端
        connectToMQTTClient();
        // 配置MQTT服务器
        connectToMQTTServer();
        // 连接MQTT服务器
        connectMqtt();
        // 订阅MQTT主题
        subScribeMqttTopic();
    }
}

void connectToMQTTClient()
{
    uint64_t deviceID = getDeviceID(); // 获取设备唯一标识符
    // 添加客户段id
    String client_id = String(deviceID);
    // 构建AT+MCONFIG命令
    String configCmd = "AT+MCONFIG=";

    // 添加客户端ID (必须)
    configCmd += "\"" + client_id + "\"";

    // 添加用户名和密码 (可选)
    if (strlen(MQTT_USERNAME) > 0)
    {
        configCmd += ",\"" + String(MQTT_USERNAME) + "\"";
        configCmd += ",\"" + String(MQTT_PASSWORD) + "\"";
    }
    else
    {
        configCmd += ",,"; // 空用户名和密码
    }
    // 添加连接质量
    configCmd += ",0,0,0,1883,2025";
    sendATCommand(configCmd.c_str(), 3000, "OK");
}

void connectToMQTTServer()
{
    String cmd = "AT+MIPSTART=\"" + String(MQTT_BROKER) + "\"," + String(MQTT_PORT) + "";
    int retryCount = 0;
    while (!sendATCommand(cmd.c_str(), 5000, "MIPSTART: SUCCESS"))
    {
        retryCount++;
        delay(2000); // 等待2秒
        Serial.println("[MQTT]  start, loding...");
        // 如果重试次数超过5次，则重启设备
        if (retryCount > 5)
        {
            return;
        }
    }

    Serial.println("[MQTT]  server config successfully.");
}

void connectMqtt()
{
    // 设置服务器地址和端口 持久会话/临时会话 并且 心跳机制为30s
    int count = 0;
    while (!sendATCommand("AT+MCONNECT=1,30", 5000, "OK"))
    {
        count++;
        delay(2000);
        Serial.println("[MQTT]  start, loding...");
        if (count > 5)
        {
            return;
        }
    }

    Serial.println("[MQTT]  connect successfully.");
}

void subScribeMqttTopic()
{

    // 订阅主题
    String serverCmd = "AT+MSUB=\"" + String(MQTT_SUB_TOPIC) + "\",1";
    sendATCommand(serverCmd.c_str(), 3000, "MSUB: SUCCESS");
}

String base64Encode(const String &input)
{
    return base64::encode(input);
}

void publishMqttMessage(const String &message)
{
    // 发布消息 AT+MPUB=<topic>,<qos>,<retain>,<message>
    String serverCmd = "AT+MPUB=\"" + String(MQTT_TOPIC) + "\""
                                                           ",1" +
                       ",0," + "\"" + message + "\"";
    if (sendATCommand(serverCmd.c_str(), 3000, "MPUB: SUCCESS"))
    {
        Serial.println("[MQTT]  publish message successfully: " + message);
        SEND_FAIL_COUNT = 0; // 重置发送失败计数
        return;
    }
    else
    {
        Serial.println("[MQTT]  publish message failed: " + message);
        SEND_FAIL_COUNT++;
        // 3次发送失败后重置模块
        if (SEND_FAIL_COUNT > 3)
        {
            Serial.println("[MQTT]  publish message failed more than 3 times, resetting module...");
            resetMoudule(); // 重置模块
        }
    }
}

void closeMqttConnection()
{
    sendATCommand("AT+MDISCONN", 1500, "MDISCONNECT:");
    // 关闭MQTT连接
    sendATCommand("AT+MIPSTOP", 1500, "MIPCLOSE:");
}

boolean net_work_is_tcp_connected()
{
    return isTcpConnected;
}

void resetMoudule()
{
    Serial.println("Resetting module...");
    delay(1000);    // 等待1秒
    setupNetwork(); // 重新设置网络
    Serial.println("Module reset complete.");
}