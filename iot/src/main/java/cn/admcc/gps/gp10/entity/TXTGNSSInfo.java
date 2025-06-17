package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 输出，开机时输出一次$GPTXT,xx,yy,zz,info*hh<CR><LF>
 *  $GPTXT,01,01,01,ANTENNA
 *  OPEN*25
 * @createTime 17:51
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class TXTGNSSInfo extends BaseGpsInfo {

    /**
     * xx当前消息的语句
     * 总数
     * 01范围：01~99，如果某个消息过长，需要分为
     * 多条信息显示
     */
    @DataIndex(order = 1)
    private Integer xx;

    /**
     * yy语句编号1范围：01~99
     */
    @DataIndex(order = 2)
    private Integer yy;


    /**
     * 00=错误信息；
     * 01=警告信息；
     * 02=通知信息；
     * 07=用户信息。
     */
    @DataIndex(order = 3)
    private String zz;

    /**
     * 文本信息
     * ANTENNA_OPEN=天线开路
     * ANTENNA_OK=天线良好
     * ANTENNA_SHORT=天线短路
     */
    @DataIndex(order = 4)
    private String info;



    public  String getInfoTxt() throws TxtInfoException {
        return switch (this.info) {
            case "ANTENNA OPEN" -> "天线开路";
            case "ANTENNA OK" -> "天线良好";
            case "ANTENNA SHORT" -> "天线短路";
            default -> throw new TxtInfoException("不支持的文本消息，请参考GP10-A的DX-GP10-NMEA0183协议规范");
        };
    }



    public  static String getInfoTxt(String code) throws TxtInfoException {
        return switch (code) {
            case "ANTENNA OPEN" -> "天线开路";
            case "ANTENNA OK" -> "天线良好";
            case "ANTENNA SHORT" -> "天线短路";
            default -> throw new TxtInfoException("不支持的文本消息，请参考GP10-A的DX-GP10-NMEA0183协议规范");
        };
    }



}
