package cn.admcc.net.mqtt;

import cn.admcc.net.mqtt.config.MqStarterConfig;
import cn.hutool.core.codec.Base64;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.mqtt.core.MqttPahoClientFactory;
import org.springframework.integration.mqtt.inbound.MqttPahoMessageDrivenChannelAdapter;
import org.springframework.integration.mqtt.support.DefaultPahoMessageConverter;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHandler;

/**
 * @author wck
 */
@Slf4j
@Configuration
public class MqttSubscriber implements InitializingBean {

    private final MqStarterConfig mqStarterConfig;


    public MqttSubscriber(MqStarterConfig mqStarterConfig) {
        this.mqStarterConfig = mqStarterConfig;
    }

    @Bean
    public MessageChannel mqttInboundChannel(){
        return new DirectChannel();
    }

    @Bean
    public MqttPahoMessageDrivenChannelAdapter inboundAdapter(
            MqttPahoClientFactory factory) {
        // 订阅主题
        String[] topics = {mqStarterConfig.getTopic()};
        MqttPahoMessageDrivenChannelAdapter adapter = 
            new MqttPahoMessageDrivenChannelAdapter(mqStarterConfig.getClientId(),factory, topics);

        adapter.setConverter(new DefaultPahoMessageConverter());
        adapter.setQos(1);
        adapter.setOutputChannel(mqttInboundChannel());
        return adapter;
    }


    @Bean
    @ServiceActivator(inputChannel = "mqttInboundChannel")
    public MessageHandler messageHandler() {
        return message -> {
            String topic = (String) message.getHeaders().get("mqtt_receivedTopic");
            String payload = (String) message.getPayload();
            

           // base64解密
            byte[] decode = Base64.decode(payload);
            String deviceMessage = new String(decode);
            log.info("Received from [{}]: {}", topic, deviceMessage);

        };
    }

    @Override
    public void afterPropertiesSet() {
        log.info("MQTT 接收器初始化成功");
    }
}
