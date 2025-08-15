import { Permissions } from '../api/user/Permissions'

/**
 * 菜单项接口
 */
export interface MenuItem {
  id: string
  title: string
  path?: string
  icon?: string
  children?: MenuItem[]
  isHidden?: boolean
  sortOrder?: number
}

/**
 * 根据权限树构建菜单
 * @param permissions 权限树
 * @returns 菜单项数组
 */
export function buildMenuFromPermissions(permissions: Permissions[]): MenuItem[] {
  if (!permissions || permissions.length === 0) {
    return []
  }

  // 递归处理权限树，保持树结构
  return buildMenuTreeFromPermissions(permissions)
}

/**
 * 从权限树递归构建菜单树
 * @param permissions 权限树数组
 * @returns 菜单树
 */
function buildMenuTreeFromPermissions(permissions: Permissions[]): MenuItem[] {
  const menuItems: MenuItem[] = []

  permissions.forEach(perm => {
    // 只处理菜单类型的权限
    if (perm.permType === 'MENU') {
      const menuItem: MenuItem = {
        id: perm.permissionId,
        title: perm.permName,
        path: perm.componentPath || undefined,
        icon: getIconByPermKey(perm.permKey),
        isHidden: perm.isHidden,
        sortOrder: perm.sortOrder,
        children: []
      }

      // 如果有子权限，递归处理
      if (perm.children && perm.children.length > 0) {
        const childMenus = buildMenuTreeFromPermissions(perm.children)
        menuItem.children = childMenus
      }

      menuItems.push(menuItem)
    }
  })

  // 排序后返回
  return sortMenuItems(menuItems)
}

/**
 * 根据权限键获取图标
 * @param permKey 权限键
 * @returns 图标名称
 */
function getIconByPermKey(permKey: string): string {
  const iconMap: Record<string, string> = {
    // 精确匹配
    'menu:dashboard': 'Odometer',
    'menu:system': 'Setting',
    'menu:system:user': 'User',
    'menu:system:role': 'UserFilled',
    'menu:system:permission': 'Lock',
    'menu:device': 'Monitor',
    'menu:device:list': 'List',
    'menu:device:control': 'SetUp',
    'menu:monitor': 'DataAnalysis',
    'menu:monitor:map': 'Location',
    'menu:monitor:analysis': 'DataLine',
    
    // 通用匹配
    'menu:map': 'Location',
    'menu:users': 'User',
    'menu:analysis': 'DataLine',
    'menu:logs': 'Document',
    'menu:reports': 'PieChart',
    'menu:settings': 'Tools'
  }

  // 尝试精确匹配
  if (iconMap[permKey]) {
    return iconMap[permKey]
  }

  // 尝试部分匹配
  for (const [key, icon] of Object.entries(iconMap)) {
    if (permKey.includes(key.split(':').pop() || '')) {
      return icon
    }
  }

  // 默认图标
  return 'Menu'
}

/**
 * 递归排序菜单项
 * @param menus 菜单数组
 * @returns 排序后的菜单数组
 */
function sortMenuItems(menus: MenuItem[]): MenuItem[] {
  // 按sortOrder排序
  menus.sort((a, b) => (a.sortOrder || 0) - (b.sortOrder || 0))
  
  // 递归排序子菜单
  menus.forEach(menu => {
    if (menu.children && menu.children.length > 0) {
      menu.children = sortMenuItems(menu.children)
    }
  })
  
  return menus
}

/**
 * 过滤隐藏的菜单项
 * @param menus 菜单数组
 * @returns 过滤后的菜单数组
 */
export function filterHiddenMenus(menus: MenuItem[]): MenuItem[] {
  return menus
    .filter(menu => !menu.isHidden)
    .map(menu => ({
      ...menu,
      children: menu.children ? filterHiddenMenus(menu.children) : []
    }))
    .filter(menu => !menu.isHidden || (menu.children && menu.children.length > 0))
}
