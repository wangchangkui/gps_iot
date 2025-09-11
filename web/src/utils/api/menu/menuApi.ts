/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-08-21 20:52:35
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-09-11 15:27:00
 * @FilePath: \web\src\utils\api\menu\menuApi.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import request from "../request"
import type { ApiResponse } from "../Response"

import { Permissions } from '../user/Permissions'

/**
 * 菜单管理API接口
 */
export class MenuApi {
  /**
   * 获取菜单树
   */
  static async getMenuTree(): Promise<ApiResponse<Permissions[]>> {
    return request({
      url: 'api/permission/list',
      method: 'get',
    }) as Promise<ApiResponse<Permissions[]>>
  }

  /**
   * 获取当前用户的权限树
   * @returns 权限
   */
  static async getUserMenuTree(): Promise<ApiResponse<Permissions[]>> {
    return request({
      url: 'api/permission/user/list',
      method: 'get',
    }) as Promise<ApiResponse<Permissions[]>>
  }

  /**
   * 添加菜单
   */
  static async addMenu(menu: Partial<Permissions>): Promise<ApiResponse<string>> {
    return request({
      url: 'api/permission/add',
      method: 'post',
      data: menu,
    }) as Promise<ApiResponse<string>>
  }

  /**
   * 更新菜单
   */
  static async updateMenu(menu: Partial<Permissions>): Promise<ApiResponse<string>> {
    return request({
      url: 'api/permission/edit',
      method: 'post',
      data:menu
    }) as Promise<ApiResponse<string>>

  }

  /**
   * 删除菜单
   */
  static async deleteMenu(permissionId: string): Promise<ApiResponse<string>> {
    return request({
      url: 'api/permission/delete/' + permissionId,
      method: 'delete',
    }) as Promise<ApiResponse<string>>

  }

  /**
   * 获取菜单详情
   */
  static async getMenuDetail(permissionId: string): Promise<ApiResponse<string>> {
    return request({
      url: 'api/permission/detail' + permissionId,
      method: 'get',
    }) as Promise<ApiResponse<string>>
  }
}
