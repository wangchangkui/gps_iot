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
          :navigation="true"
          :home-button="true"
          :fullscreen-button="false"
          :base-layer-picker="false"
          :geocoder="true"
          :scene-mode-picker="true"
          :navigation-help-button="false"
          :info-box="true"
          :selection-indicator="true"
          :show-credit="false"
          @ready="onViewerReady"
        >
        <!-- 地图图层 -->
               <!-- 取消天地图默认的 1w次请求的限制 -->
        <!-- <vc-layer-imagery>
          <vc-imagery-provider-tianditu
            :token="tiandituToken"
            :map-style="'cia_w'"
          />
        </vc-layer-imagery> -->
        
        <!-- 矢量底图图层 -->
        <vc-layer-imagery>
          <vc-imagery-provider-wmts
            :url="getVecWmtsUrl()"
            :layer="'vec'"
            wmts-style="default"
            tileMatrixSetID="w"
            :tileMatrixLabels="wmtsMatrixLabels"
          />
        </vc-layer-imagery>

        <!-- 矢量注记图层 -->
        <vc-layer-imagery>
          <vc-imagery-provider-wmts
            :url="getCvaWmtsUrl()"
            :layer="'cva'"
            wmts-style="default"
            tileMatrixSetID="w"
            :tileMatrixLabels="wmtsMatrixLabels"
          />
        </vc-layer-imagery>


                  <!-- 设备位置 -->
          <vc-entity
            v-for="device in devices"
            :key="device.id"
            :position="Cesium.Cartesian3.fromDegrees(device.position.lng, device.position.lat, device.position.height)"
          >
            <vc-graphics-billboard
              :image="'/marker.png'"
              :vertical-origin="Cesium.VerticalOrigin.BOTTOM"
              :scale="0.5"
            />
            <vc-graphics-label
              :text="device.name"
              :font="'14pt sans-serif'"
              :fill-color="Cesium.Color.WHITE"
              :outline-color="Cesium.Color.BLACK"
              :outline-width="2"
              :style="Cesium.LabelStyle.FILL_AND_OUTLINE"
              :pixel-offset="new Cesium.Cartesian2(0, -40)"
            />
          </vc-entity>
      </vc-viewer>

      <!-- 经纬度信息面板 -->
      <div class="coordinate-info">
        <div class="coordinate-item">
          <span class="label">经度:</span>
          <span class="value">{{ coordinates.lng }}</span>
        </div>
        <div class="coordinate-item">
          <span class="label">纬度:</span>
          <span class="value">{{ coordinates.lat }}</span>
        </div>
        <div class="coordinate-item">
          <span class="label">高度:</span>
          <span class="value">{{ coordinates.height }}m</span>
        </div>
      </div>
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
const tiandituToken = import.meta.env.VITE_TIANDITU_TOKEN || ''

// 用户状态
const isLoggedIn = ref(false)
const userInfo = ref({
  username: 'admin',
  avatar: ''
})

// 坐标信息
const coordinates = ref({
  lng: 104.397428,
  lat: 39.90923,
  height: '0'
})


const wmtsMatrixLabels = ref([
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18'
])

// 设备数据
const devices = ref([
  {
    id: '1',
    name: '鸡腿',
    position: {
      lng: 104.397428,
      lat: 39.90923,
      height: 0
    }
  },
  {
    id: '2',
    name: '设备2',
    position: {
      lng: 116.397428,
      lat: 39.90923,
      height: 0
    }
  }
])


const getCvaWmtsUrl = () => {
  // 构建url
  let baseUrl = "https://tianditu-cva-w.admcc.cn/cva_w/wmts?tk="+tiandituToken
  return baseUrl
}


const getVecWmtsUrl = () => {
  // 构建url
  let baseUrl = "https://tianditu-vec-w.admcc.cn/vec_w/wmts?tk="+tiandituToken
  return baseUrl
}

const onViewerReady = (cesiumInstance: any) => {
  const { Cesium, viewer } = cesiumInstance
  
  // 设置相机初始位置
  viewer.camera.setView({
    destination: Cesium.Cartesian3.fromDegrees(104.397428, 39.90923, 1000000)
  })

  // 监听鼠标移动更新坐标信息
  viewer.screenSpaceEventHandler.setInputAction((event: any) => {
    const pickedPosition = viewer.camera.pickEllipsoid(event.endPosition, viewer.scene.globe.ellipsoid)
    if (pickedPosition) {
      const cartographic = Cesium.Cartographic.fromCartesian(pickedPosition)
      coordinates.value = {
        lng: (Cesium.Math.toDegrees(cartographic.longitude)).toFixed(6),
        lat: (Cesium.Math.toDegrees(cartographic.latitude)).toFixed(6),
        height: Math.round(cartographic.height).toString()
      }
    }
  }, Cesium.ScreenSpaceEventType.MOUSE_MOVE)
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
  // TODO: 从后端获取设备列表
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

  // 经纬度信息面板
  .coordinate-info {
    position: absolute;
    bottom: 80px;
    right: 20px;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 10px 15px;
    border-radius: 5px;
    font-size: 12px;
    z-index: 1000;

    .coordinate-item {
      display: flex;
      justify-content: space-between;
      margin: 2px 0;
      min-width: 150px;

      .label {
        margin-right: 10px;
        color: #ccc;
      }

      .value {
        font-weight: bold;
        color: #fff;
      }
    }
  }
}
</style> 