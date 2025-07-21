package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.jsontype.TypeDeserializer;
import org.locationtech.jts.geom.Coordinate;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @author Arjen10
 * @date 2024/6/19 14:15
 */
@Component
public class CoordinateDeserializer extends JsonDeserializer<Coordinate> {

    /**
     * 从JSON解析器中反序列化出Coordinate对象。
     * 此方法用于将JSON格式的数据转换为Coordinate对象。如果遇到null值，则直接返回null；
     * 如果当前Token不是对象的开始标记，则抛出异常，表示解析出错。
     *
     * @param p    JSON解析器，用于读取和解析JSON数据。
     * @param ctxt 解析上下文，提供了解析过程中所需的配置和辅助功能。
     * @return 解析出的Coordinate对象，如果输入为null，则返回null。
     * @throws IOException            如果在读取JSON数据时发生错误。
     * @throws JacksonException       如果在处理JSON数据时发生错误。
     */
    @Override
    public Coordinate deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JacksonException {
        // 检查当前Token是否为NULL，如果是，则直接返回null。
        if (p.currentToken() == JsonToken.VALUE_NULL) {
            return null;
        }
        // 检查当前Token是否为对象的开始，如果不是，则抛出异常。
        if (!p.isExpectedStartObjectToken()) {
            throw ctxt.wrongTokenException(p, Coordinate.class, p.currentToken(), "Coordinate 应该为对象类型");
        }
        // 创建一个NodeTree以便于解析对象内容
        JsonNode node = p.getCodec().readTree(p);
        JsonNode xNode = node.at("/x");
        JsonNode yNode = node.at("/y");
        JsonNode zNode = node.at("/z");
        if (xNode.isMissingNode() || yNode.isMissingNode() || xNode.isNull() || yNode.isNull()) {
            throw ctxt.wrongTokenException(p, Coordinate.class, p.currentToken(), "Coordinate x,y不能为null");
        }
        if (zNode.isMissingNode() || zNode.isNull()) {
            return new Coordinate(xNode.asDouble(), yNode.asDouble());
        }
        return new Coordinate(xNode.asDouble(), yNode.asDouble(), zNode.asDouble());
    }


    @Override
    public Object deserializeWithType(JsonParser p, DeserializationContext ctxt,
                                      TypeDeserializer typeDeserializer)
        throws IOException, JacksonException {
        return deserialize(p, ctxt);
    }

}
