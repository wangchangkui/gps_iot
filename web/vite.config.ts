import { fileURLToPath, URL } from 'node:url'
import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'
import vueJsx from '@vitejs/plugin-vue-jsx'
import { resolve } from 'path'

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '')

  return {
  plugins: [
    vue(),
    vueDevTools(),
      vueJsx(),
  ],
    css: {
      preprocessorOptions: {
        scss: {
          charset: false
        }
      }
    },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      'cesium': resolve(__dirname, 'node_modules/cesium')
    },
  },
    server: {
      host: '0.0.0.0',
      port: 5173,
      headers: {
        'Cross-Origin-Embedder-Policy': 'require-corp',
        'Cross-Origin-Opener-Policy': 'same-origin',
      }
    },
    build: {
      rollupOptions: {
        external: ['cesium'],
        output: {
          globals: {
            cesium: 'Cesium'
          }
        }
      }
    },
    define: {
      'process.env': env
    }
  }
})
