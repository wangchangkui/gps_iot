/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-27 19:25:31
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-29 16:48:26
 * @FilePath: \web\src\utils\api\user\login_user_api.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import request from "../request"

import type { ApiResponse } from "../Response"
import type { Captcha } from "./captcha"


/**
 * 获取验证码图片
 * @returns 验证码base64
 */
export const get_captcha = () => {
    return request({
        url: 'api/login/captcha',
        method: 'get',
    }) as Promise<ApiResponse<Captcha>>
}


/**
 * 发送验证码
 * @param email 邮箱地址
 * @returns  ok
 */
export const send_email = (email:string) =>{
    return request({
        url: 'api/login/register/email/'+email,
        method: 'post',
    }) as Promise<ApiResponse<any>>
}