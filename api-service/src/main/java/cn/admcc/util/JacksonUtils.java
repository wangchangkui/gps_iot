package cn.admcc.util;

import cn.hutool.extra.spring.SpringUtil;
import com.fasterxml.jackson.annotation.JsonFilter;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.jsontype.impl.LaissezFaireSubTypeValidator;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.fasterxml.jackson.databind.ser.FilterProvider;
import com.fasterxml.jackson.databind.ser.impl.SimpleBeanPropertyFilter;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;
import org.springframework.lang.NonNull;
import org.springframework.util.Assert;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:08
 */
public class JacksonUtils {


    /**
     * 确保这个OBJECT_MAPPER在这个工具类中是唯一的
     */
    private final static ObjectMapper OBJECT_MAPPER;

    private final static ObjectMapper WARP_OBJECT_MAPPER;

    static {
        OBJECT_MAPPER = SpringUtil.getBean("baseOM", ObjectMapper.class).copy();
        OBJECT_MAPPER.getSerializerProvider()
                .setNullValueSerializer(new JsonSerializer<>() {
                    @Override
                    public void serialize(Object o, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)
                            throws IOException {
                        jsonGenerator.writeNull();
                    }
                });
        OBJECT_MAPPER.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false)
                .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        // 带有字段包装的OBJECT_MAPPER
        WARP_OBJECT_MAPPER = getObjectMapper();
        WARP_OBJECT_MAPPER.activateDefaultTyping(LaissezFaireSubTypeValidator.instance , ObjectMapper.DefaultTyping.NON_FINAL, JsonTypeInfo.As.PROPERTY);
    }

    /**
     * json转对象
     *
     * @param json json字符串
     * @param t    字节码对象
     * @param <T>  字节码对象
     * @return 字节码对象的实例
     */
    public static <T> T parseObject(@NonNull String json, @NonNull Class<T> t) {
        try {
            return OBJECT_MAPPER.readValue(json, OBJECT_MAPPER.getTypeFactory().constructType(t));
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * json转对象
     *
     * @param json json字符串
     * @param <T>  字节码对象
     * @return 字节码对象的实例
     */
    public static <T> T parseObject(@NonNull String json, TypeReference<T> tr) {
        try {
            return OBJECT_MAPPER.readValue(json, OBJECT_MAPPER.getTypeFactory().constructType(tr));
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 解析包装对象，这个通常用来处理json增加了class信息的情况
     *
     * @param json json
     * @return {@link T}
     */
    public static <T> T parseWarpObject(@NonNull String json) {
        try {
            return WARP_OBJECT_MAPPER.readValue(json, WARP_OBJECT_MAPPER.getTypeFactory().constructType(new TypeReference<T>() {}));
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }


    /**
     * json文件转对象
     *
     * @param jsonFile json文件对象
     * @param t        字节码对象
     * @param <T>      字节码对象
     * @return 字节码对象的实例
     */
    public static <T> T toJSONString(@NonNull File jsonFile, @NonNull Class<T> t) {
        Assert.notNull(jsonFile, "json文件对象不能为空！");
        Assert.notNull(t, "类对象不能为空！");
        if (!jsonFile.exists()) {
            throw new RuntimeException("json文件不存在");
        }
        try {
            return OBJECT_MAPPER.readValue(jsonFile, OBJECT_MAPPER.getTypeFactory().constructType(t));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static <T> String toWarpJSONString(@NonNull T t) {
        Assert.notNull(t, "类对象不能为空！");
        try {
            return WARP_OBJECT_MAPPER.writeValueAsString(t);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 对象转json字符串
     *
     * @param t   实例对象
     * @param <T> 实例对象类型
     * @param excludeProperties 排除属性
     * @return json字符串
     */
    public static <T> String toJSONString(@NonNull T t, String... excludeProperties) {
        Assert.notNull(t, "对象不能为空！");
        ObjectMapper objectMapper = getObjectMapper();
        objectMapper.addMixIn(t.getClass(), JacksonFilter.class);
        FilterProvider filters = new SimpleFilterProvider()
                .addFilter("JacksonFilter", SimpleBeanPropertyFilter.serializeAllExcept(excludeProperties));
        try {
            return objectMapper.writer(filters).writeValueAsString(t);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 下划线json转驼峰式实体类，这通常用于Python服务端的规范
     *
     * @param t   字节码对象
     * @param <T> 实例对象类型
     * @return 字节码对象的实例
     */
    public static <T> T snakeCaseJSONToObj(@NonNull String snakeCaseJSON, @NonNull Class<T> t) {
        Assert.notNull(t, "对象不能为空！");
        try {
            ObjectMapper snakeCaseOm = getSnakeCaseOm();
            return snakeCaseOm.readValue(snakeCaseJSON, snakeCaseOm.getTypeFactory().constructType(t));
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 获得一个支持下划线转驼峰的ObjectMapper对象
     */
    public static ObjectMapper getSnakeCaseOm() {
        return getObjectMapper().setPropertyNamingStrategy(PropertyNamingStrategies.SNAKE_CASE);
    }

    /**
     * 创建对象节点
     *
     * @return {@link ObjectNode}
     */
    public static ObjectNode createObjectNode() {
        return OBJECT_MAPPER.createObjectNode();
    }

    /**
     * 对象转json字符串
     *
     * @param t   实例对象
     * @param <T> 实例对象类型
     * @return json字符串
     */
    public static <T> String toJSONString(@NonNull T t) {
        Assert.notNull(t, "对象不能为空！");
        try {
            return OBJECT_MAPPER.writeValueAsString(t);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 驼峰式实体类转下划线json，这通常用于Python服务端的规范
     *
     * @param t   实例对象
     * @param <T> 实例对象类型
     * @return json字符串
     */
    public static <T> String toSnakeCaseJSON(@NonNull T t) {
        Assert.notNull(t, "对象不能为空！");
        try {
            return getSnakeCaseOm().writeValueAsString(t);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    public static <T> void objWritJSONFile(File targetFile, T t) throws IOException {
        try (FileWriter writer = new FileWriter(targetFile)) {
            OBJECT_MAPPER.writeValue(writer, t);
        }
    }

    /**
     * 根据json指针表达式获取数据
     *
     * @param jsonPointerExpression json指针表达式
     * @param json                  json
     * @return {@link JsonNode}
     */
    public static JsonNode at(String jsonPointerExpression, String json) {
        JsonNode jsonNode = readTree(json);
        return jsonNode.at(jsonPointerExpression);
    }

    /**
     * json转JsonTree
     *
     * @param json json
     * @return {@link JsonNode}
     */
    public static JsonNode readTree(String json) {
        try {
            return OBJECT_MAPPER.readTree(json);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * byte[]转JsonTree
     *
     * @param data json字节
     * @return {@link JsonNode}
     */
    public static JsonNode readTree(byte[] data) {
        try {
            return OBJECT_MAPPER.readTree(data);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * InputStream转JsonTree
     *
     * @param is json输入流
     * @return {@link JsonNode}
     */
    public static JsonNode readTree(InputStream is) {
        try {
            return OBJECT_MAPPER.readTree(is);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 确保这个类中的OBJECT_MAPPER是唯一的，避免产生线程问题
     *
     * @return ObjectMapper的复制对象
     */
    public static ObjectMapper getObjectMapper() {
        return OBJECT_MAPPER.copy();
    }

    @JsonFilter("JacksonFilter")
    public static class JacksonFilter {
    }

}
