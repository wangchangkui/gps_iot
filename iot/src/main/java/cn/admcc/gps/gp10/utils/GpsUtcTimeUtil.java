package cn.admcc.gps.gp10.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:11
 */
public class GpsUtcTimeUtil {

    /**
     * 原始格式
     * 格式：时时分分秒秒.秒秒秒
     *（hhmmss.sss）
     * 调用该方法默认获取当前年月日+格式时间 yyyy-mm-dd HH:mm:ss
     * @return
     */
    public static String resetGpsUtcTimeToGmtTime(String gpsUtcTime){
        // 获取当前日期
        LocalDate currentDate = LocalDate.now();

        // 解析GPS UTC时间
        int hours = Integer.parseInt(gpsUtcTime.substring(0, 2));
        int minutes = Integer.parseInt(gpsUtcTime.substring(2, 4));
        int seconds = Integer.parseInt(gpsUtcTime.substring(4, 6));
        int milliseconds = Integer.parseInt(gpsUtcTime.substring(7));

        // 创建 LocalDateTime 对象
        LocalDateTime dateTime = LocalDateTime.of(
                currentDate.getYear(),
                currentDate.getMonth(),
                currentDate.getDayOfMonth(),
                hours,
                minutes,
                seconds,
                milliseconds * 1_000_000
        );
        // UTC需要加8小时才能是GMT时间
        dateTime = dateTime.plusHours(8);

        // 格式化为 yyyy-MM-dd HH:mm:ss
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return dateTime.format(formatter);


    }


    /**
     * 将日期格式从 "日日月月年年" 转换为 "yyyy-MM-dd"
     * @param date 输入的日期字符串，格式为 "日日月月年年"
     * @return 格式化后的日期字符串，格式为 "yyyy-MM-dd"
     */
    public static String convertToDateYmd(String date) {
        // 提取输入日期中的日、月、年
        int day = Integer.parseInt(date.substring(0, 2));
        int month = Integer.parseInt(date.substring(2, 4));
        int year = Integer.parseInt(date.substring(4, 6));

        // 假设年份为 20xx 年
        int fullYear = 2000 + year;

        // 创建 LocalDate 对象
        LocalDate localDate = LocalDate.of(fullYear, month, day);

        // 格式化为 "yyyy-MM-dd"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return localDate.format(formatter);
    }

}
