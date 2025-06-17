package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * --RMC,UTCtime,status,lat,uL
 *  at,lon,uLon,spd,cog,date,mv,
 *  mvE,mode*CS<CR><LF>
 *  $GNRMC,073028.600,A,2236.401
 *  01,N,11349.73472,E,0.00,0.00,090
 *  724,,,A,V*00
 * @createTime 17:39
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class RMCGNSSInfo extends BaseGpsInfo {

    /**
     * 格式：时时分分秒秒.秒秒秒
     * （hhmmss.sss）
     * 073028.600
     *
     */
    @DataIndex(order = 1)
    private String utcTime;

    /**
     * V=接收机警告，数据无效
     * A=数据有效
     */
    @DataIndex(order = 2)
    private String status;

    /**
     * 纬度，前2字符表示度，
     * 后面的字符表示分
     * 格式：度度分分.分分分分
     */
    @DataIndex(order =3 )
    private String lat;

    /**
     * 纬度方向北 半球（N）或南半球（S）
     */
    @DataIndex(order = 4)
    private String uLat;

    /**
     * 经度，前3字符表示度，
     * 后面的字符表示分
     * 格式：度度度分分.分分分分
     */
    @DataIndex(order = 5)
    private String lon;

    /**
     * 经度方向E东（E）半球或西（W）半球
     */
    @DataIndex(order = 6)
    private String uLon;

    /**
     * 对地速度
     */
    @DataIndex(order = 7)
    private Double spd;

    /**
     * 对地真航向
     */
    @DataIndex(order = 8)
    private Double cog;

    /**
     * date日期090724格式:日日月月年年
     */
    @DataIndex(order = 9)
    private String date;

    /**
     * 磁偏角单位为度。固定为空
     */
    @DataIndex(order = 10)
    private Double mv;

    /**
     * 磁偏角方向E-东，W-西。固定为空
     */
    @DataIndex(order = 11)
    private Double mvE;

    /**
     * 定位模式标志
     * A自主模式
     * E估算模式（航位推算）
     * N数据无效
     * D差分模式
     * M未定位，但存在外部输入或历史保存的位置
     */
    @DataIndex(order = 12)
    private String mode;


    /**
     * 导航状态标示符V
     */
    @DataIndex(order = 13)
    private String navStatus;


}
