package cn.admcc.gaode.controller;

import cn.admcc.gaode.entity.TmcsVo;
import cn.admcc.gaode.service.PathPlanningServiceI;
import cn.admcc.util.R;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:21
 */
@RestController
@RequestMapping("/api/gd")
@RequiredArgsConstructor
public class PathPlanningController {


    private final PathPlanningServiceI pathPlanningServiceI;


    /**
     * 路径规划
     * @param start 起始点位置
     * @param end 结束点位
     * @return TmcsVo
     */
    @GetMapping("/path/planning/{start}/{end}")
    public R<List<TmcsVo>> pathPlanning(@PathVariable("start") String start,@PathVariable("end") String end){
        return R.success(pathPlanningServiceI.pathPlanning(start,end));
    }


}
