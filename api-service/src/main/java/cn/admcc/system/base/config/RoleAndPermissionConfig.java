package cn.admcc.system.base.config;

import cn.admcc.system.base.dao.SysPermissionsDao;
import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.entity.SysRole;
import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.dev33.satoken.stp.StpInterface;
import cn.hutool.core.collection.CollUtil;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:18
 */
@Component
public class RoleAndPermissionConfig implements StpInterface {

    private final SysUserServiceI sysUserServiceI;



    private final SysPermissionsDao sysPermissionsDao;

    public RoleAndPermissionConfig(SysUserServiceI sysUserServiceI, SysPermissionsDao sysPermissionsDao) {
        this.sysUserServiceI = sysUserServiceI;
        this.sysPermissionsDao = sysPermissionsDao;

    }


    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        long userId = Long.parseLong(loginId.toString());
        List<SysPermissions> userAllPermissions = sysPermissionsDao.getUserAllPermissions(userId);
        if(CollUtil.isNotEmpty(userAllPermissions)){
            return userAllPermissions.stream()
                    .map(SysPermissions::getPermKey)
                    .toList();
        }
        return List.of();
    }

    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        SysUser userInfo = sysUserServiceI.getUserInfo(Long.parseLong(loginId.toString()));
        if(CollUtil.isNotEmpty(userInfo.getSysRoles())){
            return userInfo.getSysRoles().stream().map(SysRole::getRoleName).toList();
        }
        return List.of();
    }
}
