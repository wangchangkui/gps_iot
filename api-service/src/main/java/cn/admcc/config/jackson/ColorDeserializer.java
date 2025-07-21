package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.jsontype.TypeDeserializer;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.awt.*;
import java.io.IOException;

@Component
public class ColorDeserializer extends JsonDeserializer<Color> {

    @Override
    public Color deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        if (p.currentToken() == JsonToken.VALUE_NULL) {
            return null;
        }
        String hex = p.getValueAsString();
        if (!StringUtils.hasText(hex)) {
            return null;
        }
        if (!hex.startsWith("#")) {
            throw ctxt.weirdStringException(hex, Color.class, "必须#开头");
        }
        try {
            return Color.decode(hex);
        } catch (NumberFormatException e) {
            throw ctxt.weirdStringException(hex, Color.class, e.getMessage());
        }
    }

    @Override
    public Color deserializeWithType(JsonParser p, DeserializationContext ctxt,
                                      TypeDeserializer typeDeserializer) throws IOException {
        Object v = super.deserializeWithType(p, ctxt, typeDeserializer);
        if (v instanceof Color c) {
            return c;
        }
        ctxt.handleUnexpectedToken(Color.class, p);
        return null; //Jackson说的： never gets here
    }

}
