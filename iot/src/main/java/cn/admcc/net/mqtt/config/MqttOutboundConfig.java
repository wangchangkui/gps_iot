package cn.admcc.net.mqtt.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.mqtt.core.MqttPahoClientFactory;
import org.springframework.integration.mqtt.outbound.MqttPahoMessageHandler;
import org.springframework.messaging.MessageChannel;

/**
 * @author wck
 */
@Configuration
public class MqttOutboundConfig {


    private final MqStarterConfig mqStarterConfig;

    private final MqttPahoClientFactory factory;

    public MqttOutboundConfig(MqStarterConfig mqStarterConfig, MqttPahoClientFactory factory) {
        this.mqStarterConfig = mqStarterConfig;
        this.factory = factory;
    }

    @Bean
    public MessageChannel mqttOutboundChannel(){
        return new DirectChannel();
    }


    @Bean
    @ServiceActivator(inputChannel = "mqttOutboundChannel")
    public MqttPahoMessageHandler mqttOutbound() {
        MqttPahoMessageHandler handler = new MqttPahoMessageHandler(
                mqStarterConfig.getClientId() + System.currentTimeMillis(),
                factory
        );
        handler.setAsync(true);
        return handler;
    }
}
