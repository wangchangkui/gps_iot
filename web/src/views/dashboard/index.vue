<template>
  <div class="dashboard-container">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card>
          <template #header>设备总数</template>
          <div class="card-value">128</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <template #header>在线设备</template>
          <div class="card-value">86</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <template #header>今日告警</template>
          <div class="card-value">5</div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <template #header>活跃用户</template>
          <div class="card-value">24</div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped lang="scss">
.dashboard-container {
  padding: 20px;
  
  .card-value {
    font-size: 24px;
    font-weight: bold;
    color: #409EFF;
    text-align: center;
  }
}
</style> 