package cn.admcc.gp10.iot.gps10;

import cn.admcc.gps.gp10.DecryptI;
import cn.admcc.gps.gp10.GpsGnssType;
import cn.admcc.gps.gp10.exception.GnssDecryptException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:51
 */
@Component
@Slf4j
public class GnssDecryptManager implements InitializingBean {

    /**
     * 所有GPS数据的解析类
     */
    public final Map<String, DecryptI<?>> decryptIMap = new HashMap<>(9);


    /**
     * 解密数据 传入对应的码以及设备id
     * @param code 需要解码的数据
     * @param deviceId 设备id
     * @return 解密对象
     */
    public Object decrypt(String code,Object deviceId){
        String type = code.split(",")[0];
        if(!decryptIMap.containsKey(type)){
            throw new GnssDecryptException("找不到对应的解析对象:"+type);
        }
        return decryptIMap.get(type).decrypt(code, deviceId);
    }


    @Override
    public void afterPropertiesSet() {
        for (GpsGnssType type : GpsGnssType.values()) {
            String name = type.getType();
            // 反射创建对象
            Class<? extends DecryptI<?>> decryptClass = type.getDecryptClass();
            try {
                // 使用反射实例化对象
                DecryptI<?> decryptInstance = decryptClass.getDeclaredConstructor().newInstance();
                // 注入到 Map 中
                decryptIMap.put(name, decryptInstance);
                log.info("初始化对象成功: {}", name);
            } catch (Exception e) {
                throw new GnssDecryptException("无法加载目标对象: " + name, e);
            }
        }
        log.info("成功注入了{}个解密对象", decryptIMap.size());
    }
}
