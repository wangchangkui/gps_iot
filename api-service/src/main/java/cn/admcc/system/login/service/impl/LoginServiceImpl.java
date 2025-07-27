package cn.admcc.system.login.service.impl;

import cn.admcc.entity.CaptchaObject;
import cn.admcc.system.login.service.LoginServiceI;
import cn.admcc.util.SysCaptchaUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:13
 */
@Service
@Slf4j
public class LoginServiceImpl implements LoginServiceI {

    private final SysCaptchaUtil captchaUtil;

    public LoginServiceImpl(SysCaptchaUtil captchaUtil) {
        this.captchaUtil = captchaUtil;
    }


    @Override
    public CaptchaObject getCaptcha() {
        return captchaUtil.createPicCaptcha();
    }
}
