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

    // 清理接收缓冲区
    while (NET_4G_RX_TX.available())
    {
        NET_4G_RX_TX.read();
    }
    // 发送指令（添加明确的回车换行）
    NET_4G_RX_TX.print(command);
    NET_4G_RX_TX.print("\r"); // 确保发送完整AT指令格式
    Serial.printf("[AT] SEND: %s\r\n", command);
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
bool sendDataToServer(const String &data) {
    
    Serial.println("Sending data: " + data);
    // 发送数据
    NET_4G_RX_TX.print(data);
    return true;
}

/**
 * @brief 单独处理TCP连接（带重试机制）
 */
void connectTcp(){
    String tcpCommand = "AT+CIPOPEN=0,\"TCP\",\"" + String(SERVER_IP) + "\"," + String(SERVER_PORT);
     // 单独处理TCP连接（带重试机制）
    for(int retry=0; retry<3; retry++) {
        if(sendATCommand(tcpCommand.c_str(), MODEM_TIMEOUT, ">")) {
            Serial.println("TCP connection established");
            isTcpConnected = true;

            break;
        }
        delay(1000);
        Serial.println("TCP connect retrying...");
    }
    if (!isTcpConnected)
    {
        Serial.println("[ERROR] Failed to establish TCP connection");
        return;
    }
}


/**
 * @brief 设置4G网络连接
 */
void setupNetwork()
{
    NET_4G_RX_TX.begin(MODEM_BAUD, SERIAL_8N1, GPX_RX, GPX_TX);
    delay(1000); // 等待4G模块稳定
    const char *initSequence[] = {
        "AT",                           // 基础测试
        "ATE0",                         // 关闭回显
        "ATI",                          // 查询模块信息
        "AT+ICCID",                     // 查询SIM卡ICCID
        "AT+CPIN?",                     // SIM卡状态
        "AT+CSQ",                       // 信号质量
        "AT+COPS?",                     // 运营商信息
        "AT+QICSGP=1,1,\"\",\"\",\"\"", // APN设置
        "AT+CIPMODE=1",                 // 设置为数据模式
        "AT+CIPMODE?",                  // 数据模式查询
        "AT+NETOPEN",                   // 开启网络
        "AT+NETOPEN?",                  // 网络状态查询
        "AT+IPADDR",                    // 获取IP地址
        NULL                            // 结束标志
    };


    const char *expSequence[] = {
        "OK",                           // 基础测试
        "OK",                         // 关闭回显
        "OK",                          // 查询模块信息
        "OK",                     // 查询SIM卡ICCID
        "OK",                     // SIM卡状态
        "OK",                       // 信号质量
        "OK",                     // 运营商信息
        "OK", // APN设置
        "OK",                 // 设置为数据模式
        "OK",                  // 数据模式查询
        "SUCCESS",                   // 开启网络
        "OK",                  // 网络状态查询
        "OK",                    // 获取IP地址
        NULL                            // 结束标志
    };


    


    for (int i = 0; initSequence[i]; i++)
    {
        // 跳过第8条网络开启指令 应为有可能会是ERROR: 902 902的含义是已经开启过了网络服务
        if (!sendATCommand(initSequence[i],MODEM_TIMEOUT,expSequence[i]) && i != 8)
        {
            Serial.printf("Init failed at step %d\n", i);
            break;
        }
        delay(200); // 指令间间隔
    }

    connectTcp();
}




/**
 * 安全读取4G模块数据（非阻塞式）
 */
void pollModemData()
{
    static String buffer;

    while (NET_4G_RX_TX.available())
    {
        char c = NET_4G_RX_TX.read();

        // 过滤控制字符
        if (c == '\0' || c == 255)
            continue;

        buffer += c;

        // 检测到完整行
        if (c == '\n')
        {
            buffer.trim();
            if (buffer.length() > 0)
            {
                Serial.printf("[4G] %s\n", buffer.c_str());

                // 这里添加业务逻辑处理
                if (buffer.startsWith("+CIPRXGET"))
                {
                    // 处理TCP数据示例
                }
            }
            buffer = "";
        }
    }

    // 防止缓冲区累积
    if (buffer.length() > 512)
    {
        Serial.println("[WARN] Buffer overflow cleared");
        buffer = "";
    }
}


boolean net_work_is_tcp_connected()
{
    return isTcpConnected;
}


void resetMoudule()
{
    Serial.println("Resetting module...");
    NET_4G_RX_TX.print("AT+RESET");
    delay(1000);        // 等待1秒
    setupNetwork();     // 重新设置网络
    Serial.println("Module reset complete.");
}