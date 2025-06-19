package cn.admcc.net.data.handler;

import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.admcc.gps.gp10.utils.DataOrderIndexUtil;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:00
 */
@Slf4j
public class StringHandler extends SimpleChannelInboundHandler<String> {

    /**
     * 数据处理包
     */
    private final DataPacketHandler dataPacketHandler;

    public StringHandler(DataPacketHandler dp) {
        dataPacketHandler = dp;
    }

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, String msg) throws Exception {
        // 这里处理接收到的字符串消息
        log.info("Received message: {}",msg);
        // 可以发送响应
        ctx.writeAndFlush("Server received: " + msg + "\n");
        DataPacket dataPacket = new DataPacket();
        try {
            DataOrderIndexUtil.setValue(msg,dataPacket);
            dataPacketHandler.handler( dataPacket);
        } catch (TxtInfoException | IllegalAccessException | NoSuchMethodException | InvocationTargetException |
                 InstantiationException e) {
            log.error("处理数据失败：{},原因：{}",msg,e.getMessage());
        }

    }
    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        log.error("Unexpected exception from downstream: {}", cause.getMessage());
        ctx.close();
    }
}
