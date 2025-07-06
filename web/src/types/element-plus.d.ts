declare module 'element-plus' {
  const content: any
  export default content
  export interface FormInstance {
    validate: (callback: (valid: boolean, fields?: any) => void) => Promise<void>
  }
  export interface FormRules {
    [key: string]: any[]
  }
}

declare module '@element-plus/icons-vue' {
  const content: any
  export default content
  export const Search: any
  export const User: any
  export const Lock: any
  export const Monitor: any
  export const Location: any
  export const SetUp: any
  export const DataLine: any
  export const Odometer: any
  export const Fold: any
  export const Expand: any
  export const ArrowDown: any
} 