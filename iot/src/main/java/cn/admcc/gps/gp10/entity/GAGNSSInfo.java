package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 参考示例 $GNGGA,073028.600,2236.40101,N,11349.73472,E,1,19,0.8,14.2,M,-4.0,M,,*6E
 * @createTime 17:09
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class GAGNSSInfo extends BaseGpsInfo{

    /**
     * 格式：时时分分秒秒.秒秒秒
     * （hhmmss.sss）
     * 073028.600
     */
    @DataIndex(order = 1)
    private String utcTime;

    /**
     * 纬度，前2字符表示度，
     * 后面的字符表示分
     * 格式：度度分分.分分分分
     */
    @DataIndex(order = 2)
    private String lat;

    /**
     * 纬度方向北 半球（N）或南半球（S）
     */
    @DataIndex(order = 3)
    private String uLat;

    /**
     * 经度，前3字符表示度，
     * 后面的字符表示分
     * 格式：度度度分分.分分分分
     */
    @DataIndex(order = 4)
    private String lon;

    /**
     * 经度方向E东（E）半球或西（W）半球
     */
    @DataIndex(order = 5)
    private String uLon;

    /**
     * 指示当前定位质量
     * 0定位不可用或无效
     * 1 SPS定位模式，定位有效
     * 6估算模式（航位模式）仅NMEA2.3及以上版本有效
     */
    @DataIndex(order = 6)
    private Integer fs;

    /**
     * 定位的卫星数目 范围 （0-24）
     */
    @DataIndex(order = 7)
    private Integer  numSv;

    /**
     * 水平精度因子（HDOP）0.5~99.99
     */
    @DataIndex(order = 8)
    private Double hdop;

    /**
     * 海拔高度，即接收机天线相对于大地水准面的高度
     */
    @DataIndex(order = 9)
    private Double msl;

    /**
     * 高度单位 默认M
     */
    @DataIndex(order = 10)
    private String uMsl;

    /**
     * 参考椭球面与大地水准面之
     * 间的距离，“-”表示大地水
     * 准面低于参考椭球面
     */
    @DataIndex(order = 11)
    private Double sep;

    /**
     * 高度单位，米
     */
    @DataIndex(order = 12)
    private String uSep;

    /**
     * 差分修正DGPS
     */
    @DataIndex(order = 13)
    private String diffAge;

    /**
     * 差分参考基站标号
     */@DataIndex(order = 14)
    private String diffSta;

}
