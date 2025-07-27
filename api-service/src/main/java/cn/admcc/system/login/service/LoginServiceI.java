package cn.admcc.system.login.service;

import cn.admcc.entity.CaptchaObject;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:12
 */
public interface LoginServiceI {


    /**
     * 获取验证码
     * @return CaptchaObject
     */
    CaptchaObject getCaptcha();



}
