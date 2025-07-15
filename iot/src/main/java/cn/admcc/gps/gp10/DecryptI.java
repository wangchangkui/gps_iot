package cn.admcc.gps.gp10;

import cn.admcc.gps.gp10.entity.BaseGpsInfo;
import cn.admcc.gps.gp10.exception.TxtInfoException;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:53
 */
public interface DecryptI<M extends BaseGpsInfo> {


    /**
     * 解GPS密数据
     * @param baseGpsInfo 数据信息
     * @param deviceId 设备id
     * @return 解密镀锡
     * @throws TxtInfoException 解密错误信息
     */
    M decryptData(String baseGpsInfo, Object deviceId) throws TxtInfoException;

    /**
     * 调用的解密数据的核心方法
     * @param baseGpsInfo 数据信息
     * @param deviceId 设备信息
     * @return M
     */
    default M decrypt(String baseGpsInfo, Object deviceId) {
        M m = this.decryptData(baseGpsInfo, deviceId);
        m.setDataSource(baseGpsInfo);
        return m;
    }
}
