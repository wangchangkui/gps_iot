package cn.admcc.system.base.service;

import cn.admcc.system.base.entity.SysPermissions;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 09:13
 */
public interface SysPermissionServiceI extends IService<SysPermissions> {


    /**
     * 获取用户所有的权限
     * @param userId 用户id
     * @return 返回权限树
     */
    List<SysPermissions> getUserAllPermissions(Long userId);


    /**
     * 获取所有的权限
     * @return 权限树
     */
    List<SysPermissions> getAllPermission();


    /**
     * 添加权限
     * @param sysPermissions 权限
     */
    void add(SysPermissions sysPermissions);

    /**
     * 删除权限
     *
     * @param permissionId 权限id
     * @return 是否成功
     */
    boolean deletePermission(Long permissionId);

    /**
     * 编辑权限
     *
     * @param sysPermissions 系统权限
     * @return 是否成功
     */
    boolean edit(SysPermissions sysPermissions);
}
