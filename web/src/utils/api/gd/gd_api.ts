/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-24 15:49:19
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-27 12:44:13
 * @FilePath: \web\src\utils\api\gd\gd_api.ts
 * @Description: 后台服务的高德API接口
 */
import request from "../request"

import type { ApiResponse } from "../Response"



/** 
 * 获取路径规划
 * @param start_point 起点坐标
 * @param end_point 终点坐标
 * @returns 路径规划结果
 */
export const  get_direction = (start_point: string, end_point: string) => {
  return request({
    url: 'api/api/gd/path/planning/'+start_point+'/'+end_point,
    method: 'get',
  }) as Promise<ApiResponse<string[]>>
}