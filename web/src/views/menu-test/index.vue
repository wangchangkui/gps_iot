<template>
  <div class="menu-test-container">
    <h1>🌳 动态菜单系统测试（支持树结构）</h1>
    
    <div class="test-section">
      <h2>当前权限数据</h2>
      <el-button type="primary" @click="loadSamplePermissions">🌳 加载示例权限（树结构）</el-button>
      <el-button type="success" @click="loadFromLocalStorage">从本地存储加载</el-button>
      <el-button type="warning" @click="clearPermissions">清除权限</el-button>
      <el-button type="info" @click="showCurrentMenu">显示当前菜单</el-button>
    </div>
    
    <div class="test-section">
      <h2>权限数据预览</h2>
      <el-input
        v-model="permissionsJson"
        type="textarea"
        :rows="10"
        placeholder="权限数据JSON格式"
        readonly
      />
    </div>
    
    <div class="test-section">
      <h2>生成的菜单结构</h2>
      <el-input
        v-model="menuJson"
        type="textarea"
        :rows="10"
        placeholder="生成的菜单结构"
        readonly
      />
    </div>
    
    <div class="test-section">
      <h2>操作说明</h2>
      <div class="instructions">
        <p>1. 点击"加载示例权限"按钮，将示例权限数据存储到localStorage</p>
        <p>2. 点击"从本地存储加载"按钮，从localStorage读取权限数据</p>
        <p>3. 点击"显示当前菜单"按钮，查看当前生成的菜单结构</p>
        <p>4. 刷新页面或重新进入管理页面，侧边栏将根据权限数据动态生成</p>
        <p>5. 权限类型为MENU的项目才会显示在侧边栏中</p>
        <p>6. 有parentId的项目会作为子菜单显示</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { samplePermissions } from '../../utils/menu/samplePermissions'
import { buildMenuFromPermissions, filterHiddenMenus, type MenuItem } from '../../utils/menu/menuBuilder'
import { Permissions } from '../../utils/api/user/Permissions'
import ElMessage from 'element-plus/es/components/message/index'

const permissionsJson = ref('')
const menuJson = ref('')

// 加载示例权限数据
const loadSamplePermissions = () => {
  try {
    localStorage.setItem('permissions', JSON.stringify(samplePermissions))
    ElMessage.success('示例权限数据已加载到localStorage')
    loadFromLocalStorage()
  } catch (error) {
    ElMessage.error('加载示例权限数据失败')
  }
}

// 从本地存储加载权限数据
const loadFromLocalStorage = () => {
  try {
    const permissionsStr = localStorage.getItem('permissions')
    if (permissionsStr) {
      const permissions: Permissions[] = JSON.parse(permissionsStr)
      permissionsJson.value = JSON.stringify(permissions, null, 2)
      
      // 生成菜单
      const menuTree = buildMenuFromPermissions(permissions)
      const visibleMenu = filterHiddenMenus(menuTree)
      menuJson.value = JSON.stringify(visibleMenu, null, 2)
      
      ElMessage.success('权限数据加载成功')
    } else {
      ElMessage.warning('本地存储中没有权限数据')
      permissionsJson.value = ''
      menuJson.value = ''
    }
  } catch (error) {
    ElMessage.error('加载权限数据失败')
    console.error(error)
  }
}

// 清除权限数据
const clearPermissions = () => {
  localStorage.removeItem('permissions')
  permissionsJson.value = ''
  menuJson.value = ''
  ElMessage.success('权限数据已清除')
}

// 显示当前菜单
const showCurrentMenu = () => {
  try {
    const permissionsStr = localStorage.getItem('permissions')
    if (permissionsStr) {
      const permissions: Permissions[] = JSON.parse(permissionsStr)
      const menuTree = buildMenuFromPermissions(permissions)
      const visibleMenu = filterHiddenMenus(menuTree)
      menuJson.value = JSON.stringify(visibleMenu, null, 2)
      ElMessage.success('当前菜单结构已显示')
    } else {
      ElMessage.warning('没有权限数据')
    }
  } catch (error) {
    ElMessage.error('显示菜单结构失败')
  }
}

onMounted(() => {
  loadFromLocalStorage()
})
</script>

<style scoped lang="scss">
.menu-test-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
  
  h1 {
    color: #303133;
    margin-bottom: 30px;
    text-align: center;
  }
  
  .test-section {
    margin-bottom: 30px;
    
    h2 {
      color: #606266;
      margin-bottom: 15px;
      border-bottom: 2px solid #409EFF;
      padding-bottom: 5px;
    }
    
    .el-button {
      margin-right: 10px;
      margin-bottom: 10px;
    }
  }
  
  .instructions {
    background-color: #f5f7fa;
    padding: 15px;
    border-radius: 4px;
    border-left: 4px solid #409EFF;
    
    p {
      margin: 8px 0;
      color: #606266;
      line-height: 1.6;
    }
  }
}
</style>
