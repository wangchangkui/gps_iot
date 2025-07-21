package cn.admcc.config.jackson;

import cn.hutool.core.img.ColorUtil;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.core.type.WritableTypeId;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.jsontype.TypeSerializer;
import org.springframework.stereotype.Component;

import java.awt.*;
import java.io.IOException;
import java.util.Objects;

@Component
public class ColorSerializer extends JsonSerializer<Color> {

    @Override
    public void serialize(Color color, JsonGenerator gen, SerializerProvider serializerProvider) throws IOException {
        if (Objects.isNull(color)) {
            gen.writeNull();
            return;
        }
        gen.writeString(ColorUtil.toHex(color));
    }

    @Override
    public void serializeWithType(Color value, JsonGenerator gen, SerializerProvider provider, TypeSerializer typeSer) throws IOException {
        //对于long，不能直接序列化成字符串，我们需要带上long的相关信息
        WritableTypeId typeIdDef = typeSer.writeTypePrefix(gen, typeSer.typeId(value, value.getClass(), JsonToken.FIELD_NAME));
        serialize(value, gen, provider);
        typeSer.writeTypeSuffix(gen, typeIdDef);
    }

}
