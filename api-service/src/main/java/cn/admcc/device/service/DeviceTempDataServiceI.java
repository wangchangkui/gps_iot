package cn.admcc.device.service;

import cn.admcc.device.entity.DeviceTempData;
import cn.admcc.device.entity.dto.IotGpsData;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 18:46
 */
public interface DeviceTempDataServiceI extends IService<DeviceTempData> {

    /**
     * 添加临时数据
     * @param data 数据
     */
    void addData(IotGpsData data);



}
