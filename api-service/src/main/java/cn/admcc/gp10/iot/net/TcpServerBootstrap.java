package cn.admcc.gp10.iot.net;

import cn.admcc.gp10.iot.net.config.TcpConfig;
import cn.admcc.net.data.TcpServerUtil;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:28
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class TcpServerBootstrap implements InitializingBean {

    private final TcpConfig tcpConfig;

    private final StringDataPackageHandler stringDataPackageHandler;

    @Getter
    private TcpServerUtil tcpServerUtil;


    @Override
    public void afterPropertiesSet() {
        tcpServerUtil = new TcpServerUtil(stringDataPackageHandler);
        try {
            tcpServerUtil.startTcpServer(tcpConfig.getPort());
        } catch (Exception e) {
            throw new RuntimeException("TCP服务启动失败",e);
        }
    }
}
