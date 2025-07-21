<!--
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-17 21:58:18
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-21 09:58:14
 * @FilePath: \web\src\App.vue
 * @Description: 
-->
<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <router-view></router-view>
</template>

<style>
html, body {
  margin: 0;
  padding: 0;
  height: 100%;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
}

#app {
  height: 100vh;
}
</style>
