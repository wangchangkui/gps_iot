package cn.admcc.gaode.service;

import cn.admcc.gaode.entity.TmcsVo;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:26
 */
public interface PathPlanningServiceI {


    /**
     * 路径规划
     *
     * @param startPoint 起始目标
     * @param endPoint   终点目标
     * @return 路径
     */
    List<String> pathPlanning(String startPoint, String endPoint);



}
