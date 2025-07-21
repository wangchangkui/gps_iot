package cn.admcc.config.jackson;


import cn.admcc.util.JacksonUtils;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.jsontype.TypeSerializer;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.geotools.api.feature.simple.SimpleFeature;
import org.geotools.api.referencing.FactoryException;
import org.geotools.api.referencing.crs.CoordinateReferenceSystem;
import org.geotools.data.geojson.GeoJSONWriter;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.referencing.CRS;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Objects;

/**
 * @author Arjen10
 * @date 2024/3/19 下午5:18
 */
@Slf4j
@Component
public class SFCSerializer extends JsonSerializer<SimpleFeatureCollection> {

    @Override
    public void serialize(SimpleFeatureCollection value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (Objects.isNull(value)) {
            gen.writeNull();
            return;
        }
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        try (GeoJSONWriter writer = new GeoJSONWriter(out);
             SimpleFeatureIterator itr = value.features()) {
            //不要让他给我重投影
            writer.setEncodeFeatureCollectionCRS(true);
            while (itr.hasNext()) {
                SimpleFeature f = itr.next();
                writer.write(f);
            }
        }
        CoordinateReferenceSystem sourceCRS = value.getSchema().getCoordinateReferenceSystem();
        ObjectNode objectNode = (ObjectNode) JacksonUtils.readTree(out.toByteArray());
        if (Objects.isNull(sourceCRS)) {
            gen.writeObject(objectNode);
            return;
        }
        try {
            // 获取 EPSG 代码
            Integer epsgCode = CRS.lookupEpsgCode(sourceCRS, true);
            // 构建 urn
            ObjectNode crsNameNode = JacksonUtils.createObjectNode();
            crsNameNode.put("name", "urn:ogc:def:crs:EPSG::" + epsgCode);
            JsonNode crsNode = JacksonUtils.createObjectNode()
                    .put("type", "name")
                    .set("properties", crsNameNode);
            gen.writeObject(objectNode.set("crs", crsNode));
        } catch (FactoryException e) {
            log.warn("序列化参考坐标系失败！{}", e.getMessage());
            gen.writeObject(objectNode);
        }
    }

    @Override
    public void serializeWithType(SimpleFeatureCollection value, JsonGenerator gen, SerializerProvider serializers, TypeSerializer typeSer) throws IOException {
        serialize(value, gen, serializers);
    }

}
