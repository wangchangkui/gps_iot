/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-28 16:44:57
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-29 17:19:04
 * @FilePath: \web\src\utils\api\user\user.ts
 * @Description: 
 */
export class UserRegister{
    /**
     * 用户名称
     */
    nickName: string;

    /**
     * 账号
     */
    account: string;

    /**
     * 密码
     */
    password: string;

    /**
     * 邮箱
     */
    email: string;


    /**
     * 邮箱验证码
     */
    emailCode: string;

    /**
     * 手机号
     */
    phone: string;

  
    /**
     * 验证码
     */
    captcha: string;

    /**
     * 验证码id
     */
    captchaCode: string;

    /**
     * 性别 1 男 0 女
     */
    gender: number;


    constructor(
        nickName: string,
        password: string, 
        email: string, 
        phone: string,  
        captcha: string, 
        captchaCode: string, 
        gender: number,
        emailCode:string,
        account: string
    ) {
        this.nickName = nickName;
        this.account = account;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.captcha = captcha;
        this.captchaCode = captchaCode;
        this.gender = gender;
        this.emailCode =emailCode;
    }
}