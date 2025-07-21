package cn.admcc.gaode.entity;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:36
 */
@Data
public class RouteVo {

    /**
     * 起始目标
     */
    private String origin;

    /**
     * 终点目标
     */
    private String destination;

    /**
     * 预估打表价格
     */
    private String taxiCost;

    /**
     * 路径方案
     */
    private List<PathsVo> paths;
}
