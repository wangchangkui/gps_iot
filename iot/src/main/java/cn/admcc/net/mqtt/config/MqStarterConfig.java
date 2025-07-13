package cn.admcc.net.mqtt.config;

import lombok.Data;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.mqtt.core.DefaultMqttPahoClientFactory;
import org.springframework.integration.mqtt.core.MqttPahoClientFactory;

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
public class MqStarterConfig {

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

    /**
     * 连接信息
     */
    private Integer keepAlive;


    @Bean
    public MqttPahoClientFactory mqttPahoClientFactory(){
        DefaultMqttPahoClientFactory factory = new DefaultMqttPahoClientFactory();
        MqttConnectOptions options = new MqttConnectOptions();;
        options.setServerURIs(new String[]{host});
        options.setUserName(userName);
        options.setPassword(password.toCharArray());
        options.setAutomaticReconnect(true);
        options.setCleanSession(true);
        options.setKeepAliveInterval(keepAlive);
        factory.setConnectionOptions(options);
        return factory;
    }

}
