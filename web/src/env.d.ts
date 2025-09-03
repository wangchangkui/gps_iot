/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-06 11:50:46
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-27 22:02:18
 * @FilePath: \web\src\env.d.ts
 * @Description: 
 */
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_CESIUM_ACCESS_TOKEN: string
  readonly VITE_API_BASE_URL: string
  readonly VITE_TIANDITU_TOKEN: string
  readonly GADODE_API_KEY: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
} 