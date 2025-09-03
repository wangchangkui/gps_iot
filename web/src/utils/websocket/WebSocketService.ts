/**
 * WebSocket服务类
 * 用于管理STOMP WebSocket连接和消息处理
 */

// 如果没有安装@stomp/stompjs，可以直接使用浏览器原生WebSocket
export interface StompMessage {
  body: string;
  command: string;
  headers: Record<string, string>;
}

export interface WebSocketMessage {
  type: string;
  data: any;
  timestamp: number;
}

type MessageCallback = (message: WebSocketMessage) => void;

class WebSocketService {
  private socket: WebSocket | null = null;
  private url: string = '';
  private reconnectAttempts: number = 0;
  private maxReconnectAttempts: number = 5;
  private reconnectInterval: number = 3000;
  private messageCallbacks: Map<string, MessageCallback[]> = new Map();
  private isConnected: boolean = false;
  private heartbeatInterval: number | null = null;

  constructor() {
    // 从环境变量或配置文件获取WebSocket URL
    this.url = this.getWebSocketUrl();
  }

  /**
   * 获取WebSocket连接URL
   */
  private getWebSocketUrl(): string {
    // 对于原生WebSocket，如果使用SockJS，应该使用http协议
    // 这里保持原生WebSocket的实现，如果需要SockJS，应该使用StompService
    const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
    const host = window.location.hostname;
    const port = '8564'; // 固定端口
    return `${protocol}//${host}:${port}/api/ws`;
  }

  /**
   * 连接WebSocket
   */
  public connect(token?: string): Promise<void> {
    return new Promise((resolve, reject) => {
      try {
        // 构建连接URL，包含认证token
        const connectUrl = token ? `${this.url}?token=${token}` : this.url;
        
        this.socket = new WebSocket(connectUrl);

        this.socket.onopen = () => {
          console.log('WebSocket连接已建立');
          this.isConnected = true;
          this.reconnectAttempts = 0;
          this.startHeartbeat();
          resolve();
        };

        this.socket.onmessage = (event) => {
          this.handleMessage(event.data);
        };

        this.socket.onclose = (event) => {
          console.log('WebSocket连接已关闭', event);
          this.isConnected = false;
          this.stopHeartbeat();
          
          // 如果不是主动关闭，则尝试重连
          if (event.code !== 1000 && this.reconnectAttempts < this.maxReconnectAttempts) {
            setTimeout(() => {
              this.reconnect(token);
            }, this.reconnectInterval);
          }
        };

        this.socket.onerror = (error) => {
          console.error('WebSocket连接错误:', error);
          reject(error);
        };

      } catch (error) {
        reject(error);
      }
    });
  }

  /**
   * 重连WebSocket
   */
  private reconnect(token?: string): void {
    this.reconnectAttempts++;
    console.log(`尝试重连WebSocket (${this.reconnectAttempts}/${this.maxReconnectAttempts})`);
    this.connect(token).catch(() => {
      // 重连失败，等待下次重试
    });
  }

  /**
   * 断开WebSocket连接
   */
  public disconnect(): void {
    if (this.socket) {
      this.socket.close(1000, '主动断开连接');
      this.socket = null;
      this.isConnected = false;
      this.stopHeartbeat();
    }
  }

  /**
   * 发送消息
   */
  public send(message: any): void {
    if (this.socket && this.isConnected) {
      const messageString = typeof message === 'string' ? message : JSON.stringify(message);
      this.socket.send(messageString);
    } else {
      console.warn('WebSocket未连接，无法发送消息');
    }
  }

  /**
   * 订阅消息类型
   */
  public subscribe(messageType: string, callback: MessageCallback): void {
    if (!this.messageCallbacks.has(messageType)) {
      this.messageCallbacks.set(messageType, []);
    }
    this.messageCallbacks.get(messageType)?.push(callback);
  }

  /**
   * 取消订阅
   */
  public unsubscribe(messageType: string, callback?: MessageCallback): void {
    if (!this.messageCallbacks.has(messageType)) return;

    if (callback) {
      const callbacks = this.messageCallbacks.get(messageType) || [];
      const index = callbacks.indexOf(callback);
      if (index > -1) {
        callbacks.splice(index, 1);
      }
    } else {
      // 如果没有指定回调函数，则清空该类型的所有回调
      this.messageCallbacks.set(messageType, []);
    }
  }

  /**
   * 处理接收到的消息
   */
  private handleMessage(data: string): void {
    try {
      const message: WebSocketMessage = JSON.parse(data);
      
      // 触发对应类型的回调函数
      const callbacks = this.messageCallbacks.get(message.type) || [];
      callbacks.forEach(callback => {
        try {
          callback(message);
        } catch (error) {
          console.error('处理WebSocket消息回调时出错:', error);
        }
      });

      // 触发通用消息回调
      const allCallbacks = this.messageCallbacks.get('*') || [];
      allCallbacks.forEach(callback => {
        try {
          callback(message);
        } catch (error) {
          console.error('处理WebSocket通用消息回调时出错:', error);
        }
      });

    } catch (error) {
      console.error('解析WebSocket消息失败:', error);
    }
  }

  /**
   * 开始心跳检测
   */
  private startHeartbeat(): void {
    this.heartbeatInterval = setInterval(() => {
      if (this.isConnected) {
        this.send({
          type: 'ping',
          timestamp: Date.now()
        });
      }
    }, 30000); // 每30秒发送一次心跳
  }

  /**
   * 停止心跳检测
   */
  private stopHeartbeat(): void {
    if (this.heartbeatInterval) {
      clearInterval(this.heartbeatInterval);
      this.heartbeatInterval = null;
    }
  }

  /**
   * 获取连接状态
   */
  public getConnectionState(): boolean {
    return this.isConnected;
  }

  /**
   * 发送菜单变更通知
   */
  public notifyMenuChange(action: 'add' | 'update' | 'delete', menuData?: any): void {
    this.send({
      type: 'menu_change',
      data: {
        action,
        menuData,
        userId: this.getCurrentUserId()
      },
      timestamp: Date.now()
    });
  }

  /**
   * 获取当前用户ID（从token或本地存储中获取）
   */
  private getCurrentUserId(): string {
    // 这里应该从你的认证系统中获取用户ID
    // 例如从localStorage、sessionStorage或Pinia store中获取
    return localStorage.getItem('userId') || 'unknown';
  }
}

// 创建单例实例
export const webSocketService = new WebSocketService();

// 导出类型
export default WebSocketService;
