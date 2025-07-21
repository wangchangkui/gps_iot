package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.jsontype.TypeSerializer;
import lombok.extern.slf4j.Slf4j;
import org.geotools.api.referencing.FactoryException;
import org.geotools.api.referencing.crs.CoordinateReferenceSystem;
import org.geotools.referencing.CRS;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Objects;

/**
 * @author Arjen10
 * @date 2024/1/29 下午4:03
 */
@Slf4j
@Component
public class CRSSerializer extends JsonSerializer<CoordinateReferenceSystem> {

    @Override
    public void serialize(CoordinateReferenceSystem crs, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (Objects.isNull(crs)) {
            gen.writeNull();
            return;
        }
        try {
            String epsg = CRS.lookupIdentifier(crs, true);
            gen.writeString(epsg);
        } catch (FactoryException e) {
            throw new IOException(e);
        }
    }

    @Override
    public void serializeWithType(CoordinateReferenceSystem value, JsonGenerator g, SerializerProvider serializers, TypeSerializer typeSer) throws IOException {
        //针对CoordinateReferenceSystem，直接调用serialize序列化成字符串
        serialize(value, g, serializers);
    }

}
