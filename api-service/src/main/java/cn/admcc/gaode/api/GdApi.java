package cn.admcc.gaode.api;

import cn.admcc.gaode.entity.PathPlanningResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.service.annotation.HttpExchange;
import org.springframework.web.service.annotation.PostExchange;

import java.util.Map;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 高德Api接口
 * @createTime 15:34
 */
@Component
@HttpExchange
public interface GdApi {


    /**
     * 高德地图路径规划
     * @param parameters 路径规划必要的参数
     * @return Object
     */
    @PostExchange("/v5/direction/driving")
    PathPlanningResponse pathPlaningApi(@RequestParam Map<?,?> parameters);

}
