import { Permissions } from '../api/user/Permissions'

/**
 * 示例权限数据（树结构）
 * 用于测试菜单系统，模拟后端返回的权限树
 */
export const samplePermissions: Permissions[] = [
  // 控制台 - 独立菜单
  {
    permissionId: 'dashboard',
    permKey: 'menu:dashboard',
    permName: '控制台',
    permType: 'MENU',
    parentId: '',
    componentPath: '/manage/dashboard',
    sortOrder: 0,
    isHidden: false,
    createdTime: '',
    updatedTime: '',
    children: []
  },
  
  // 系统管理 - 顶级菜单（包含子菜单）
  {
    permissionId: 'sys_mgmt',
    permKey: 'menu:system',
    permName: '系统管理',
    permType: 'MENU',
    parentId: '',
    componentPath: '',
    sortOrder: 1,
    isHidden: false,
    createdTime: '',
    updatedTime: '',
    children: [
      {
        permissionId: 'user_mgmt',
        permKey: 'menu:system:user',
        permName: '用户管理',
        permType: 'MENU',
        parentId: 'sys_mgmt',
        componentPath: '/manage/users',
        sortOrder: 1,
        isHidden: false,
        createdTime: '',
        updatedTime: '',
        children: []
      },
      {
        permissionId: 'role_mgmt',
        permKey: 'menu:system:role',
        permName: '角色管理',
        permType: 'MENU',
        parentId: 'sys_mgmt',
        componentPath: '/manage/roles',
        sortOrder: 2,
        isHidden: false,
        createdTime: '',
        updatedTime: '',
        children: []
      },
      {
        permissionId: 'perm_mgmt',
        permKey: 'menu:system:permission',
        permName: '权限管理',
        permType: 'MENU',
        parentId: 'sys_mgmt',
        componentPath: '/manage/permissions',
        sortOrder: 3,
        isHidden: false,
        createdTime: '',
        updatedTime: '',
        children: []
      }
    ]
  },
  
  // 设备管理 - 顶级菜单（包含子菜单）
  {
    permissionId: 'device_mgmt',
    permKey: 'menu:device',
    permName: '设备管理',
    permType: 'MENU',
    parentId: '',
    componentPath: '',
    sortOrder: 2,
    isHidden: false,
    createdTime: '',
    updatedTime: '',
    children: [
      {
        permissionId: 'device_list',
        permKey: 'menu:device:list',
        permName: '设备列表',
        permType: 'MENU',
        parentId: 'device_mgmt',
        componentPath: '/manage/devices',
        sortOrder: 1,
        isHidden: false,
        createdTime: '',
        updatedTime: '',
        children: []
      },
      {
        permissionId: 'device_control',
        permKey: 'menu:device:control',
        permName: '设备控制',
        permType: 'MENU',
        parentId: 'device_mgmt',
        componentPath: '/manage/device-control',
        sortOrder: 2,
        isHidden: false,
        createdTime: '',
        updatedTime: '',
        children: []
      }
    ]
  },
  
  // 监控分析 - 顶级菜单（包含子菜单）
  {
    permissionId: 'monitor_analysis',
    permKey: 'menu:monitor',
    permName: '监控分析',
    permType: 'MENU',
    parentId: '',
    componentPath: '',
    sortOrder: 3,
    isHidden: false,
    createdTime: '',
    updatedTime: '',
    children: [
      {
        permissionId: 'map_monitor',
        permKey: 'menu:monitor:map',
        permName: '地图监控',
        permType: 'MENU',
        parentId: 'monitor_analysis',
        componentPath: '/manage/map',
        sortOrder: 1,
        isHidden: false,
        createdTime: '',
        updatedTime: '',
        children: []
      },
      {
        permissionId: 'data_analysis',
        permKey: 'menu:monitor:analysis',
        permName: '数据分析',
        permType: 'MENU',
        parentId: 'monitor_analysis',
        componentPath: '/manage/analysis',
        sortOrder: 2,
        isHidden: false,
        createdTime: '',
        updatedTime: '',
        children: []
      }
    ]
  }
]