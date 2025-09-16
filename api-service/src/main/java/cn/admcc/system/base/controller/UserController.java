package cn.admcc.system.base.controller;

import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.UserEmailPhoneDto;
import cn.admcc.system.base.entity.dto.UserRegisterDto;
import cn.admcc.system.base.entity.dto.UserRoleManagerDto;
import cn.admcc.system.base.entity.dto.UserUploadDto;
import cn.admcc.system.base.exception.NoAuthException;
import cn.admcc.system.base.service.LoginServiceI;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.util.PageQuery;
import cn.admcc.util.PageVo;
import cn.admcc.util.R;
import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.stp.StpUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 10:56
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {

    private final SysUserServiceI sysUserServiceI;

    private final LoginServiceI loginServiceI;


    /**
     * 更新用户头像以及用户的基本信息
     * @param userUploadDto 更新信息
     * @return success
     */
    @PostMapping("/update/base")
    public R<String> uploadUser(@RequestBody UserUploadDto userUploadDto) {
        sysUserServiceI.updateUserBaseInfo(userUploadDto);
        return R.success();
    }


    /**
     * 获取当前登录用户的信息
     * @return SysUser
     */
    @GetMapping("/loginUser")
    public R<SysUser> getLoginUserInfo(){
        long userId;
        try {
            userId = Long.parseLong( StpUtil.getLoginId().toString());
        } catch (NotLoginException e) {
            throw new NoAuthException("未登录");
        }
        return this.getUserInfo(userId);
    }


    /**
     * 获取用户的详细信息
     * @param userId 用户id
     * @return SysUser
     */
    @GetMapping("/detail")
    public R<SysUser> getUserInfo(Long userId){
        return R.success(sysUserServiceI.getUserInfo(userId));
    }


    /**
     * 更新用户的手机号或邮箱
     * @param userUploadDto 用户的新的信息
     * @return success
     */
    @PostMapping("/update/email/phone")
    public R<String> updateUserEmailAndPhone(UserEmailPhoneDto userUploadDto) {
        loginServiceI.updateUserEmailAndPhone(userUploadDto);
        return R.success();
    }

    /**
     * 更新用户头像
     * @param file 头像文件
     * @return String
     */
    @PostMapping("/upload-avatar")
    public R<String> uploadUserAvatar(MultipartFile file){
        return R.successByData(sysUserServiceI.uploadUserAvatar(file));
    }


    /**
     * 重新设置密码
     * @param userUploadDto 密码
     * @return  String
     */
    @PostMapping("/resetPassword")
    public R<String> resetPassword(@RequestBody UserUploadDto userUploadDto){
        sysUserServiceI.resetPassword(userUploadDto);
        return R.success();
    }


    /**
     * 更新邮箱
     * @param userUploadDto 更新参数
     * @return String
     */
    @PostMapping("/resetEmail")
    public R<String> resetEmail(@RequestBody UserUploadDto userUploadDto){
        loginServiceI.checkEmail(userUploadDto.getEmail(),userUploadDto.getEmailCode());
        sysUserServiceI.resetEmail(userUploadDto);
        return R.success();
    }


    /**
     * 分页获取用户信息
     * @param query 查询对象
     * @return page
     */
    @PostMapping("/page")
    public R<PageVo<SysUser>> pageUser(@RequestBody PageQuery<SysUser,SysUser> query){
        return R.success(PageVo.getPage(sysUserServiceI.pageUser(query)));
    }


    /**
     * 删除用户信息
     * @param userId 用户id
     * @return Void
     */
    @DeleteMapping("/delete/{userId}")
    public R<Void> deleteUser(@PathVariable Long userId){
        sysUserServiceI.deleteUser(userId);
        return R.success();
    }


    /**
     * 更新用户
     * @param userRegisterDto 用户更新对象
     * @return ok
     */
    @PostMapping("/edit")
    public R<Void> editUser(@RequestBody UserRegisterDto userRegisterDto){
        sysUserServiceI.updateUserInfo(userRegisterDto);
        return R.success();
    }


    /**
     * 管理用户的角色信息
     * @param userRoleManagerDto 用户角色对象
     * @return Void
     */
    @PostMapping("/manageUserRole")
    public R<Void> managerUserRole(@RequestBody UserRoleManagerDto userRoleManagerDto){
        sysUserServiceI.managerUserRole(userRoleManagerDto);
        return R.success();
    }

}
