package cn.admcc.service.impl;

import cn.admcc.dao.DeviceGpsTxtMapper;
import cn.admcc.entity.DeviceGpsTxt;
import cn.admcc.service.DeviceGpsTxtServiceI;
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
public class DeviceGpsTxtServiceImpl extends ServiceImpl<DeviceGpsTxtMapper, DeviceGpsTxt> implements DeviceGpsTxtServiceI {
}
