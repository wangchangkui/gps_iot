package cn.admcc.net.data.handler;

import cn.admcc.gps.gp10.utils.DataIndex;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:15
 */
@Slf4j
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

    public DataPacket(String msg) {
        String[] split = msg.split(",");
        // 第一位为设备的ID，其余的为数据包，1.确认设备是Id是一个Long 类型，2，确定数据包是以$开头
        int dataPackageLength = 2;
        if(split.length > dataPackageLength){
            long deviceId;
            try {
                deviceId = Long.parseLong(split[0]);
            } catch (NumberFormatException e) {
                log.error("这可能是一个无效的数据包，因为无法解析设备的id {}",split[0]);
                return;
            }
            String dataPacketPrefix = "$";

            if(split[1].startsWith(dataPacketPrefix)){
                this.setDeviceId(deviceId);
                StringBuilder sb = new StringBuilder();
                for (int i = 1; i < split.length; i++) {
                    sb.append(split[i]).append(",");
                }
                // 去掉最后一个,并输出
                this.setGpsData( sb.substring(0,sb.length()-1));
            }
        }
    }
}
