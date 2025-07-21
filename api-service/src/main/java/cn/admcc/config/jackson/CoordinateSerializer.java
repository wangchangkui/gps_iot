package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.jsontype.TypeSerializer;
import org.locationtech.jts.geom.Coordinate;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Objects;

/**
 * @author Arjen10
 * @date 2024/6/19 14:24
 */
@Component
public class CoordinateSerializer extends JsonSerializer<Coordinate> {

    /**
     * 将Coordinate对象序列化为JSON格式。
     * 此方法覆盖了默认的序列化行为，以自定义Coordinate对象的JSON表示形式。
     *
     * @param value 待序列化的Coordinate对象。
     * @param gen 用于生成JSON的JsonGenerator对象。
     * @param serializers 序列化器提供者，用于提供额外的序列化器支持。
     * @throws IOException 如果在序列化过程中发生I/O错误。
     */
    @Override
    public void serialize(Coordinate value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        // 检查Coordinate对象是否为null，如果是，则直接写入null值到JSON
        if (Objects.isNull(value)) {
            gen.writeNull();
            return;
        }
        // 开始写入一个JSON对象
        gen.writeStartObject();
        // 写入属性名"x"及其值
        gen.writeFieldName("x");
        gen.writeNumber(value.getX());
        // 写入属性名"y"及其值
        gen.writeFieldName("y");
        gen.writeNumber(value.getY());
        // 如果"z"属性不是NaN，则写入属性名"z"及其值
        if (!Double.isNaN(value.getZ())) {
            gen.writeFieldName("z");
            gen.writeNumber(value.getZ());
        }
        // 结束写入JSON对象
        gen.writeEndObject();
    }

    @Override
    public void serializeWithType(Coordinate value, JsonGenerator gen, SerializerProvider serializers, TypeSerializer typeSer) throws IOException {
        serialize(value, gen, serializers);
    }

}
