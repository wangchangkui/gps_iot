package cn.admcc.net.data.handler;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:15
 */
@Data
public class DataPacket {

    /**
     * 设备ID
     */
    @DataIndex(order = 0)
    private Long deviceId;

    /**
     * gps的数据
     */
    @DataIndex(order = 1)
    private String gpsData;


}
