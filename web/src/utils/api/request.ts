/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-19 15:51:58
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-10 14:24:29
 * @FilePath: \web\src\utils\api\request.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import axios, { type InternalAxiosRequestConfig, type AxiosResponse } from 'axios'
import ElMessage from 'element-plus/es/components/message/index'

// 创建 axios 实例
const service = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api', // 后端服务地址
  timeout: 10000, // 请求超时时间
  withCredentials: true // 跨域携带cookie
})

// 请求拦截器
service.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 自动携带 token
    const token = localStorage.getItem('token')
    if (token && config.headers) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  (response: AxiosResponse) => {
    // 统一处理后端返回的数据
    if (response.data && response.data.code && response.data.code !== 10000) {
      // 这里可以全局弹窗提示
      // ElMessage.error(response.data.message || '请求失败')
      return Promise.reject(response.data)
    }
    return response.data
  },
  (error) => {
    // 统一处理网络错误
    console.error('网络请求错误:', error)
    // 详细记录错误信息
    if (error.response) {
      // 服务器返回错误状态码
      console.error('HTTP状态:', error.response.status)
      console.error('错误数据:', error.response.data)
      ElMessage.error(error.response.data)
    } else if (error.request) {
      // 请求已发送但未收到响应
      console.error('未收到响应:', error.request)
      ElMessage.error(error.request)
    } else {
      // 请求配置出错
      console.error('请求错误:', error.message)
      ElMessage.error(error.message)
    }
    
    // ElMessage.error(error.message || '网络错误')
    return Promise.reject(error)
  }
)

export default service