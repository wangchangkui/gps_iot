/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-01-15 10:00:00
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-09-16 15:33:35
 * @FilePath: \web\src\utils\api\user\user_page_api.ts
 * @Description: 用户分页查询API
 */

import request from "../request"
import type { ApiResponse } from "../Response"
import type { PageQuery } from "@/utils/PageQuery"

// 用户查询条件
export interface UserQuery {
    nickName?: string;  // 用户名称（模糊查询）
    userName?: string;  // 账号（模糊查询）
    email?: string;    // 电子邮箱（模糊查询）
    phoneNumber?: string; // 电话号码（模糊查询）
}

// 角色信息
export interface RoleInfo {
    id: string;
    roleName: string;
    description: string;
    roleCode: string;
    createdTime: string;
    updatedTime: string;
    permissions: any;
}

// 用户详情信息（包含角色）
export interface UserDetailInfo {
    id: string;
    userName: string;
    email: string;
    password: string;
    nickName: string;
    phoneNumber: string;
    sex: number;
    avatarUrl: string;
    isActive: boolean;
    lastLogin: string;
    createdTime: string;
    updatedTime: string;
    sysRoles: RoleInfo[];
}

// 用户信息
export interface UserInfo {
    id: string;
    userName: string;
    email: string;
    password: string;
    nickName: string;
    phoneNumber: string;
    sex: number;
    avatarUrl: string;
    isActive: boolean;
    lastLogin: string;
    createdTime: string;
    updatedTime: string | null;
    sysRoles: any;
}

// 用户表单数据
export interface UserFormData {
    id?: string;
    account: string;
    email: string;
    password?: string;
    nickName: string;
    phone: string;
    gender: number;
    avatarUrl?: string;
    isActive: boolean;
}

// 分页响应数据
export interface UserPageResponse {
    records: UserInfo[];
    size: string;
    total: string;
    pages: string;
    current: string;
}

/**
 * 用户分页查询
 * @param query 查询条件
 * @param page 分页参数
 * @returns 用户分页数据
 */
export const getUserPageList = (query: UserQuery, page: PageQuery) => {
    return request({
        url: 'api/user/page',
        method: 'post',
        data: { query, page },
    }) as Promise<ApiResponse<UserPageResponse>>
}

/**
 * 新增用户
 * @param userData 用户数据
 * @returns 操作结果
 */
export const createUser = (userData: UserFormData) => {
    return request({
        url: 'api/login/register/force',
        method: 'post',
        data: userData,
    }) as Promise<ApiResponse<any>>
}

/**
 * 更新用户
 * @param userData 用户数据
 * @returns 操作结果
 */
export const updateUser = (userData: UserFormData) => {
    return request({
        url: 'api/user/edit',
        method: 'post',
        data: userData,
    }) as Promise<ApiResponse<any>>
}

/**
 * 删除用户
 * @param id 用户ID
 * @returns 操作结果
 */
export const deleteUser = (id: string) => {
    return request({
        url: `api/user/delete/${id}`,
        method: 'delete',
    }) as Promise<ApiResponse<any>>
}

/**
 * 获取用户详情（包含角色信息）
 * @param userId 用户ID
 * @returns 用户详情
 */
export const getUserDetail = (userId: string) => {
    return request({
        url: `api/user/detail?userId=${userId}`,
        method: 'get',
    }) as Promise<ApiResponse<UserDetailInfo>>
}

/**
 * 管理用户角色
 * @param account 用户账号
 * @param roleIds 角色ID数组
 * @returns 操作结果
 */
export const manageUserRole = (account: string, roleIds: string[]) => {
    return request({
        url: 'api/user/manageUserRole',
        method: 'post',
        data: {
            account,
            roleId: roleIds
        },
    }) as Promise<ApiResponse<any>>
}
