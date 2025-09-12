import type { PageQuery } from "@/utils/PageQuery"
import request from "../request"
import type { ApiResponse } from "../Response"

import { RoleType, RoleResponse } from './roleType'

export class RoleApi{

    /**
     * 创建角色
     * @param submitData 创建对象的参数
     * @returns ok
     */
    static createRole(submitData: RoleType) {
        return request({
            url: 'api/role/add',
            method: 'post',
            data: submitData,
        }) as Promise<ApiResponse<RoleType>>
    }

    /**
     * 分页获取角色
     * @param query 查询条件
     * @param page 分页对象
     * @returns 角色列表
     */
    static async getRoleList(query:RoleType,page:PageQuery):Promise<ApiResponse<RoleResponse>>{
        return request({
            url: 'api/role/page',
            method: 'post',
            data: {query,page},
        }) as Promise<ApiResponse<RoleResponse>>
    }
    
    /**
     * 更新角色
     * @param submitData 更新对象的参数
     * @returns ok
     */
    static async updateRole(submitData: RoleType) {
        return request({
            url: 'api/role/edit',
            method: 'post',
            data: submitData,
        }) as Promise<ApiResponse<RoleType>>
    }

    /**
     * 获取角色权限
     * @param roleId 角色ID
     * @returns 角色权限列表
     */
    static getRolePermissions(roleId: string) {
        return request({
            url: `api/role/detail?roleId=${roleId}`,
            method: 'get',
        
        }) as Promise<ApiResponse<any[]>>
    }

    /**
     * 删除角色
     * @param roleId 角色id
     * @returns ok
     */
    static deleteRole(roleId: string) {
        return request({
            url: `api/role/delete?roleId=${roleId}`,
            method: 'delete',
        }) as Promise<ApiResponse<string>>
    }

}