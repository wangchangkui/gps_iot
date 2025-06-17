/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-16 10:16:30
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-15 16:32:33
 * @FilePath: \esp32demo\include\wifi_manager\WiFiManager.cpp
 * @Description: WiFi管理器实现
 */

#include "WiFiManager.h"

// // 实例化全局WiFi管理器对象
// WiFiManager wifiManager;

// HTML页面 - 主页带WiFi扫描功能
const char *HTML_TEMPLATE = R"(
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESP32配置页面</title>
    <style>
        body { font-family: Arial; margin: 10px; max-width: 600px; margin: 0 auto; }
        .form-group { margin: 15px 0; }
        label { display: block; margin-bottom: 5px; }
        input { width: 100%; padding: 8px; box-sizing: border-box; border-radius: 4px; border: 1px solid #ddd; }
        button { background: #4CAF50; color: white; padding: 10px; border: none; border-radius: 4px; cursor: pointer; width: 100%; }
        button.scan-btn { background: #2196F3; margin-bottom: 10px; }
        .wifi-list { max-height: 300px; overflow-y: auto; margin: 15px 0; border: 1px solid #ddd; border-radius: 4px; }
        .wifi-item { padding: 12px; border-bottom: 1px solid #eee; cursor: pointer; display: flex; justify-content: space-between; }
        .wifi-item:hover { background-color: #f5f5f5; }
        .wifi-item.selected { background-color: #e8f5e9; }
        .signal-strength { font-size: 0.8em; color: #666; }
        .modal { display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; 
                overflow: auto; background-color: rgba(0,0,0,0.4); }
        .modal-content { background-color: #fefefe; margin: 15% auto; padding: 20px; border-radius: 5px; 
                        width: 80%; max-width: 400px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .close-btn { color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer; }
        .close-btn:hover { color: #000; }
        .status-bar { margin: 10px 0; padding: 8px; background-color: #e8f5e9; border-radius: 4px; display: none; }
        .status-bar.error { background-color: #ffebee; }
        h1, h2, h3 { color: #333; }
        .container { padding: 15px; }
        .hidden { display: none; }
    </style>
</head>
<body>
    <div class="container">
        <h2>ESP32网络配置</h2>
        
        <div id="status-bar" class="status-bar"></div>

        <button id="scan-wifi" class="scan-btn">扫描WiFi网络</button>
        
        <div id="wifi-list" class="wifi-list hidden"></div>
        
        <form id="wifi-form" method="POST" action="/save">
            <div class="form-group">
                <label>WiFi名称:</label>
                <input type="text" id="ssid-input" name="ssid" value="%s" required>
            </div>
            <div class="form-group">
                <label>WiFi密码:</label>
                <input type="password" id="password-input" name="password" value="%s" required>
            </div>
            <div class="form-group">
                <label>服务器地址:</label>
                <input type="text" name="server" value="%s" placeholder="http://admcc.cn/api">
            </div>
            <button type="submit">确定</button>
        </form>
    </div>
    
    <!-- WiFi密码输入弹窗 -->
    <div id="password-modal" class="modal">
        <div class="modal-content">
            <span class="close-btn">&times;</span>
            <h3>输入WiFi密码</h3>
            <div class="form-group">
                <label>选中的网络: <span id="selected-wifi-name"></span></label>
            </div>
            <div class="form-group">
                <label>密码:</label>
                <input type="password" id="modal-password-input">
            </div>
            <button id="connect-btn">确定</button>
        </div>
    </div>

    <script>
        // 获取页面元素
        const scanBtn = document.getElementById('scan-wifi');
        const wifiList = document.getElementById('wifi-list');
        const ssidInput = document.getElementById('ssid-input');
        const passwordInput = document.getElementById('password-input');
        const modal = document.getElementById('password-modal');
        const closeBtn = document.querySelector('.close-btn');
        const selectedWifiName = document.getElementById('selected-wifi-name');
        const modalPasswordInput = document.getElementById('modal-password-input');
        const connectBtn = document.getElementById('connect-btn');
        const statusBar = document.getElementById('status-bar');
        
        // 显示状态信息
        function showStatus(message, isError = false) {
            statusBar.textContent = message;
            statusBar.style.display = 'block';
            if (isError) {
                statusBar.classList.add('error');
            } else {
                statusBar.classList.remove('error');
            }
            setTimeout(() => {
                statusBar.style.display = 'none';
            }, 5000);
        }
        
        // 扫描WiFi
        scanBtn.addEventListener('click', async () => {
            scanBtn.disabled = true;
            scanBtn.textContent = '正在扫描...';
            showStatus('扫描中，请稍后...');
            
            try {
                const response = await fetch('/scan-wifi');
                const networks = await response.json();
                
                wifiList.innerHTML = '';
                if (networks.length > 0) {
                    networks.sort((a, b) => b.rssi - a.rssi); // 按信号强度排序
                    
                    networks.forEach(network => {
                        const item = document.createElement('div');
                        item.className = 'wifi-item';
                        
                        // 信号强度图标 (简单实现)
                        let signalStrength = '';
                        if (network.rssi > -50) {
                            signalStrength = '强';
                        } else if (network.rssi > -70) {
                            signalStrength = '中';
                        } else {
                            signalStrength = '弱';
                        }
                        
                        item.innerHTML = `
                            <span>${network.ssid}</span>
                            <span class="signal-strength">信号: ${signalStrength}</span>
                        `;
                        
                        item.addEventListener('click', () => {
                            // 选中当前WiFi
                            document.querySelectorAll('.wifi-item').forEach(el => {
                                el.classList.remove('selected');
                            });
                            item.classList.add('selected');
                            
                            // 打开密码输入弹窗
                            selectedWifiName.textContent = network.ssid;
                            modal.style.display = 'block';
                            modalPasswordInput.focus();
                        });
                        
                        wifiList.appendChild(item);
                    });
                    
                    wifiList.classList.remove('hidden');
                } else {
                    showStatus('未找到WiFi网络', true);
                }
            } catch (error) {
                showStatus('扫描失败: ' + error.message, true);
            } finally {
                scanBtn.disabled = false;
                scanBtn.textContent = '扫描WiFi网络';
            }
        });
        
        // 关闭弹窗
        closeBtn.addEventListener('click', () => {
            modal.style.display = 'none';
        });
        
        // 点击弹窗外部关闭
        window.addEventListener('click', (event) => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });
        
        // 连接按钮点击事件
        connectBtn.addEventListener('click', () => {
            const selectedWifi = document.querySelector('.wifi-item.selected');
            if (selectedWifi) {
                const name = selectedWifiName.textContent;
                const password = modalPasswordInput.value;
                
                // 填充表单
                ssidInput.value = name;
                passwordInput.value = password;
                
                modal.style.display = 'none';
                showStatus(`已选择 "${name}" WiFi`);
            }
        });
    </script>
</body>
</html>
)";

// 构造函数
WiFiManager::WiFiManager() : _server(80), _isConfigMode(true), _resetBtnPin(0), _resetTimeout(3000),
                             _lastReconnectAttempt(0), _scheduledConnectAttempt(0), _hasPendingConnect(false)
{
    _htmlTemplate = HTML_TEMPLATE;

    // 初始化默认服务器地址，在配置为空时使用
    _defaultServerUrl = "http://admcc.cn/api";

    Serial.println("WiFiManager Initialized");
}

// 初始化
void WiFiManager::begin(int resetBtnPin, int resetTimeout)
{
    Serial.println("\n===== WiFi Manager Initialized =====");

    // 配置重置按钮引脚
    _resetBtnPin = resetBtnPin;
    _resetTimeout = resetTimeout;
    pinMode(_resetBtnPin, INPUT_PULLUP); // 初始化EEPROM并加载配置
    EEPROM.begin(sizeof(WiFiConfig));
    _loadConfig();

    // 如果服务器地址为空（首次使用），设置默认值
    if (strlen(_config.server_url) == 0)
    {
        strncpy(_config.server_url, _defaultServerUrl.c_str(), sizeof(_config.server_url) - 1);
    }

    // 检查配置是否有效
    if (_isConfigValid())
    {
        Serial.println("检测到有效的WiFi配置");
        Serial.print("尝试连接到: ");
        Serial.println(_config.wifi_ssid);

        // 尝试连接WiFi
        if (_connectToWifi())
        {
            Serial.println("成功连接到WiFi，设备正常工作中");
            _isConfigMode = false; // 切换到正常工作模式
            return;
        }
        else
        {
            Serial.println("连接保存的WiFi失败，切换到配置模式");
            _isConfigMode = true;
        }
    }
    else
    {
        Serial.println("no valid WiFi configuration found, entering config mode");
        _isConfigMode = true;
    }

    // 配置模式：设置AP
    if (_isConfigMode)
    {
        WiFi.softAP(_apName, _apPassword);
        Serial.println("setup Config Mode");
        Serial.print("config ip address : ");
        Serial.println(WiFi.softAPIP());

        // 设置Web服务器
        _setupWebServer();
        _server.begin();
        Serial.println("config mode started, Web server running on port 80");
    }
}

// 处理任务
void WiFiManager::handle()
{
    // 只在配置模式下处理Web服务器请求
    if (_isConfigMode)
    {
        _server.handleClient();
    }

    // 检测重置按钮
    if (digitalRead(_resetBtnPin) == LOW)
    {
        // 记录按下开始时间
        unsigned long pressStartTime = millis();
        Serial.println("reset confim...");

        // 等待按钮释放或超时
        while (digitalRead(_resetBtnPin) == LOW)
        {
            // 计算已按下时间
            unsigned long pressDuration = millis() - pressStartTime;

            // 如果按下超过设定时间，执行重置
            if (pressDuration >= _resetTimeout)
            {
                Serial.println("reset .....");
                // 闪烁LED或其他指示
                for (int i = 0; i < 5; i++)
                {
                    delay(100);
                }
                clearConfig(); // 清除配置并重启
                // 此处不会执行，因为clearConfig会重启设备
            }

            delay(100);
        }

        Serial.println("按钮已释放");
    }

    // 在正常工作模式下，检查WiFi连接状态
    if (!_isConfigMode && WiFi.status() != WL_CONNECTED)
    {
        unsigned long currentTime = millis();
        if (currentTime - _lastReconnectAttempt > _reconnectInterval)
        {
            _lastReconnectAttempt = currentTime;
            Serial.println("WiFi连接已断开，尝试重新连接...");
            _connectToWifi();
        }
    }
}

// 清除配置
void WiFiManager::clearConfig()
{
    Serial.println("清除WiFi配置...");

    // 清空配置
    memset(&_config, 0, sizeof(WiFiConfig));

    // 保存清空的配置
    _saveConfig();

    // 重启ESP32
    Serial.println("重启设备中...");
    delay(1000);
    ESP.restart();
}

// 手动重连WiFi
bool WiFiManager::reconnectWifi()
{
    return _connectToWifi();
}

// 加载配置
bool WiFiManager::_loadConfig()
{
    EEPROM.get(0, _config);
    return true;
}

// 保存配置
bool WiFiManager::_saveConfig()
{
    EEPROM.put(0, _config);
    return EEPROM.commit();
}

// 检查配置有效性
bool WiFiManager::_isConfigValid()
{
    // 简单检查SSID是否为空或乱码
    if (strlen(_config.wifi_ssid) < 1 || strlen(_config.wifi_ssid) > 31)
    {
        return false;
    }

    // 检查SSID是否包含有效字符
    for (int i = 0; i < strlen(_config.wifi_ssid); i++)
    {
        if (_config.wifi_ssid[i] < 32 || _config.wifi_ssid[i] > 126)
        {
            return false; // 非打印字符，可能是未初始化数据
        }
    }

    return true;
}

// 连接WiFi
bool WiFiManager::_connectToWifi()
{
    // 断开现有连接
    WiFi.disconnect();
    delay(500);

    // 尝试连接
    WiFi.begin(_config.wifi_ssid, _config.wifi_password);
    Serial.print("connect WiFi SSID : ");
    Serial.print(_config.wifi_ssid);
    Serial.print(" | PassWord: ");
    Serial.println(_config.wifi_password);

    // 等待连接
    int attempts = 0;
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(1000);
        Serial.print("trying to connect to WiFi, attempt ");
        Serial.print(attempts + 1);
        Serial.println(" ...");
        attempts++;
        if (attempts > 10)
        {
            break;
        }
    }

    if (WiFi.status() != WL_CONNECTED)
    {
        Serial.println("Connect Faild !");
        _isConfigMode = true;
        return false;
    }

    Serial.println("");
    Serial.println("WiFi Connect Success!");
    Serial.print("IP Address: ");
    Serial.println(WiFi.localIP());
    Serial.print("Server Address: ");
    Serial.println(_config.server_url);

    _isConfigMode = false;
    return true;
}

// 设置Web服务器
void WiFiManager::_setupWebServer()
{
    Serial.println("Setting Web Server...");
    // 主页
    _server.on("/", HTTP_GET, [this]()
               { _handleRoot(); });

    // WiFi扫描
    _server.on("/scan-wifi", HTTP_GET, [this]()
               { _handleScanWifi(); });

    // 保存配置
    _server.on("/save", HTTP_POST, [this]()
               { _handleSave(); });
}

// 处理主页请求
void WiFiManager::_handleRoot()
{
    Serial.println("build Set HTML page");
    String html = String(HTML_TEMPLATE);
    html.replace("%s", _config.wifi_ssid);
    html.replace("%s", _config.wifi_password);

    // 如果服务器地址为空，则使用默认值
    if (strlen(_config.server_url) == 0 || strcmp(_config.server_url, "") == 0)
    {
        html.replace("%s", _defaultServerUrl);
    }
    else
    {
        html.replace("%s", _config.server_url);
    }

    _server.send(200, "text/html", html);
}

// 处理WiFi扫描请求
void WiFiManager::_handleScanWifi()
{
    Serial.println("Start scanning WiFi networks...");

    // 删除之前的扫描结果
    WiFi.scanDelete();

    // 开始异步扫描
    int networksFound = WiFi.scanNetworks(false, true);

    // 等待扫描完成
    while (networksFound == WIFI_SCAN_RUNNING)
    {
        delay(100);
        networksFound = WiFi.scanComplete();
    }

    Serial.printf("Ok,Found %d pieces of network information\n", networksFound);

    String json = "[";
    if (networksFound > 0)
    {
        for (int i = 0; i < networksFound; i++)
        {
            if (i > 0){
                json += ",";
            }
                
            String ssid = WiFi.SSID(i);
            json += "{";
            // 对SSID进行转义，避免JSON格式错误
            ssid.replace("\"", "\\\""); // 转义双引号
            json += "\"ssid\":\"" + ssid + "\",";
            json += "\"rssi\":" + String(WiFi.RSSI(i)) + ",";
            json += "\"secure\":" + String(WiFi.encryptionType(i) != WIFI_AUTH_OPEN);
            json += "}";
        }
    }
    json += "]";

    _server.send(200, "application/json", json);
}

// 处理保存配置请求
void WiFiManager::_handleSave()
{ // 获取表单数据
    String ssid = _server.arg("ssid");
    String password = _server.arg("password");
    String server_url = _server.arg("server");

    // 如果服务器地址为空，使用默认值
    if (server_url.length() == 0 || server_url.equals(""))
    {
        server_url = _defaultServerUrl;
    }

    Serial.println("Save config");
    Serial.print("WiFi: ");
    Serial.println(ssid);
    Serial.print("Save Server : ");
    Serial.println(server_url);

    // 清空当前配置
    memset(&_config, 0, sizeof(WiFiConfig));

    // 写入新配置
    strncpy(_config.wifi_ssid, ssid.c_str(), sizeof(_config.wifi_ssid) - 1);
    strncpy(_config.wifi_password, password.c_str(), sizeof(_config.wifi_password) - 1);
    strncpy(_config.server_url, server_url.c_str(), sizeof(_config.server_url) - 1);

    // 保存配置到EEPROM
    bool saved = _saveConfig();
    Serial.println(saved ? "Config save to EEPROM,Success" : "Config save  to EEPROM,Failed!");

    if (!saved)
    {
        Serial.println("保存配置到EEPROM失败!");
        _server.send(500, "text/plain", "保存配置失败，请稍后重试");
        return;
    }
    // 安全地设置连接计划，而不是立即尝试连接
    _scheduledConnectAttempt = millis() + 3000; // 3秒后尝试连接
    _hasPendingConnect = true;
    // 开始连接
    Serial.println("配置已保存，设备将尝试连接到新的WiFi网络...");

    // 连接到WIFI
    if (this->_connectToWifi())
    {
        _server.send(200, "text/html", "<meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                                       "<style>body{font-family:Arial;text-align:center;margin-top:50px;} "
                                       ".success{color:#4CAF50;} .container{max-width:400px;margin:0 auto;padding:20px;border:1px solid #ddd;border-radius:5px;}</style>"
                                       "<div class='container'><h2 class='success'>连接成功!</h2>"
                                       "<p>WiFi配置已保存并成功连接</p>"
                                       "<p>设备将在3秒后切换到正常工作模式...</p></div>");

        delay(3000);
    }
    else
    {
        _server.send(200, "text/html", "<meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                                       "<style>body{font-family:Arial;text-align:center;margin-top:50px;} "
                                       ".error{color:#F44336;} .container{max-width:400px;margin:0 auto;padding:20px;border:1px solid #ddd;border-radius:5px;} "
                                       "a.btn{display:block;background:#4CAF50;color:white;text-align:center;padding:10px;text-decoration:none;border-radius:4px;margin-top:20px;}</style>"
                                       "<div class='container'><h2 class='error'>连接失败</h2>"
                                       "<p>无法连接到指定的WiFi网络</p>"
                                       "<p>请检查网络名称和密码是否正确</p>"
                                       "<a href='/' class='btn'>返回设置</a></div>");
        delay(3000);
    }
}
