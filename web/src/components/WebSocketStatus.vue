<template>
  <div class="websocket-status">
    <el-tooltip :content="tooltipContent" placement="bottom">
      <div class="status-indicator" :class="statusClass">
        <div class="status-dot"></div>
        <span class="status-text">{{ statusText }}</span>
      </div>
    </el-tooltip>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { webSocketManager } from '../utils/websocket/WebSocketManager'

// 响应式数据
const isConnected = ref(false)
const lastUpdateTime = ref<Date | null>(null)

// 计算属性
const statusClass = computed(() => ({
  'status-connected': isConnected.value,
  'status-disconnected': !isConnected.value
}))

const statusText = computed(() => 
  isConnected.value ? '已连接' : '未连接'
)

const tooltipContent = computed(() => {
  if (isConnected.value) {
    return `WebSocket已连接${lastUpdateTime.value ? `\n最后更新: ${lastUpdateTime.value.toLocaleTimeString()}` : ''}`
  } else {
    return 'WebSocket未连接，实时功能不可用'
  }
})

// 检查连接状态
const checkConnectionStatus = () => {
  const connected = webSocketManager.isConnected()
  if (connected !== isConnected.value) {
    isConnected.value = connected
    lastUpdateTime.value = new Date()
  }
}

// 生命周期钩子
onMounted(() => {
  checkConnectionStatus()
  
  // 定期检查连接状态
  const interval = setInterval(checkConnectionStatus, 1000)
  
  onUnmounted(() => {
    clearInterval(interval)
  })
})
</script>

<style scoped lang="scss">
.websocket-status {
  display: inline-flex;
  align-items: center;
  font-size: 12px;
  
  .status-indicator {
    display: flex;
    align-items: center;
    gap: 4px;
    padding: 2px 6px;
    border-radius: 12px;
    transition: all 0.3s ease;
    
    &.status-connected {
      background-color: #f0f9ff;
      color: #16a34a;
      
      .status-dot {
        background-color: #16a34a;
        box-shadow: 0 0 0 2px #dcfce7;
      }
    }
    
    &.status-disconnected {
      background-color: #fef2f2;
      color: #dc2626;
      
      .status-dot {
        background-color: #dc2626;
        box-shadow: 0 0 0 2px #fecaca;
      }
    }
    
    .status-dot {
      width: 6px;
      height: 6px;
      border-radius: 50%;
      transition: all 0.3s ease;
      animation: pulse 2s infinite;
    }
    
    .status-text {
      font-weight: 500;
      white-space: nowrap;
    }
  }
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
    opacity: 1;
  }
  50% {
    transform: scale(1.1);
    opacity: 0.8;
  }
}
</style>
