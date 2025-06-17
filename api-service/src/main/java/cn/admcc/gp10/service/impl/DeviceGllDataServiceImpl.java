package cn.admcc.gp10.service.impl;

import cn.admcc.gp10.dao.DeviceGllDataMapper;
import cn.admcc.gp10.entity.DeviceGllData;
import cn.admcc.gp10.service.DeviceGllDataServiceI;
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
public class DeviceGllDataServiceImpl extends ServiceImpl<DeviceGllDataMapper, DeviceGllData> implements DeviceGllDataServiceI {
}
