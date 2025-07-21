package cn.admcc.config.jackson;

import cn.hutool.core.util.NumberUtil;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.util.Objects;

/**
 *
 * double 保留两位小数
 *
 * @author Arjen10
 * @date 2022/11/22 18:04
 */
@Slf4j
public class DoubleSerializer extends JsonSerializer<Double> {

    @Override
    public void serialize(Double value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (Objects.isNull(value)) {
            gen.writeNull();
            return;
        }
        if (value == 0) {
            gen.writeNumber(0d);
            return;
        }
        gen.writeNumber(NumberUtil.round(value, 2).doubleValue());
    }

}
