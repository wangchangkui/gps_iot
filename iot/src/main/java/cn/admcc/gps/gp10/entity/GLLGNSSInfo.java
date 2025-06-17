package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 参考示例 $GNGLL,2236.40101,N,11349.73472,E,073028.600,A,A*45
 * $--GLL,lat,uLat,lon,uLon,UTCtime,valid,mode*CS<CR><LF>
 * @createTime 17:20
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class GLLGNSSInfo extends BaseGpsInfo {



    /**
     * 纬度，前2字符表示度，
     * 后面的字符表示分
     * 格式：度度分分.分分分分
     */
    @DataIndex(order = 1)
    private String lat;

    /**
     * 纬度方向北 半球（N）或南半球（S）
     */
    @DataIndex(order = 2)
    private String uLat;

    /**
     * 经度，前3字符表示度，
     * 后面的字符表示分
     * 格式：度度度分分.分分分分
     */
    @DataIndex(order = 3)
    private String lon;

    /**
     * 经度方向E东（E）半球或西（W）半球
     */
    @DataIndex(order = 4)
    private String uLon;


    /**
     * 格式：时时分分秒秒.秒秒秒
     * （hhmmss.sss）
     * 073028.600
     */
    @DataIndex(order = 5)
    private String utcTime;


    /**
     * 定位质量 A有效  V 无效
     */
    @DataIndex(order = 6)
    private String valid;

    /**
     * 定位模式
     * A自主模式
     * E估算模式（航位推算）
     * N数据无效
     * D差分模式
     * M未定位，但存在外部输入或历史保存的位置
     */
    @DataIndex(order = 7)
    private String mode;
}
