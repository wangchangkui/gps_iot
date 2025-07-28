package cn.admcc.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:04
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "spring.mail")
public class EmailConfig {


    /**
     * 模板文件
     */
    private String templateConfig;
}
