package cn.admcc.gps.gp10.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:11
 */
public class LonLatUtil {

    public static String resetLonLat(String lonLat) {
        try {
            // 将输入字符串转换为 BigDecimal
            BigDecimal input = new BigDecimal(lonLat);
            // 提取度部分（整数部分）
            BigDecimal degrees = input.divide(new BigDecimal("100"), 0, RoundingMode.DOWN);
            // 提取分部分（小数部分）
            BigDecimal minutes = input.remainder(new BigDecimal("100"));
            // 计算十进制格式的经纬度
            BigDecimal decimalValue = degrees.add(minutes.divide(new BigDecimal("60"), 6, RoundingMode.HALF_UP));
            // 返回结果，保留6位小数
            return decimalValue.setScale(6, RoundingMode.HALF_UP).toString();
        } catch (NumberFormatException e) {
            // Handle the case where the input is not a valid number
            throw new IllegalArgumentException("Invalid longitude or latitude format", e);
        }

    }


    public static String resetLonLat(String lonLat, String mr) {
        try {
            // 计算十进制格式的经纬度
            BigDecimal decimalValue = new BigDecimal(resetLonLat(lonLat));
            // 根据 mr 的值调整符号
            if ("S".equalsIgnoreCase(mr) || "W".equalsIgnoreCase(mr)) {
                // 转为负数
                decimalValue = decimalValue.negate();
            } else if (!"N".equalsIgnoreCase(mr) && !"E".equalsIgnoreCase(mr)) {
                throw new IllegalArgumentException("Invalid direction value: " + mr);
            }
            // 返回结果，保留6位小数
            return decimalValue.toString();
        } catch (NumberFormatException e) {
            // 处理输入格式错误的情况
            throw new IllegalArgumentException("Invalid longitude or latitude format: " + lonLat, e);
        }



    }
}
