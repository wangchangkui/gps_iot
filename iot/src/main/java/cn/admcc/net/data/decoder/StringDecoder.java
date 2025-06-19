package cn.admcc.net.data.decoder;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.ByteToMessageDecoder;
import org.springframework.core.codec.ByteBufferDecoder;

import java.nio.charset.Charset;
import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:57
 */
public class StringDecoder extends ByteToMessageDecoder {
    private final Charset charset;

    public StringDecoder() {
        this(Charset.defaultCharset());
    }

    public StringDecoder(Charset charset) {
        this.charset = charset;
    }


    @Override
    protected void decode(ChannelHandlerContext channelHandlerContext, ByteBuf byteBuf, List<Object> list) throws Exception {
        // 将ByteBuf转换为字符串
        String decoded = byteBuf.toString(charset);
        list.add(decoded);
        byteBuf.skipBytes(byteBuf.readableBytes());
    }
}
