<template>
  <div class="devices-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <div class="left">
            <el-input
              v-model="searchQuery"
              placeholder="搜索设备"
              style="width: 200px"
              clearable
            >
              <template #prefix>
                <el-icon><Search /></el-icon>
              </template>
            </el-input>
            <el-select v-model="statusFilter" placeholder="状态筛选" clearable>
              <el-option label="全部" value="" />
              <el-option label="在线" value="online" />
              <el-option label="离线" value="offline" />
            </el-select>
          </div>
          <el-button type="primary" @click="handleAdd">
            添加设备
          </el-button>
        </div>
      </template>

      <el-table :data="filteredDevices" style="width: 100%">
        <el-table-column prop="id" label="设备ID" width="120" />
        <el-table-column prop="name" label="设备名称" />
        <el-table-column prop="type" label="设备类型" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 'online' ? 'success' : 'danger'">
              {{ row.status === 'online' ? '在线' : '离线' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="lastUpdate" label="最后更新时间" width="180" />
        <el-table-column label="操作" width="250" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link @click="handleEdit(row)">
              编辑
            </el-button>
            <el-button type="primary" link @click="handleView(row)">
              查看
            </el-button>
            <el-button type="danger" link @click="handleDelete(row)">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-container">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :total="total"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 设备表单对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="dialogType === 'add' ? '添加设备' : '编辑设备'"
      width="500px"
    >
      <el-form
        ref="deviceFormRef"
        :model="deviceForm"
        :rules="deviceRules"
        label-width="100px"
      >
        <el-form-item label="设备名称" prop="name">
          <el-input v-model="deviceForm.name" />
        </el-form-item>
        <el-form-item label="设备类型" prop="type">
          <el-select v-model="deviceForm.type" placeholder="请选择设备类型">
            <el-option label="GPS追踪器" value="gps_tracker" />
            <el-option label="定位器" value="locator" />
          </el-select>
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            v-model="deviceForm.description"
            type="textarea"
            :rows="3"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">
            确定
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import { Search } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'

interface Device {
  id: string
  name: string
  type: string
  status: 'online' | 'offline'
  lastUpdate: string
  description?: string
}

// 状态管理
const searchQuery = ref('')
const statusFilter = ref('')
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(100)
const dialogVisible = ref(false)
const dialogType = ref<'add' | 'edit'>('add')
const deviceFormRef = ref<FormInstance>()

// 设备表单
const deviceForm = ref({
  name: '',
  type: '',
  description: ''
})

// 表单验证规则
const deviceRules: FormRules = {
  name: [
    { required: true, message: '请输入设备名称', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  type: [
    { required: true, message: '请选择设备类型', trigger: 'change' }
  ]
}

// 模拟数据
const devices = ref<Device[]>([
  {
    id: '001',
    name: 'GPS-001',
    type: 'gps_tracker',
    status: 'online',
    lastUpdate: '2024-03-20 10:00:00'
  },
  {
    id: '002',
    name: 'GPS-002',
    type: 'locator',
    status: 'offline',
    lastUpdate: '2024-03-20 09:30:00'
  }
])

// 过滤设备列表
const filteredDevices = computed(() => {
  return devices.value.filter(device => {
    const matchQuery = device.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                      device.id.toLowerCase().includes(searchQuery.value.toLowerCase())
    const matchStatus = !statusFilter.value || device.status === statusFilter.value
    return matchQuery && matchStatus
  })
})

// 处理分页
const handleSizeChange = (val: number) => {
  pageSize.value = val
  // TODO: 重新加载数据
}

const handleCurrentChange = (val: number) => {
  currentPage.value = val
  // TODO: 重新加载数据
}

// 处理设备操作
const handleAdd = () => {
  dialogType.value = 'add'
  deviceForm.value = {
    name: '',
    type: '',
    description: ''
  }
  dialogVisible.value = true
}

const handleEdit = (row: Device) => {
  dialogType.value = 'edit'
  deviceForm.value = {
    name: row.name,
    type: row.type,
    description: row.description || ''
  }
  dialogVisible.value = true
}

const handleView = (row: Device) => {
  // TODO: 实现查看详情逻辑
}

const handleDelete = (row: Device) => {
  ElMessageBox.confirm(
    '确定要删除该设备吗？',
    '警告',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }
  ).then(() => {
    // TODO: 实现删除逻辑
    ElMessage({
      type: 'success',
      message: '删除成功'
    })
  }).catch(() => {})
}

const handleSubmit = async () => {
  if (!deviceFormRef.value) return
  
  await deviceFormRef.value.validate((valid, fields) => {
    if (valid) {
      // TODO: 实现提交逻辑
      dialogVisible.value = false
      ElMessage({
        type: 'success',
        message: dialogType.value === 'add' ? '添加成功' : '更新成功'
      })
    }
  })
}
</script>

<style scoped lang="scss">
.devices-container {
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    
    .left {
      display: flex;
      gap: 16px;
    }
  }
  
  .pagination-container {
    margin-top: 20px;
    display: flex;
    justify-content: flex-end;
  }
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}
</style> 