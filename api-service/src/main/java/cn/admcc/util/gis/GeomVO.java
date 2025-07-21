package cn.admcc.util.gis;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.locationtech.jts.geom.Geometry;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Arjen10
 * @date 2022/6/10 15:30
 * @since 1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class GeomVO {

    /**
     * 空间信息对象实体
     */
    private Geometry geometry;

    /**
     * 属性集合
     */
    private List<Property> properties = new LinkedList<>();

    public void addProperty(Collection<org.geotools.api.feature.Property> properties) {
        List<Property> list = properties.stream()
            .map(Property::new)
            .toList();
        this.properties.addAll(list);
    }

    public void addProperty(String key, Object value) {
        Property property = new Property(key, value);
        this.properties.add(property);
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Property {

        /**
         * 属性名称
         */
        private String name;

        /**
         * 属性值
         */
        private Object v;

        public Property(org.geotools.api.feature.Property geotoolsProperty) {
            this.name = geotoolsProperty.getName().toString();
            this.v = geotoolsProperty.getValue();
        }

    }

}
