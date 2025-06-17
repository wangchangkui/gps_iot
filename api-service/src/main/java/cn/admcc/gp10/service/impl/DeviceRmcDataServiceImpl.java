package cn.admcc.gp10.service.impl;

import cn.admcc.gp10.dao.DeviceRmcDataMapper;
import cn.admcc.gp10.entity.DeviceRmcData;
import cn.admcc.gp10.service.DeviceRmcDataServiceI;
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
