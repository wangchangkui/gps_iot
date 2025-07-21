package cn.admcc.config;

import cn.admcc.config.jackson.*;
import cn.hutool.core.date.DatePattern;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
import lombok.extern.slf4j.Slf4j;
import org.geotools.api.referencing.crs.CoordinateReferenceSystem;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.Envelope;
import org.locationtech.jts.geom.Geometry;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

import java.awt.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;

import static cn.hutool.core.date.DatePattern.NORM_DATETIME_FORMATTER;
import static cn.hutool.core.date.DatePattern.NORM_DATE_FORMATTER;

/**
 * @author Arjen10
 * @date 2022/4/26 11:35
 */
@Slf4j
@Configuration
public class ResultJsonFormatConfig {

    @Bean
    public LocalDateTimeSerializer getLocalDateTimeSerializer() {
        return new LocalDateTimeSerializer(NORM_DATETIME_FORMATTER);
    }

    @Bean
    public LocalDateTimeDeserializer getLocalDateTimeDeserializer() {
        return new LocalDateTimeDeserializer(NORM_DATETIME_FORMATTER);
    }

    @Bean
    public LocalDateSerializer getLocalDateSerializer() {
        return new LocalDateSerializer(NORM_DATE_FORMATTER);
    }

    @Bean
    public LocalDateDeserializer getLocalDateDeserializer() {
        return new LocalDateDeserializer(NORM_DATE_FORMATTER);
    }

    /**
     * 基础ObjectMapper
     *
     * @return ObjectMapper
     */
    @Primary
    @Bean("baseOM")
    public ObjectMapper getBaseOM(LocalDateTimeSerializer ldts, LocalDateTimeDeserializer ldtd,
                                  LocalDateDeserializer ldd, LocalDateSerializer dateSer,
                                  CRSSerializer cs, CRSDeserializer cds,
                                  EnvelopeSerializer es, EnvelopeDeserializer eds,
                                  SFCSerializer sfcSerializer, SFCDeserializer sfcDeserializer,
                                  GeoJSONSerializer gs, GeoJSONDeserializer gds,
                                  CoordinateSerializer coors, CoordinateDeserializer coordDes,
                                  LongSerializer ls, LongDeserializer lds,
                                  ColorSerializer colorSerializer, ColorDeserializer colorDeserializer) {
        ObjectMapper om = new Jackson2ObjectMapperBuilder()
            .findModulesViaServiceLoader(true)
            .serializerByType(LocalDateTime.class, ldts)
            .deserializerByType(LocalDateTime.class, ldtd)
            .serializerByType(LocalDate.class, dateSer)
            .deserializerByType(LocalDate.class, ldd)
            .serializerByType(CoordinateReferenceSystem.class, cs)
            .deserializerByType(CoordinateReferenceSystem.class, cds)
            .serializerByType(Envelope.class, es)
            .deserializerByType(Envelope.class, eds)
            .serializerByType(SimpleFeatureCollection.class, sfcSerializer)
            .deserializerByType(SimpleFeatureCollection.class, sfcDeserializer)
            .serializerByType(Geometry.class, gs)
            .deserializerByType(Geometry.class, gds)
            .serializerByType(Coordinate.class, coors)
            .deserializerByType(Coordinate.class, coordDes)
            .serializerByType(Long.class, ls)
            .deserializerByType(Long.class, lds)
            .serializerByType(Color.class, colorSerializer)
            .deserializerByType(Color.class, colorDeserializer)
            .dateFormat(new SimpleDateFormat(DatePattern.NORM_DATETIME_PATTERN))
            .build();
        om.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
        return om;
    }

    /**
     * 前端用的ObjectMapper
     *
     * @param om baseObjectMapper
     * @return 复制了一份的ObjectMapper
     */
    @Bean("webOM")
    public ObjectMapper getWebOM(@Qualifier("baseOM") ObjectMapper om) {
        ObjectMapper copy = om.copy();
        copy.getSerializerProvider()
            .setNullValueSerializer(new JsonSerializer<>() {
                @Override
                public void serialize(Object o, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)
                    throws IOException {
                    jsonGenerator.writeNull();
                }
            });
        return copy;
    }

    @Bean
    public MappingJackson2HttpMessageConverter jackson2HttpMessageConverter(@Qualifier("webOM") ObjectMapper om) {
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setObjectMapper(om);
        return converter;
    }

}
