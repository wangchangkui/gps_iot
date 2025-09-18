package cn.admcc.system.base.controller;

import cn.admcc.system.base.entity.SysRole;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.SysRoleServiceI;
import cn.admcc.util.PageQuery;
import cn.admcc.util.PageVo;
import cn.admcc.util.R;
import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaMode;
import org.springframework.web.bind.annotation.*;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:54
 */
@RestController
@RequestMapping("/role")

public class SysRoleController {


    private final SysRoleServiceI sysRoleServiceI;

    public SysRoleController(SysRoleServiceI sysRoleServiceI) {
        this.sysRoleServiceI = sysRoleServiceI;
    }


    /**
     * 分页获取所有的角色
     * @param page 分页对象
     * @return SysRole
     */
    @PostMapping("/page")
    @SaCheckPermission({"func:role:manager:role"})
    public R<PageVo<SysRole>> getAllSysRole(@RequestBody PageQuery<SysRole,SysRole> page){
        return R.success(PageVo.getPage(sysRoleServiceI.getAllSysRole(page)));
    }


    /**
     * 添加角色
     * @param sysRole 角色信息
     * @return String
     */
    @RequestMapping("/add")
    @SaCheckPermission({"func:role:manager:role"})
    public R<String> addRole(@RequestBody SysRole sysRole){
        try {
            sysRoleServiceI.add(sysRole);
        } catch (Exception e) {
            throw new SystemException("重复的数据");
        }
        return R.success();
    }


    /**
     * 获取角色的详细信息
     * @param roleId 角色id
     * @return SysRole
     */
    @GetMapping("/detail")
    @SaCheckPermission({"func:role:manager:role"})
    public R<SysRole> getRoleAndPermission(Long roleId){
        return R.success(sysRoleServiceI.getRoleDetail(roleId));
    }

    /**
     * 更新角色信息
     * @param sysRole 角色列表
     * @return String
     */
    @PostMapping("/edit")
    @SaCheckPermission({"func:role:manager:role"})
    public R<String> updateRole(@RequestBody SysRole sysRole){
        try {
            sysRoleServiceI.updateRole(sysRole);
        } catch (Exception e) {
            throw new SystemException("更新失败，请检查角色名称及角色编码是否重复");
        }
        return R.success();
    }


    /**
     * 删除角色
     * @param roleId 角色id
     * @return String
     */
    @SaCheckPermission({"func:role:manager:role"})
    @DeleteMapping("/delete")
    public R<String> removeRole(Long roleId){
        sysRoleServiceI.removeRole(roleId);
        return R.success();
    }


}
