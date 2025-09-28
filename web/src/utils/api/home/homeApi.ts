/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-01-27 10:00:00
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-01-27 10:00:00
 * @FilePath: \web\src\utils\api\home\homeApi.ts
 * @Description: Home页面相关的API接口
 */
import request from "../request"
import type { ApiResponse } from "../Response"
import type { OnlineUser } from "./homeTypes"

/**
 * Home页面API接口类
 */
export class HomeApi {
  /**
   * 获取所有在线用户
   * @returns 在线用户列表
   */
  static async getAllOnlineUsers(): Promise<ApiResponse<OnlineUser[]>> {
    return request({
      url: 'api/all/home/user',
      method: 'get',
    }) as Promise<ApiResponse<OnlineUser[]>>
  }
}
