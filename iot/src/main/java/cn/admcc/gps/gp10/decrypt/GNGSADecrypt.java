package cn.admcc.gps.gp10.decrypt;

import cn.admcc.gps.gp10.*;
import cn.admcc.gps.gp10.entity.GSAGNSSInfo;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataOrderIndexUtil;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 10:59
 */
@Slf4j
public class GNGSADecrypt implements GnssTypeI, DecryptI<GSAGNSSInfo> {


    @Override
    public String getType() {
        return GpsGnssType.GNGSA.getType();
    }

    @Override
    public GSAGNSSInfo decryptData(String baseGpsInfo, Object deviceId) throws TxtInfoException {
        log.info("[{}] 收到来自设备ID 为{}的数据信息：{}" , LocalDateTime.now(),deviceId,baseGpsInfo);
        // 样例数据$GNGSA,A,3,11,13,15,18,20,24,29,194,195,199,,,1.4,0.8,1.1,1*0C
        GSAGNSSInfo gsagnssInfo = new GSAGNSSInfo();
        gsagnssInfo.setDeviceId(deviceId);
        try {
            DataOrderIndexUtil.setValue(baseGpsInfo.replaceAll("\\n",""),gsagnssInfo);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            throw new TxtInfoException("无法解密数据包："+baseGpsInfo,e);
        }

        return gsagnssInfo;
    }
}
