/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-01-27 10:00:00
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-09-16 11:41:01
 * @FilePath: \web\src\utils\api\user\profile_api.ts
 * @Description: 个人信息相关API接口
 */
import request from "../request"
import type { ApiResponse } from "../Response"

/**
 * 用户信息更新请求参数
 */
export interface UpdateUserInfoRequest {
  nickName: string
  email: string
  phoneNumber: string
  sex: number,
  account: string
}

/**
 * 修改密码请求参数
 */
export interface ChangePasswordRequest {
  password: string
  newPassword: string
  confirmPassword: string
  account: string
}

/**
 * 修改邮箱请求参数
 */
export interface ChangeEmailRequest {
  account: string
  email: string
  newEmail: string
  emailCode: string
}

/**
 * 用户信息响应 - 匹配Java后端User对象
 */
export interface UserInfoResponse {
  id: number
  userName: string
  email: string
  password?: string // 密码字段通常不返回给前端
  nickName: string
  phoneNumber: string
  sex: number // 1 男 0 女
  avatarUrl: string
  isActive: boolean
  lastLogin: string
  createdTime: string
  updatedTime: string
}

/**
 * 获取当前用户信息
 * @returns 用户信息
 */
export const getUserInfo = () => {
  return request({
    url: 'api/user/loginUser',
    method: 'get',
  }) as Promise<ApiResponse<UserInfoResponse>>
}

/**
 * 获取当前用户信息（别名）
 * @returns 用户信息
 */
export const getCurrentUserInfo = getUserInfo

/**
 * 更新用户信息
 * @param userInfo 用户信息
 * @returns 更新结果
 */
export const updateUserInfo = (userInfo: UpdateUserInfoRequest) => {
  return request({
    url: 'api/user/update/base',
    method: 'post',
    data: userInfo,
  }) as Promise<ApiResponse<any>>
}

/**
 * 修改密码
 * @param passwordData 密码修改数据
 * @returns 修改结果
 */
export const changePassword = (passwordData: ChangePasswordRequest) => {
  return request({
    url: 'api/user/resetPassword',
    method: 'post',
    data: passwordData,
  }) as Promise<ApiResponse<any>>
}

/**
 * 发送修改密码邮箱验证码
 * @param email 邮箱地址
 * @returns 发送结果
 */
export const sendChangePasswordEmail = (email: string) => {
  return request({
    url: 'api/user/send-change-password-email',
    method: 'post',
    data: { email },
  }) as Promise<ApiResponse<any>>
}

/**
 * 上传用户头像
 * @param file 头像文件
 * @returns 上传结果
 */
export const uploadUserAvatar = (file: File) => {
  const formData = new FormData()
  formData.append('file', file)
  
  return request({
    url: 'api/user/upload-avatar',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  }) as Promise<ApiResponse<string>>
}

/**
 * 发送邮箱验证码
 * @param email 邮箱地址
 * @returns 发送结果
 */
export const sendEmailVerificationCode = (email: string) => {
  return request({
    url: 'api/login/register/email/'+email,
    method: 'post',
  }) as Promise<ApiResponse<any>>
}

/**
 * 修改绑定邮箱
 * @param emailData 邮箱修改数据
 * @returns 修改结果
 */
export const changeEmail = (emailData: ChangeEmailRequest) => {
  return request({
    url: 'api/user/resetEmail',
    method: 'post',
    data: emailData,
  }) as Promise<ApiResponse<any>>
}
