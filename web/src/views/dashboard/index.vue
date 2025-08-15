<!--
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-06 11:32:58
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-15 17:41:50
 * @FilePath: \web\src\views\dashboard\index.vue
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
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
          <template #header>离线次数</template>
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