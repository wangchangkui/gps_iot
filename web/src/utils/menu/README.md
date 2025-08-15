# 动态菜单系统说明

## 概述

本系统实现了基于权限树的动态侧边栏菜单，支持多级菜单结构，可以根据用户权限动态生成菜单项。

## 核心特性

- 🎯 **权限驱动**：根据用户权限数据动态生成菜单
- 🌳 **树形结构**：支持两种数据格式的多级菜单
  - 已经是树结构的权限数据（包含 `children` 字段）
  - 平级权限数据（通过 `parentId` 构建树结构）
- 🔒 **类型过滤**：只显示 `permType` 为 `MENU` 的权限项
- 🔄 **递归处理**：自动递归处理嵌套的权限树结构
- 📱 **响应式设计**：支持菜单折叠和展开
- 🎨 **图标映射**：根据权限键自动匹配图标
- 📊 **排序支持**：按 `sortOrder` 字段排序菜单项

## 文件结构

```
src/utils/menu/
├── menuBuilder.ts      # 菜单构建核心逻辑
├── defaultMenu.ts      # 默认菜单配置
├── samplePermissions.ts # 示例权限数据
└── README.md           # 说明文档

src/components/
└── MenuTree.vue        # 递归菜单组件

src/layout/
└── index.vue           # 主布局组件
```

## 权限数据结构

### Permissions 类

```typescript
export class Permissions {
  permissionId: string        // 权限ID（主键）
  permKey: string            // 权限键（唯一标识）
  permName: string           // 权限显示名称
  permType: string           // 权限类型 (MENU, BUTTON, API, DATA)
  parentId: string           // 父权限ID（空字符串表示顶级菜单）
  componentPath: string      // 组件访问路径
  sortOrder: number          // 排序序号
  isHidden: boolean          // 是否隐藏
  children: Permissions[]    // 子权限列表
}
```

### 权限类型说明

- **MENU**: 菜单类型，会显示在侧边栏中
- **BUTTON**: 按钮类型，用于页面内功能权限控制
- **API**: API接口权限
- **DATA**: 数据权限

## 菜单生成流程

### 1. 权限过滤
```typescript
// 只保留菜单类型的权限
const menuPermissions = permissions.filter(perm => perm.permType === 'MENU')
```

### 2. 树形构建
```typescript
// 根据 parentId 构建父子关系
if (perm.parentId && perm.parentId.trim() !== '') {
  // 有父级，添加到父级的children中
  const parentMenu = menuMap.get(perm.parentId)
  if (parentMenu) {
    parentMenu.children!.push(menuItem)
  }
} else {
  // 没有父级，是根菜单
  rootMenus.push(menuItem)
}
```

### 3. 排序处理
```typescript
// 按sortOrder排序
menus.sort((a, b) => (a.sortOrder || 0) - (b.sortOrder || 0))
```

### 4. 隐藏过滤
```typescript
// 过滤隐藏的菜单项
export function filterHiddenMenus(menus: MenuItem[]): MenuItem[]
```

## 使用方法

### 1. 在布局组件中使用

```vue
<template>
  <el-aside>
    <el-menu>
      <!-- 动态菜单 -->
      <MenuTree :menu-items="menuItems" />
    </el-menu>
  </el-aside>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import MenuTree from '../components/MenuTree.vue'
import { buildMenuFromPermissions, filterHiddenMenus } from '../utils/menu/menuBuilder'

const menuItems = ref<MenuItem[]>([])

const initMenu = () => {
  const permissionsStr = localStorage.getItem('permissions')
  if (permissionsStr) {
    const permissions = JSON.parse(permissionsStr)
    const menuTree = buildMenuFromPermissions(permissions)
    const visibleMenu = filterHiddenMenus(menuTree)
    menuItems.value = visibleMenu
  }
}

onMounted(() => {
  initMenu()
})
</script>
```

### 2. 权限数据格式示例

```typescript
const permissions = [
  // 顶级菜单
  {
    permissionId: 'sys_mgmt',
    permKey: 'menu:system',
    permName: '系统管理',
    permType: 'MENU',
    parentId: '',           // 空字符串表示顶级菜单
    componentPath: '',      // 顶级菜单通常没有路径
    sortOrder: 1
  },
  
  // 子菜单
  {
    permissionId: 'user_mgmt',
    permKey: 'menu:system:user',
    permName: '用户管理',
    permType: 'MENU',
    parentId: 'sys_mgmt',  // 指向父级菜单ID
    componentPath: '/manage/users',
    sortOrder: 1
  }
]
```

### 3. 图标映射规则

系统会根据 `permKey` 自动匹配图标：

```typescript
const iconMap = {
  'menu:dashboard': 'Odometer',
  'menu:map': 'Location',
  'menu:devices': 'Monitor',
  'menu:system': 'Setting',
  // ... 更多映射
}
```

## 测试和调试

### 1. 使用测试页面

访问 `/manage/menu-test` 页面可以：
- 加载示例权限数据
- 查看权限数据JSON
- 预览生成的菜单结构
- 测试菜单生成逻辑

### 2. 控制台调试

```typescript
// 在浏览器控制台查看菜单数据
console.log('权限数据:', JSON.parse(localStorage.getItem('permissions')))
console.log('菜单项:', menuItems.value)
```

## 扩展和自定义

### 1. 添加新的图标映射

在 `menuBuilder.ts` 中的 `getIconByPermKey` 函数添加：

```typescript
const iconMap: Record<string, string> = {
  // 现有映射...
  'menu:newfeature': 'NewIcon',
}
```

### 2. 自定义菜单样式

在 `MenuTree.vue` 组件中修改样式：

```scss
.menu-tree {
  .el-menu-item,
  .el-sub-menu {
    // 自定义样式
  }
}
```

### 3. 添加菜单权限验证

```typescript
// 在菜单点击时验证权限
const handleMenuClick = (item: MenuItem) => {
  if (hasPermission(item.permKey)) {
    router.push(item.path)
  } else {
    ElMessage.error('没有访问权限')
  }
}
```

## 注意事项

1. **权限数据格式**：确保后端返回的权限数据符合 `Permissions` 类结构
2. **路径配置**：`componentPath` 应该与路由配置匹配
3. **图标支持**：确保使用的图标在 Element Plus 中可用
4. **性能考虑**：大量菜单项时考虑虚拟滚动或懒加载
5. **错误处理**：权限数据解析失败时使用默认菜单

## 故障排除

### 常见问题

1. **菜单不显示**：检查权限数据是否正确加载
2. **图标不显示**：确认图标名称是否正确
3. **路由跳转失败**：检查 `componentPath` 是否与路由匹配
4. **菜单顺序错误**：检查 `sortOrder` 字段值

### 调试步骤

1. 检查 localStorage 中的权限数据
2. 查看控制台错误信息
3. 使用测试页面验证数据格式
4. 检查网络请求是否成功
