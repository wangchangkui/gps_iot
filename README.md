# 快速开始

### 基于ESP32+GP10-A 物联网GPS定位项目

硬件资料清单:

* 大夏龙雀GP10-A GPS定位模块
* ESP32-WROOM
* 大夏龙雀4G模块

软件:

* 移动端部分 Arduino
* Springboot 3.5.0
* 数据库 Postgresql 12
* node 20.19



## 目录结构说明
    api-service ---- 后台服务
    common      ---- 通用工具代码模块
    deps        ---- 依赖模块
    eda         ---- 嘉立创
    handware    ---- esp32代码
    iot         ---- 物联网模块
    sql         ---- 数据库文件
    web         ---- 前端
    wx-app      ---- 微信小程序


## Docker 快速部署

### 构建服务
> 提前把jar包以及Dockerfile文件放在一起

```bash
     docker build -t gps-iot:latest .
```


### 后台服务部署

```shell  
  docker run -dit --restart always \
          -p 8564:8564 \
          -e USER_SAVE=/opt/gps-iot   \
          -v /opt/gps-iot:/src   \
          -e DB_HOST=172.18.0.18 \
          -e DB_PORT=15432 \
          -e DB_DATABASE=gps-iot \
          -e DB_USER=postgres \
          -e DB_PASSWORD=pg@admcc.cn   \
          -e REDIS_HOST=172.18.0.16   \
          -e REDIS_PORT=16379  \
          --name gps-iot   \
          -t gps-iot:latest
```


## 参考资料

    DX-GP10-NMEA0183通讯协议
    
## 官方网站

    https://admcc.cn

## 微信小程序界面

![](https://github.com/wangchangkui/gps_iot/blob/master/images/wx_app.jpg?raw=true)


## 开发工具
    
    IDEA
    VSCODE
    微信开发者工具
    Cursor
