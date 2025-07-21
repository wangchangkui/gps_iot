package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.jsontype.TypeDeserializer;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Envelope;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Arjen10
 * @date 2024/3/15 上午10:42
 */
@Slf4j
@Component
public class EnvelopeDeserializer extends JsonDeserializer<Envelope> {

    @Override
    public Envelope deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        if (p.currentToken() == JsonToken.VALUE_NULL) {
            return null;
        }
        // 预期数组开始
        if (!p.isExpectedStartArrayToken()) {
            throw ctxt.wrongTokenException(p, Envelope.class, p.currentToken(), "bbox 应该为数组类型");
        }
        List<Double> doubleList = new LinkedList<>();
        // 循环遍历数组元素
        while (p.nextToken() != JsonToken.END_ARRAY) {
            // 确保当前令牌是数值
            JsonToken currentToken = p.currentToken();
            if (currentToken != JsonToken.VALUE_NUMBER_FLOAT) {
                throw ctxt.wrongTokenException(p, Envelope.class, currentToken, "bbox 应该为double类型");
            }
            double value = p.getDoubleValue();
            doubleList.add(value);
        }
        if (doubleList.size() != 4) {
            throw ctxt.instantiationException(Envelope.class, "bbox 长度只能为4");
        }
        return new Envelope(doubleList.get(0), doubleList.get(2), doubleList.get(1), doubleList.get(3));
    }


    @Override
    public Object deserializeWithType(JsonParser p, DeserializationContext ctxt,
                                      TypeDeserializer typeDeserializer)
            throws IOException, JacksonException {
        //直接调用deserialize反序列化Envelope
        return deserialize(p, ctxt);
    }


}
