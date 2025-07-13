package cn.admcc.net.mqtt;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 13:07
 */
@Configuration
@EnableConfigurationProperties
@Data
@ConfigurationProperties(prefix = "mqtt")
public class MqStarter {

    /**
     * mqtt 的配置
     */
    private  String host;

    /**
     * 端口
     */
    private  Integer port;

    /**
     * 账号
     */
    private  String userName;


    /**
     * 连接密码
     */
    private  String password;


    /**
     * 客户端
     */
    private  String clientId;


    /**
     * 订阅通道
     */
    private String topic;



}
