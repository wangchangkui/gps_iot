<!--
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-06 11:19:34
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-09-11 15:39:22
 * @FilePath: \web\src\layout\index.vue
 * @Description: 主布局组件
-->
<template>
  <el-container class="layout-container">
    <el-aside :width="isCollapse ? '64px' : '200px'" class="aside">
      <el-menu
        :default-active="route.path"
        class="el-menu-vertical"
        :collapse="isCollapse"
        router
        background-color="rgba(255, 255, 255, 0.8)"
        text-color="#303133"
        active-text-color="#409EFF"
      >
        <div class="logo-container">
          <img src="../assets/logo.svg" alt="Logo" class="logo" v-if="!isCollapse">
          <img src="../assets/logo.svg" alt="Logo" class="logo-small" v-else>
        </div>
        <!-- 动态菜单 -->
        <MenuTree :menu-items="menuItems" />
      </el-menu>
    </el-aside>
    <el-container class="main-container">
      <el-header class="header">
        <div class="header-left">
          <el-button type="text" @click="toggleCollapse">
            <el-icon><Fold v-if="!isCollapse" /><Expand v-else /></el-icon>
          </el-button>
          <el-breadcrumb separator="/">
            <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>{{ route.meta.title }}</el-breadcrumb-item>
          </el-breadcrumb>
        </div>
        <div class="header-right">
          <WebSocketStatus />
          <el-dropdown>
            <span class="el-dropdown-link">
              <img :src="avatar" crossorigin="anonymous" alt="avatar" class="avatar">
              <span>{{ nickName }}</span>
              <el-icon class="el-icon--right"><arrow-down /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item>个人信息</el-dropdown-item>
                <el-dropdown-item>修改密码</el-dropdown-item>
                <el-dropdown-item divided @click="handleLogout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </el-header>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import ElMessage from 'element-plus/es/components/message/index'

import {
  Fold,
  Expand,
  ArrowDown
} from '@element-plus/icons-vue'
import { loginOut } from '../utils/api/user/login_out_util'
import MenuTree from '../components/MenuTree.vue'
import WebSocketStatus from '../components/WebSocketStatus.vue'
import { buildMenuFromPermissions, filterHiddenMenus, type MenuItem } from '../utils/menu/menuBuilder'
import { defaultMenuItems } from '../utils/menu/defaultMenu'
import { Permissions } from '../utils/api/user/Permissions'

const route = useRoute()

const isCollapse = ref(false)
const menuItems = ref<MenuItem[]>([])

const nickName=ref(localStorage.getItem('nickName') || '')
const avatar=ref(localStorage.getItem('avatar') || '')

// 初始化菜单
const initMenu = async (forceRefresh: boolean = false) => {
  try {
    let permissions: Permissions[] = []
    
    // 如果需要强制刷新或本地没有权限数据，从服务器获取
    if (forceRefresh || !localStorage.getItem('permissions')) {

      const { MenuApi } = await import('../utils/api/menu/menuApi');
      const response = await MenuApi.getUserMenuTree();


      if (response.code === 10000 && response.data) {
        permissions = response.data;
        // 更新本地存储
        localStorage.setItem('permissions', JSON.stringify(permissions));
      } else {
        throw new Error('获取权限数据失败');
      }
    } else {
      // 从本地存储获取
      const permissionsStr = localStorage.getItem('permissions');
      if (permissionsStr) {
        permissions = JSON.parse(permissionsStr);
      }
    }

    if (permissions.length > 0) {
      const menuTree = buildMenuFromPermissions(permissions);
      const visibleMenu = filterHiddenMenus(menuTree);
      
      // 如果权限菜单为空，使用默认菜单
      if (visibleMenu.length === 0) {
        menuItems.value = defaultMenuItems;
      } else {
        menuItems.value = visibleMenu;
        
      }
    } else {
      menuItems.value = defaultMenuItems;
      ElMessage.info('无数据权限')
    }
  } catch (error) {
    console.error('初始化菜单失败:', error);
    menuItems.value = defaultMenuItems;
  }
}



const toggleCollapse = () => {
  isCollapse.value = !isCollapse.value
}

const handleLogout = async () => {
  
  loginOut()
}

// 处理菜单变更事件（WebSocket消息）
const handleMenuChangeEvent = async (event: Event) => {
  const customEvent = event as CustomEvent;

  try {
    // 强制从服务器刷新菜单数据
    await initMenu(true);
    
    // 显示成功提示
    ElMessage({
      type: 'success',
      message: '导航栏已更新',
      duration: 2000
    });
  } catch (error) {
    console.error('刷新导航栏失败:', error);
    ElMessage({
      type: 'error',
      message: '导航栏更新失败，请刷新页面',
      duration: 3000
    });
  }
}

// 设置WebSocket监听器
const setupWebSocketListeners = () => {
  window.addEventListener('menu-change', handleMenuChangeEvent)
}

// 清理WebSocket监听器
const cleanupWebSocketListeners = () => {
  window.removeEventListener('menu-change', handleMenuChangeEvent)
}

// 组件挂载时初始化菜单
onMounted(async () => {
  await initMenu()
  setupWebSocketListeners()
})

// 组件卸载时清理监听器
onUnmounted(() => {
  cleanupWebSocketListeners()
})
</script>

<style scoped lang="scss">
.layout-container {
  height: 100vh;
  width: 100vw;
  display: flex;
  background-color: #f0f2f5;
  overflow: hidden;
  
  .aside {
    transition: width 0.3s;
    position: relative;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    flex-shrink: 0;
    
    &::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      backdrop-filter: blur(10px);
      background: rgba(255, 255, 255, 0.8);
      z-index: 0;
    }
    
    .el-menu {
      border-right: none;
      position: relative;
      z-index: 1;
      
      &-vertical {
        height: 100%;
      }
      
      .el-menu-item {
        &:hover, &:focus {
          background-color: rgba(64, 158, 255, 0.1);
        }
        
        &.is-active {
          background-color: rgba(64, 158, 255, 0.15);
          color: #409EFF;
          
          &::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background-color: #409EFF;
          }
        }
      }
    }
    
    .logo-container {
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 10px;
      position: relative;
      z-index: 1;
      
      .logo {
        height: 40px;
        object-fit: contain;
      }
      
      .logo-small {
        height: 32px;
        object-fit: contain;
      }
    }
  }
  
  .main-container {
    position: relative;
    flex: 1;
    display: flex;
    flex-direction: column;
    min-width: 0;
    
    .header {
      position: relative;
      background-color: #fff;
      border-bottom: 1px solid #dcdfe6;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 20px;
      height: 60px;
      flex-shrink: 0;
      z-index: 1;
      
      .header-left {
        display: flex;
        align-items: center;
        gap: 20px;
      }
      
      .header-right {
        display: flex;
        align-items: center;
        gap: 16px;
        
        .el-dropdown-link {
          cursor: pointer;
          display: flex;
          align-items: center;
          color: #606266;
          gap: 8px;
          
          .avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e4e7ed;
            transition: border-color 0.3s;
          }
          
          &:hover .avatar {
            border-color: #409EFF;
          }
          
          .el-icon {
            margin-left: 8px;
          }
        }
      }
    }
    
    .el-main {
      position: relative;
      flex: 1;
      padding: 0;
      background-color: #f0f2f5;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      min-height: 0;
    }
  }
}
</style> 