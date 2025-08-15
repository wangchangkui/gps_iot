package cn.admcc.device.iot.net;

import cn.admcc.gps.gp10.GnssDecryptManager;
import cn.admcc.net.data.handler.DataPacket;
import cn.admcc.net.data.handler.DataPacketHandler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:20
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class StringDataPackageHandler implements DataPacketHandler {

    private final GnssDecryptManager gnssDecryptManager;









    @Override
    public Object handler(DataPacket data) {
        return gnssDecryptManager.decrypt(data.getGpsData(), data.getDeviceId());
    }


}
