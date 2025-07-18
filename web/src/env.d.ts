/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_CESIUM_ACCESS_TOKEN: string
  readonly VITE_API_BASE_URL: string
  readonly VITE_TIANDITU_TOKEN: string
  readonly GADODE_API_KEY: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
} 