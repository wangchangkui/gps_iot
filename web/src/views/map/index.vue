<template>
  <div class="map-container">
    <div class="control-panel">
      <el-card>
        <template #header>
          <div class="card-header">
            <span>设备列表</span>
            <el-button type="primary" size="small" @click="refreshDevices">
              刷新
            </el-button>
          </div>
        </template>
        <el-table :data="devices" style="width: 100%" height="calc(100vh - 300px)">
          <el-table-column prop="name" label="设备名称" />
          <el-table-column prop="status" label="状态">
            <template #default="{ row }">
              <el-tag :type="row.status === 'online' ? 'success' : 'danger'">
                {{ row.status === 'online' ? '在线' : '离线' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="120">
            <template #default="{ row }">
              <el-button type="primary" link @click="locateDevice(row)">
                定位
              </el-button>
              <el-button type="primary" link @click="showTrackDialog(row)">
                航线
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    <div class="map-view">
      <vc-viewer ref="viewerRef" 
        :animation="false" 
        :timeline="false" 
        :navigation="false" 
        :base-layer-picker="false"
        :creditsDisplay="false" 
        :showCredit="false" 
        :selectionIndicator="false"
        :infoBox="false"
        :scene3DOnly="true"
        :fullscreenButton="false"
        :requestRenderMode="true"
        :contextOptions="{
          webgl: {
            preserveDrawingBuffer: true
          }
        }"
        @ready="onViewerReady">
        <vc-layer-imagery>
          <vc-layer-imagery>
            <vc-layer-imagery>
              <vc-imagery-provider-tianditu map-style="vec_w" :minimumLevel="1" :maximumLevel="18"
                :token="tiandituToken" />
            </vc-layer-imagery>

            <vc-layer-imagery>
              <vc-imagery-provider-tianditu map-style="cva_w" :minimumLevel="1" :maximumLevel="18"
                :token="tiandituToken" />
            </vc-layer-imagery>
          </vc-layer-imagery>
        </vc-layer-imagery>

        <template v-if="viewerRef">
          <vc-entity v-for="device in activeDevices" :key="device.id" :position="device.position"
            :billboard="device.id === selectedDevice?.id ? locationBillboardConfig : billboardConfig"
            :label="getLabelConfig(device)" />
          <vc-entity-path v-if="selectedDevice?.track" :positions="selectedDevice.track" :material="pathMaterial"
            :width="3" />
        </template>
      </vc-viewer>
    </div>
  </div>

  <el-dialog v-model="trackDialogVisible" title="选择时间范围" width="500px">
    <el-date-picker
      v-model="trackTimeRange"
      type="datetimerange"
      range-separator="至"
      start-placeholder="开始时间"
      end-placeholder="结束时间"
      format="YYYY-MM-DD HH:mm:ss"
      value-format="YYYY-MM-DD HH:mm:ss"
    />
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="trackDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="loadTrackData">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import * as Cesium from 'cesium'

const tiandituToken = import.meta.env.VITE_TIANDITU_TOKEN

interface Device {
  id: string
  name: string
  status: 'online' | 'offline'
  position: {
    lng: number
    lat: number
    height: number
  }
  track?: Cesium.Cartesian3[]
}

const viewerRef = ref()
const devices = ref<Device[]>([])
const activeDevices = ref<Device[]>([])
const selectedDevice = ref<Device | null>(null)
const trackDialogVisible = ref(false)
const trackTimeRange = ref<[Date, Date]>([new Date(), new Date()])

const billboardConfig = {
  image: '/marker.png',
  verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
  scale: 0.3,
  pixelOffset: new Cesium.Cartesian2(0, 0)
}


const locationBillboardConfig = {
  image: '/location.png',
  verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
  scale: 0.4,
  pixelOffset: new Cesium.Cartesian2(0, -10)
}

const pathMaterial = new Cesium.ColorMaterialProperty(
  Cesium.Color.DODGERBLUE.withAlpha(0.7)
)

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
  
  // 设置相机参数
  viewer.scene.screenSpaceCameraController.minimumZoomDistance = 50  // 最小缩放距离（米）
  viewer.scene.screenSpaceCameraController.maximumZoomDistance = 20000000  // 最大缩放距离（米）
  viewer.scene.screenSpaceCameraController.enableTilt = false  // 禁用倾斜
  
  // 禁用默认的双击事件
  viewer.cesiumWidget.screenSpaceEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_DOUBLE_CLICK)
  
  // 设置默认视角
  viewer.camera.setView({
    destination: Cesium.Cartesian3.fromDegrees(116.397428, 39.90923, 8000000),
    orientation: {
      heading: 0,
      pitch: -Cesium.Math.PI_OVER_TWO,
      roll: 0
    }
  })
}

const refreshDevices = async () => {
  // TODO: 从后端获取设备列表
  devices.value = [
    {
      id: '1',
      name: '设备1',
      status: 'online',
      position: {
        lng: 116.397428,
        lat: 39.90923,
        height: 0
      }
    }
  ]
  activeDevices.value = devices.value.filter(d => d.status === 'online')
}

const locateDevice = (device: Device) => {
  const viewer = viewerRef.value?.cesiumObject
  if (viewer) {
    // 计算15级缩放对应的高度（米）
    const height = 40075017 * Math.cos(device.position.lat * Math.PI / 180) / Math.pow(2, 15)
    
    viewer.camera.flyTo({
      destination: Cesium.Cartesian3.fromDegrees(
        device.position.lng,
        device.position.lat,
        height
      ),
      duration: 1,
      complete: () => {
        // 确保视角正对下方
        viewer.camera.setView({
          destination: Cesium.Cartesian3.fromDegrees(
            device.position.lng,
            device.position.lat,
            height
          ),
          orientation: {
            heading: 0,
            pitch: -Cesium.Math.PI_OVER_TWO,
            roll: 0
          }
        })
      }
    })
  }
}

const showTrackDialog = (device: Device) => {
  selectedDevice.value = device
  trackDialogVisible.value = true
}

const loadTrackData = async () => {
  if (!selectedDevice.value) return
  
  // TODO: 根据时间范围从后端获取轨迹数据
  const [startTime, endTime] = trackTimeRange.value
  console.log('加载轨迹数据:', {
    deviceId: selectedDevice.value.id,
    startTime,
    endTime
  })
  
  // 模拟轨迹数据
  selectedDevice.value = {
    ...selectedDevice.value,
    track: [
      Cesium.Cartesian3.fromDegrees(116.397428, 39.90923, 0),
      Cesium.Cartesian3.fromDegrees(116.397428, 39.91923, 0),
      Cesium.Cartesian3.fromDegrees(116.398428, 39.91923, 0)
    ]
  }
  
  trackDialogVisible.value = false
}

onMounted(() => {
  refreshDevices()
})
</script>

<style scoped lang="scss">
.map-container {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  gap: 20px;
  padding: 20px;
  box-sizing: border-box;
  overflow: hidden;

  .control-panel {
    width: 300px;
    height: 100%;
    z-index: 2;

    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    :deep(.el-card) {
      height: 100%;
      display: flex;
      flex-direction: column;

      .el-card__body {
        flex: 1;
        overflow: hidden;
      }
    }
  }

  .map-view {
    flex: 1;
    position: relative;
    border-radius: 4px;
    overflow: hidden;
    background-color: #000;
    box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);

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
}
</style>