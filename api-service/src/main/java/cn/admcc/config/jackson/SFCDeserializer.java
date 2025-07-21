package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.jsontype.TypeDeserializer;
import lombok.extern.slf4j.Slf4j;
import org.geotools.data.geojson.GeoJSONReader;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @author Arjen10
 * @date 2024/3/19 下午7:54
 */
@Slf4j
@Component
public class SFCDeserializer extends JsonDeserializer<SimpleFeatureCollection> {

    @Override
    public SimpleFeatureCollection deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JacksonException {
        if (p.currentToken() == JsonToken.VALUE_NULL) {
            return null;
        }
        String geojson = p.getText().trim();
        //FIXME 有bug
        return GeoJSONReader.parseFeatureCollection(geojson);
    }

    @Override
    public Object deserializeWithType(JsonParser p, DeserializationContext ctxt,
                                      TypeDeserializer typeDeserializer)
            throws IOException, JacksonException {
        //直接调用deserialize
        return deserialize(p, ctxt);
    }

}
