package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * 接收机伪距的测
 * 量精度详细信息输出
 * $--GST,UTCtime,RMS,stdDevMaj,
 *  stdfDevMin,orientation,stdLat,st
 *  dLon,stdAlt*CS<CR><LF>
 *  $GMGST,102017.000,0.0,68.0,
 *  14.7,108.6,35.9,74.8,66.1*4A
 * @createTime 17:55
 */
@EqualsAndHashCode(callSuper = true)
@Data

public class GSTGPNSSInfo extends BaseGpsInfo{

    /**
     * 格式：时时分分秒秒.秒秒秒
     * （hhmmss.sss）
     * 073028.600
     */
    @DataIndex(order = 1)
    private String utcTime;

    /**
     * 定位过程中接收机伪距
     * 误差标准差的RMS值
     */
    @DataIndex(order = 2)
    private Double rms;

    /**
     * 接收机椭圆半长轴方向
     * 的位置标准差
     */
    @DataIndex(order = 3)
    private Double stdDevMaj;

    /**
     * 接收机椭圆半短轴方向
     * 的位置标准差
     */
    @DataIndex(order = 4)
    private Double stdfDevMin;

    /**
     * 接收机椭圆半长轴方向
     * 的朝向
     */
    @DataIndex(order = 5)
    private Double orientation;

    /**
     * 接收机纬度向误差的标
     * 准差
     */
    @DataIndex(order = 6)
    private Double stdLat;

    /**
     * 接收机经度向误差的标
     * 准差
     */
    @DataIndex(order = 7)
    private Double stdLon;

    /**
     * 接收机高度向误差的标
     * 准差
     */
    @DataIndex(order = 8)
    private Double stdAlt;



}
