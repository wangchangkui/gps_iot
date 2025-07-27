package cn.admcc.system.login.controller;

import cn.admcc.entity.CaptchaObject;
import cn.admcc.system.login.service.LoginServiceI;
import cn.admcc.util.R;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
