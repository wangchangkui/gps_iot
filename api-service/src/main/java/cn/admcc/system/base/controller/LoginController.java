package cn.admcc.system.base.controller;

import cn.admcc.entity.CaptchaObject;
import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import cn.admcc.system.base.entity.dto.UserRegisterDto;
import cn.admcc.system.base.service.LoginServiceI;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.util.R;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:11
 */
@RestController
@RequestMapping("/login")
public class LoginController {


    private final LoginServiceI loginServiceI;
    private final SysUserServiceI sysUserServiceI;


    public LoginController(LoginServiceI loginServiceI, SysUserServiceI sysUserServiceI) {
        this.loginServiceI = loginServiceI;
        this.sysUserServiceI = sysUserServiceI;
    }

    /**
     * 登录
     * token 在响应头内
     * @param loginUserDto 请求参数
     * @return R
     */
    @PostMapping("/loginSystem")
    public R<Object> login(@RequestBody LoginUserDto loginUserDto){
        return R.success(loginServiceI.login(loginUserDto));
    }


    /**
     * 退出登录
     * @return success
     */
    @PostMapping("/loginOut")
    public R<String> loginOut(){
        loginServiceI.loginOut();
        return R.success();
    }

    /**
     * 账号邮箱登陆时需要发送的验证码
     * @param userAccount 账号
     * @return success
     */
    @PostMapping("/login/sendEmail/{userAccount}")
    public R<String> loginSendEmail(@PathVariable String userAccount){
        loginServiceI.sendUserEmail(userAccount);
        return R.success();
    }


    /**
     * 获得一个验证码图片
     * @return CaptchaObject
     */
    @GetMapping("/captcha")
    public R<CaptchaObject> getCaptcha(){
        return R.success(loginServiceI.getCaptcha());
    }


    /**
     * 往邮箱内发送验证码
     * @param email 验证码
     * @return String
     */
    @PostMapping("/register/email/{email}")
    public R<String> sendRegisterEmail(@PathVariable("email") String email){
        loginServiceI.sendRegisterEmail(email);
        return R.success();
    }

    /**
     * 注册用户
     * @param userRegisterDto 用户的信息
     * @return success
     */
    @PostMapping("/register")
    public R<String> registerUser(@RequestBody UserRegisterDto userRegisterDto){
        loginServiceI.registerUser(userRegisterDto);
        return R.success();
    }


    /**
     * 判断邮箱是否被注册
     * @param mail 邮箱
     * @return Boolean
     */
    @GetMapping("/register/mail/{mail}")
    public R<Boolean> checkEmailContains(@PathVariable String mail){
        SysUser userByEmail = sysUserServiceI.getUserByEmail(mail);
        return R.successByData(Optional.ofNullable(userByEmail).isEmpty());
    }


    /**
     * 判断电话是否已经存在
     * @param phone 电话
     * @return Boolean
     */
    @GetMapping("/register/phone/{phone}")
    public R<Boolean> checkPhoneContains(@PathVariable String phone){
        SysUser user = sysUserServiceI.getUserByPhone(phone);
        return R.successByData(Optional.ofNullable(user).isEmpty());
    }
}
