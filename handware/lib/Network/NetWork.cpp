/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-22 10:36:45
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-13 15:15:20
 * @FilePath: \handware\lib\Network\NetWork.cpp
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
#include "NetWork.h"



boolean isTcpConnected = false; // TCP连接状态

/**
 * 向 4G 模块发送 AT 命令并等待响应
 * @param command AT 命令
 * @param timeout 超时时间(ms)
 * @param expected_reply 期望的回复(默认为 "OK")
 * @return true:命令成功执行, false:命令执行失败
 */
bool sendATCommand(const char *command, unsigned long timeout, const char *expected_reply)
{
    // 发送指令（添加明确的回车换行）
    NET_4G_RX_TX.print(command);
    NET_4G_RX_TX.print("\r"); // 确保发送完整AT指令格式
    Serial.printf("[AT] SEND: %s%c", command, '\n');
    String response;
    unsigned long start = millis();
    bool found = false;
    // 增强型响应接收逻辑
    while (millis() - start < timeout)
    {
        while (NET_4G_RX_TX.available())
        {
            char c = NET_4G_RX_TX.read();

            // 过滤无效字符
            if (c == '\0' || c == 255)
                continue;

            response += c;

            // 实时检测响应结束标志
            if (response.endsWith("\r\n") ||
                response.endsWith(expected_reply) ||
                response.indexOf("ERROR") != -1)
            {
                found = true;
            }
        }

        // 收到完整响应后额外等待50ms确保数据完整
        if (found && (millis() - start > timeout / 2))
        {
            delay(50);
            break;
        }
    }
    // 规范化输出（去除多余空行）
    response.trim();
    if (response.length() > 0)
    {
        Serial.printf("[AT] RECV: %s\n", response.c_str());
    }
    // 多条件成功判断
    return (response.indexOf(expected_reply) != -1 ||
            (strcmp(expected_reply, "OK") != 0 && response.endsWith("OK\r\n")));
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
    if (!sendATCommand("AT", 1000, "OK"))
    {
        Serial.println("[ERROR] 4G module not responding.");
    }
    delay(100);

    // 关闭回显
    sendATCommand("ATE0", 1000, "OK");
    delay(100);

    sendATCommand("AT+CEREG=0", 1000, "OK"); // 禁用网络注册状态报告
    delay(100);

    // 2. 设置APN
    String apnCommand = "AT+QICSGP=1,1,\"\",\"\",\"\"";
    sendATCommand(apnCommand.c_str(), 3000, "OK");
    delay(100);

    // 设置TCP心跳间隔为60秒
    sendATCommand("AT+MCIPCFG=30", 3000, "OK");
    delay(100);

    int model_count = 0;
    while (model_count < 4)
    {
        // 开启透传模式
        if (sendATCommand("AT+CIPMODE=1", 1000, "OK"))
        {
            Serial.println("[4G] Transparent mode enabled.");
            break;
        }
        else
        {
            Serial.println("[ERROR] Failed to enable transparent mode. Retrying... ");
        }
        delay(1000); // 等待2秒后重试
        model_count += 1;
    }

    // 3. 开启移动网络
    int count = 0;
    while (count < 5)
    {
        if (sendATCommand("AT+NETOPEN", 5000, "SUCCESS") || sendATCommand("AT+NETOPEN", 5000, "902"))
        {
            break; // 成功开启网络
        }
        count++;
        Serial.printf("[4G] Attempt %d to open network failed, retrying...\n", count);
        delay(200); // 等待2秒后重试
    }
    // 再次检查
    if (!sendATCommand("AT+NETOPEN?", 5000, "1"))
    {
        Serial.println("[ERROR] Failed to open network after multiple attempts.");
        return;
    }
    else
    {
        Serial.println("[4G] Network opened successfully.");
    }
    isTcpConnected = true; // 连接成功

    startMQTT(); // 启动MQTT连接
}

void startMQTT(){
    
    // 配置MQTT客户端
    connectToMQTTClient();
    // 配置MQTT服务器
    connectToMQTTServer();
    // 连接MQTT服务器
    connectMqtt();
    // 订阅MQTT主题
    subScribeMqttTopic();
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
    sendATCommand(configCmd.c_str(), 3000,"OK");
}

void connectToMQTTServer()
{
    // 设置服务器地址和端口
    String serverCmd = "AT+MIPSTART=\"" + String(MQTT_BROKER) + "\"," + String(MQTT_PORT);
    if (sendATCommand(serverCmd.c_str(), 10000, "SUCCESS"))
    {
        Serial.println("[MQTT]  server config successfully.");
    }
    else
    {
        Serial.println("[MQTT] Failed set  server config.");
        isTcpConnected = false; // 设置TCP连接状态为false
    }
}


void connectMqtt(){
     // 设置服务器地址和端口 持久会话 并且 心跳机制为30s
    String serverCmd = "AT+MCONNECT=" + String(0) + "," + String(30);
    if (sendATCommand(serverCmd.c_str(), 10000, "SUCCESS"))
    {
        Serial.println("[MQTT] Connected  successfully.");
    }
    else
    {
        Serial.println("[MQTT] Failed to connect to server.");
        isTcpConnected = false; // 设置TCP连接状态为false
    }
}

void subScribeMqttTopic(){
    // 订阅主题
    String serverCmd = "AT+MSUB=\"" + String(MQTT_TOPIC) + "\",1";
    if (sendATCommand(serverCmd.c_str(), 10000, "SUCCESS"))
    {
        Serial.println("[MQTT]  scribe topic  successfully.");
    }
    else
    {
        Serial.println("[MQTT] Failed to scribe topic to server.");
        isTcpConnected = false; // 设置TCP连接状态为false
    }
}

String base64Encode(const String &input) {
 return base64::encode(input);
}


void publishMqttMessage(const String &message){
    // 发布消息 AT+MPUB=<topic>,<qos>,<retain>,<message>
    // 将数据转换为base64

    String encodedMessage = base64Encode(message);
    if (encodedMessage.isEmpty()) {
        Serial.println("[ERROR] Failed to encode message to Base64.");
        return;
    }
    String serverCmd = "AT+MPUB=\"" + String(MQTT_TOPIC) + "\",1"+ ",0," + encodedMessage;
    if (sendATCommand(serverCmd.c_str(), 10000, "SUCCESS"))
    {
        Serial.println("[MQTT]  publish message successfully.");
    }else{
        // 检查MQTT连接
        if(sendATCommand("AT+MQTTSTATU", 3000, "0")){
            isTcpConnected = false;
            // 释放MQTT资源
            // AT+MIPCLOSE
            sendATCommand("AT+MIPCLOSE", 3000, "SUCCESS");

            // 从新建立连接
            Serial.println("[MQTT] MQTT connection lost, attempting to reconnect...");
            resetMoudule();
        }

    }
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