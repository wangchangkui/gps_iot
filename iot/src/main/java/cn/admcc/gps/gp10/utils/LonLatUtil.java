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

    public static String resetLonLat(String lonLat){
        try {
            BigDecimal bigDecimal = new BigDecimal(lonLat);
            BigDecimal divide = bigDecimal.divide(new BigDecimal("100"), RoundingMode.DOWN);
            // Move the decimal point two places to the left
            return divide.toString();
        } catch (NumberFormatException e) {
            // Handle the case where the input is not a valid number
            throw new IllegalArgumentException("Invalid longitude or latitude format", e);
        }

    }
}
