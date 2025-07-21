package cn.admcc.config.jackson;


import cn.admcc.util.gis.GeoToolsUtils;
import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.jsontype.TypeDeserializer;
import lombok.extern.slf4j.Slf4j;
import org.geotools.api.referencing.crs.CoordinateReferenceSystem;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Arjen10
 * @date 2024/1/29 下午3:58
 */
@Slf4j
@Component
public class CRSDeserializer extends JsonDeserializer<CoordinateReferenceSystem> {

    private static final Pattern PATTERN = Pattern.compile("^EPSG:(\\d+)$");

    @Override
    public CoordinateReferenceSystem deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JacksonException {
        JsonToken currentToken = p.currentToken();
        if (currentToken == JsonToken.VALUE_NULL) {
            return null;
        }
        if (currentToken != JsonToken.VALUE_STRING) {
            throw ctxt.wrongTokenException(p, CoordinateReferenceSystem.class, currentToken, "epsg代码必须是字符串！");
        }
        String epsg = p.getText().trim();
        Matcher m = PATTERN.matcher(epsg);
        if (!m.matches()) {
            throw ctxt.weirdStringException(epsg, CoordinateReferenceSystem.class, "epsg代码格式不对！");
        }
        return GeoToolsUtils.decode(epsg);
    }

    @Override
    public Object deserializeWithType(JsonParser p, DeserializationContext ctxt,
                                      TypeDeserializer typeDeserializer)
            throws IOException, JacksonException {
        //直接调用deserialize反序列化CoordinateReferenceSystem接口
        return deserialize(p, ctxt);
    }

}
