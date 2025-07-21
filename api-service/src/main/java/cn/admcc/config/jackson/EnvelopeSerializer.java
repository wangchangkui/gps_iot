package cn.admcc.config.jackson;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.jsontype.TypeSerializer;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Envelope;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Objects;

/**
 * @author Arjen10
 * @date 2024/3/1 上午9:51
 */
@Slf4j
@Component
public class EnvelopeSerializer extends JsonSerializer<Envelope> {

    @Override
    public void serialize(Envelope value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        //[xmin, ymin, xmax, ymax]
        if (Objects.isNull(value) || value.isNull()) {
            gen.writeNull();
            return;
        }
        gen.writeStartArray();
        gen.writeNumber(value.getMinX());
        gen.writeNumber(value.getMinY());
        gen.writeNumber(value.getMaxX());
        gen.writeNumber(value.getMaxY());
        gen.writeEndArray();
    }

    @Override
    public void serializeWithType(Envelope value, JsonGenerator g, SerializerProvider serializers, TypeSerializer typeSer) throws IOException {
        //直接调用serialize序列化成字数组
        serialize(value, g, serializers);
    }

}
