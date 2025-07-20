
import axios, { type InternalAxiosRequestConfig, type AxiosResponse } from 'axios'

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
    if (response.data && response.data.code && response.data.code !== 200) {
      // 这里可以全局弹窗提示
      // ElMessage.error(response.data.message || '请求失败')
      return Promise.reject(response.data)
    }
    return response.data
  },
  (error) => {
    // 统一处理网络错误
    // ElMessage.error(error.message || '网络错误')
    return Promise.reject(error)
  }
)

export default service