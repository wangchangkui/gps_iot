package cn.admcc.gps.gp10;

import lombok.Getter;

/**
 * @author coder wang
 * @version 1.0.0
 * @description GPS 解密模块
 *
 * 北斗导航卫星系统（BDS）BD
 * 全球定位系统（GPS、SBAS、QZSS）GP
 * 全球导航卫星系统（GLONASS）GL
 * 全球导航卫星系统（GNSS）GN
 * 自定义信息P
 *
 *
 * @createTime 17:02
 */

@Getter
public enum GpsGnssType {
    /**
     * $GNGGA 全球导航卫星系统(GN) GGA( 接收机时间、位)置及定位相关的数据
     */
    GNGGA("$GNGGA"),

    /**
     * 设备信息
     */
    GPTXT("$GPTXT"),

    /**
     * 可见卫星的卫星
     * 编号及其仰角、
     * 方位角、载噪比
     * 等信息。
     */
    GNGSV("$GPGSV"),

    /**
     * 可见卫星的卫星
     * 编号及其仰角、
     * 方位角、载噪比
     * 等信息。
     */
    BDGSV("$BDGSV"),

    /**
     * 当前经度度坐标信息
     */
    GNGLL("$GNGLL"),

    /**
     * 用于定位的卫星编号与DOP信息。
     */
    GNGSA("$GNGSA"),

    /**
     * 推荐的最小定位信息
     */
    GNRMC("$GNRMC"),

    /**
     * 对地速度与对地航向信息
     */
    GNVTG("$GNVTG"),

    /**
     * 接收机伪距的测量精度详细信息
     */
    GMGTS("$GNGTS"),
    ;
    private final String type;

    GpsGnssType(String type) {
        this.type = type;
    }
}
