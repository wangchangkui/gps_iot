/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-08-15 10:30:00
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-15 10:30:00
 * @FilePath: \web\src\utils\api\filter\urlMatcher.ts
 * @Description: URL匹配工具函数，用于检查URL是否在免登录列表中
 */

import { noPermissionUrl } from './filter'

/**
 * 检查当前路径是否在免登录列表中
 * @param path 当前路径
 * @returns 是否免登录
 */
export function isNoPermissionUrl(path: string): boolean {
  return noPermissionUrl.some(pattern => {
    // 将通配符模式转换为正则表达式
    const regexPattern = pattern
      .replace(/\//g, '\\/') // 转义斜杠
      .replace(/\*/g, '.*') // 将 * 转换为 .*
      .replace(/\?/g, '\\.') // 将 ? 转换为 \.
    
    const regex = new RegExp(`^${regexPattern}$`)
    return regex.test(path)
  })
}

/**
 * 获取当前路径（去除查询参数和哈希）
 * @param fullPath 完整路径
 * @returns 清理后的路径
 */
export function getCleanPath(fullPath: string): string {
  return fullPath.split('?')[0].split('#')[0]
}
