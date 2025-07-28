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


    /**
     * 发送注册验证码
     * @param email 验证码
     */
    void sendRegisterEmail(String email);


    /**
     * 移除所有的验证码
     * @param email 验证码
     */
    void removeAllEmailCode(String email);
}
