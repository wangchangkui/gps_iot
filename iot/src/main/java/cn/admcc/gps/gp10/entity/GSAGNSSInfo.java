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
 * 用于定位的卫星编号与DOP信息。不管是
 * 否定位或者是否有可用卫星，都输出GSA
 * 语句；当接收机处于多系统联合工作时，每
 * 个系统的可用卫星对应一条GSA语句，每
 * 条GSA语句都包含根据组合卫星系统得
 * 到的PDOP、HDOP和VDOP
 * 输出
 * $--GSA,smode,FS{,S
 *  VID},PDOP,HDOP,VD
 *  OP*CS<CR><LF>
 *  $GNGSA,A,3,11,13,
 *  15,18,20,24,29,194,
 *  195,199,,,1.4,0.8,1.
 *  1,1*0C
 * @createTime 17:27
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class GSAGNSSInfo extends BaseGpsInfo {

    /**
     * 模式切换方式指示
     * M手动切换。强制为2D或者3D工作模式
     * A自动切换。接收机自动切换2D/3D工作模式
     */
    @DataIndex(order = 1)
    private String sMode;

    /**
     * 定位状态标志
     * 1定位无效
     * 2 2D定位
     * 3 3D定位
     */
    @DataIndex(order = 2)
    private String fs;

    /**
     * 用于定位的卫星编号，该字段共显示12
     * 颗可用卫星编号，多于12颗时只输出前
     * 12颗，不足12颗时不足的区域补空
     */
    @DataIndex(range = {3,14})
    private List<Integer> satellite;

    /**
     * 位置精度因子（PDOP）1.4范围：0.5~99.9
     */
    @DataIndex(order = 15)
    private Double pDop;

    /**
     * 水平精度因子（HDOP）0.8范围：0.5~99.9
     */
    @DataIndex(order = 16)
    private Double hDop;

    /**
     * 水平精度因子（vDOP）0.8范围：0.5~99.9
     */
    @DataIndex(order = 17)
    private Double vDop;

    /**
     * 系统id
     * 1 GPS系统
     * 2 GLONASS系统
     * 4 BDS系统
     */
    @DataIndex(order = 18)
    private String systemId;
}
