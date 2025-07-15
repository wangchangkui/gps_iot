package cn.admcc.net.mqtt;

import cn.admcc.gps.gp10.TempDataHandler;
import cn.admcc.gps.gp10.entity.BaseGpsInfo;
import cn.admcc.net.data.handler.DataPacket;
import cn.admcc.net.data.handler.DataPacketHandler;
import cn.admcc.net.mqtt.config.MqStarterConfig;
import cn.hutool.extra.spring.SpringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.integration.annotation.ServiceActivator;
import org.springframework.integration.channel.DirectChannel;
import org.springframework.integration.mqtt.core.MqttPahoClientFactory;
import org.springframework.integration.mqtt.inbound.MqttPahoMessageDrivenChannelAdapter;
import org.springframework.integration.mqtt.support.DefaultPahoMessageConverter;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHandler;

import java.util.Optional;

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


            String[] split = payload.split(",");
            // 第一位为设备的ID，其余的为数据包，1.确认设备是Id是一个Long 类型，2，确定数据包是以$开头
            int dataPackageLength = 2;
            if(split.length > dataPackageLength){
                DataPacketHandler bean = SpringUtil.getBean(DataPacketHandler.class);
                DataPacket dataPacket = new DataPacket(payload);
                BaseGpsInfo handler =  (BaseGpsInfo) bean.handler(dataPacket);
                // 保存临时数据数据的标签
                TempDataHandler tempDataHandler = SpringUtil.getBean(TempDataHandler.class);
                if(Optional.ofNullable(tempDataHandler).isPresent()){
                    tempDataHandler.handler(handler);
                }

                // 业务数据入库





            }


        };
    }

    @Override
    public void afterPropertiesSet() {
        log.info("MQTT 接收器初始化成功");
    }
}
