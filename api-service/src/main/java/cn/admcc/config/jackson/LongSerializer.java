package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.core.type.WritableTypeId;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.jsontype.TypeSerializer;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Objects;

/**
 * @author Arjen10
 * @date 2024/4/29 14:08
 */
@Component
public class LongSerializer extends JsonSerializer<Long> {

    @Override
    public void serialize(Long value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (Objects.isNull(value)) {
            gen.writeNull();
            return;
        }
        gen.writeString(value.toString());
    }

    @Override
    public void serializeWithType(Long value, JsonGenerator gen, SerializerProvider provider, TypeSerializer typeSer) throws IOException {
        //对于long，不能直接序列化成字符串，我们需要带上long的相关信息
        WritableTypeId typeIdDef = typeSer.writeTypePrefix(gen, typeSer.typeId(value, Long.class, JsonToken.VALUE_STRING));
        serialize(value, gen, provider);
        typeSer.writeTypeSuffix(gen, typeIdDef);
    }

}
