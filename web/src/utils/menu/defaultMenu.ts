import type { MenuItem } from './menuBuilder'

/**
 * 默认菜单配置
 * 当权限数据为空或加载失败时使用
 */
export const defaultMenuItems: MenuItem[] = [
  {
    id: 'dashboard',
    title: '控制台',
    path: '/manage/dashboard',
    icon: 'Odometer',
    sortOrder: 1
  },
  {
    id: 'map',
    title: '地图监控',
    path: '/manage/map',
    icon: 'Location',
    sortOrder: 2
  },
  {
    id: 'devices',
    title: '设备管理',
    path: '/manage/devices',
    icon: 'Monitor',
    sortOrder: 3
  },
  {
    id: 'device-control',
    title: '设备控制',
    path: '/manage/device-control',
    icon: 'SetUp',
    sortOrder: 4
  },
  {
    id: 'users',
    title: '用户管理',
    path: '/manage/users',
    icon: 'User',
    sortOrder: 5
  },
  {
    id: 'analysis',
    title: '数据分析',
    path: '/manage/analysis',
    icon: 'DataLine',
    sortOrder: 6
  }
]
