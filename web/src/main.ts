/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-17 21:58:18
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-08-27 22:00:30
 * @FilePath: \web\src\main.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import VueCesium from 'vue-cesium'
import { webSocketManager } from './utils/websocket/WebSocketManager'

import App from './App.vue'
import router from './router'

const app = createApp(App)

// 注册Element Plus图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

app.use(createPinia())
app.use(router)
app.use(ElementPlus)
app.use(VueCesium, {
  cesiumPath: 'Cesuim/Cesium1.131/Cesium.js',
  accessToken: import.meta.env.VITE_CESIUM_ACCESS_TOKEN
})

// 初始化WebSocket连接
const initWebSocket = async () => {
  try {
    // 检查用户是否已登录
    const token =  localStorage.getItem('authentication');
    console.log(token)
    if (token) {
      await webSocketManager.initialize({
        enableLogging: import.meta.env.DEV,
        reconnectAttempts: 5,
        reconnectInterval: 3000
      });
      console.log('WebSocket初始化成功');
    }else{
      // 重新登录
 
      router.push('/login')
    }
  } catch (error) {
    console.error('WebSocket初始化失败:', error);
  }
};

// 监听路由变化，在用户登录后初始化WebSocket
router.afterEach((to) => {
  // 如果跳转到非登录页面且有token，则初始化WebSocket
  if (to.path !== '/login' && !webSocketManager.isConnected()) {
    initWebSocket();
  }
  
  // 如果跳转到登录页面，断开WebSocket连接
  if (to.path === '/login' && webSocketManager.isConnected()) {
    webSocketManager.disconnect();
  }
});

app.mount('#app')
