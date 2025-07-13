package cn.admcc.net.mqtt;

import cn.admcc.net.mqtt.config.MqStarterConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.core.MessageProducer;
import org.springframework.integration.mqtt.inbound.MqttPahoMessageDrivenChannelAdapter;
import org.springframework.integration.mqtt.outbound.MqttPahoMessageHandler;
import org.springframework.integration.mqtt.support.MqttHeaders;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;
/**
 * @author wck
 */
@Slf4j
@Service
public class MqttPublisher implements InitializingBean {
    private final MqttPahoMessageHandler mqttHandler;

    private final MqStarterConfig mqStarterConfig;

    @Autowired
    public MqttPublisher(MqttPahoMessageHandler mqttHandler,MqStarterConfig mqStarterConfig) {
        this.mqttHandler = mqttHandler;
        this.mqStarterConfig = mqStarterConfig;
    }

    public void publish(String topic, String payload) {
        Message<String> message = MessageBuilder.withPayload(payload)
                .setHeader(MqttHeaders.TOPIC, topic)
                .setHeader(MqttHeaders.QOS, 1)
                .build();
        mqttHandler.handleMessage(message);
    }

    @Override
    public void afterPropertiesSet() {
      log.info("MQTT 发布者初始化成功");
    }
}
