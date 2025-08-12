package cn.admcc.system.base.service.impl;

import cn.admcc.system.base.dao.SysPermissionsDao;
import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.service.SysPermissionServiceI;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

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

    public SysPermissionServiceImpl(SysPermissionsDao sysPermissionsDao) {
        this.sysPermissionsDao = sysPermissionsDao;
    }

    @Override
    public List<SysPermissions> getUserAllPermissions(Long userId) {
        List<SysPermissions> userAllPermissions = sysPermissionsDao.getUserAllPermissions(userId);
        return buildPermissionTree(userAllPermissions);
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
