<template>
  <div class="home-container">
    <!-- 顶部导航栏 -->
    <header class="header">
      <div class="logo">
        <img src="/marker.png" alt="logo" />
        <span>Admcc</span>
      </div>
      <div class="nav-right">
        <template v-if="isLoggedIn">
          <el-dropdown>
            <el-avatar :src="userInfo.avatar" />
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="goToConsole">进入控制台</el-dropdown-item>
                <el-dropdown-item @click="handleLogout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
        <template v-else>
          <el-button type="primary" link @click="goToLogin">登录</el-button>
          <el-button link @click="goToRegister">注册</el-button>
        </template>
      </div>
    </header>

    <!-- 地图展示区 -->
    <main class="main-content">
      <vc-viewer
        ref="viewerRef"
        :animation="false"
        :timeline="false"
        :navigation="false"
        :base-layer-picker="false"
        :creditsDisplay="false"
        :showCredit="false"
        @ready="onViewerReady"
      >
        <vc-layer-imagery>
          <vc-layer-imagery>
            <vc-imagery-provider-tianditu
              map-style="vec_w"
              :minimumLevel="1"
              :maximumLevel="18"
              :token="tiandituToken"
            />
          </vc-layer-imagery>
          <vc-layer-imagery>
            <vc-imagery-provider-tianditu
              map-style="cva_w"
              :minimumLevel="1"
              :maximumLevel="18"
              :token="tiandituToken"
            />
          </vc-layer-imagery>
        </vc-layer-imagery>

        <template v-if="viewerRef">
          <vc-entity
            v-for="device in devices"
            :key="device.id"
            :position="device.position"
            :billboard="billboardConfig"
            :label="getLabelConfig(device)"
          />
        </template>
      </vc-viewer>
    </main>

    <!-- 底部信息 -->
    <footer class="footer">
      <div class="footer-content">
        <div class="footer-section">
          <h3>关于我们</h3>
          <p>开源的物联网定位系统</p>
        </div>
        <div class="footer-section">
          <h3>联系方式</h3>
          <p>邮箱：17360402335@163.com</p>
          
        </div>
        <div class="footer-section">
          <h3>相关链接</h3>
          <a href="https://github.com/wangchangkui/gps_iot" target="_blank">
            <el-icon><svg-icon name="github" /></el-icon>
            GitHub
          </a>
        </div>
      </div>
      <div class="footer-bottom">
        <p>© 2025 ADMCC.cn . All rights reserved.</p>
        <p><a href="https://beian.miit.gov.cn/" target="_blank" class="beian">蜀ICP备20013378号</a></p>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import * as Cesium from 'cesium'

const router = useRouter()
const viewerRef = ref()
const tiandituToken = import.meta.env.VITE_TIANDITU_TOKEN

interface Device {
  id: string
  name: string
  position: {
    lng: number
    lat: number
    height: number
  }
}

// 模拟用户状态
const isLoggedIn = ref(false)
const userInfo = ref({
  avatar: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png'
})

const devices = ref<Device[]>([])

const billboardConfig = {
  image: '/marker.png',
  verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
  scale: 0.3,
  pixelOffset: new Cesium.Cartesian2(0, 0)
}

const getLabelConfig = (device: Device) => ({
  text: device.name,
  font: '14px sans-serif',
  fillColor: Cesium.Color.WHITE,
  outlineColor: Cesium.Color.BLACK,
  outlineWidth: 2,
  style: Cesium.LabelStyle.FILL_AND_OUTLINE,
  verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
  pixelOffset: new Cesium.Cartesian2(0, -30)
})

const onViewerReady = (readyObject: any) => {
  const { viewer } = readyObject
  const imageryLayers = viewer.imageryLayers
  imageryLayers.removeAll()
  
  viewer.scene.globe.enableLighting = true
  viewer.camera.setView({
    destination: Cesium.Cartesian3.fromDegrees(116.397428, 39.90923, 1000000)
  })
}

// 获取所有设备位置
const fetchDevices = async () => {
  // TODO: 从后端获取设备列表
  devices.value = [
    {
      id: '1',
      name: '设备1',
      position: {
        lng: 116.397428,
        lat: 39.90923,
        height: 0
      }
    }
  ]
}

// 路由跳转
const goToLogin = () => router.push('/login')
const goToRegister = () => router.push('/register')
const goToConsole = () => router.push('/manage/dashboard')
const handleLogout = () => {
  isLoggedIn.value = false
  // TODO: 实现登出逻辑
}

onMounted(() => {
  fetchDevices()
})
</script>

<style scoped lang="scss">
.home-container {
  padding-top: 60px; /* 为固定的头部腾出空间 */
}

.header {
  height: 60px;
  padding: 0 20px;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  
  .logo {
    display: flex;
    align-items: center;
    gap: 10px;
    
    img {
      height: 40px;
    }
    
    span {
      font-size: 20px;
      font-weight: bold;
    }
  }
  
  .nav-right {
    display: flex;
    gap: 10px;
    align-items: center;
  }
}

.main-content {
  /* 地图区域占据初始视口减去头部的高度 */
  height: calc(100vh - 60px);
  position: relative; /* 用于内部 Cesium 视图的绝对定位 */
  width: 100%;

  :deep(.vc-viewer) {
    position: absolute !important;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100% !important;
    height: 100% !important;
  }
}

.footer {
  /* 恢复为正常的文档流布局 */
  position: relative;
  background-color: #f5f5f5;
  padding: 40px 0;

  .footer-content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 40px;
  }

  .footer-section {
    h3 {
      font-size: 18px;
      margin-bottom: 20px;
    }

    p {
      margin: 10px 0;
      color: #666;
    }

    a {
      display: flex;
      align-items: center;
      gap: 8px;
      color: #666;
      text-decoration: none;
      margin: 10px 0;

      &:hover {
        color: #409EFF;
      }
    }
  }

  .footer-bottom {
    margin-top: 40px;
    padding-top: 20px;
    border-top: 1px solid #ddd;
    text-align: center;

    p {
      color: #999;
      font-size: 14px;
      margin: 5px 0;
    }

    .beian {
      color: #999;
      text-decoration: none;
      &:hover {
        color: #666;
      }
    }
  }
}
</style> 