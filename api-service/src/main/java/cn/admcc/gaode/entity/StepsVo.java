package cn.admcc.gaode.entity;

import lombok.Data;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:32
 */
@Data
public class StepsVo {

    /**
     * 行驶指示
     */
    private String instruction;

    /**
     * 进入道路方向
     */
    private String orientation;

    /**
     * 道路名称
     */
    private String roadName;

    /**
     * 每段路的距离
     */
    private Double stepDistance;

    /**
     * 分段路
     */
    private List<TmcsVo> tmcs;


    /**
     * 路线
     */
    private String polyline;
}
