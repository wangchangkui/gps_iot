package cn.admcc.config.jackson;


import cn.admcc.util.JacksonUtils;
import cn.admcc.util.gis.GeoToolsUtils;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.core.type.WritableTypeId;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.jsontype.TypeSerializer;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Geometry;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @author Arjen10
 * @date 2022/8/30 11:08
 */
@Slf4j
@Component
public class GeoJSONSerializer extends JsonSerializer<Geometry> {

    @Override
    public void serialize(Geometry value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        String geojson = GeoToolsUtils.geometryToGeoJSON(value);
        gen.writeTree(JacksonUtils.readTree(geojson));
    }

    /**
     * 序列化带有类型的几何对象。
     * 此方法重写了Jackson库中StdSerializer类的方法，以支持带有类型信息的几何对象的JSON序列化。
     * 它首先写入类型的前缀，然后序列化几何对象本身，最后写入类型的后缀，以确保JSON输出中包含完整的类型信息。
     *
     * @param value 需要序列化的几何对象。
     * @param g JSON生成器，用于写入序列化后的JSON数据。
     * @param serializers 序列化提供者，用于获取序列化器实例。
     * @param typeSer 类型序列化器，用于处理类型的序列化。
     * @throws IOException 如果在序列化过程中发生I/O错误。
     */
    @Override
    public void serializeWithType(Geometry value, JsonGenerator g, SerializerProvider serializers, TypeSerializer typeSer) throws IOException {
        // 写入类型的前缀，包括类型标识和序列化器决定的其他类型信息。
        WritableTypeId typeIdDef = typeSer.writeTypePrefix(g,
            typeSer.typeId(value, value.getClass(), JsonToken.VALUE_STRING));

        serialize(value, g, serializers);
        // 写入类型的后缀，完成类型的序列化标记。
        typeSer.writeTypeSuffix(g, typeIdDef);
    }

}
