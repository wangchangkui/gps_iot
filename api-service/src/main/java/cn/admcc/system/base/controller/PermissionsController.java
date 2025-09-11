package cn.admcc.system.base.controller;

import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.exception.NoAuthException;
import cn.admcc.system.base.service.SysPermissionServiceI;
import cn.admcc.util.R;
import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.stp.StpUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:59
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/permission")
public class PermissionsController {


    private final SysPermissionServiceI sysPermissionServiceI;


    /**
     * 获取所有的权限信息
     * @return List
     */
    @GetMapping("/list")
    public R<List<SysPermissions>> getAllPermission(){
        return R.success(sysPermissionServiceI.getAllPermission());
    }


    /**
     * 获取用户的所有权限的集合
     * @return List
     */
    @GetMapping("/user/list")
    public R<List<SysPermissions>> getUserAllPermission(){
        long userId;
        try {
            userId = Long.parseLong( StpUtil.getLoginId().toString());
        } catch (NotLoginException e) {
            throw new NoAuthException("未登录");
        }
        return R.success(sysPermissionServiceI.getUserAllPermissions(userId));
    }

    /**
     * 添加一个权限
     * @param sysPermissions 权限
     * @return 字符串
     */
    @PostMapping("/add")
    public R<String> addPermission(@RequestBody SysPermissions sysPermissions){
        sysPermissionServiceI.add(sysPermissions);
        return R.success();
    }


    /**
     * 删除权限
     * @param permissionId 权限id
     * @return 成功
     */
    @DeleteMapping("/delete/{permissionId}")
    public R<String> deletePermission(@PathVariable Long permissionId){
        sysPermissionServiceI.deletePermission(permissionId);
        return R.success();
    }

    /**
     * 获取详情
     * @param permissionId 权限id
     * @return 详情
     */
    @GetMapping("/detail/{permissionId}")
    public R<SysPermissions> getDetail(@PathVariable Long permissionId){
        return R.success(sysPermissionServiceI.getById(permissionId));
    }


    /**
     * 添加一个权限
     * @param sysPermissions 权限
     * @return 字符串
     */
    @PostMapping("/edit")
    public R<String> editPermission(@RequestBody SysPermissions sysPermissions){
        sysPermissionServiceI.edit(sysPermissions);
        return R.success();
    }



}
