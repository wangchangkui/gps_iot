package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 *
 * 可见卫星的卫星
 * 编号及其仰角、
 * 方位角、载噪比
 * 等信息。每条
 * GSV语句中的
 * {卫星编号,仰角,
 * 方位角,载噪比}
 * 参数组的数量可
 * 变，最多为4组，
 * 最少为0组
 * 输出
 * $--GSV,numMsg,
 *  msgNo,numSv{,S
 *  VID,ele,az,cn0}
 *  *CS<CR><LF>
 *  $GPGSV,3,1,12,05,37,054,17,11,18,134,21,13,
 *  42,032,25,15,66,347,28,0*62
 *  $GPGSV,3,2,12,18,38,326,26,20,22,081,29,23,
 *  14,297,,24,42,168,30,0*62
 *  $GPGSV,3,3,12,29,41,235,27,194,12,149,25,1
 *  95,60,141,36,199,60,149,28,0*56
 *  $BDGSV,4,1,13,03,,,30,04,,,27,06,45,176,27,1
 *  0,26,213,27,0*70
 *  $BDGSV,4,2,13,16,45,174,27,23,11,173,24,24,
 *  12,071,30,25,24,123,25,0*75
 *  $BDGSV,4,3,13,28,64,214,30,38,53,022,26,39,
 *  56,166,29,40,,,20,0*41
 *  $BDGSV,4,4,13,59,,,31,0*78
 * @createTime 17:33
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class GSVGNSSInfo extends BaseGpsInfo {
    @Data
    public static class SatelliteInfo {

        /**
         * 卫星id
         */
        @DataIndex(order = 0)
        private String satelliteId;

        /**
         * 卫星仰角
         */
        @DataIndex(order = 1)
        private String els;

        /**
         * 卫星方位角
         */
        @DataIndex(order = 2)
        private String az;

        /**
         * 讯号噪声比(C/No)
         */
        @DataIndex(order = 3)
        private String cno;
    }

    /**
     *  语句总数
     * 每条GSV语句最多输出4颗可见卫星信息，
     * 因此，当该系统可见卫星多于4颗时，将需要
     * 多条GSV语句
     */
    @DataIndex(order = 1)
    private Integer numMsg;

    /**
     * 当前语句编号
     */
    @DataIndex(order = 2)
    private Integer msgNo;

    /**
     * 可见卫星总数
     */
    @DataIndex(order = 3)
    private Integer numSv;

    /**
     * 卫星信息
     *
     */
    @DataIndex(range = {4,19})
    private List<SatelliteInfo> satelliteList;

    /**
     * NMEA所定义的
     * GNSS信号ID
     */
    @DataIndex(order = 20,or = 8)
    private String signalId;


    /**
     * 数据类型 北斗卫星系统 全球导航卫星系统
     */
    private String type;
}
