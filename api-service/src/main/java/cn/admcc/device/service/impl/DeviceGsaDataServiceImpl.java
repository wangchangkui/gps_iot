package cn.admcc.device.service.impl;

import cn.admcc.device.dao.DeviceGsaDataMapper;
import cn.admcc.device.entity.DeviceGsaData;
import cn.admcc.device.service.DeviceGsaDataServiceI;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:26
 */
@Service
@Slf4j
public class DeviceGsaDataServiceImpl extends ServiceImpl<DeviceGsaDataMapper, DeviceGsaData> implements DeviceGsaDataServiceI {
}
