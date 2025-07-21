package cn.admcc.gaode.api;

import cn.admcc.gaode.entity.PathPlanningRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import org.springframework.web.service.annotation.PostExchange;

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
    @GetExchange("/v5/direction/driving")
    Object pathPlaningApi(PathPlanningRequest parameters);

}
