package cn.admcc.gps.gp10.decrypt;

import cn.admcc.gps.gp10.DecryptI;
import cn.admcc.gps.gp10.GnssTypeI;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.entity.GNGSTInfo;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataOrderIndexUtil;

import java.lang.reflect.InvocationTargetException;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:00
 */
public class GMGSTDecrypt implements GnssTypeI, DecryptI<GNGSTInfo> {
    @Override
    public GNGSTInfo decryptData(String baseGpsInfo, Object deviceId) {
        GNGSTInfo gsvgnssInfo = new GNGSTInfo();
        gsvgnssInfo.setDeviceId(deviceId);
        try {
            DataOrderIndexUtil.setValue(baseGpsInfo,gsvgnssInfo);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            throw new TxtInfoException("无法解密数据包："+baseGpsInfo,e);
        }
        return gsvgnssInfo;

    }

    @Override
    public String getType() {
        return GpsGnssType.GMGST.getType();
    }
}
