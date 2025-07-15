package cn.admcc.gp10.service.impl;

import cn.admcc.gp10.dao.DeviceGgaDataMapper;
import cn.admcc.gp10.entity.DeviceGgaData;
import cn.admcc.gp10.service.DeviceGgaDataServiceI;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.InsertDataToDbInterface;
import cn.admcc.gps.gp10.entity.BaseGpsInfo;
import cn.admcc.gps.gp10.entity.GAGNSSInfo;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import static cn.admcc.gps.gp10.utils.GpsUtcTimeUtil.paresLocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:25
 */
@Service
@Slf4j
public class DeviceGgaDataServiceImplInterface extends ServiceImpl<DeviceGgaDataMapper, DeviceGgaData> implements DeviceGgaDataServiceI, InsertDataToDbInterface {

    @Override
    public void saveData(BaseGpsInfo baseGpsInfo) {
        if(baseGpsInfo instanceof GAGNSSInfo gs){
            DeviceGgaData deviceGgaData = new DeviceGgaData();
            deviceGgaData.setDeviceId((Long) gs.getDeviceId());
            deviceGgaData.setDataTime(paresLocalDateTime(gs.getUtcTime()));
            deviceGgaData.setId(IdUtil.getSnowflakeNextId());
            deviceGgaData.setSourceData(gs.getDataSource());
            deviceGgaData.setLat(gs.getLat());
            deviceGgaData.setLon(gs.getLon());
            deviceGgaData.setDiffAge(gs.getDiffAge());
            deviceGgaData.setDiffSta(gs.getDiffSta());
            deviceGgaData.setHdop(gs.getHdop());
            deviceGgaData.setMsl(gs.getMsl());
            deviceGgaData.setSep(gs.getSep());
            deviceGgaData.setSvNum(gs.getNumSv());
            deviceGgaData.setULon(gs.getULon());
            deviceGgaData.setULat(gs.getULat());
            this.save(deviceGgaData);
        }
    }



    @Override
    public String getType() {
        return GpsGnssType.GNGGA.getType();
    }
}
