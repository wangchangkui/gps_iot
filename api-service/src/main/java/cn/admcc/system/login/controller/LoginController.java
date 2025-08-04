package cn.admcc.system.login.controller;

import cn.admcc.entity.CaptchaObject;
import cn.admcc.system.login.entity.dto.UserRegisterDto;
import cn.admcc.system.login.service.LoginServiceI;
import cn.admcc.util.R;
import org.springframework.web.bind.annotation.*;

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



    public LoginController(LoginServiceI loginServiceI) {
        this.loginServiceI = loginServiceI;
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
}
