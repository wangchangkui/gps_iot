package cn.admcc.system.base.entity.dto;

import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:22
 */
@Data
public class LoginUserDto {

    /**
     * 账号
     */
    private String account;

    /**
     * 密码
     */
    private String password;


    /**
     * 验证码id
     */
    private Long captureId;

    /**
     * 验证码图片
     */
    private String capture;


    /**
     * 邮箱
     */
    private String emailCode;


    /**
     * 登录方式
     */
    private String type;



}
