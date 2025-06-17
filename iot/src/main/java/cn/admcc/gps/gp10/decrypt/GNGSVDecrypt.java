package cn.admcc.gps.gp10.decrypt;

import cn.admcc.gps.gp10.DecryptI;
import cn.admcc.gps.gp10.entity.GSVGNSSInfo;
import cn.admcc.gps.gp10.GnssTypeI;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataOrderIndexUtil;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;


/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:56
 */
@Slf4j
public class GNGSVDecrypt implements GnssTypeI, DecryptI<GSVGNSSInfo> {




    @Override
    public String getType() {
        return GpsGnssType.GNGSV.getType();
    }

    @Override
    public GSVGNSSInfo decrypt(String baseGpsInfo, Object deviceId) throws TxtInfoException {
        log.info("[{}] 收到来自设备ID 为{}的数据信息：{}" , LocalDateTime.now(),deviceId,baseGpsInfo);

        // 测试样例  $GPGSV,3,1,12,05,37,054,17,11,18,134,21,13,42,032,25,15,66,347,28,0*62
        GSVGNSSInfo gsvgnssInfo = new GSVGNSSInfo();
        gsvgnssInfo.setDeviceId(deviceId);
        try {
            DataOrderIndexUtil.setValue(baseGpsInfo,gsvgnssInfo);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            throw new TxtInfoException("无法解密数据包："+baseGpsInfo,e);
        }
        gsvgnssInfo.setType("GN");
        return gsvgnssInfo;

    }
}
