package cn.admcc.system.base.service;

import cn.admcc.system.base.entity.SysRole;
import cn.admcc.util.PageQuery;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:53
 */
public interface SysRoleServiceI extends IService<SysRole> {

    /**
     * 分页获取角色信息
     * @param page 分页对象
     * @return Page
     */
    Page<SysRole> getAllSysRole(PageQuery<SysRole, SysRole> page);

    /**
     * 添加角色
     * @param sysRole 角色信息
     */
    void add(SysRole sysRole);

    /**
     * 获取角色的基本信息
     * @param roleId 角色id
     * @return role
     */
    SysRole getRoleDetail(Long roleId);

    /**
     * 更新角色
     * @param sysRole 角色信息
     */
    void updateRole(SysRole sysRole);

    /**
     * 删除角色 同时删除关联铉锡
     * @param roleId 角色的id
     */
    void removeRole(Long roleId);
}
