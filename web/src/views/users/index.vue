<template>
  <div class="users-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <div class="search-form">
            <el-form :model="searchForm" inline>
              <el-form-item label="用户名称">
                <el-input 
                  v-model="searchForm.nickName" 
                  placeholder="请输入用户名称" 
                  clearable 
                  style="width: 200px"
                  @keyup.enter="handleSearch"
                />
              </el-form-item>
              <el-form-item label="账号">
                <el-input 
                  v-model="searchForm.userName" 
                  placeholder="请输入账号" 
                  clearable 
                  style="width: 200px"
                  @keyup.enter="handleSearch"
                />
              </el-form-item>
              <el-form-item label="邮箱">
                <el-input 
                  v-model="searchForm.email" 
                  placeholder="请输入邮箱" 
                  clearable 
                  style="width: 200px"
                  @keyup.enter="handleSearch"
                />
              </el-form-item>
              <el-form-item label="电话">
                <el-input 
                  v-model="searchForm.phoneNumber" 
                  placeholder="请输入电话" 
                  clearable 
                  style="width: 200px"
                  @keyup.enter="handleSearch"
                />
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="handleSearch">搜索</el-button>
                <el-button @click="handleReset">重置</el-button>
              </el-form-item>
            </el-form>
          </div>
          <el-button type="primary" @click="handleAdd">添加用户</el-button>
        </div>
      </template>

      <el-table 
        :data="users" 
        style="width: 100%" 
        v-loading="loading"
        element-loading-text="加载中..."
        table-layout="fixed"
      >
        <el-table-column prop="userName" label="账号" width="120" />
        <el-table-column prop="nickName" label="用户名称" width="120" />
        <el-table-column prop="email" label="邮箱" min-width="200" />
        <el-table-column prop="phoneNumber" label="电话" width="130" />
        <el-table-column prop="sex" label="性别" width="80">
          <template #default="{ row }">
            <el-tag :type="row.sex === 1 ? 'success' : 'info'">
              {{ row.sex === 1 ? '男' : '女' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="isActive" label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.isActive ? 'success' : 'danger'">
              {{ row.isActive ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="lastLogin" label="最后登录" min-width="160" />
        <el-table-column prop="createdTime" label="创建时间" min-width="160" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link @click="handleEdit(row)">编辑</el-button>
            <el-button type="success" link @click="handleManageRole(row)">管理角色</el-button>
            <el-button type="danger" link @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页组件 -->
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="pagination.current"
          v-model:page-size="pagination.size"
          :page-sizes="[5, 10, 20, 50]"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 用户表单弹窗 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogTitle"
      width="600px"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
    >
      <el-form
        ref="formRef"
        :model="userForm"
        :rules="formRules"
        label-width="100px"
        label-position="right"
      >
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="账号" prop="account">
              <el-input
                v-model="userForm.account"
                placeholder="请输入账号"
                :disabled="isEdit"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="用户名称" prop="nickName">
              <el-input
                v-model="userForm.nickName"
                placeholder="请输入用户名称"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input
                v-model="userForm.email"
                placeholder="请输入邮箱"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="电话" prop="phone">
              <el-input
                v-model="userForm.phone"
                placeholder="请输入电话号码"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="密码" prop="password" v-if="!isEdit">
              <el-input
                v-model="userForm.password"
                type="password"
                placeholder="请输入密码"
                show-password
              />
            </el-form-item>
            <el-form-item label="密码" v-else>
              <el-input
                v-model="userForm.password"
                type="password"
                placeholder="留空则不修改密码"
                show-password
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="性别" prop="gender">
              <el-radio-group v-model="userForm.gender">
                <el-radio :label="1">男</el-radio>
                <el-radio :label="0">女</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
         
          <el-col :span="12">
            <el-form-item label="状态" prop="isActive">
              <el-switch
                v-model="userForm.isActive"
                active-text="启用"
                inactive-text="禁用"
              />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>

      <template #footer>
        <div class="dialog-footer">
          <el-button @click="handleCancel">取消</el-button>
          <el-button type="primary" @click="handleSave" :loading="loading">
            {{ isEdit ? '更新' : '创建' }}
          </el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 角色管理弹窗 -->
    <el-dialog
      v-model="roleDialogVisible"
      title="管理用户角色"
      width="800px"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
    >
      <div class="role-management">
        <div class="role-header">
          <span class="user-info">用户：{{ currentUser.nickName }} ({{ currentUser.userName }})</span>
          <el-button type="primary" @click="handleAddRole">添加角色</el-button>
        </div>
        
        <el-table 
          :data="userRoles" 
          style="width: 100%" 
          v-loading="roleLoading"
          element-loading-text="加载中..."
        >
          <el-table-column prop="roleName" label="角色名称" width="150" />
          <el-table-column prop="roleCode" label="角色编码" width="120" />
          <el-table-column prop="description" label="描述" min-width="200" />
          <el-table-column prop="createdTime" label="创建时间" width="160" />
          <el-table-column label="操作" width="100">
            <template #default="{ row }">
              <el-button type="danger" link @click="handleRemoveRole(row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>

      <template #footer>
        <div class="dialog-footer">
          <el-button @click="roleDialogVisible = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 添加角色弹窗 -->
    <el-dialog
      v-model="addRoleDialogVisible"
      title="添加角色"
      width="600px"
      :close-on-click-modal="false"
    >
      <el-table 
        ref="roleTableRef"
        :data="allRoles" 
        style="width: 100%" 
        v-loading="allRolesLoading"
        element-loading-text="加载中..."
        @selection-change="handleRoleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="roleName" label="角色名称" width="150" />
        <el-table-column prop="roleCode" label="角色编码" width="120" />
        <el-table-column prop="description" label="描述" min-width="200" />
      </el-table>

      <template #footer>
        <div class="dialog-footer">
          <el-button @click="handleCancelAddRole">取消</el-button>
          <el-button type="primary" @click="handleConfirmAddRole" :loading="roleLoading">
            确定添加
          </el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, reactive, nextTick } from 'vue'
import ElMessage from 'element-plus/es/components/message/index'
import ElMessageBox from 'element-plus/es/components/message-box/index'
import { getUserPageList, createUser, updateUser, deleteUser, getUserDetail, manageUserRole, type UserQuery, type UserInfo, type UserFormData, type UserDetailInfo, type RoleInfo } from '../../utils/api/user/user_page_api'
import { RoleApi } from '../../utils/api/role/RoleApi'
import { RoleType } from '../../utils/api/role/roleType'
import { PageQuery } from '../../utils/PageQuery'

// 搜索表单
const searchForm = ref<UserQuery>({
  nickName: '',
  userName: '',
  email: '',
  phoneNumber: ''
})

// 用户列表数据
const users = ref<UserInfo[]>([])
const loading = ref(false)

// 分页参数
const pagination = ref({
  current: 1,
  size: 10
})

// 总条数
const total = ref(0)

// 弹窗相关状态
const dialogVisible = ref(false)
const dialogTitle = ref('')
const isEdit = ref(false)

// 角色管理相关状态
const roleDialogVisible = ref(false)
const addRoleDialogVisible = ref(false)
const currentUser = ref<UserInfo>({} as UserInfo)
const userRoles = ref<RoleInfo[]>([])
const allRoles = ref<RoleInfo[]>([])
const selectedRoles = ref<RoleInfo[]>([])
const roleLoading = ref(false)
const allRolesLoading = ref(false)

// 用户表单数据
const userForm = reactive<UserFormData>({
  account: '',
  email: '',
  password: '',
  nickName: '',
  phone: '',
  gender: 1,
  avatarUrl: '',
  isActive: true
})

// 表单验证规则
const formRules = {
  account: [
    { required: true, message: '请输入账号', trigger: 'blur' },
    { min: 3, max: 20, message: '账号长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  nickName: [
    { required: true, message: '请输入用户名称', trigger: 'blur' },
    { min: 2, max: 20, message: '用户名称长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入电话号码', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ]
}

// 表单引用
const formRef = ref()
const roleTableRef = ref()

// 获取用户列表
const fetchUsers = async () => {
  try {
    loading.value = true
    const pageQuery = new PageQuery(pagination.value.current, pagination.value.size)
    const response = await getUserPageList(searchForm.value, pageQuery)
    
    if (response.code === 10000) {
      users.value = response.data.records
      total.value = parseInt(response.data.total)
    } else {
      ElMessage.error(response.message || '获取用户列表失败')
    }
  } catch (error) {
    console.error('获取用户列表失败:', error)
    ElMessage.error('获取用户列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  pagination.value.current = 1
  fetchUsers()
}

// 重置搜索
const handleReset = () => {
  searchForm.value = {
    nickName: '',
    userName: '',
    email: '',
    phoneNumber: ''
  }
  pagination.value.current = 1
  fetchUsers()
}

// 分页大小改变
const handleSizeChange = (size: number) => {
  pagination.value.size = size
  pagination.value.current = 1
  fetchUsers()
}

// 当前页改变
const handleCurrentChange = (current: number) => {
  pagination.value.current = current
  fetchUsers()
}

// 重置表单
const resetForm = () => {
  Object.assign(userForm, {
    account: '',
    email: '',
    password: '',
    nickName: '',
    phone: '',
    gender: 1,
    avatarUrl: '',
    isActive: true
  })
  if (formRef.value) {
    formRef.value.clearValidate()
  }
}

// 添加用户
const handleAdd = () => {
  resetForm()
  dialogTitle.value = '添加用户'
  isEdit.value = false
  dialogVisible.value = true
}

// 编辑用户
const handleEdit = (row: UserInfo) => {
  resetForm()
  dialogTitle.value = '编辑用户'
  isEdit.value = true
  
  // 回填数据
  Object.assign(userForm, {
    id: row.id,
    account: row.userName, // 注意：这里将 userName 映射到 account
    email: row.email,
    nickName: row.nickName,
    phone: row.phoneNumber, // 注意：这里将 phoneNumber 映射到 phone
    gender: row.sex, // 注意：这里将 sex 映射到 gender
    avatarUrl: row.avatarUrl || '',
    isActive: row.isActive
  })
  
  dialogVisible.value = true
}

// 保存用户
const handleSave = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    
    if (isEdit.value) {
      // 编辑用户
      const response = await updateUser(userForm)
      if (response.code === 10000) {
        ElMessage.success('用户更新成功')
        dialogVisible.value = false
        fetchUsers()
      } else {
        ElMessage.error(response.message || '用户更新失败')
      }
    } else {
      // 新增用户
      const response = await createUser(userForm)
      if (response.code === 10000) {
        ElMessage.success('用户创建成功')
        dialogVisible.value = false
        fetchUsers()
      } else {
        ElMessage.error(response.message || '用户创建失败')
      }
    }
  } catch (error) {
    console.error('保存用户失败:', error)
    ElMessage.error('保存用户失败')
  }
}

// 取消保存
const handleCancel = () => {
  dialogVisible.value = false
  resetForm()
}

// 删除用户
const handleDelete = (row: UserInfo) => {
  ElMessageBox.confirm(
    `确定要删除用户 "${row.nickName}" 吗？`,
    '确认删除',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  ).then(async () => {
    try {
      const response = await deleteUser(row.id)
      if (response.code === 10000) {
        ElMessage.success('删除成功')
        fetchUsers()
      } else {
        ElMessage.error(response.message || '删除失败')
      }
    } catch (error) {
      console.error('删除用户失败:', error)
      ElMessage.error('删除用户失败')
    }
  }).catch(() => {
    ElMessage.info('已取消删除')
  })
}

// 管理用户角色
const handleManageRole = async (row: UserInfo) => {
  currentUser.value = row
  roleDialogVisible.value = true
  await fetchUserRoles(row.id)
}

// 获取用户角色
const fetchUserRoles = async (userId: string) => {
  try {
    roleLoading.value = true
    const response = await getUserDetail(userId)
    if (response.code === 10000) {
      userRoles.value = response.data.sysRoles || []
    } else {
      ElMessage.error(response.message || '获取用户角色失败')
    }
  } catch (error) {
    console.error('获取用户角色失败:', error)
    ElMessage.error('获取用户角色失败')
  } finally {
    roleLoading.value = false
  }
}

// 添加角色
const handleAddRole = async () => {
  addRoleDialogVisible.value = true
  await fetchAllRoles()
  // 自动勾选用户已拥有的角色
  autoSelectUserRoles()
}

// 获取所有角色
const fetchAllRoles = async () => {
  try {
    allRolesLoading.value = true
    const pageQuery = new PageQuery(1, 999999)
    const emptyQuery = new RoleType()
    const response = await RoleApi.getRoleList(emptyQuery, pageQuery)
    if (response.code === 10000) {
      allRoles.value = response.data.records || []
    } else {
      ElMessage.error(response.message || '获取角色列表失败')
    }
  } catch (error) {
    console.error('获取角色列表失败:', error)
    ElMessage.error('获取角色列表失败')
  } finally {
    allRolesLoading.value = false
  }
}

// 自动勾选用户已拥有的角色
const autoSelectUserRoles = async () => {
  await nextTick() // 等待DOM更新
  
  if (!roleTableRef.value) return
  
  // 获取用户已拥有角色的ID列表
  const userRoleIds = userRoles.value.map(role => role.id)
  
  // 找到所有角色中用户已拥有的角色
  const alreadyOwnedRoles = allRoles.value.filter(role => 
    userRoleIds.includes(role.id)
  )
  
  // 自动选中这些角色
  selectedRoles.value = alreadyOwnedRoles
  
  // 设置表格的选中状态
  alreadyOwnedRoles.forEach(role => {
    const rowIndex = allRoles.value.findIndex(r => r.id === role.id)
    if (rowIndex !== -1) {
      roleTableRef.value.toggleRowSelection(allRoles.value[rowIndex], true)
    }
  })
}

// 角色选择变化
const handleRoleSelectionChange = (selection: RoleInfo[]) => {
  selectedRoles.value = selection
}

// 取消添加角色
const handleCancelAddRole = () => {
  addRoleDialogVisible.value = false
  selectedRoles.value = []
  // 清空表格选中状态
  if (roleTableRef.value) {
    roleTableRef.value.clearSelection()
  }
}

// 确认添加角色
const handleConfirmAddRole = async () => {
  if (selectedRoles.value.length === 0) {
    ElMessage.warning('请选择要添加的角色')
    return
  }

  try {
    roleLoading.value = true
    const currentRoleIds = userRoles.value.map(role => role.id)
    const selectedRoleIds = selectedRoles.value.map(role => role.id)
    
    // 找出新选择的角色（排除已拥有的角色）
    const newRoleIds = selectedRoleIds.filter(roleId => !currentRoleIds.includes(roleId))
    
    if (newRoleIds.length === 0) {
      ElMessage.warning('没有选择新的角色')
      return
    }
    
    // 合并当前角色和新角色
    const allRoleIds = [...currentRoleIds, ...newRoleIds]
    
    const response = await manageUserRole(currentUser.value.userName, allRoleIds)
    if (response.code === 10000) {
      ElMessage.success(`成功添加 ${newRoleIds.length} 个新角色`)
      addRoleDialogVisible.value = false
      selectedRoles.value = []
      // 清空表格选中状态
      if (roleTableRef.value) {
        roleTableRef.value.clearSelection()
      }
      await fetchUserRoles(currentUser.value.id)
    } else {
      ElMessage.error(response.message || '角色添加失败')
    }
  } catch (error) {
    console.error('添加角色失败:', error)
    ElMessage.error('添加角色失败')
  } finally {
    roleLoading.value = false
  }
}

// 删除角色
const handleRemoveRole = (row: RoleInfo) => {
  ElMessageBox.confirm(
    `确定要删除角色 "${row.roleName}" 吗？`,
    '确认删除',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  ).then(async () => {
    try {
      roleLoading.value = true
      const currentRoleIds = userRoles.value
        .filter(role => role.id !== row.id)
        .map(role => role.id)
      
      const response = await manageUserRole(currentUser.value.userName, currentRoleIds)
      if (response.code === 10000) {
        ElMessage.success('角色删除成功')
        await fetchUserRoles(currentUser.value.id)
      } else {
        ElMessage.error(response.message || '角色删除失败')
      }
    } catch (error) {
      console.error('删除角色失败:', error)
      ElMessage.error('删除角色失败')
    } finally {
      roleLoading.value = false
    }
  }).catch(() => {
    ElMessage.info('已取消删除')
  })
}

// 页面加载时获取数据
onMounted(() => {
  fetchUsers()
})
</script>

<style scoped lang="scss">
.users-container {
  padding: 20px;
  
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 20px;
    
    .search-form {
      flex: 1;
      margin-right: 20px;
      
      .el-form {
        .el-form-item {
          margin-bottom: 10px;
        }
      }
    }
  }
  
  .pagination-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
    padding: 20px 0;
  }
  
  .el-table {
    width: 100%;
    
    .el-table__header {
      th {
        background-color: #f5f7fa;
        color: #606266;
        font-weight: 600;
        text-align: center;
      }
    }
    
    .el-table__body {
      td {
        text-align: center;
      }
    }
    
    .el-table__cell {
      padding: 12px 0;
    }
  }
  
  // 弹窗样式
  .dialog-footer {
    text-align: right;
    
    .el-button {
      margin-left: 10px;
    }
  }
  
  // 表单样式
  .el-form {
    .el-form-item {
      margin-bottom: 20px;
    }
    
    .el-input {
      width: 100%;
    }
    
    .el-radio-group {
      .el-radio {
        margin-right: 20px;
      }
    }
  }
  
  // 角色管理样式
  .role-management {
    .role-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      padding: 10px 0;
      border-bottom: 1px solid #ebeef5;
      
      .user-info {
        font-size: 16px;
        font-weight: 600;
        color: #303133;
      }
    }
    
    .el-table {
      .el-table__header {
        th {
          background-color: #f5f7fa;
          color: #606266;
          font-weight: 600;
          text-align: center;
        }
      }
      
      .el-table__body {
        td {
          text-align: center;
        }
      }
    }
  }
}
</style> 