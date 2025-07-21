package cn.admcc.gaode.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 高德配置类
 * @createTime 15:20
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "gd")
public class GdConfig {


    /**
     * 高德地图的token
     */
    private String apiToken;

    /**
     * 默认访问的url
     */
    private String baseUrl;

}
