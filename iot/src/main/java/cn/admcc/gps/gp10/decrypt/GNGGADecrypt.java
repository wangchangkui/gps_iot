package cn.admcc.gps.gp10.decrypt;


import cn.admcc.gps.gp10.DecryptI;
import cn.admcc.gps.gp10.entity.GAGNSSInfo;
import cn.admcc.gps.gp10.GnssTypeI;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataOrderIndexUtil;
import cn.admcc.gps.gp10.utils.GpsUtcTimeUtil;
import cn.admcc.gps.gp10.utils.LonLatUtil;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;
import java.util.Optional;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * 格式 $--GGA,UTCtime,lat,uLat,lon,uLon,FS,numSv,HDOP,msl,uMsl,sep,uSep,diffAge,diffSta*CS<CR><LF>
 *  示例： $GNGGA,073028.600,2236.
 *  40101,N,11349.73472,E,1,19
 *  ,0.8,14.2,M,-4.0,M,,*6E
 * @createTime 17:06
 */
@Slf4j
public class GNGGADecrypt implements GnssTypeI, DecryptI<GAGNSSInfo> {



    @Override
    public String getType() {
        return GpsGnssType.GNGGA.getType();
    }

    @Override
    public GAGNSSInfo decryptData(String baseGpsInfo, Object deviceId) throws TxtInfoException {
        log.info("[{}] 收到来自设备ID 为{}的数据信息：{}" , LocalDateTime.now(),deviceId,baseGpsInfo);
        // 样例数据$GNGGA,115001.000,3028.01364,N,10406.49959,E,1,08,1.3,575.6,M,-43.0,M,,*65
        GAGNSSInfo gagnssInfo = new GAGNSSInfo();
        gagnssInfo.setDeviceId(deviceId);
        try {
            DataOrderIndexUtil.setValue(baseGpsInfo.replaceAll("\\n",""),gagnssInfo);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            throw new TxtInfoException("无法解密数据包："+baseGpsInfo,e);
        }
        if (Optional.ofNullable(gagnssInfo.getLon()).isPresent()) {
            gagnssInfo.setLon(LonLatUtil.resetLonLat(gagnssInfo.getLon()));
        }

        if (Optional.ofNullable(gagnssInfo.getLat()).isPresent()) {
            gagnssInfo.setLat(LonLatUtil.resetLonLat(gagnssInfo.getLat()));
        }
        if(Optional.ofNullable(gagnssInfo.getUtcTime()).isPresent()){
            gagnssInfo.setUtcTime(GpsUtcTimeUtil.resetGpsUtcTimeToGmtTime(gagnssInfo.getUtcTime()));
        }

        return gagnssInfo;
    }
}
