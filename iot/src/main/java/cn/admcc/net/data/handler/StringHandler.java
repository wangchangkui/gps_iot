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
public class StringHandler extends SimpleChannelInboundHandler<String> {
    @Override
    protected void channelRead0(ChannelHandlerContext ctx, String msg) throws Exception {
        // 这里处理接收到的字符串消息
        log.info("Received message: {}",msg);
        // 可以发送响应
        ctx.writeAndFlush("Server received: " + msg + "\n");
    }
    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        log.error("Unexpected exception from downstream: {}", cause.getMessage());
        ctx.close();
    }
}
