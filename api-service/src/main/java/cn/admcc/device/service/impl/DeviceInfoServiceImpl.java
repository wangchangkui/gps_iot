package cn.admcc.device.service.impl;

import cn.admcc.device.dao.DeviceInfoMapper;
import cn.admcc.device.entity.DeviceInfo;
import cn.admcc.device.service.DeviceInfoServiceI;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 18:42
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class DeviceInfoServiceImpl extends ServiceImpl<DeviceInfoMapper,DeviceInfo> implements DeviceInfoServiceI {
}
