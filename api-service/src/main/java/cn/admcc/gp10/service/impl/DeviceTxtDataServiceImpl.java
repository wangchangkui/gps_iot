package cn.admcc.gp10.service.impl;

import cn.admcc.gp10.dao.DeviceGpsTxtMapper;
import cn.admcc.gp10.entity.DeviceTxtData;
import cn.admcc.gp10.service.DeviceTxtDataServiceI;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:52
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class DeviceTxtDataServiceImpl extends ServiceImpl<DeviceGpsTxtMapper, DeviceTxtData> implements DeviceTxtDataServiceI {
}
