/**
 * WebSocket管理器
 * 统一管理WebSocket连接和消息分发
 */

import { webSocketService } from './WebSocketService';
import { stompService } from './StompService';
import type { 
  WebSocketMessage, 
  MenuChangeMessage, 
  SystemNotificationMessage,
  UserStatusMessage,
  PermissionChangeMessage,
  MessageCallback,
  WebSocketConfig
} from './types';

class WebSocketManager {
  private useStoredProtocol: boolean = false;
  private isInitialized: boolean = false;
  private config: WebSocketConfig = {};

  constructor() {
    // 检查是否使用STOMP协议
    this.useStoredProtocol = true;
  }

  /**
   * 初始化WebSocket连接
   */
  public async initialize(config: WebSocketConfig = {}): Promise<void> {
    this.config = {
      reconnectAttempts: 5,
      reconnectInterval: 3000,
      heartbeatInterval: 30000,
      enableLogging: true,
      ...config
    };

    try {
      // 获取用户token
      const token = this.getAuthToken();
      console.log(token)
      if (this.useStoredProtocol) {
        // 使用STOMP协议
        await stompService.connect({
          'Authorization': `Bearer ${token}`,
          'X-Requested-With': 'WebSocket'
        });
        this.setupStompSubscriptions();
      } else {
        // 使用原生WebSocket
        await webSocketService.connect(token);
        this.setupWebSocketSubscriptions();
      }

      this.isInitialized = true;
      console.log('WebSocket连接初始化成功');
      
    } catch (error) {
      console.error('WebSocket连接初始化失败:', error);
      throw error;
    }
  }

  /**
   * 断开WebSocket连接
   */
  public disconnect(): void {
    if (this.useStoredProtocol) {
      stompService.disconnect();
    } else {
      webSocketService.disconnect();
    }
    this.isInitialized = false;
  }

  /**
   * 设置原生WebSocket订阅
   */
  private setupWebSocketSubscriptions(): void {
    // 订阅菜单变更消息
    webSocketService.subscribe('menu_change', (message: WebSocketMessage) => {
      this.handleMenuChange(message as MenuChangeMessage);
    });
    
    // 订阅系统通知消息
    webSocketService.subscribe('system_notification', (message: WebSocketMessage) => {
      this.handleSystemNotification(message as SystemNotificationMessage);
    });
    
    // 订阅用户状态变更消息
    webSocketService.subscribe('user_status', (message: WebSocketMessage) => {
      this.handleUserStatus(message as UserStatusMessage);
    });
    
    // 订阅权限变更消息
    webSocketService.subscribe('permission_change', (message: WebSocketMessage) => {
      this.handlePermissionChange(message as PermissionChangeMessage);
    });
  }

  /**
   * 设置STOMP订阅
   */
  private setupStompSubscriptions(): void {
    
    // 订阅个人消息队列
    stompService.subscribe(`/topic/messages`, (message) => {
      this.handleStompMessage(message);
    });
    
    // 订阅广播消息
    stompService.subscribe('/topic/system-notifications', (message) => {
      this.handleStompMessage(message);
    });
    
    // 订阅菜单变更广播
    stompService.subscribe('/topic/menu-change', (message) => {
      this.handleStompMessage(message);
    });
  }

  /**
   * 处理STOMP消息
   */
  private handleStompMessage(message: any): void {
    if (message.type) {
      switch (message.type) {
        case 'menu_change':
          this.handleMenuChange(message as MenuChangeMessage);
          break;
        case 'system_notification':
          this.handleSystemNotification(message as SystemNotificationMessage);
          break;
        case 'user_status':
          this.handleUserStatus(message as UserStatusMessage);
          break;
        case 'permission_change':
          this.handlePermissionChange(message as PermissionChangeMessage);
          break;
        default:
          console.log('未知的消息类型:', message.type);
      }
    }
  }

  /**
   * 处理菜单变更消息
   */
  private handleMenuChange(message: MenuChangeMessage): void {
    console.log('收到菜单变更消息:', message);
    
    // 触发菜单刷新事件
    window.dispatchEvent(new CustomEvent('menu-change', {
      detail: message.data
    }));

    
  }

  /**
   * 处理系统通知消息
   */
  private handleSystemNotification(message: SystemNotificationMessage): void {
    console.log('收到系统通知:', message);
    
    // 显示系统通知
    this.showNotification(message.data);
  }

  /**
   * 处理用户状态变更消息
   */
  private handleUserStatus(message: UserStatusMessage): void {
    console.log('用户状态变更:', message);
    
    // 触发用户状态变更事件
    window.dispatchEvent(new CustomEvent('user-status-change', {
      detail: message.data
    }));
  }

  /**
   * 处理权限变更消息
   */
  private handlePermissionChange(message: PermissionChangeMessage): void {
    console.log('权限变更:', message);
    
    const currentUserId = this.getCurrentUserId();
    if (message.data.userId === currentUserId) {
      // 当前用户权限发生变更，需要重新加载页面或刷新权限
      window.dispatchEvent(new CustomEvent('permission-change', {
        detail: message.data
      }));
    }
  }

  /**
   * 显示系统通知
   */
  private showNotification(notification: SystemNotificationMessage['data']): void {
    // 这里可以集成Element Plus的通知组件
    // 或者使用浏览器原生通知API
    if ('Notification' in window && Notification.permission === 'granted') {
      new Notification(notification.title, {
        body: notification.message,
        icon: '/favicon.ico'
      });
    } else {
      // 使用Element Plus消息提示
      console.log('系统通知:', notification);
    }
  }

  /**
   * 发送菜单变更通知
   */
  public notifyMenuChange(action: 'add' | 'update' | 'delete', menuData?: any): void {
  
    const message = {
      type: 'menu_change',
      content: '操作了菜单',
      timestamp: this.nowDate(new Date())
    }

    if (this.useStoredProtocol) {
      stompService.send('/app/topic/menu-change', message);
    } else {
      webSocketService.send(message);
    }
  }

  public nowDate(time: Date) {
    var year = time.getFullYear(); // 年
    var month = (time.getMonth() + 1).toString().padStart(2, '0'); // 月
    var date = time.getDate().toString().padStart(2, '0'); // 日
    var hour = time.getHours().toString().padStart(2, '0'); // 时
    var minute = time.getMinutes().toString().padStart(2, '0'); // 分
    var second = time.getSeconds().toString().padStart(2, '0'); // 秒
    return (
      year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second
    )
  }

  /**
   * 订阅特定类型的消息
   */
  public subscribe<T = any>(messageType: string, callback: MessageCallback<T>): void {
    if (this.useStoredProtocol) {
      // STOMP协议需要根据目的地订阅
      console.log('请使用STOMP服务直接订阅特定目的地');
    } else {
      webSocketService.subscribe(messageType, (message: WebSocketMessage) => {
        callback(message as T);
      });
    }
  }

  /**
   * 取消订阅
   */
  public unsubscribe(messageType: string, callback?: MessageCallback): void {
    if (!this.useStoredProtocol) {
      webSocketService.unsubscribe(messageType, callback);
    }
  }

  /**
   * 获取认证token
   */
  private getAuthToken(): string {
    // 从localStorage、sessionStorage或Pinia store中获取token
    return localStorage.getItem('authentication') || 
           sessionStorage.getItem('authentication') || 
           '123456'; // 默认token用于测试
  }

  /**
   * 获取当前用户ID
   */
  private getCurrentUserId(): string {
    return localStorage.getItem('userId') || sessionStorage.getItem('userId') || 'unknown';
  }

  /**
   * 获取连接状态
   */
  public isConnected(): boolean {
    if (this.useStoredProtocol) {
      return stompService.getConnectionState();
    } else {
      return webSocketService.getConnectionState();
    }
  }

  /**
   * 获取初始化状态
   */
  public getInitializeState(): boolean {
    return this.isInitialized;
  }
}

// 创建单例实例
export const webSocketManager = new WebSocketManager();

export default WebSocketManager;
