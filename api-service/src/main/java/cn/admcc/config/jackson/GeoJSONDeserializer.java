package cn.admcc.config.jackson;


import cn.admcc.util.gis.GeoToolsUtils;
import com.fasterxml.jackson.core.JacksonException;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonTokenId;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.jsontype.TypeDeserializer;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Geometry;
import org.locationtech.jts.io.ParseException;
import org.locationtech.jts.io.WKTReader;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @author Arjen10
 * @date 2022/8/30 11:03
 */
@Slf4j
@Component
public class GeoJSONDeserializer extends JsonDeserializer<Geometry> {

    @Override
    public Geometry deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        if (!p.hasTokenId(JsonTokenId.ID_STRING)) {
            return null;
        }

        String jsonOrWKT = p.getText().trim();
        if (jsonOrWKT.startsWith("{") && jsonOrWKT.endsWith("}")) {
            try {
                return GeoToolsUtils.geoJsonToGeometry(jsonOrWKT);
            } catch (Exception e) {
                throw new JsonParseException(p, "解析geojson数据异常！ " + e.getMessage());
            }
        }

        try {
            WKTReader reader = new WKTReader();
            return reader.read(jsonOrWKT);
        } catch (ParseException e) {
            throw new JsonParseException(p, "解析WKT数据异常！ " + e.getMessage());
        }
    }

    @Override
    public Object deserializeWithType(JsonParser p, DeserializationContext ctxt,
                                      TypeDeserializer typeDeserializer)
            throws IOException, JacksonException {
        //直接调用deserialize反序列化CoordinateReferenceSystem接口
        return deserialize(p, ctxt);
    }

}

