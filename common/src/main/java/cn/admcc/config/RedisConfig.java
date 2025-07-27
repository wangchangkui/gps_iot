package cn.admcc.config;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsontype.impl.LaissezFaireSubTypeValidator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericToStringSerializer;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:05
 */
@Configuration
public class RedisConfig {
    @Bean
    public RedisTemplate<String, Object> redisTemplate(@Qualifier("baseOM") ObjectMapper projectOM,
                                                       RedisConnectionFactory factory) {
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(factory);
        GenericToStringSerializer<String> serializer = new GenericToStringSerializer<>(String.class);
        //对于Key都应该采用字符串，原因，不可变，稳定。
        redisTemplate.setKeySerializer(serializer);
        redisTemplate.setHashKeySerializer(serializer);
        ObjectMapper copy = projectOM.copy();
        Jackson2JsonRedisSerializer<Object> jacksonRedis = new Jackson2JsonRedisSerializer<>(copy, Object.class);
        copy.activateDefaultTyping(LaissezFaireSubTypeValidator.instance , ObjectMapper.DefaultTyping.NON_FINAL, JsonTypeInfo.As.PROPERTY);
        redisTemplate.setValueSerializer(jacksonRedis);
        redisTemplate.setHashKeySerializer(jacksonRedis);
        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }
}
