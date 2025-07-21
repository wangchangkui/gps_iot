package cn.admcc.config.jackson;

import cn.hutool.core.util.StrUtil;
import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.jsontype.TypeDeserializer;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @author Arjen10
 * @date 2024/4/29 14:13
 */
@Component
public class LongDeserializer extends JsonDeserializer<Long> {

    @Override
    public Long deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JacksonException {
        JsonToken currentToken = p.currentToken();
        if (currentToken == JsonToken.VALUE_NULL) {
            return null;
        }
        if (p.isExpectedNumberIntToken()) {
            return p.getLongValue();
        }
        String str = p.getText().trim();
        if (StrUtil.isBlank(str)) {
            return null;
        }
        return Long.parseLong(str);
    }

    @Override
    public Long deserializeWithType(JsonParser p, DeserializationContext ctxt,
                                    TypeDeserializer typeDeserializer)
            throws IOException {
        Object v = super.deserializeWithType(p, ctxt, typeDeserializer);
        if (v instanceof Long l) {
            return l;
        }
        ctxt.handleUnexpectedToken(Long.class, p);
        return null; //Jackson说的： never gets here
    }

}
