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
              <el-button
                type="primary"
                link
                @click="showTrack(row)"
              >
                查看轨迹
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    <div class="map-view">
      <vc-viewer
        ref="viewerRef"
        :animation="false"
        :timeline="false"
        :navigation="false"
        @ready="onViewerReady"
      >
        <vc-entity
          v-for="device in activeDevices"
          :key="device.id"
          :position="device.position"
          :billboard="billboardConfig"
          :label="getLabelConfig(device)"
        />
        <vc-entity-path
          v-if="selectedDevice"
          :positions="selectedDevice.track"
          :material="pathMaterial"
          :width="3"
        />
      </vc-viewer>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import type { Viewer } from 'cesium'
import * as Cesium from 'cesium'

interface Device {
  id: string
  name: string
  status: 'online' | 'offline'
  position: Cesium.Cartesian3
  track?: Cesium.Cartesian3[]
}

const viewerRef = ref<typeof Viewer>()
const devices = ref<Device[]>([])
const activeDevices = ref<Device[]>([])
const selectedDevice = ref<Device | null>(null)

const billboardConfig = {
  image: '/marker.png',
  verticalOrigin: Cesium.VerticalOrigin.BOTTOM,
  scale: 0.5
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

const onViewerReady = (viewer: Viewer) => {
  // 初始化地图视图
  viewer.camera.flyTo({
    destination: Cesium.Cartesian3.fromDegrees(116.397428, 39.90923, 1000000)
  })
}

const refreshDevices = async () => {
  // TODO: 从后端获取设备列表
  devices.value = [
    {
      id: '1',
      name: '设备1',
      status: 'online',
      position: Cesium.Cartesian3.fromDegrees(116.397428, 39.90923, 0)
    },
    {
      id: '2',
      name: '设备2',
      status: 'offline',
      position: Cesium.Cartesian3.fromDegrees(116.397428, 39.90923, 0)
    }
  ]
  activeDevices.value = devices.value.filter(d => d.status === 'online')
}

const showTrack = async (device: Device) => {
  // TODO: 从后端获取设备轨迹
  selectedDevice.value = {
    ...device,
    track: [
      Cesium.Cartesian3.fromDegrees(116.397428, 39.90923, 0),
      Cesium.Cartesian3.fromDegrees(116.397428, 39.91923, 0),
      Cesium.Cartesian3.fromDegrees(116.398428, 39.91923, 0)
    ]
  }
  
  if (viewerRef.value) {
    viewerRef.value.camera.flyTo({
      destination: Cesium.Cartesian3.fromDegrees(
        116.397428,
        39.90923,
        10000
      )
    })
  }
}

onMounted(() => {
  refreshDevices()
})
</script>

<style scoped lang="scss">
.map-container {
  height: 100%;
  display: flex;
  gap: 20px;
  
  .control-panel {
    width: 300px;
    
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
  }
  
  .map-view {
    flex: 1;
    position: relative;
    border-radius: 4px;
    overflow: hidden;
  }
}
</style> 