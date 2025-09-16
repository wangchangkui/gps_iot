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
     * 前端访问的路径
     * 这个地址需要与nginx配合使用
     */
    private String webBaseUrl;

    /**
     * 本地存储或桶的位置
     */
    private String src;

    /**
     * 默认使用的存储方案
     */
    private String type;
}
