package cn.admcc.system.base.service;

import cn.admcc.entity.CaptchaObject;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import cn.admcc.system.base.entity.dto.UserEmailPhoneDto;
import cn.admcc.system.base.entity.dto.UserRegisterDto;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:12
 */
public interface LoginServiceI {


    /**
     * 登录入口
     * @param loginUserDto 登录参数
     * @return Object
     */
    Object login(LoginUserDto loginUserDto);


    /**
     * 给账号默认邮箱发送验证码
     * @param account 账号
     */
    void sendUserEmail(String account);


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

    /**
     * 注册用户
     * @param userRegisterDto 用户信息
     */
    void registerUser(UserRegisterDto userRegisterDto);

    /**
     * 更新用户的手机号或邮箱
     * @param userUploadDto 新的手机号或邮箱
     */
    void updateUserEmailAndPhone(UserEmailPhoneDto userUploadDto);

    /**
     * 退出登录
     */
    void loginOut();
}
