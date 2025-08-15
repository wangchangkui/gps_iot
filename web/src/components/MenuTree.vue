<template>
  <div class="menu-tree">
    <template v-for="item in menuItems" :key="item.id">
      <!-- 有子菜单的情况 -->
      <el-sub-menu v-if="item.children && item.children.length > 0" :index="item.id">
        <template #title>
          <el-icon v-if="item.icon">
            <component :is="item.icon" />
          </el-icon>
          <span>{{ item.title }}</span>
        </template>
        
        <!-- 递归渲染子菜单 -->
        <MenuTree :menu-items="item.children" />
      </el-sub-menu>
      
      <!-- 没有子菜单的情况 -->
      <el-menu-item v-else :index="item.path || item.id" @click="handleMenuClick(item)">
        <el-icon v-if="item.icon">
          <component :is="item.icon" />
        </el-icon>
        <span>{{ item.title }}</span>
      </el-menu-item>
    </template>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import type { MenuItem } from '../utils/menu/menuBuilder'

interface Props {
  menuItems: MenuItem[]
}

const props = defineProps<Props>()
const router = useRouter()

/**
 * 处理菜单点击
 */
const handleMenuClick = (item: MenuItem) => {
  if (item.path) {
    router.push(item.path)
  }
}
</script>

<style scoped lang="scss">
.menu-tree {
  .el-menu-item,
  .el-sub-menu {
    .el-icon {
      margin-right: 8px;
      font-size: 16px;
    }
  }
}
</style>
