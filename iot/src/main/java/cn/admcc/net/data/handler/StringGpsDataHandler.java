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
        String[] split = msg.split(",");
        // 第一位为设备的ID，其余的为数据包，1.确认设备是Id是一个Long 类型，2，确定数据包是以$开头
        int dataPackageLength = 2;
        if(split.length > dataPackageLength){
            DataPacket dataPacket = new DataPacket(msg);
            dataPacketHandler.handler(dataPacket);
        }

    }
    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        log.error("Unexpected exception from downstream: {}", cause.getMessage());
        ctx.close();
    }
}
