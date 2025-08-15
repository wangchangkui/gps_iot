package cn.admcc.device.service.impl;

import cn.admcc.device.dao.DeviceRmcDataMapper;
import cn.admcc.device.entity.DeviceRmcData;
import cn.admcc.device.service.DeviceRmcDataServiceI;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:33
 */
@Service
@Slf4j
public class DeviceRmcDataServiceImpl extends ServiceImpl<DeviceRmcDataMapper, DeviceRmcData> implements DeviceRmcDataServiceI {
}
