/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-08-13 17:52:20
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-14 16:11:06
 * @FilePath: \web\src\utils\api\user\login_user.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
export class LoginUser{

    /**
     * 账号
     */
    account:string;

    /**
     * 密码
     */
    password:string;


    /**
     * 验证码id
     */
     captureId:string;

    /**
     * 验证码图片
     */
     capture:string;


    /**
     * 邮箱
     */
     emailCode:string;


    /**
     * 登录方式
     */
    type:string;




    constructor(account:string,password:string,captureId:string,capture:string,emailCode:string,type:string){
        this.account = account;
        this.password = password;
        this.captureId = captureId;
        this.capture = capture;
        this.emailCode = emailCode;
        this.type = type;
    }

}


export class LoginUserResponse{
    /**
     * 登录成功后获取到的token
     */
    loginToken:string="";

    /**
     * 用户的所有权限和访问地址
     */
    userAllPermissions:Permissions[] = [];
}


