package cn.admcc.system.base.dao;

import cn.admcc.system.base.entity.SysPermissions;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:12
 */
@Mapper
public interface SysPermissionsDao extends BaseMapper<SysPermissions> {


    /**
     * 获取用户所有的权限
     * @param userId 用户id
     * @return 权限
     */
    List<SysPermissions> getUserAllPermissions(@Param("userId") Long userId);


    /**
     * 获取一个权限下面所有的子权限id和名称
     * @param permissionId id
     * @return List
     */
    List<SysPermissions> getAllPermissionIds(@Param("permissionId") Long permissionId);

    /**
     * 移除该用户角色关联的所有id
     * @param allPermissionIds 需要被移除的id的集合
     */
    void deleteAllUserRolePermission(List<Long> allPermissionIds);

    /**
     * 获取角色下面的所有权限
     * @param roleId 角色id
     * @return SysPermissions
     */
    List<SysPermissions> getRolePermission(Long roleId);
}
