/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-27 19:25:31
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-15 10:08:20
 * @FilePath: \web\src\utils\api\user\login_user_api.ts
 * @Description: 
 */
import request from "../request"

import type { ApiResponse } from "../Response"
import type { Captcha } from "./captcha"
import type { LoginUser, LoginUserResponse } from "./login_user"
import { UserRegister } from './user_register'


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

/**
 * 注册用户
 * @param user 用户
 * @returns  OK
 */
export const register_user = (user:UserRegister) =>{
    return request({
        url: 'api/login/register',
        method: 'post',
        data: user,
    }) as Promise<ApiResponse<any>>
}

/**
 * 判断邮箱是否被注册，如果没有注册会返回true
 * @param email 邮箱
 * @returns 
 */
export const check_email = (email:string) =>{
    return request({
        url: 'api/login/register/mail/'+email,
        method: 'get',
    }) as Promise<ApiResponse<boolean>>
}


/**
 * 检查邮箱是否被注册，如果没有则返回true
 * @param phone 邮箱 
 * @returns 
 */
export const check_phone = (phone:string) =>{
    return request({
        url: 'api/login/register/phone/'+phone,
        method: 'get',
    }) as Promise<ApiResponse<boolean>>
}


/**
 * 系统登录
 * @param loginUser 登录参数
 * @returns 
 */
export const login = (loginUser:LoginUser) =>{
    return request({
        url: 'api/login/loginSystem',
        method: 'post',
        data: loginUser,
    }) as Promise<ApiResponse<LoginUserResponse>>
}

/**
 * 给指定账号发送邮箱验证码
 * @param account 账号
 * @returns 
 */
export const  send_login_email = (account:string) =>{
    return request({
        url: 'api/login/login/sendEmail/'+account,
        method: 'post',
    }) as Promise<ApiResponse<any>>
}


/**
 * 退出系统 通过系统的header 默认携带的token
 * @returns 退出系统
 */
export const logout = () =>{
    return request({
        url: 'api/login/loginOut',
        method: 'post',
    }) as Promise<ApiResponse<any>>
}