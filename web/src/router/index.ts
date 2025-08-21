/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-17 21:58:18
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-21 20:54:03
 * @FilePath: \web\src\router\index.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import { isNoPermissionUrl, getCleanPath } from '../utils/api/filter/urlMatcher'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'home',
   redirect: '/home'
  },
  {
    path: '/index',
    name: 'index',
    redirect:'/home'
  },
  {
    path: '/home',
    name: 'home-map',
    component: () => import('../views/home/index.vue')
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('../views/login/index.vue')
  },
  {
    path: '/register',
    name: 'register',
    component: () => import('../views/login/register.vue')
  },
  {
    path: '/manage',
    name: 'Layout',
    component: () => import('../layout/index.vue'),
    redirect: '/manage/dashboard',
    children: [
      {
        path: '/manage/dashboard',
        name: 'Dashboard',
        component: () => import('../views/dashboard/index.vue'),
        meta: { title: '控制台', icon: 'Odometer' }
      },
      {
        path: '/manage/map',
        name: 'Map',
        component: () => import('../views/map/index.vue'),
        meta: { title: '地图监控', icon: 'Location' }
      },
      {
        path: '/manage/devices',
        name: 'Devices',
        component: () => import('../views/devices/index.vue'),
        meta: { title: '设备管理', icon: 'Monitor' }
      },
      {
        path: '/manage/device-control',
        name: 'DeviceControl',
        component: () => import('../views/device-control/index.vue'),
        meta: { title: '设备控制', icon: 'SetUp' }
      },
      {
        path: '/manage/users',
        name: 'Users',
        component: () => import('../views/users/index.vue'),
        meta: { title: '用户管理', icon: 'User' }
      },
      {
        path: '/manage/menus',
        name: 'MenuManagement',
        component: () => import('../views/menu/index.vue'),
        meta: { title: '菜单管理', icon: 'Menu' }
      },
      {
        path: '/manage/analysis',
        name: 'Analysis',
        component: () => import('../views/analysis/index.vue'),
        meta: { title: '数据分析', icon: 'DataLine' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

// 全局前置守卫
router.beforeEach((to, from, next) => {
  // 获取当前路径
  const currentPath = to.path
  const cleanPath = getCleanPath(currentPath)
  
  // 检查当前路径是否在免登录列表中
  if (isNoPermissionUrl(cleanPath)) {
    // 免登录路径，直接放行
    next()
    return
  }
  
  // 检查是否有登录token
  const token = localStorage.getItem('authentication')
  
  if (!token) {
    // 没有token，跳转到登录页
    next('/login')
    return
  }
  
  // 有token，放行
  next()
})

export default router
