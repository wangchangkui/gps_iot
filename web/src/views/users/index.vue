<template>
  <div class="users-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <el-input v-model="searchQuery" placeholder="搜索用户" style="width: 200px" />
          <el-button type="primary" @click="handleAdd">添加用户</el-button>
        </div>
      </template>

      <el-table :data="users" style="width: 100%">
        <el-table-column prop="username" label="用户名" />
        <el-table-column prop="role" label="角色" />
        <el-table-column prop="email" label="邮箱" />
        <el-table-column prop="lastLogin" label="最后登录" width="180" />
        <el-table-column label="操作" width="200">
          <template #default="{ row }">
            <el-button type="primary" link @click="handleEdit(row)">编辑</el-button>
            <el-button type="danger" link @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const searchQuery = ref('')
const users = ref([
  {
    username: 'admin',
    role: '管理员',
    email: 'admin@example.com',
    lastLogin: '2024-03-20 10:00:00'
  }
])

const handleAdd = () => {
  // TODO: 实现添加用户逻辑
}

const handleEdit = (row: any) => {
  // TODO: 实现编辑用户逻辑
}

const handleDelete = (row: any) => {
  // TODO: 实现删除用户逻辑
}
</script>

<style scoped lang="scss">
.users-container {
  padding: 20px;
  
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
}
</style> 