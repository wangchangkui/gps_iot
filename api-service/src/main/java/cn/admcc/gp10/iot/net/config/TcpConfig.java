package cn.admcc.gp10.iot.net.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:26
 */
@Data
@EnableConfigurationProperties
@Configuration
@ConfigurationProperties(prefix = "tcp")
public class TcpConfig {

    private Integer port;
}
