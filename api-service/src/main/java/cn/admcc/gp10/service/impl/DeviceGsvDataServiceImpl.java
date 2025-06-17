package cn.admcc.gp10.service.impl;

import cn.admcc.gp10.dao.DeviceGsvDataMapper;
import cn.admcc.gp10.entity.DeviceGsvData;
import cn.admcc.gp10.service.DeviceGsvDataServiceI;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:27
 */
@Service
@Slf4j
public class DeviceGsvDataServiceImpl extends ServiceImpl<DeviceGsvDataMapper, DeviceGsvData>  implements DeviceGsvDataServiceI {
}
