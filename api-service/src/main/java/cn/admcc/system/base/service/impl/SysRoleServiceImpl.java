package cn.admcc.system.base.service.impl;

import cn.admcc.system.base.dao.SysRoleDao;
import cn.admcc.system.base.dao.SysRolePermissionDao;
import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.entity.SysRole;
import cn.admcc.system.base.entity.SysRolePermission;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.SysPermissionServiceI;
import cn.admcc.system.base.service.SysRoleServiceI;
import cn.admcc.util.PageQuery;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:53
 */
@Service
@Slf4j
public class SysRoleServiceImpl extends ServiceImpl<SysRoleDao, SysRole> implements SysRoleServiceI {


    private final SysRolePermissionDao sysRolePermissionDao;

    private final SysPermissionServiceI permissionServiceI;

    public SysRoleServiceImpl(SysRolePermissionDao sysRolePermissionDao, SysPermissionServiceI permissionServiceI) {
        this.sysRolePermissionDao = sysRolePermissionDao;
        this.permissionServiceI = permissionServiceI;
    }

    @Override
    public Page<SysRole> getAllSysRole(PageQuery<SysRole, SysRole> page) {
        SysRole query = page.getQuery();
        Page<SysRole> pageObject = page.getPage();

        LambdaQueryWrapper<SysRole> sysRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        Optional.ofNullable(query.getRoleName()).ifPresent(k->{
            sysRoleLambdaQueryWrapper.like(SysRole::getRoleName,query.getRoleName());
        });
        sysRoleLambdaQueryWrapper.orderByDesc(SysRole::getCreatedTime);
        return this.page(pageObject, sysRoleLambdaQueryWrapper);
    }



    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(SysRole sysRole) {

        sysRole.setId(IdUtil.getSnowflakeNextId());
        sysRole.setCreatedTime(LocalDateTime.now());
        this.save(sysRole);
        // 处理id
        if (CollUtil.isNotEmpty(sysRole.getPermissions())) {
            List<SysRolePermission> list = sysRole.getPermissions().stream().map(t -> {
                SysRolePermission sysRolePermission = new SysRolePermission();
                sysRolePermission.setId(IdUtil.getSnowflakeNextId());
                sysRolePermission.setRoleId(sysRole.getId());
                sysRolePermission.setPermissionId(t.getPermissionId());
                sysRolePermission.setCreatedTime(t.getCreatedTime());
                return sysRolePermission;
            }).toList();
            sysRolePermissionDao.insert(list);
        }
    }

    @Override
    public SysRole getRoleDetail(Long roleId) {
        SysRole role = this.getById(roleId);
        if(role == null){
            throw new SystemException("角色不存在");
        }
        List<SysPermissions> rolePermissionTree = permissionServiceI.getRolePermissionTree(roleId);
        role.setPermissions(rolePermissionTree);
        return role;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateRole(SysRole sysRole) {
        SysRole role = this.getById(sysRole.getId());
        if(role == null){
            throw new SystemException("角色不存在");
        }
        role.setRoleName(sysRole.getRoleName());
        role.setUpdatedTime(LocalDateTime.now());
        role.setRoleCode(sysRole.getRoleCode());
        this.updateById(sysRole);
        // 删除之前的所有权限
        List<SysRolePermission> sysRolePermissions = sysRolePermissionDao.selectList(new LambdaQueryWrapper<SysRolePermission>().eq(SysRolePermission::getRoleId, sysRole.getId()));
        if(CollUtil.isNotEmpty(sysRolePermissions)){
            sysRolePermissionDao.deleteByIds(sysRolePermissions);
        }

        // 添加信息的
        if (CollUtil.isNotEmpty(sysRole.getPermissions())) {
            List<SysRolePermission> list = sysRole.getPermissions().stream().map(t -> {
                SysRolePermission sysRolePermission = new SysRolePermission();
                sysRolePermission.setRoleId(sysRole.getId());
                sysRolePermission.setId(IdUtil.getSnowflakeNextId());
                sysRolePermission.setPermissionId(t.getPermissionId());
                sysRolePermission.setCreatedTime(t.getCreatedTime());
                return sysRolePermission;
            }).toList();
            sysRolePermissionDao.insert(list);
        }

        // todo 更新权限管理，redis

    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeRole(Long roleId) {
        this.removeById(roleId);
        sysRolePermissionDao.delete(new LambdaQueryWrapper<SysRolePermission>().eq(SysRolePermission::getRoleId,roleId));
        // todo 更新权限管理，redis


    }
}
