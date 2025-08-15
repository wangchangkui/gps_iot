package cn.admcc.device.service.impl;

import cn.admcc.device.dao.DeviceTempDataMapper;
import cn.admcc.device.entity.DeviceTempData;
import cn.admcc.device.entity.dto.IotGpsData;
import cn.admcc.device.service.DeviceTempDataServiceI;
import cn.admcc.gps.gp10.TempDataHandler;
import cn.admcc.gps.gp10.entity.BaseGpsInfo;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 18:46
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class DeviceTempDataServiceImpl extends ServiceImpl<DeviceTempDataMapper, DeviceTempData> implements DeviceTempDataServiceI, TempDataHandler {



    @Override
    public void addData(IotGpsData data) {
        if(StrUtil.isEmpty(data.getValue()) || data.getDeviceId() == null){
            return;
        }
        DeviceTempData deviceTempData = new DeviceTempData();
        deviceTempData.setDeviceId(data.getDeviceId());
        deviceTempData.setTempData(data.getValue().replaceAll("\\n",""));
        deviceTempData.setTime(LocalDateTime.now());
        deviceTempData.setId(IdUtil.getSnowflakeNextId());
        log.info("deviceTempData:{}",deviceTempData);
        this.save(deviceTempData);
    }



    @Override
    public void handler(BaseGpsInfo baseGpsInfo) {
        DeviceTempData deviceTempData = new DeviceTempData();
        deviceTempData.setDeviceId((Long) baseGpsInfo.getDeviceId());
        deviceTempData.setTempData(baseGpsInfo.getDataSource());
        deviceTempData.setTime(LocalDateTime.now());
        deviceTempData.setId(IdUtil.getSnowflakeNextId());
        this.save(deviceTempData);
    }
}
