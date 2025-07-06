/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-17 21:58:18
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-06 11:34:06
 * @FilePath: \web\src\router\index.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/login/index.vue')
  },
  {
    path: '/',
    name: 'Layout',
    component: () => import('../layout/index.vue'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('../views/dashboard/index.vue'),
        meta: { title: '控制台', icon: 'Odometer' }
      },
      {
        path: 'map',
        name: 'Map',
        component: () => import('../views/map/index.vue'),
        meta: { title: '地图监控', icon: 'Location' }
      },
      {
        path: 'devices',
        name: 'Devices',
        component: () => import('../views/devices/index.vue'),
        meta: { title: '设备管理', icon: 'Monitor' }
      },
      {
        path: 'device-control',
        name: 'DeviceControl',
        component: () => import('../views/device-control/index.vue'),
        meta: { title: '设备控制', icon: 'SetUp' }
      },
      {
        path: 'users',
        name: 'Users',
        component: () => import('../views/users/index.vue'),
        meta: { title: '用户管理', icon: 'User' }
      },
      {
        path: 'analysis',
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

export default router
