package cn.admcc.system.login.entity.dto;

import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:54
 */
@Data
public class UserRegisterDto {

    /**
     * 用户名称
     */
    private  String username;

    /**
     * 登录账号
     */
    private String account;

    /**
     * 密码
     */
    private  String password;

    /**
     * 邮箱
     */
    private  String email;

    /**
     * 邮箱验证码
     */
    private String emailCode;

    /**
     * 手机号
     */
    private  String phone;


    /**
     * 验证码
     */
    private  String captcha;

    /**
     * 验证码id
     */
    private  String captchaCode;

    /**
     * 性别
     */
    private Integer gender;
}
