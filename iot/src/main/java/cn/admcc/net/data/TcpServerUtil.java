package cn.admcc.net.data;

import cn.admcc.net.data.decoder.StringDecoder;
import cn.admcc.net.data.handler.StringHandler;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.*;
import io.netty.channel.nio.NioIoHandler;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.net.ServerSocket;
import java.util.ArrayList;
import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 开启一个TCP服务
 * @createTime 20:30
 */
@Slf4j
public class TcpServerUtil {

    /**
     *  // 最小端口号（避免使用系统保留端口）
     */
    private static final int MIN_PORT = 8000;
    /**
     *  // 最大端口号
     */
    private static final int MAX_PORT = 65535;


    /**
     * 所有连接的通道数量
     */
    private static final List<ChannelFuture> CHANNEL_FUTURES = new ArrayList<>();


    /**
     * 获取打开的通道数量
     * @return 通道数量 Integer
     */
    public Integer getChannelSize(){
        return CHANNEL_FUTURES.size();
    }


    /**
     * 获取一个随机可用的端口
     * @return 可用的端口号
     * @throws IllegalStateException 如果找不到可用端口
     */
    public static int findRandomAvailablePort() {
        int temp = MIN_PORT;
        while (temp < MAX_PORT) {
            if (isPortAvailable(temp)) {
                return temp;
            }else{
                temp++;
            }
        }
        throw new IllegalStateException("No available port found");
    }
    /**
     * 检查端口是否可用
     * @param port 要检查的端口号
     * @return true如果端口可用，false如果已被占用
     */
    private static boolean isPortAvailable(int port) {
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            serverSocket.setReuseAddress(true);
            return true;
        } catch (IOException e) {
            // 端口被占用或其他IO异常
            return false;
        }
    }


    public static void randomPortServer(){
        int randomAvailablePort = findRandomAvailablePort();
        startTcpServer(randomAvailablePort);
    }


    public static void startTcpServer(Integer port){
        // 创建两个EventLoopGroup，一个用于处理连接，一个用于处理业务
        IoHandlerFactory ioHandlerFactory = NioIoHandler.newFactory();
        EventLoopGroup bossGroup = new MultiThreadIoEventLoopGroup(ioHandlerFactory);
        EventLoopGroup workerGroup = new MultiThreadIoEventLoopGroup(ioHandlerFactory);

        try {
            ServerBootstrap bootstrap = new ServerBootstrap();
            bootstrap.group(bossGroup, workerGroup)
                    .channel(NioServerSocketChannel.class)
                    .childHandler(new ChannelInitializer<SocketChannel>() {
                        @Override
                        protected void initChannel(SocketChannel ch) throws Exception {
                            ch.pipeline()
                                    .addLast(new StringDecoder())
                                    .addLast(new StringHandler());
                        }
                    })
                    .option(ChannelOption.SO_BACKLOG, 128)
                    .childOption(ChannelOption.SO_KEEPALIVE, true);
            ChannelFuture future = bootstrap.bind(port).sync();
            log.info("TCP server started on port: {}", port);
            // 等待服务器socket关闭
            future.channel().closeFuture().sync();
            CHANNEL_FUTURES.add(future);
        } catch (InterruptedException e) {
            log.error("TCP server interrupted", e);
            Thread.currentThread().interrupt();
        } finally {
            // 优雅关闭
            workerGroup.shutdownGracefully();
            bossGroup.shutdownGracefully();
            log.info("TCP server stopped");
        }
    }

}
