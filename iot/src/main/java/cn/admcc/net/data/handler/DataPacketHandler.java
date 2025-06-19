package cn.admcc.net.data.handler;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:18
 */
public interface DataPacketHandler {

    /**
     * 数据处理，用于给上级模块提供接口
     * @param tcpData  获取到的字符串类型的数据
     * @return 返回对象由上级决定
     */
    Object handler(DataPacket tcpData);


}
