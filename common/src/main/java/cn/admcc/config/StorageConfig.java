package cn.admcc.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:37
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "storage")
public class StorageConfig {


    /**
     * 本地存储的位置
     */
    private String localStorage;

    /**
     * 默认使用的存储方案
     */
    private String type;
}
