package cn.admcc.net.data.handler;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:00
 */
@Slf4j
public class StringGpsDataHandler extends SimpleChannelInboundHandler<String> {




    /**
     * 数据处理包
     */
    private final DataPacketHandler dataPacketHandler;

    public StringGpsDataHandler(DataPacketHandler dp) {
        dataPacketHandler = dp;
    }

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, String msg) {
        // 这里处理接收到的字符串消息
        log.debug("Received message: {}",msg);
        // 可以发送响应
        ctx.writeAndFlush("Server received: " + msg + "\n");
        DataPacket dataPacket = new DataPacket();
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
                dataPacket.setDeviceId(deviceId);
                StringBuilder sb = new StringBuilder();
                for (int i = 1; i < split.length; i++) {
                    sb.append(split[i]).append(",");
                }
                // 去掉最后一个,并输出
                dataPacket.setGpsData( sb.substring(0,sb.length()-1));
            }
            dataPacketHandler.handler(dataPacket);
        }

    }
    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        log.error("Unexpected exception from downstream: {}", cause.getMessage());
        ctx.close();
    }
}
