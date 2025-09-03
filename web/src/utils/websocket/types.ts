/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-08-27 21:36:33
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-09-03 20:57:01
 * @FilePath: \web\src\utils\websocket\types.ts
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
/**
 * WebSocket相关类型定义
 */

// WebSocket消息类型
export interface WebSocketMessage {
  type: string;
  data: any;
  timestamp: number;
  userId?: string;
}

// 菜单变更消息
export interface MenuChangeMessage extends WebSocketMessage {
  type: 'menu_change';
  data: {
    action: 'add' | 'update' | 'delete';
    menuData?: any;
    userId: string;
  };
}

// 系统通知消息
export interface SystemNotificationMessage extends WebSocketMessage {
  type: 'system_notification';
  data: {
    title: string;
    message: string;
    level: 'info' | 'warning' | 'error' | 'success';
  };
}

// 用户在线状态消息
export interface UserStatusMessage extends WebSocketMessage {
  type: 'user_status';
  data: {
    userId: string;
    status: 'online' | 'offline';
    timestamp: number;
  };
}

// 权限变更消息
export interface PermissionChangeMessage extends WebSocketMessage {
  type: 'permission_change';
  data: {
    userId: string;
    permissions: string[];
  };
}

// 消息回调函数类型
export type MessageCallback<T = any> = (message: T) => void;

// WebSocket配置
export interface WebSocketConfig {
  url?: string;
  reconnectAttempts?: number;
  reconnectInterval?: number;
  heartbeatInterval?: number;
  enableLogging?: boolean;
}
