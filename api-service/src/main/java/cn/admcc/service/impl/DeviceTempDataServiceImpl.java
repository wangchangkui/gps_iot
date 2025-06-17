package cn.admcc.service.impl;

import cn.admcc.dao.DeviceTempDataMapper;
import cn.admcc.entity.DeviceTempData;
import cn.admcc.entity.dto.IotGpsData;
import cn.admcc.service.DeviceTempDataServiceI;
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
public class DeviceTempDataServiceImpl extends ServiceImpl<DeviceTempDataMapper, DeviceTempData> implements DeviceTempDataServiceI {



    @Override
    public void addData(IotGpsData data) {
        // todo 测试数据
        if(StrUtil.isEmpty(data.getValue())){
            return;
        }
        DeviceTempData deviceTempData = new DeviceTempData();
        deviceTempData.setDeviceId(1L);
        deviceTempData.setTempData(data.getValue().replaceAll("\\n",""));
        deviceTempData.setTime(LocalDateTime.now());
        deviceTempData.setId(IdUtil.getSnowflakeNextId());
        log.info("deviceTempData:{}",deviceTempData);
        this.save(deviceTempData);
    }
}
