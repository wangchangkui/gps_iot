package cn.admcc.gps.gp10.decrypt;

import cn.admcc.gps.gp10.DecryptI;
import cn.admcc.gps.gp10.GnssTypeI;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.entity.TXTGNSSInfo;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataOrderIndexUtil;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 测试数据 $GPTXT, 01, 01, 01, ANTENNA OPEN*25
 * @createTime 19:51
 */
@Slf4j
public class GPSTXTDecrypt implements GnssTypeI, DecryptI<TXTGNSSInfo> {


    @Override
    public String getType() {
        return GpsGnssType.GPTXT.getType();
    }

    @Override
    public TXTGNSSInfo decrypt(String baseGpsInfo,Object deviceId) throws TxtInfoException {

        log.info("[{}] 收到来自设备ID 为{}的数据信息：{}" , LocalDateTime.now(),deviceId,baseGpsInfo);

        // 测试样例 $GPTXT,xx,yy,zz,info*hh<CR><LF>
        TXTGNSSInfo txtgnssInfo = new TXTGNSSInfo();
        txtgnssInfo.setDeviceId(deviceId);
        try {
            DataOrderIndexUtil.setValue(baseGpsInfo,txtgnssInfo);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            throw new TxtInfoException("无法解密数据包："+baseGpsInfo,e);
        }

        return txtgnssInfo;
    }
}
