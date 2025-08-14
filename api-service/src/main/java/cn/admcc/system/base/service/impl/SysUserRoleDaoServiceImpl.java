package cn.admcc.system.base.service.impl;

import cn.admcc.system.base.dao.SysUserRoleDao;
import cn.admcc.system.base.entity.SysUserRole;
import cn.admcc.system.base.service.SysUserRoleDaoServiceI;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:39
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class SysUserRoleDaoServiceImpl extends ServiceImpl<SysUserRoleDao, SysUserRole>  implements SysUserRoleDaoServiceI {
}
