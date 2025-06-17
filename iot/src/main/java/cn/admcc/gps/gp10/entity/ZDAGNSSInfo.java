package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * $--ZDA,UTCtime,day,month,yea
 *  r,ltzh,ltzn*CS<CR><LF>
 *  $GNZDA,073030.200,09,07,20
 *  24,00,00*47
 * @createTime 17:47
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class ZDAGNSSInfo extends BaseGpsInfo{

    /**
     * 格式：时时分分秒秒.秒秒秒
     * （hhmmss.sss）
     * 073028.600
     */
    @DataIndex(order = 1)
    private String utcTime;

    /**
     * 日，取值范围01~31
     */
    @DataIndex(order = 2)
    private String day;

    /**
     * 月07固定两位数字，取值范围01~12
     */
    @DataIndex(order = 3)
    private String month;

    /**
     *  year年2024固定四位数字
     */
    @DataIndex(order = 4)
    private String year;

    /**
     *  ltzh本时区小时00不支持，固定为00
     */
    @DataIndex(order = 5)
    private String ltzh;

    /**
     *  本时区分钟00不支持，固定为00
     */
    @DataIndex(order = 6)
    private String ltzn;

}
