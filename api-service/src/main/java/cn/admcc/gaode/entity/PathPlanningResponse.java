package cn.admcc.gaode.entity;

import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:31
 */
@Data
public class PathPlanningResponse {

    private Integer status;

    private String info;

    private String infoCode;

    private Integer count;

    private RouteVo route;
}
