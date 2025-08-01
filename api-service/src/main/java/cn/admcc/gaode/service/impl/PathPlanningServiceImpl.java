package cn.admcc.gaode.service.impl;

import cn.admcc.gaode.api.GdApi;
import cn.admcc.gaode.config.GdConfig;
import cn.admcc.gaode.entity.*;
import cn.admcc.gaode.entity.enums.GdApiResponseStatus;
import cn.admcc.gaode.exception.GdException;
import cn.admcc.gaode.service.PathPlanningServiceI;
import cn.admcc.util.JacksonUtils;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:40
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PathPlanningServiceImpl implements PathPlanningServiceI {

    private final GdApi gdApi;

    private final GdConfig gdConfig;

    @Override
    public List<String> pathPlanning(String startPoint, String endPoint) {

        PathPlanningRequest pathPlanningRequest = new PathPlanningRequest(gdConfig.getApiToken(), startPoint, endPoint);
        // 默认采用2号方案，具体可以参考高德API接口
        pathPlanningRequest.setStrategy(2);
        pathPlanningRequest.setShowFields("tmcs,polyline");

        ObjectMapper snakeCaseOm = JacksonUtils.getSnakeCaseOm();
        Map<String, Object> map = snakeCaseOm.convertValue(pathPlanningRequest, new TypeReference<>() {});

        PathPlanningResponse pathPlanningResponse = gdApi.pathPlaningApi(map);
        if(pathPlanningResponse.getStatus().equals(GdApiResponseStatus.ERROR.getCode())) {
            log.error("路径规划失败：{}",pathPlanningResponse);
            throw new GdException(pathPlanningResponse.getInfo());
        }

        if (pathPlanningResponse.getCount()== 0) {
            throw new GdException("该位置不可达");
        }

        // 默认取第一条数据
        PathsVo pathsVo = pathPlanningResponse.getRoute().getPaths().get(0);


        return pathsVo.getSteps().stream().map(StepsVo::getPolyline).toList();
    }
}
