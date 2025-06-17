package cn.admcc.gps.gp10.entity;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author coder wang
 * @version 1.0.0
 *
 * @description
 * $--VTG,cogt,T,cogm,M,sog,N,
 *  kph,K,mode*CS<CR><LF>
 * $GNVTG, 0.00, T, , M, 0.00, N, 0.00,K,A*23
 * @createTime 17:43
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class VTGGNSSInfo extends BaseGpsInfo{

    /**
     * 对地真北航向 单位为度，范围：000-359
     */
    @DataIndex(order = 1)
    private Double cotg;

    /**
     *  真北指示T
     */
    @DataIndex(order = 2)
    private String  t;

    /**
     * 对地磁北航向单位为度，范围：000-359度
     */
    @DataIndex(order = 3)
    private Double cogm;

    /**
     * M磁北指示M固定为M
     */
    @DataIndex(order = 4)
    private String m;

    /**
     * 对地速度0.00单位为节，范围：00.0-999.9节
     */
    @DataIndex(order = 5)
    private Double sog;

    /**
     *   N速度单位节N固定为N
     */
    @DataIndex(order = 6)
    private String n;

    /**
     * 对地速度0.00单位为千米每小时，00.0至1851公里／小时
     */
    @DataIndex(order = 7)
    private Double kph;

    /**
     * K速度单位K千米每小时，固定为K
     */
    @DataIndex(order = 8)
    private Double k;

    /**
     * 定位模式
     * A自主模式
     * E估算模式（航位推算）
     * N数据无效
     * D差分模式
     * M未定位，但存在外部输入或历史保存的位置
     */
    @DataIndex(order = 9)
    private String mode;


}
