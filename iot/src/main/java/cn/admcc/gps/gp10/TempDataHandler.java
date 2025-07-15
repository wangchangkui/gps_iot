package cn.admcc.gps.gp10;

import cn.admcc.gps.gp10.entity.BaseGpsInfo;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:18
 */
public interface TempDataHandler {


    /**
     * 临时数据的处理
     * @param baseGpsInfo 从GPS获取到的数据信息
     */
    void handler(BaseGpsInfo baseGpsInfo);
}
