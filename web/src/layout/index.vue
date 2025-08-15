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
        <el-menu-item index="/manage/dashboard">
          <el-icon><Odometer /></el-icon>
          <span>控制台</span>
        </el-menu-item>
        <el-menu-item index="/manage/map">
          <el-icon><Location /></el-icon>
          <span>地图监控</span>
        </el-menu-item>
        <el-menu-item index="/manage/devices">
          <el-icon><Monitor /></el-icon>
          <span>设备管理</span>
        </el-menu-item>
        <el-menu-item index="/manage/device-control">
          <el-icon><SetUp /></el-icon>
          <span>设备控制</span>
        </el-menu-item>
        <el-menu-item index="/manage/users">
          <el-icon><User /></el-icon>
          <span>用户管理</span>
        </el-menu-item>
        <el-menu-item index="/manage/analysis">
          <el-icon><DataLine /></el-icon>
          <span>数据分析</span>
        </el-menu-item>
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
          <el-dropdown>
            <span class="el-dropdown-link">
              管理员
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
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'

import {
  Odometer,
  Location,
  Monitor,
  SetUp,
  User,
  DataLine,
  Fold,
  Expand,
  ArrowDown
} from '@element-plus/icons-vue'
import { loginOut } from '../utils/api/user/login_out_util'

const route = useRoute()

const isCollapse = ref(false)

const toggleCollapse = () => {
  isCollapse.value = !isCollapse.value
}

const handleLogout = async () => {
  
  loginOut()
}
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
        .el-dropdown-link {
          cursor: pointer;
          display: flex;
          align-items: center;
          color: #606266;
          
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