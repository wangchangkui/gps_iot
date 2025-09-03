<template>
  <div class="menu-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span class="header-title">菜单管理</span>
          <el-button type="primary" @click="handleAddRoot">添加根菜单</el-button>
        </div>
      </template>

      <div class="menu-content">
        <!-- 左侧菜单树 -->
        <div class="menu-tree-container">
          <el-tree ref="treeRef" :data="menuTree" :props="treeProps" node-key="permissionId" default-expand-all
            :expand-on-click-node="false" @node-click="handleNodeClick">
            <template #default="{ node, data }">
              <div class="tree-node">
                <div class="node-content">
                  <span class="node-icon">{{ data.permType === 'MENU' ? '📁' : '🔗' }}</span>
                  <span class="node-title">{{ data.permName }}</span>
                  <el-tag v-if="data.permType === 'API'" size="small" type="info">API</el-tag>
                  <el-tag v-if="data.isHidden" size="small" type="warning">隐藏</el-tag>
                </div>
                <div class="node-actions">
                  <el-button type="primary" link size="small" @click.stop="handleAdd(data)">
                    添加
                  </el-button>
                  <el-button type="primary" link size="small" @click.stop="handleEdit(data)">
                    编辑
                  </el-button>
                  <el-button type="danger" link size="small" @click.stop="handleDelete(data)">
                    删除
                  </el-button>
                </div>
              </div>
            </template>
          </el-tree>
        </div>

        <!-- 右侧详情面板 -->
        <div class="menu-detail-container" v-if="selectedNode">
          <el-card>
            <template #header>
              <div class="detail-header">
                <span>菜单详情</span>
                <el-button type="primary" link @click="handleEdit(selectedNode)">编辑</el-button>
              </div>
            </template>
            <div class="detail-content">
              <el-descriptions :column="1" border>
                <el-descriptions-item label="权限键">{{ selectedNode.permKey }}</el-descriptions-item>
                <el-descriptions-item label="菜单名称">{{ selectedNode.permName }}</el-descriptions-item>
                <el-descriptions-item label="类型">
                  <el-tag v-if="selectedNode.permType === 'MENU'" type="success">菜单</el-tag>
                  <el-tag v-else-if="selectedNode.permType === 'API'" type="info">API</el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="路径">{{ selectedNode.componentPath || '-' }}</el-descriptions-item>
                <el-descriptions-item label="排序">{{ selectedNode.sortOrder }}</el-descriptions-item>
                <el-descriptions-item label="状态">
                  <el-tag v-if="selectedNode.isHidden" type="warning">隐藏</el-tag>
                  <el-tag v-else type="success">显示</el-tag>
                </el-descriptions-item>
              </el-descriptions>
            </div>
          </el-card>
        </div>
      </div>
    </el-card>

    <!-- 添加/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px" @close="handleDialogClose">
      <el-form ref="formRef" :model="formData" :rules="formRules" label-width="100px">
        <el-form-item label="权限键" prop="permKey">
          <el-input v-model="formData.permKey" placeholder="请输入权限键，如：menu:system:user" />
        </el-form-item>
        <el-form-item label="菜单名称" prop="permName">
          <el-input v-model="formData.permName" placeholder="请输入菜单名称" />
        </el-form-item>
        <el-form-item label="类型" prop="permType">
          <el-select v-model="formData.permType" placeholder="请选择类型" style="width: 100%">
            <el-option label="菜单" value="MENU" />
            <el-option label="API" value="API" />
          </el-select>
        </el-form-item>
        <el-form-item label="父级权限" prop="parentId">
          <el-tree-select v-model="formData.parentId"
            :data="isEdit ? getAvailableParentTree(formData.permissionId) : menuTree" :props="treeSelectProps"
            placeholder="请选择父级权限" style="width: 100%" clearable check-strictly :render-after-expand="false" />
          <div class="form-tip">
            <el-text type="info" size="small">
              选择父级权限可以将当前菜单移动到指定目录下，留空则作为根菜单
            </el-text>
          </div>
        </el-form-item>
        <el-form-item label="路径" prop="componentPath">
          <el-input v-model="formData.componentPath" placeholder="菜单时输入路由路径，API时输入接口地址" />
        </el-form-item>
        <el-form-item label="排序" prop="sortOrder">
          <el-input-number v-model="formData.sortOrder" :min="0" :max="999" style="width: 100%" />
        </el-form-item>
        <el-form-item label="是否隐藏" prop="isHidden" v-if="isEdit">
          <el-switch v-model="formData.isHidden" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onUnmounted, computed } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import ElMessage from 'element-plus/es/components/message/index'
import type { Permissions } from '../../utils/api/user/Permissions'
import { MenuApi } from '../../utils/api/menu/menuApi'
import ElMessageBox from 'element-plus/es/components/message-box/index'
import { webSocketManager } from '../../utils/websocket/WebSocketManager'
import type { MenuChangeMessage } from '../../utils/websocket/types'

// 响应式数据
const treeRef = ref()
const selectedNode = ref<Permissions | null>(null)
const dialogVisible = ref(false)
const isEdit = ref(false)
const formRef = ref<FormInstance>()

// 菜单树数据
const menuTree = ref<Permissions[]>([])

// 树形组件配置
const treeProps = {
  children: 'children',
  label: 'permName'
}

// 树形选择器配置
const treeSelectProps = {
  value: 'permissionId',
  label: 'permName',
  children: 'children'
}

// 表单数据
const formData = reactive({
  permissionId: '',
  permKey: '',
  permName: '',
  permType: 'MENU',
  parentId: '',
  componentPath: '',
  sortOrder: 0,
  isHidden: false
})

// 表单验证规则
const formRules: FormRules = {
  permKey: [
    { required: true, message: '请输入权限键', trigger: 'blur' },
    { pattern: /^[a-z][a-z0-9:]*$/, message: '权限键格式不正确', trigger: 'blur' }
  ],
  permName: [
    { required: true, message: '请输入菜单名称', trigger: 'blur' }
  ],
  permType: [
    { required: true, message: '请选择类型', trigger: 'change' }
  ],
  parentId: [
    { required: false, message: '请选择父级权限', trigger: 'change' }
  ],
  sortOrder: [
    { required: true, message: '请输入排序序号', trigger: 'blur' }
  ]
}

// 计算属性
const dialogTitle = computed(() => isEdit.value ? '编辑菜单' : '添加菜单')

// 初始化数据
onMounted(() => {
  loadMenuTree()
  setupWebSocketListeners()
})

// 清理WebSocket监听器
onUnmounted(() => {
  cleanupWebSocketListeners()
})

// 加载菜单树
const loadMenuTree = async () => {
  try {
    // 模拟数据，实际应该从API获取
    const res = await MenuApi.getMenuTree()
    menuTree.value = res.data
  } catch (error) {
    ElMessage({
      type: 'error',
      message: '加载菜单数据失败'
    })
  }
}

// 处理节点点击
const handleNodeClick = (data: Permissions) => {
  selectedNode.value = data
}

// 添加根菜单
const handleAddRoot = async () => {


  resetForm()
  formData.parentId = ''
  isEdit.value = false
  dialogVisible.value = true
}

// 添加子菜单
const handleAdd = (parentNode: Permissions) => {
  resetForm()
  formData.parentId = parentNode.permissionId
  isEdit.value = false
  dialogVisible.value = true
}

// 编辑菜单
const handleEdit = (node: Permissions) => {
  resetForm()
  Object.assign(formData, {
    permissionId: node.permissionId,
    permKey: node.permKey,
    permName: node.permName,
    permType: node.permType,
    parentId: node.parentId,
    componentPath: node.componentPath,
    sortOrder: node.sortOrder,
    isHidden: node.isHidden
  })
  isEdit.value = true
  dialogVisible.value = true
}

// 获取可选的父级权限树（排除当前编辑的节点及其子节点）
const getAvailableParentTree = (currentId?: string) => {
  if (!currentId) return menuTree.value

  const filterTree = (nodes: Permissions[]): Permissions[] => {
    return nodes.filter(node => {
      if (node.permissionId === currentId) return false
      if (node.children && node.children.length > 0) {
        node.children = filterTree(node.children)
      }
      return true
    })
  }

  return filterTree(JSON.parse(JSON.stringify(menuTree.value)))
}

// 删除菜单
const handleDelete = async (node: Permissions) => {
  ElMessageBox.confirm(
    `确定要删除菜单"${node.permName}"吗？删除后不可恢复！`,
    '确认删除',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }
  ).then(async () => {
    const id = node.permissionId
    const res = await MenuApi.deleteMenu(id)
    if (res.code === 10000) {
      ElMessage.success('删除成功')
      // 通知其他用户菜单已删除
      notifyMenuChange('delete', node)
    }

    loadMenuTree()
  }).catch(() => {
    // 用户取消删除
  })
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return

  try {
    await formRef.value.validate((valid, fields) => {
      if (!valid) {
        throw new Error('表单验证失败')
      }
    })
    if (isEdit.value) {
      const res = await MenuApi.updateMenu(formData)
      if (res.code === 10000) {
        ElMessage.success('编辑成功')
        // 通知其他用户菜单已更新
        notifyMenuChange('update', formData)
      }
    } else {
      const res = await MenuApi.addMenu(formData)
      if (res.code === 10000) {
        ElMessage.success('添加成功')
        // 通知其他用户菜单已添加
        notifyMenuChange('add', formData)
      }
    }

    dialogVisible.value = false
    loadMenuTree()
  } catch (error) {
    ElMessage({
      type: 'error',
      message: '表单验证失败'
    })
  }
}

// 重置表单
const resetForm = () => {
  Object.assign(formData, {
    permissionId: '',
    permKey: '',
    permName: '',
    permType: 'MENU',
    parentId: '',
    componentPath: '',
    sortOrder: 0,
    isHidden: false
  })
  // 重置表单验证状态
}

// 关闭对话框
const handleDialogClose = () => {
  resetForm()
}

// 设置WebSocket监听器
const setupWebSocketListeners = () => {
  // 监听菜单变更事件
  window.addEventListener('menu-change', handleMenuChangeEvent as EventListener);
}

// 清理WebSocket监听器
const cleanupWebSocketListeners = () => {
  window.removeEventListener('menu-change', handleMenuChangeEvent as EventListener);
}

// 处理菜单变更事件
const handleMenuChangeEvent = (event: Event) => {
  const customEvent = event as CustomEvent;
  // 刷新菜单树
  loadMenuTree();
}

// 通知菜单变更（在菜单操作成功后调用）
const notifyMenuChange = (action: 'add' | 'update' | 'delete', menuData?: any) => {
  console.log("所有的通知消息均有后台发回给前端，前端只接收消息")
}
</script>

<style scoped lang="scss">
.menu-container {
  padding: 20px;

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;

    .header-title {
      font-size: 16px;
      font-weight: 600;
    }
  }

  .menu-content {
    display: flex;
    gap: 20px;
    min-height: 600px;

    .menu-tree-container {
      flex: 1;
      border: 1px solid #e4e7ed;
      border-radius: 4px;
      padding: 16px;
      background-color: #fff;

      .tree-node {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;

        .node-content {
          display: flex;
          align-items: center;
          gap: 8px;
          flex: 1;

          .node-icon {
            font-size: 16px;
          }

          .node-title {
            font-weight: 500;
          }
        }

        .node-actions {
          display: flex;
          gap: 4px;
          opacity: 0;
          transition: opacity 0.3s;
        }

        &:hover .node-actions {
          opacity: 1;
        }
      }
    }

    .menu-detail-container {
      width: 400px;

      .detail-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .detail-content {
        .el-descriptions {
          margin-top: 16px;
        }
      }
    }
  }
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

.form-tip {
  margin-top: 4px;
  line-height: 1.4;
}
</style>
