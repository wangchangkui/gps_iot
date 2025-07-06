<template>
  <div class="device-control-container">
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card class="device-list">
          <template #header>
            <div class="card-header">
              <span>设备列表</span>
              <el-input
                v-model="searchQuery"
                placeholder="搜索设备"
                clearable
                style="width: 200px"
              >
                <template #prefix>
                  <el-icon><Search /></el-icon>
                </template>
              </el-input>
            </div>
          </template>
          <el-table
            :data="filteredDevices"
            style="width: 100%"
            @row-click="handleDeviceSelect"
            highlight-current-row
          >
            <el-table-column prop="name" label="设备名称" />
            <el-table-column prop="status" label="状态" width="100">
              <template #default="{ row }">
                <el-tag :type="row.status === 'online' ? 'success' : 'danger'">
                  {{ row.status === 'online' ? '在线' : '离线' }}
                </el-tag>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
      
      <el-col :span="16">
        <el-card v-if="selectedDevice" class="command-panel">
          <template #header>
            <div class="card-header">
              <span>命令控制 - {{ selectedDevice.name }}</span>
              <el-tag :type="selectedDevice.status === 'online' ? 'success' : 'danger'">
                {{ selectedDevice.status === 'online' ? '在线' : '离线' }}
              </el-tag>
            </div>
          </template>
          
          <el-tabs v-model="activeTab">
            <el-tab-pane label="快捷命令" name="quick">
              <div class="quick-commands">
                <el-button
                  v-for="command in quickCommands"
                  :key="command.id"
                  type="primary"
                  :disabled="selectedDevice.status !== 'online'"
                  @click="sendQuickCommand(command)"
                >
                  {{ command.name }}
                </el-button>
              </div>
            </el-tab-pane>
            
            <el-tab-pane label="自定义命令" name="custom">
              <el-form
                ref="commandFormRef"
                :model="commandForm"
                :rules="commandRules"
                label-width="100px"
              >
                <el-form-item label="命令类型" prop="type">
                  <el-select v-model="commandForm.type" placeholder="请选择命令类型">
                    <el-option
                      v-for="type in commandTypes"
                      :key="type.value"
                      :label="type.label"
                      :value="type.value"
                    />
                  </el-select>
                </el-form-item>
                <el-form-item label="参数" prop="params">
                  <el-input
                    v-model="commandForm.params"
                    type="textarea"
                    :rows="4"
                    placeholder="请输入命令参数（JSON格式）"
                  />
                </el-form-item>
                <el-form-item>
                  <el-button
                    type="primary"
                    :disabled="selectedDevice.status !== 'online'"
                    @click="sendCustomCommand"
                  >
                    发送命令
                  </el-button>
                </el-form-item>
              </el-form>
            </el-tab-pane>
            
            <el-tab-pane label="命令历史" name="history">
              <el-table :data="commandHistory" style="width: 100%">
                <el-table-column prop="timestamp" label="时间" width="180" />
                <el-table-column prop="type" label="命令类型" />
                <el-table-column prop="status" label="状态" width="100">
                  <template #default="{ row }">
                    <el-tag :type="row.status === 'success' ? 'success' : 'danger'">
                      {{ row.status === 'success' ? '成功' : '失败' }}
                    </el-tag>
                  </template>
                </el-table-column>
                <el-table-column prop="response" label="响应" show-overflow-tooltip />
              </el-table>
            </el-tab-pane>
          </el-tabs>
        </el-card>
        
        <el-empty v-else description="请选择设备" />
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import { Search } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

interface Device {
  id: string
  name: string
  status: 'online' | 'offline'
}

interface Command {
  id: string
  name: string
  type: string
  params?: string
}

interface CommandHistory {
  timestamp: string
  type: string
  status: 'success' | 'failure'
  response: string
}

// 状态管理
const searchQuery = ref('')
const selectedDevice = ref<Device | null>(null)
const activeTab = ref('quick')
const commandFormRef = ref<FormInstance>()

// 设备列表
const devices = ref<Device[]>([
  { id: '001', name: 'GPS-001', status: 'online' },
  { id: '002', name: 'GPS-002', status: 'offline' }
])

// 快捷命令
const quickCommands = ref<Command[]>([
  { id: '1', name: '定位请求', type: 'location_request' },
  { id: '2', name: '重启设备', type: 'restart' },
  { id: '3', name: '设置采集间隔', type: 'set_interval' }
])

// 命令类型
const commandTypes = [
  { label: '定位请求', value: 'location_request' },
  { label: '重启设备', value: 'restart' },
  { label: '设置参数', value: 'set_params' },
  { label: '固件更新', value: 'firmware_update' }
]

// 自定义命令表单
const commandForm = ref({
  type: '',
  params: ''
})

// 命令历史
const commandHistory = ref<CommandHistory[]>([
  {
    timestamp: '2024-03-20 10:00:00',
    type: '定位请求',
    status: 'success',
    response: '{"latitude": 39.90923, "longitude": 116.397428}'
  }
])

// 表单验证规则
const commandRules: FormRules = {
  type: [
    { required: true, message: '请选择命令类型', trigger: 'change' }
  ],
  params: [
    { required: true, message: '请输入命令参数', trigger: 'blur' }
  ]
}

// 过滤设备列表
const filteredDevices = computed(() => {
  return devices.value.filter(device =>
    device.name.toLowerCase().includes(searchQuery.value.toLowerCase())
  )
})

// 处理设备选择
const handleDeviceSelect = (row: Device) => {
  selectedDevice.value = row
}

// 发送快捷命令
const sendQuickCommand = (command: Command) => {
  if (!selectedDevice.value) return
  
  // TODO: 实现命令发送逻辑
  ElMessage({
    type: 'success',
    message: `命令 ${command.name} 已发送`
  })
  
  // 添加到历史记录
  commandHistory.value.unshift({
    timestamp: new Date().toLocaleString(),
    type: command.name,
    status: 'success',
    response: '命令执行成功'
  })
}

// 发送自定义命令
const sendCustomCommand = async () => {
  if (!commandFormRef.value) return
  
  await commandFormRef.value.validate((valid, fields) => {
    if (valid) {
      // TODO: 实现命令发送逻辑
      ElMessage({
        type: 'success',
        message: '命令已发送'
      })
      
      // 添加到历史记录
      commandHistory.value.unshift({
        timestamp: new Date().toLocaleString(),
        type: commandForm.value.type,
        status: 'success',
        response: '命令执行成功'
      })
      
      // 重置表单
      commandForm.value = {
        type: '',
        params: ''
      }
    }
  })
}
</script>

<style scoped lang="scss">
.device-control-container {
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .device-list {
    height: calc(100vh - 120px);
    
    .el-table {
      margin-top: 20px;
    }
  }
  
  .command-panel {
    height: calc(100vh - 120px);
    
    .quick-commands {
      display: flex;
      gap: 12px;
      flex-wrap: wrap;
      margin-bottom: 20px;
    }
  }
}
</style> 