package cn.admcc.gps.gp10.decrypt;

import cn.admcc.gps.gp10.DecryptI;
import cn.admcc.gps.gp10.entity.GLLGNSSInfo;
import cn.admcc.gps.gp10.GnssTypeI;
import cn.admcc.gps.gp10.GpsGnssType;
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
 * @createTime 22:29
 */
@Slf4j
public class GNGGLDecrypt implements GnssTypeI, DecryptI<GLLGNSSInfo> {
    @Override
    public String getType() {
        return GpsGnssType.GNGLL.getType();
    }

    @Override
    public GLLGNSSInfo decrypt(String baseGpsInfo, Object deviceId) throws TxtInfoException {
        log.info("[{}] 收到来自设备ID 为{}的数据信息：{}" , LocalDateTime.now(),deviceId,baseGpsInfo);
        // 样例数据$GNGLL,3028.01217,N,10406.50000,E,114547.000,A,A*4F
        GLLGNSSInfo gllgnssInfo = new GLLGNSSInfo();
        gllgnssInfo.setDeviceId(deviceId);
        try {
            DataOrderIndexUtil.setValue(baseGpsInfo.replaceAll("\\n",""),gllgnssInfo);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            throw new TxtInfoException("无法解密数据包："+baseGpsInfo,e);
        }
        // 解析数据
        String mode = gllgnssInfo.getMode();
        String[] modeTxt = mode.split("\\*");
        gllgnssInfo.setMode(modeTxt[0]);
        gllgnssInfo.setLon(LonLatUtil.resetLonLat(gllgnssInfo.getLon()));
        gllgnssInfo.setLat(LonLatUtil.resetLonLat(gllgnssInfo.getLat()));
        gllgnssInfo.setUtcTime(GpsUtcTimeUtil.resetGpsUtcTimeToGmtTime(gllgnssInfo.getUtcTime()));
        return gllgnssInfo;
    }
}
