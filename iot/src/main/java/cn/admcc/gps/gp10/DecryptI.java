package cn.admcc.gps.gp10;

import cn.admcc.gps.gp10.exception.TxtInfoException;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:53
 */
public interface DecryptI<M> {


    /**
     * 解密物联网传入的数据
     * @param baseGpsInfo 数据信息
     * @param deviceId 设备的id
     * @return M
     */
    M decrypt(String baseGpsInfo,Object deviceId) throws TxtInfoException;
}
