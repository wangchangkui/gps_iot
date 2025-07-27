<template>
  <div class="home-container">
    <!-- 顶部导航栏 -->
    <header class="header">
      <div class="logo">
        <img src="/marker.png" alt="logo" />
        <span>Admcc</span>

        <span style="font-size: 12px;color: #999;margin-left: 10px;">当前在线设备：{{ devices.length }}</span>
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
      <vc-viewer ref="viewerRef" :animation="false" :timeline="false" :navigation="true" :home-button="true"
        :fullscreen-button="false" :base-layer-picker="false" :geocoder="true" :scene-mode-picker="true"
        :navigation-help-button="false" :info-box="false" :selection-indicator="false" :show-credit="false"
        :scene3d-only="false" :should-animate="false" @ready="onViewerReady">
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
          <vc-imagery-provider-wmts :url="getVecWmtsUrl()" :layer="'vec'" wmts-style="default" tileMatrixSetID="w"
            :tileMatrixLabels="wmtsMatrixLabels" />
        </vc-layer-imagery>

        <!-- 矢量注记图层 -->
        <vc-layer-imagery>
          <vc-imagery-provider-wmts :url="getCvaWmtsUrl()" :layer="'cva'" wmts-style="default" tileMatrixSetID="w"
            :tileMatrixLabels="wmtsMatrixLabels" />
        </vc-layer-imagery>


        <!-- 设备位置 暂时关闭掉用户的标签 -->
        <vc-entity v-for="device in devices" :key="device.id"
          :position="Cesium.Cartesian3.fromDegrees(device.position.lng, device.position.lat, device.position.height)"
          @click="handleEntityClick(device, false)">
          <vc-graphics-billboard :image="'/marker.png'" :vertical-origin="Cesium.VerticalOrigin.BOTTOM" :scale="0.3" />
          <vc-graphics-label 
          :text="device.name" 
          :font="'14pt sans-serif'" 
          :fill-color="Cesium.Color.LIME"
          :outline-color="Cesium.Color.BLACK" 
          :outline-width="3" 
          :style="Cesium.LabelStyle.FILL_AND_OUTLINE"
          :pixel-offset="new Cesium.Cartesian2(0, -70)" 
          :show="false" :show-background="false"
          :background-color="Cesium.Color.BLACK" 
          :background-padding="new Cesium.Cartesian2(8, 4)" />
        </vc-entity>

        <!-- 用户GPS位置 暂时关闭掉用户的标签 -->
        <vc-entity v-if="userLocation.isVisible" :key="userLocation.id"
          :position="Cesium.Cartesian3.fromDegrees(userLocation.position.lng, userLocation.position.lat, userLocation.position.height)"
          @click="handleEntityClick(userLocation, true)">
          <vc-graphics-billboard :image="'/boy.png'" :vertical-origin="Cesium.VerticalOrigin.BOTTOM" :scale="0.2" />
          <vc-graphics-label 
          :text="userLocation.name" :font="'15pt sans-serif'" 
          :fill-color="Cesium.Color.LIME"
          :outline-color="Cesium.Color.BLACK" 
          :outline-width="3" 
          :style="Cesium.LabelStyle.FILL_AND_OUTLINE"
          :pixel-offset="new Cesium.Cartesian2(0, -80)" 
          :show="false" :show-background="false"
          :background-color="Cesium.Color.BLACK" 
          :background-padding="new Cesium.Cartesian2(8, 4)" />
        </vc-entity>
      </vc-viewer>

      <!-- 经纬度信息面板 -->
      <div class="coordinate-info" style="position: absolute;top: 20px;left: 20px;">
        <div class="coordinate-item">
          <span class="label">经度:</span>
          <span class="value">{{ coordinates.lng }}</span>
          &nbsp;&nbsp;
          <span class="label">纬度:</span>
          <span class="value">{{ coordinates.lat }}</span>
        </div>
      </div>

      <!-- 弹出信息面板 -->
      <div v-if="popupInfo.visible" class="popup-overlay" @click="closePopup"
        style="position:absolute;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:2000;">
        <div class="popup-content" @click.stop :style="{
          position: 'absolute',
          left: popupInfo.position.x + 'px',
          top: popupInfo.position.y - 280 + 'px',
          transform: 'translate(-50%, 0)',
          zIndex: 3001,
          pointerEvents: 'auto',
          minWidth: '300px',
          maxWidth: '400px'
        }">
          <el-card class="box-card">
            <template #header>
              <span>{{ popupInfo.data.name }}</span>
              <el-button size="small" style="float: right; padding: 3px 0" type="primary"
                @click="closePopup">关闭</el-button>
            </template>
            <div class="popup-body">
              <div class="coordinate-display">
                <div class="coord-item">
                  <span class="label">经度:</span>
                  <span class="value">{{ popupInfo.data.lng.toFixed(6) }}</span>
                </div>
                <div class="coord-item">
                  <span class="label">纬度:</span>
                  <span class="value">{{ popupInfo.data.lat.toFixed(6) }}</span>
                </div>
                <div class="coord-item">
                  <span class="label">位置信息:</span>
                  <span class="value">四川省成都市双流区</span>
                </div>
              </div>
              <div class="popup-actions">
                <el-button type="primary" size="small"
                  @click="navigateToLocation(popupInfo.data.lng, popupInfo.data.lat)"
                  :disabled="popupInfo.data.isUserLocation" :icon="'Location'">
                  {{ popupInfo.data.isUserLocation ? '无法导航到自己的位置' : '导航到此位置' }}
                </el-button>
              </div>
            </div>
          </el-card>
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
            <el-icon></el-icon>
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
import { get_direction } from '../../utils/api/gd/gd_api'
import type { Tmcs } from '../../utils/api/gd/gd_tmcs'

import ElMessage from 'element-plus/es/components/message/index'
const Cesium = (window as any).Cesium
defineExpose({ Cesium })

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

// 用户GPS位置
const userLocation = ref({
  id: 'user',
  name: '我的位置',
  position: {
    lng: 0,
    lat: 0,
    height: 0
  },
  isVisible: false
})

// 弹出面板状态
const popupInfo = ref({
  visible: false,
  position: { x: 0, y: 0 },
  data: {
    id: '',
    name: '',
    lng: 0,
    lat: 0,
    isUserLocation: false
  }
})

// 设备数据
const devices = ref([
  {
    id: '1',
    name: '鸡腿',
    position: {
      lng: 104.063641,
      lat: 30.467283,
      height: 0
    }
  }
])


const getCvaWmtsUrl = () => {
  // 构建url
  let baseUrl = "https://tianditu-cva-w.admcc.cn/cva_w/wmts?tk=" + tiandituToken
  return baseUrl
}


const getVecWmtsUrl = () => {
  // 构建url
  let baseUrl = "https://tianditu-vec-w.admcc.cn/vec_w/wmts?tk=" + tiandituToken
  return baseUrl
}

const onViewerReady = (cesiumInstance: any) => {
  const { Cesium, viewer } = cesiumInstance


  // 设置相机初始位置
  viewer.camera.setView({
    destination: Cesium.Cartesian3.fromDegrees(104.108377, 30.467283, 1000000),
    orientation: {
      heading: 0.0,
      pitch: -Cesium.Math.PI_OVER_TWO,
      roll: 0.0
    }
  })

  // 设置相机缩放限制
  viewer.scene.screenSpaceCameraController.enableCollisionDetection = false
  viewer.scene.screenSpaceCameraController.minimumZoomDistance = 100 // 最小缩放距离（米）
  viewer.scene.screenSpaceCameraController.maximumZoomDistance = 20000000 // 最大缩放距离（米）

  // 禁用双击缩放功能，防止与图标双击冲突
  viewer.scene.screenSpaceCameraController.enableLook = true
  viewer.scene.screenSpaceCameraController.enableRotate = true
  viewer.scene.screenSpaceCameraController.enableTranslate = true
  viewer.scene.screenSpaceCameraController.enableZoom = true
  viewer.scene.screenSpaceCameraController.enableTilt = true

  // 禁用双击缩放
  viewer.scene.screenSpaceCameraController.enableDoubleClickZoom = false

  // 确保标签和图标能够正确显示
  viewer.scene.globe.enableLighting = false
  viewer.scene.fog.enabled = false
  viewer.scene.skyAtmosphere.show = false

  // 监听相机移动事件，限制缩放层级
  viewer.camera.moveEnd.addEventListener(() => {
    const height = viewer.camera.positionCartographic.height
    const minHeight = 100 // 对应19层级的最小高度
    const maxHeight = 20000000 // 对应18层级的最大高度

    if (height < minHeight) {
      viewer.camera.setView({
        destination: Cesium.Cartesian3.fromDegrees(
          viewer.camera.positionCartographic.longitude,
          viewer.camera.positionCartographic.latitude,
          minHeight
        )
      })
    } else if (height > maxHeight) {
      viewer.camera.setView({
        destination: Cesium.Cartesian3.fromDegrees(
          viewer.camera.positionCartographic.longitude,
          viewer.camera.positionCartographic.latitude,
          maxHeight
        )
      })
    }
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

  // 默认获取当前用户的位置
  getUserLocation()
}

// 处理实体点击事件
const handleEntityClick = (entity: any, isUserLocation: boolean) => {
  // 获取点击位置
  const position = entity.position || entity
  const lng = position.lng || position.longitude
  const lat = position.lat || position.latitude
  // 飞行到用户位置
  if (viewerRef.value?.cesiumObject) {
    viewerRef.value.cesiumObject.camera.flyTo({
      destination: Cesium.Cartesian3.fromDegrees(lng, lat, 10000)
    })
  }


  // 获取viewer对象
  const viewer = viewerRef.value?.cesiumObject
  let screenPosition = { x: 0, y: 0 }
  if (viewer) {
    const cartesian = Cesium.Cartesian3.fromDegrees(lng, lat, position.height || 0)


    // 计算屏幕像素坐标 2D模式下无法获得真实坐标（相对于canvas左上角）
    const windowPos = Cesium.SceneTransforms.worldToWindowCoordinates(viewer.scene, cartesian)


    if (windowPos) {
      // 需要减去canvas在页面中的偏移量，使其相对于.main-content
      const canvas = viewer.scene.canvas
      const rect = canvas.getBoundingClientRect()
      // main-content 也可能有边距，需获取其rect
      const mainContent = document.querySelector('.main-content') as HTMLElement
      const mainRect = mainContent ? mainContent.getBoundingClientRect() : { left: 0, top: 0 }
      screenPosition = {
        x: windowPos.x + rect.left - mainRect.left,
        y: windowPos.y + rect.top - mainRect.top
      }



    }
  }
  // 设置弹出面板数据
  popupInfo.value = {
    visible: true,
    position: screenPosition, // 屏幕像素坐标
    data: {
      id: entity.id,
      name: entity.name,
      lng: lng,
      lat: lat,
      isUserLocation: isUserLocation
    }
  }
}

// 关闭弹出面板
const closePopup = () => {
  popupInfo.value.visible = false
}


// 路况实体集合
const trafficEntities = ref<Array<any>>([])

// 上次路由请求的缓存
const lastRouteRequest = ref<{start_point: string, end_point: string, startPoint: {lng: number, lat: number}, endPoint: {lng: number, lat: number}} | null>(null)

// 解析polyline字符串为Cesium坐标数组
const parsePolyline = (polyline: string): any[] => {
  const points = polyline.split(';')
  const positions: any[] = []
  
  points.forEach(point => {
    const [lng, lat] = point.split(',').map(Number)
    if (!isNaN(lng) && !isNaN(lat)) {
      positions.push(Cesium.Cartesian3.fromDegrees(lng, lat, 10)) // 高度从5米改为10米，增加可见性
    }
  })
  
  return positions
}

// 清除先前的路况线
const clearTrafficEntities = () => {
  if (viewerRef.value?.cesiumObject) {
    const viewer = viewerRef.value.cesiumObject
    trafficEntities.value.forEach(entity => {
      viewer.entities.remove(entity)
    })
    trafficEntities.value = []
  }
}

// 绘制交通路况
const drawTrafficConditions = (tmcsData: Tmcs[], startPoint: { lng: number, lat: number }, endPoint: { lng: number, lat: number }) => {
  if (!viewerRef.value?.cesiumObject) return
  
  // 清除旧的路况线
  clearTrafficEntities()
  
  const viewer = viewerRef.value.cesiumObject

  // 收集所有路段点，不再按状态分组
  const allPositions: any[] = []
  
  // 按顺序收集所有路段点
  tmcsData.forEach((tmc) => {
    try {
      // 解析当前路段的坐标
      const segmentPositions = parsePolyline(tmc.tmcPolyline)
      if (segmentPositions.length >= 2) {
        // 如果不是第一段，则去掉重复点
        if (allPositions.length > 0) {
          // 添加除第一个点外的所有点（避免重复）
          allPositions.push(...segmentPositions.slice(1))
        } else {
          // 第一段直接添加所有点
          allPositions.push(...segmentPositions)
        }
      }
    } catch (error) {
      console.error('解析路段失败:', error)
    }
  })
  
  // 如果有足够的点，创建单一连续路线
  if (allPositions.length >= 2) {
    
    // 创建单一连续路线，使用统一颜色和更明显的样式
    const routeEntity = viewer.entities.add({
      name: '路线',
      polyline: {
        positions: allPositions,
        width: 15, // 增加线宽，提高可见性
        material: new Cesium.PolylineGlowMaterialProperty({
          glowPower: 0.25,
          color: new Cesium.Color(0.0, 0.5, 1.0, 1.0) // 更亮的蓝色
        }),
        clampToGround: false, // 不贴地，确保在任何地形上都可见
        arcType: Cesium.ArcType.GEODESIC, // 使用大圆弧线，更平滑
        granularity: Math.PI / 1800, // 增加分辨率
        zIndex: 100 // 确保线条在最上层
      }
    })
    
    
    trafficEntities.value.push(routeEntity)
    
    // 添加额外的实线，确保可见性
    const solidLineEntity = viewer.entities.add({
      name: '实线路线',
      polyline: {
        positions: allPositions,
        width: 8, // 实线稍窄
        material: new Cesium.ColorMaterialProperty(
          new Cesium.Color(0.0, 0.3, 1.0, 1.0)
        ),
        clampToGround: false,
        arcType: Cesium.ArcType.GEODESIC,
        granularity: Math.PI / 1800,
        zIndex: 99
      }
    })
    
    trafficEntities.value.push(solidLineEntity)
  } else {
    console.warn('没有足够的点来创建路线');
  }
  


  
  // 如果有路况线，则调整视角以查看整个路况，平滑过渡
  if (trafficEntities.value.length > 0) {
    // 提供更多调试信息
    console.log('正在调整视角, 实体数量:', trafficEntities.value.length);
    
    // 确保视角完全包含所有实体
    viewer.flyTo(trafficEntities.value, {
      duration: 2.0,
      offset: new Cesium.HeadingPitchRange(0, Cesium.Math.toRadians(-60), 0), // 更倾斜的视角
      maximumHeight: 5000 // 限制最大高度
    });
    
    // 添加一个延迟后的备用缩放，以防第一次没有正确定位
    setTimeout(() => {
      viewer.zoomTo(trafficEntities.value, new Cesium.HeadingPitchRange(0, Cesium.Math.toRadians(-60), 0));
    }, 3000);
  }
}

// 将Tmcs数据转换为GeoJSON格式
const convertToGeoJSON = (tmcsData: Tmcs[]) => {
  // 创建GeoJSON对象
  const geoJSON = {
    type: "FeatureCollection",
    features: [] as any[]
  };

  // 处理每个路段
  tmcsData.forEach((tmc, index) => {
    try {
      const coordinates: number[][] = [];
      
      // 解析路段坐标点
      const points = tmc.tmcPolyline.split(';');
      points.forEach(point => {
        const [lng, lat] = point.split(',').map(Number);
        if (!isNaN(lng) && !isNaN(lat)) {
          coordinates.push([lng, lat]);
        }
      });
      
      if (coordinates.length >= 2) {
        // 创建GeoJSON LineString特征
        const feature = {
          type: "Feature",
          properties: {
            id: index,
            status: tmc.tmcStatus,
            distance: tmc.tmcDistance
          },
          geometry: {
            type: "LineString",
            coordinates: coordinates
          }
        };
        
        geoJSON.features.push(feature);
      }
    } catch (error) {
      console.error('解析路段失败:', error);
    }
  });
  
  return geoJSON;
};

// 请求路径规划数据
const requestRouteData = (start_point: string, end_point: string) => {
  console.log('请求路径规划:', { start_point, end_point })
  
  // 解析起点终点坐标
  const [startLng, startLat] = start_point.split(',').map(Number)
  const [endLng, endLat] = end_point.split(',').map(Number)
  
  // 保存本次请求
  lastRouteRequest.value = {
    start_point,
    end_point,
    startPoint: { lng: startLng, lat: startLat },
    endPoint: { lng: endLng, lat: endLat }
  }
  
  // 调用高德地图api接口获取地址
  get_direction(start_point, end_point).then((res) => {
    if (res && res.data) {
      // 转换为GeoJSON格式并打印
      const geoJSON = convertToGeoJSON(res.data);
      console.log('路线GeoJSON数据:', JSON.stringify(geoJSON, null, 2));
      
      // 原始tmcPolyline数据
      console.log('原始路段数据:');
      res.data.forEach((tmc, index) => {
        console.log(`路段${index + 1} - 状态: ${tmc.tmcStatus}, 距离: ${tmc.tmcDistance}`);
        console.log(`路段${index + 1} - 坐标: ${tmc.tmcPolyline}`);
      });
      
      // 继续绘制路线
      drawTrafficConditions(res.data, { lng: startLng, lat: startLat }, { lng: endLng, lat: endLat })
    } else {
      ElMessage.warning('获取的路径规划数据为空')
    }
  }).catch((err) => {
    console.error('路径规划错误详情:', err)
    if (err && err.code !== undefined) {
      ElMessage.error(`获取路径规划失败: ${err.message || '未知错误'}`)
    } else {
      ElMessage.error('获取路径规划失败: 网络或服务器错误')
    }
  })
}

// 导航到指定位置
const navigateToLocation = (lng: number, lat: number) => {
  // 获取当前用户的位置
  const position = userLocation.value.position
  // 保留6位小数
  const user_lng = position.lng.toFixed(6)
  const user_lat = position.lat.toFixed(6)

  const start_point = user_lng + ',' + user_lat
  const end_point = lng + ',' + lat
  
  
  
  requestRouteData(start_point, end_point)

  // 关闭面板
  popupInfo.value.visible = false
}

// 获取用户GPS位置
const getUserLocation = () => {
  if (!navigator.geolocation) {
    ElMessage.error('您的浏览器不支持地理定位功能')
    return
  }

  ElMessage.info('正在获取您的位置...')

  navigator.geolocation.getCurrentPosition(
    (position) => {
      const { longitude, latitude, altitude } = position.coords

      userLocation.value = {
        id: 'user',
        name: '我的位置',
        position: {
          lng: longitude,
          lat: latitude,
          height: altitude || 0
        },
        isVisible: true
      }

      ElMessage.success('位置获取成功！')
    },
    (error) => {
      console.error('获取位置失败:', error)
      switch (error.code) {
        case error.PERMISSION_DENIED:
          ElMessage.error('用户拒绝了位置请求')
          break
        case error.POSITION_UNAVAILABLE:
          ElMessage.error('位置信息不可用')
          break
        case error.TIMEOUT:
          ElMessage.error('获取位置超时')
          break
        default:
          ElMessage.error('获取位置时发生未知错误')
      }
    },
    {
      enableHighAccuracy: true,
      timeout: 20000,
      maximumAge: 60000
    }
  )
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
  padding-top: 40px;
  /* 为固定的头部腾出空间 */
  min-height: 100vh;

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
  /* 地图区域占据初始视口减去头部的高度，并留出边距 */
  height: calc(100vh - 120px);
  margin: 30px;
  position: relative;
  /* 用于内部 Cesium 视图的绝对定位 */
  width: calc(100% - 45px);
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);

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
    top: 20px;
    bottom: 100px;
    right: 30px;
    background: rgba(0, 0, 0, 0.85);
    color: white;
    padding: 12px 16px;
    border-radius: 12px;
    font-size: 13px;
    z-index: 1000;
    border: 2px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
    backdrop-filter: blur(15px);

    .coordinate-item {
      display: flex;
      justify-content: space-between;
      margin: 4px 0;
      min-width: 180px;

      .label {
        margin-right: 15px;
        color: #ddd;
        font-weight: 500;
      }

      .value {
        font-weight: bold;
        color: #fff;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.8);
      }
    }
  }

  // 弹出面板样式
  .popup-overlay {
    position: relative !important;
    top: 0 !important;
    left: 0 !important;
    right: 0 !important;
    bottom: 0 !important;
    background: rgba(0, 0, 0, 0.5) !important;
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    z-index: 2000 !important;
    backdrop-filter: blur(5px) !important;
  }

  .popup-content {
    background: white !important;
    border-radius: 12px !important;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3) !important;
    min-width: 300px !important;
    max-width: 400px !important;
    animation: popupSlideIn 0.3s ease-out !important;
  }

  .popup-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 20px 0 20px;
    border-bottom: 1px solid #eee;

    h3 {
      margin: 0;
      color: #333;
      font-size: 18px;
      font-weight: 600;
    }

    .close-btn {
      font-size: 20px;
      color: #999;
      padding: 0;
      width: 24px;
      height: 24px;
      border-radius: 50%;

      &:hover {
        background: #f5f5f5;
        color: #666;
      }
    }
  }

  .popup-body {
    padding: 20px;

    .coordinate-display {
      margin-bottom: 20px;

      .coord-item {
        display: flex;
        justify-content: space-between;
        margin: 8px 0;
        padding: 8px 12px;
        background: #f8f9fa;
        border-radius: 6px;

        .label {
          color: #666;
          font-weight: 500;
        }

        .value {
          color: #333;
          font-weight: 600;
          font-family: 'Courier New', monospace;
        }
      }
    }

    .popup-actions {
      text-align: center;

      .el-button {
        width: 100%;
        border-radius: 8px;
        font-weight: 500;
      }
    }
  }

  @keyframes popupSlideIn {
    from {
      opacity: 0;
      transform: translateY(-20px) scale(0.95);
    }

    to {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
  }
}

.status-unknown {
  background-color: #999;
  color: white;
  
  &.el-checkbox {
    --el-checkbox-checked-bg-color: #999;
    --el-checkbox-checked-input-border-color: #999;
  }
}

.status-smooth {
  background-color: #67C23A;
  color: white;
  
  &.el-checkbox {
    --el-checkbox-checked-bg-color: #67C23A;
    --el-checkbox-checked-input-border-color: #67C23A;
  }
}

.status-slow {
  background-color: #E6A23C;
  color: white;
  
  &.el-checkbox {
    --el-checkbox-checked-bg-color: #E6A23C;
    --el-checkbox-checked-input-border-color: #E6A23C;
  }
}

.status-congested {
  background-color: #F56C6C;
  color: white;
  
  &.el-checkbox {
    --el-checkbox-checked-bg-color: #F56C6C;
    --el-checkbox-checked-input-border-color: #F56C6C;
  }
}

.status-heavily-congested {
  background-color: #8B0000;
  color: white;
  
  &.el-checkbox {
    --el-checkbox-checked-bg-color: #8B0000;
    --el-checkbox-checked-input-border-color: #8B0000;
  }
}
</style>