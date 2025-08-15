package cn.admcc.device.service.impl;

import cn.admcc.device.dao.DeviceGllDataMapper;
import cn.admcc.device.entity.DeviceGllData;
import cn.admcc.device.service.DeviceGllDataServiceI;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.InsertDataToDbInterface;
import cn.admcc.gps.gp10.entity.BaseGpsInfo;
import cn.admcc.gps.gp10.entity.GLLGNSSInfo;
import cn.admcc.gps.gp10.utils.GpsUtcTimeUtil;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:26
 */
@Service
@Slf4j
public class DeviceGllDataServiceImpl extends ServiceImpl<DeviceGllDataMapper, DeviceGllData> implements DeviceGllDataServiceI, InsertDataToDbInterface {


    @Override
    public void saveData(BaseGpsInfo baseGpsInfo) {
        if(baseGpsInfo instanceof GLLGNSSInfo gll){
            DeviceGllData deviceGllData = new DeviceGllData();
            deviceGllData.setDeviceId((Long) gll.getDeviceId());
            deviceGllData.setDataTime(GpsUtcTimeUtil.paresLocalDateTime(gll.getUtcTime()));
            deviceGllData.setId(IdUtil.getSnowflakeNextId());
            deviceGllData.setMode(gll.getMode());
            deviceGllData.setSourceData(gll.getDataSource());
            deviceGllData.setLat(gll.getLat());
            deviceGllData.setLon(gll.getLon());
            deviceGllData.setULon(gll.getULon());
            deviceGllData.setULat(gll.getULat());
            this.save(deviceGllData);
        }
    }

    @Override
    public String getType() {
        return GpsGnssType.GNGLL.getType();
    }
}
