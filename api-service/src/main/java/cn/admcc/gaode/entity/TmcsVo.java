package cn.admcc.gaode.entity;

import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 高德的矢量路线数据
 * @createTime 14:59
 */
@Data
public class TmcsVo {

    /**
     * 路况信息，包括：未知、畅通、缓行、拥堵、严重拥堵
     */
    private String tmcStatus;

    /**
     * 从当前坐标点开始 step 中路况相同的距离
     */
    private String tmcDistance;


    /**
     * 此段路况涉及的道路坐标点串，点间用","分隔
     */
    private String tmcPolyline;
}
