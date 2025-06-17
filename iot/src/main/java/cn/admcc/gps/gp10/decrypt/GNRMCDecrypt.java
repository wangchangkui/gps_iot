package cn.admcc.gps.gp10.decrypt;

import cn.admcc.gps.gp10.*;
import cn.admcc.gps.gp10.entity.RMCGNSSInfo;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataOrderIndexUtil;
import cn.admcc.gps.gp10.utils.GpsUtcTimeUtil;
import cn.admcc.gps.gp10.utils.LonLatUtil;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:14
 */
@Slf4j
public class GNRMCDecrypt implements GnssTypeI, DecryptI<RMCGNSSInfo> {
    @Override
    public RMCGNSSInfo decrypt(String baseGpsInfo, Object deviceId) throws TxtInfoException {
        log.info("[{}] 收到来自设备ID 为{}的数据信息：{}" , LocalDateTime.now(),deviceId,baseGpsInfo);
        // 样例数据$GNGGA,115001.000,3028.01364,N,10406.49959,E,1,08,1.3,575.6,M,-43.0,M,,*65
        RMCGNSSInfo rmcgnssInfo = new RMCGNSSInfo();
        rmcgnssInfo.setDeviceId(deviceId);
        try {
            DataOrderIndexUtil.setValue(baseGpsInfo.replaceAll("\\n",""),rmcgnssInfo);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            throw new TxtInfoException("无法解密数据包："+baseGpsInfo,e);
        }
        rmcgnssInfo.setDate(GpsUtcTimeUtil.convertToDateYmd(rmcgnssInfo.getDate()));
        rmcgnssInfo.setLat(LonLatUtil.resetLonLat(rmcgnssInfo.getLat()));
        rmcgnssInfo.setLon(LonLatUtil.resetLonLat(rmcgnssInfo.getLon()));
        rmcgnssInfo.setUtcTime(GpsUtcTimeUtil.resetGpsUtcTimeToGmtTime(rmcgnssInfo.getUtcTime()));
        return rmcgnssInfo;
    }

    @Override
    public String getType() {
        return GpsGnssType.GNRMC.getType();
    }
}
