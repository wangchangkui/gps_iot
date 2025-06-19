package cn.admcc.net.data;

import cn.admcc.net.data.decoder.StringDecoder;
import cn.admcc.net.data.handler.DataPacketHandler;
import cn.admcc.net.data.handler.StringHandler;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.*;
import io.netty.channel.nio.NioIoHandler;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.net.ServerSocket;
import java.util.concurrent.CompletableFuture;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 开启一个TCP服务
 * @createTime 20:30
 */
@Slf4j
public class TcpServerUtil {

    /**
     * // 最小端口号（避免使用系统保留端口）
     */
    private static final int MIN_PORT = 8000;
    /**
     * // 最大端口号
     */
    private static final int MAX_PORT = 65535;


    /**
     * 启动的通道服务
     */
    private Channel serverChannel;
    /**
     * 数据包的处理方法
     */
    private final DataPacketHandler dataPacketHandler;


    private EventLoopGroup bossGroup;
    private EventLoopGroup workerGroup;



    private CompletableFuture<Void> shutdownFuture;

    public TcpServerUtil(DataPacketHandler dataPacketHandler) {
        this.dataPacketHandler = dataPacketHandler;
    }


    /**
     * 获取一个随机可用的端口
     *
     * @return 可用的端口号
     * @throws IllegalStateException 如果找不到可用端口
     */
    public int findRandomAvailablePort() {
        int temp = MIN_PORT;
        while (temp < MAX_PORT) {
            if (isPortAvailable(temp)) {
                return temp;
            } else {
                temp++;
            }
        }
        throw new IllegalStateException("No available port found");
    }

    /**
     * 检查端口是否可用
     *
     * @param port 要检查的端口号
     * @return true如果端口可用，false如果已被占用
     */
    private boolean isPortAvailable(int port) {
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            serverSocket.setReuseAddress(true);
            return true;
        } catch (IOException e) {
            // 端口被占用或其他IO异常
            return false;
        }
    }


    public void randomPortServer() {
        int randomAvailablePort = findRandomAvailablePort();
        startTcpServer(randomAvailablePort);
    }


    public CompletableFuture<Void> startTcpServer(Integer port) {

        CompletableFuture<Void> startFuture = new CompletableFuture<>();

        // 创建两个EventLoopGroup，一个用于处理连接，一个用于处理业务
        IoHandlerFactory ioHandlerFactory = NioIoHandler.newFactory();
         bossGroup = new MultiThreadIoEventLoopGroup(ioHandlerFactory);
         workerGroup = new MultiThreadIoEventLoopGroup(ioHandlerFactory);

        ServerBootstrap bootstrap = new ServerBootstrap();
        bootstrap.group(bossGroup, workerGroup)
                .channel(NioServerSocketChannel.class)
                .childHandler(new ChannelInitializer<SocketChannel>() {
                    @Override
                    protected void initChannel(SocketChannel ch) throws Exception {
                        ch.pipeline()
                                .addLast(new StringDecoder())
                                .addLast(new StringHandler(dataPacketHandler));
                    }
                })
                .option(ChannelOption.SO_BACKLOG, 128)
                .childOption(ChannelOption.SO_KEEPALIVE, true);
        ChannelFuture fs = bootstrap.bind(port).addListener((ChannelFuture future) -> {
            if (future.isSuccess()) {
                serverChannel = future.channel();
                log.info("String server started on port {}", port);
                startFuture.complete(null);
            } else {
                startFuture.completeExceptionally(future.cause());
            }
        });
        return startFuture;

    }

    public CompletableFuture<Void> stop() {
        if (shutdownFuture != null) {
            return shutdownFuture;
        }

        shutdownFuture = new CompletableFuture<>();

        if (serverChannel != null) {
            serverChannel.close().addListener(future -> {
                if (!future.isSuccess()) {
                    log.error("Error closing server channel: {}", String.valueOf(future.cause()));
                }
                shutdownGracefully();
            });
        } else {
            shutdownGracefully();
        }

        return shutdownFuture;
    }


    private void shutdownGracefully() {
        workerGroup.shutdownGracefully().addListener(future -> {
            bossGroup.shutdownGracefully().addListener(f -> {
                log.info("Server stopped");
                shutdownFuture.complete(null);
            });
        });
    }

}
