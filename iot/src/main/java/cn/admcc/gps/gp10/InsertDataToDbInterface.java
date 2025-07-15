package cn.admcc.gps.gp10;

import cn.admcc.gps.gp10.entity.BaseGpsInfo;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:53
 */
public interface InsertDataToDbInterface {


    /**
     * 保存数据 有他的子类去实现吧
     *
     * @param baseGpsInfo 需要处理的数据
     */
    void saveData(BaseGpsInfo baseGpsInfo);


    /**
     * 来自哪一个存储对象 和GnssDecryptManager的想法一样，用GpsGnssType进行分组
     * @return GpsGnssType
     */
    String getType();

}
