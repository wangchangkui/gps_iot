package cn.admcc.gps.gp10.decrypt;

import cn.admcc.gps.gp10.entity.GSVGNSSInfo;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:02
 */
@Slf4j
public class BDGSVDecrypt extends GNGSVDecrypt{

    @Override
    public GSVGNSSInfo decrypt(String baseGpsInfo, Object deviceId) throws TxtInfoException {
        // 示例：  $BDGSV,4,2,13,16,45,174,27,23,11,173,24,24,12,071,30,25,24,123,25,0*75
        log.info("[{}] 收到来自设备ID 为{}的数据信息：{}" , LocalDateTime.now(),deviceId,baseGpsInfo);
        GSVGNSSInfo decrypt = super.decrypt(baseGpsInfo, deviceId);
        decrypt.setType("BD");
        return decrypt;
    }

    @Override
    public String getType() {
        return GpsGnssType.BDGSV.getType();
    }
}
