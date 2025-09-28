/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-01-27 10:00:00
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-09-28 17:04:51
 * @FilePath: \web\src\utils\api\home\homeTypes.ts
 * @Description: Home页面相关的数据类型定义
 */

/**
 * 坐标信息接口
 */
export interface Coordinate {
  type: string;
  coordinates: [number, number]; // [经度, 纬度]
}

/**
 * 在线用户信息接口
 */
export interface OnlineUser {
  sessionId: string;
  userName: string;
  onlyId: string;
  coordinate: Coordinate;
}

