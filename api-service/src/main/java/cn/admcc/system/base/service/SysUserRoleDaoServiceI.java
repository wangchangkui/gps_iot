package cn.admcc.system.base.service;

import cn.admcc.system.base.entity.SysRole;
import cn.admcc.system.base.entity.SysUserRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:39
 */
public interface SysUserRoleDaoServiceI extends IService<SysUserRole> {

    /**
     * 获取用户的所有角色
     * @param userId 用户id
     * @return role
     */
    List<SysRole> userRoleList(Long userId);

}
