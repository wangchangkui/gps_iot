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
 * @brief 单独处理TCP连接（带重试机制）
 */
void connectTcp()
{

    // 配置AP
    String apnCommand = "AT+QICSGP=1,1,\"\",\"\",\"\"";
    sendATCommand(apnCommand.c_str());
    // 开启网络
    sendATCommand("AT+NETOPEN");
    String tcpCommand = "AT+CIPOPEN=0,\"TCP\",\"" + String(SERVER_IP) + "\"," + String(SERVER_PORT);
    // 处理TCP连接
    sendATCommand(tcpCommand.c_str());
}

/**
 * @brief 设置4G网络连接
 */
void setupNetwork()
{
    NET_4G_RX_TX.begin(MODEM_BAUD, SERIAL_8N1, GPX_RX, GPX_TX);

    // 断开之前的连接
    NET_4G_RX_TX.write("+++");
    sendATCommand("AT+QICLOSE=0", 1000, "OK"); // 关闭之前的TCP连接

    // 检查模块是否响应
    if (!sendATCommand("AT", 1000, "OK"))
    {
        Serial.println("[ERROR] 4G module not responding.");
     
    }

    // 关闭回显
    sendATCommand("ATE0", 1000, "OK");

    // 2. 设置APN
    String apnCommand = "AT+QICSGP=1,1,\"\",\"\",\"\"";
    sendATCommand(apnCommand.c_str(), 3000, "OK");

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
        delay(1000); // 等待2秒后重试
    }

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

    // 5. 建立TCP连接
    String tcpCommand = "AT+CIPOPEN=0,\"TCP\",\"" + String(SERVER_IP) + "\"," + String(SERVER_PORT);
    sendATCommand(tcpCommand.c_str(), 10000, "SUCCESS");
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
    delay(1000);    // 等待1秒
    setupNetwork(); // 重新设置网络
    Serial.println("Module reset complete.");
}