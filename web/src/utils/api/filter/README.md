# 登录验证系统说明

## 概述

本系统实现了基于URL的登录验证机制，通过配置免登录URL列表和全局拦截器来实现自动登录验证和跳转。

## 文件结构

```
src/utils/api/filter/
├── filter.ts          # 免登录URL配置
├── urlMatcher.ts      # URL匹配工具函数
├── urlMatcher.test.ts # 测试文件
└── README.md          # 说明文档
```

## 核心功能

### 1. 免登录URL配置 (`filter.ts`)

在 `noPermissionUrl` 数组中配置不需要登录就能访问的URL地址：

```typescript
export const noPermissionUrl = ['/login', '/', '/index', '/home', '/register']
```

### 2. URL匹配工具 (`urlMatcher.ts`)

提供两个核心函数：

- `isNoPermissionUrl(path: string)`: 检查指定路径是否在免登录列表中
- `getCleanPath(fullPath: string)`: 清理路径，去除查询参数和哈希

### 3. 路由守卫 (`router/index.ts`)

在路由跳转前检查登录状态：

1. 检查目标路径是否在免登录列表中
2. 如果在免登录列表中，直接放行
3. 如果不在免登录列表中，检查是否有登录token
4. 没有token则跳转到登录页

### 4. 请求拦截器 (`request.ts`)

处理API请求的401错误：

1. 当收到401响应时，清除本地存储的认证信息
2. 检查当前页面是否在免登录列表中
3. 如果不在免登录列表中，显示错误消息并跳转到登录页

## 工作流程

### 页面访问流程

1. 用户访问某个页面
2. 路由守卫检查页面路径是否在免登录列表中
3. 如果在免登录列表中，直接显示页面
4. 如果不在免登录列表中，检查是否有登录token
5. 没有token则跳转到登录页

### API请求流程

1. 发送API请求
2. 如果收到401错误（token过期或无效）
3. 清除本地存储的认证信息
4. 检查当前页面是否在免登录列表中
5. 如果不在免登录列表中，跳转到登录页

## 配置说明

### 添加免登录URL

在 `filter.ts` 文件中的 `noPermissionUrl` 数组中添加新的URL：

```typescript
export const noPermissionUrl = [
  '/login', 
  '/', 
  '/index', 
  '/home', 
  '/register',
  '/new-public-page'  // 新增的免登录页面
]
```

### 支持的通配符

目前支持简单的路径匹配，不支持通配符。如果需要支持通配符，可以修改 `urlMatcher.ts` 中的匹配逻辑。

## 测试

运行测试文件来验证URL匹配功能：

```bash
# 在浏览器控制台中运行
import('./src/utils/api/filter/urlMatcher.test.ts')
```

## 注意事项

1. 登录成功后，确保将token存储到 `localStorage` 中的 `authentication` 键
2. 用户权限信息存储在 `localStorage` 中的 `permissions` 键
3. 401错误会自动清除这些存储的信息
4. 路由守卫和请求拦截器都会检查免登录URL列表
5. 使用 `window.location.href` 进行跳转，确保页面完全刷新
