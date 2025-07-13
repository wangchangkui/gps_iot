package cn.admcc.net.mqtt;

import cn.admcc.net.mqtt.config.MqStarterConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.integration.mqtt.core.MqttPahoClientFactory;
import org.springframework.integration.mqtt.inbound.MqttPahoMessageDrivenChannelAdapter;
import org.springframework.messaging.MessageHandler;

/**
 * @author wck
 */
@Slf4j
@Configuration
public class MqttSubscriber implements InitializingBean {

    private final MqStarterConfig mqStarterConfig;
    private static final String CLIENT_ID = "spring-boot-client-" + System.currentTimeMillis();

    public MqttSubscriber(MqStarterConfig mqStarterConfig) {
        this.mqStarterConfig = mqStarterConfig;
    }

    @Bean
    public MqttPahoMessageDrivenChannelAdapter inboundAdapter(
            MqttPahoClientFactory factory) {
        // 订阅主题
        String[] topics = {mqStarterConfig.getTopic()};
        MqttPahoMessageDrivenChannelAdapter adapter = 
            new MqttPahoMessageDrivenChannelAdapter(CLIENT_ID, factory, topics);
        
        adapter.setQos(1);
        adapter.setOutputChannelName("mqttInputChannel");
        return adapter;
    }


    @Bean
    @ServiceActivator(inputChannel = "mqttInputChannel")
    public MessageHandler messageHandler() {
        return message -> {
            String topic = (String) message.getHeaders().get("mqtt_receivedTopic");
            String payload = (String) message.getPayload();
            
           log.info("Received from [{}]: {}", topic, payload);
            // 在此处添加业务逻辑处理
        };
    }

    @Override
    public void afterPropertiesSet() {
        log.info("MQTT 接收器初始化成功");
    }
}
