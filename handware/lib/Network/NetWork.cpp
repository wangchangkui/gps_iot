#include "NetWork.h"

/**
 * 向 4G 模块发送 AT 命令并等待响应
 * @param command AT 命令
 * @param timeout 超时时间(ms)
 * @param expected_reply 期望的回复(默认为 "OK")
 * @return true:命令成功执行, false:命令执行失败
 */
bool sendATCommand(const char *command, unsigned long timeout, const char *expected_reply)
{
    Serial.print("Sending AT command: ");
    Serial.print(command);
    Serial.print(" with expected reply: ");
    Serial.print(expected_reply);
    Serial.print(" and timeout: ");
    Serial.println(timeout);
    String response = ""; // 用于存储响应

    NET_4G_RX_TX.println(command);

    unsigned long startTime = millis();
    bool responseReceived = false;

    // 清除之前可能残留的数据
    while (NET_4G_RX_TX.available())
    {
        NET_4G_RX_TX.read();
    }

    delay(100); // 给模块一点响应时间

    // 读取所有响应，直到超时
    while (millis() - startTime < timeout)
    {
        if (NET_4G_RX_TX.available())
        {
            responseReceived = true;
            char c = NET_4G_RX_TX.read();
            response += c;

            // 如果收到完整响应（通常以OK或ERROR结尾），可以提前退出
            if (response.endsWith(expected_reply) ||
                response.endsWith("OK\r\n") ||
                response.endsWith("ERROR\r\n"))
            {
                break;
            }
        }

        // 如果有数据但暂时没有更多数据，等待一小段时间
        if (responseReceived && !NET_4G_RX_TX.available())
        {
            delay(50);
            // 如果等待后仍无数据，认为响应结束
            if (!NET_4G_RX_TX.available())
            {
                break;
            }
        }
    }

    // 打印完整响应
    if (response.length() > 0)
    {
        Serial.println("Modem Response:");
        Serial.println(response);
    }
    else
    {
        Serial.println("No response from modem");
    }

    // 检查是否收到期望的回复
    if (response.indexOf(expected_reply) >= 0 || response.indexOf("OK") >= 0)
    {
        return true;
    }

    return false;
}

/**
 * @brief 设置4G网络连接
 */
void setupNetwork()
{
    NET_4G_RX_TX.begin(MODEM_BAUD, SERIAL_8N1, GPX_RX, GPX_TX);
    delay(1000); // 等待串口初始化

    sendATCommand("AT");       // 测试
    sendATCommand("ATE0");     // 检查SIM卡状态
    sendATCommand("ATI");      // 查询模块信息
    sendATCommand("AT+ICCID"); // 查询SIM卡ICCID
    sendATCommand("AT+QICSGP=1,1,\"\",\"\",\"\""); // 开启APN
    sendATCommand("AT+NETOPEN"); // 打开网络连接
    sendATCommand("AT+NETOPEN?"); // 查询网络是否连接
    sendATCommand("AT+QNTP=1,\"tms.dynamicode.com.cn\",123,1"); // 同步时间功能
}


