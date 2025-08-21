/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-08-15 17:48:15
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-21 20:34:48
 * @FilePath: \web\src\utils\menu\samplePermissions.ts
 * @Description: 这是默认设置,请设置`customMade`, 
 */
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
  

]