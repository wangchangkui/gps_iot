<template>
  <div class="analysis-container">
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card>
          <template #header>设备在线率统计</template>
          <div ref="onlineChart" style="height: 300px"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>设备活跃度分析</template>
          <div ref="activityChart" style="height: 300px"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import * as echarts from 'echarts'

const onlineChart = ref<HTMLElement>()
const activityChart = ref<HTMLElement>()

onMounted(() => {
  if (onlineChart.value) {
    const chart = echarts.init(onlineChart.value)
    chart.setOption({
      title: { text: '近7天在线率' },
      tooltip: {},
      xAxis: { data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'] },
      yAxis: {},
      series: [{
        name: '在线率',
        type: 'line',
        data: [85, 88, 92, 87, 90, 89, 91]
      }]
    })
  }

  if (activityChart.value) {
    const chart = echarts.init(activityChart.value)
    chart.setOption({
      title: { text: '设备活跃度' },
      tooltip: {},
      series: [{
        name: '活跃度',
        type: 'pie',
        data: [
          { value: 60, name: '高活跃' },
          { value: 30, name: '中活跃' },
          { value: 10, name: '低活跃' }
        ]
      }]
    })
  }
})
</script>

<style scoped lang="scss">
.analysis-container {
  padding: 20px;
}
</style> 