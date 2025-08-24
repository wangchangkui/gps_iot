package cn.admcc.system.base.service.impl;

import cn.admcc.system.base.dao.SysPermissionsDao;
import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.SysPermissionServiceI;
import cn.admcc.util.RedisConsist;
import cn.admcc.util.RedisUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 09:14
 */
@Service
@Slf4j
public class SysPermissionServiceImpl extends ServiceImpl<SysPermissionsDao,SysPermissions> implements SysPermissionServiceI {




    private final SysPermissionsDao sysPermissionsDao;

    private final RedisUtil<String> redisUtil;

    public SysPermissionServiceImpl(SysPermissionsDao sysPermissionsDao, RedisUtil<String> redisUtil) {
        this.sysPermissionsDao = sysPermissionsDao;
        this.redisUtil = redisUtil;
    }

    @Override
    public List<SysPermissions> getUserAllPermissions(Long userId) {
        List<SysPermissions> userAllPermissions = sysPermissionsDao.getUserAllPermissions(userId);
        return buildPermissionTree(userAllPermissions);
    }

    @Override
    public List<SysPermissions> getAllPermission() {
        List<SysPermissions> list = this.list();
        return buildPermissionTree(list);
    }

    @Override
    public void add(SysPermissions sysPermissions) {
        SysPermissions one = this.getOne(new LambdaQueryWrapper<SysPermissions>().eq(SysPermissions::getPermKey, sysPermissions.getPermKey()));
        if(one != null){
            throw new SystemException("已存在权限key");
        }
        sysPermissions.setPermissionId(IdUtil.getSnowflakeNextId());
        this.save(sysPermissions);
    }

    @Override
    public boolean deletePermission(Long permissionId) {
        SysPermissions permissions = getById(permissionId);
        Optional.ofNullable(permissions).ifPresent(t->{
            if(t.getAllowDelete().equals(0)){
                // 移除角色的信息
                List<SysPermissions> allPermissionIds = sysPermissionsDao.getAllPermissionIds(permissionId);
                if(CollUtil.isNotEmpty(allPermissionIds)){
                    this.removeById(permissionId);
                    // 删除子集 只允许删除噢
                    List<Long> deleteIds = allPermissionIds.stream().map(SysPermissions::getPermissionId).toList();
                    this.removeByIds(deleteIds);
                    long count = redisUtil.deleteByPatternBatch(RedisConsist.PERMISSION_KEY + "*",1000);
                    log.info("移除权限数量：{}",count);
                }
            }else {
                throw new SystemException("系统菜单或接口 无法删除");
            }
        });

        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean edit(SysPermissions sysPermissions) {
        Long permissionId = sysPermissions.getPermissionId();
        if (permissionId == null){
            throw new SystemException("请传入权限id");
        }
        SysPermissions permissions = getById(permissionId);
        Optional.ofNullable(permissions).ifPresent(t->{
            if(permissions.getAllowDelete().equals(1)){
                throw new SystemException("系统默认菜单功能，不允许修改或删除");
            }
            // 更新系统
            try {
                // 先删除
                this.removeById(permissionId);
                sysPermissions.setCreatedTime(t.getCreatedTime());
                sysPermissions.setUpdatedTime(LocalDateTime.now());
                this.save(sysPermissions);
            } catch (Exception e) {
                log.error("更新权限失败",e);
                throw new SystemException("系统菜单或接口无法更新");
            }
            // 删除权限
            long count = redisUtil.deleteByPatternBatch(RedisConsist.PERMISSION_KEY + "*",1000);
            log.info("移除登录权限数量：{}",count);
        });

        return true;
    }


    /**
     * 构建权限树结构
     * @param permissions 平铺权限列表
     * @return 树形结构
     */
    private List<SysPermissions> buildPermissionTree(List<SysPermissions> permissions) {
        // 创建ID到权限节点的映射
        Map<Long, SysPermissions> permissionMap = new HashMap<>();
        List<SysPermissions> rootNodes = new ArrayList<>();

        // 第一遍遍历：初始化所有节点
        for (SysPermissions perm : permissions) {
            // 初始化子节点列表
            perm.setChildren(new ArrayList<>());
            permissionMap.put(perm.getPermissionId(), perm);
        }

        // 第二遍遍历：建立父子关系
        for (SysPermissions perm : permissions) {
            Long parentId = perm.getParentId();
            if (parentId != null && parentId > 0) {
                SysPermissions parent = permissionMap.get(parentId);
                if (parent != null) {
                    parent.getChildren().add(perm);
                    // 保持子节点排序
                    parent.getChildren().sort(Comparator.comparingInt(SysPermissions::getSortOrder));
                }
            } else {
                rootNodes.add(perm);
            }
        }

        // 根节点排序
        rootNodes.sort(Comparator.comparingInt(SysPermissions::getSortOrder));
        return rootNodes;
    }


}
