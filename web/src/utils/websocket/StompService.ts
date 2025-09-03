/**
 * STOMP WebSocket服务类
 * 使用 SockJS + STOMP 连接 Spring Boot WebSocket
 */

export interface StompMessage {
  type: string;
  destination: string;
  body: any;
  headers?: Record<string, string>;
}

type StompCallback = (message: any) => void;

// 声明 SockJS 和 Stomp 全局变量（如果通过script标签引入）
declare global {
  interface Window {
    SockJS: any;
    Stomp: any;
  }
}

class StompService {
  private socket: any = null;
  private stompClient: any = null;
  private subscriptions: Map<string, StompCallback[]> = new Map();
  private isConnected: boolean = false;
  private url: string = '';
  private sessionId: string = '';
  private messageId: number = 0;

  constructor() {
    this.url = this.getWebSocketUrl();
  }

  /**
   * 获取WebSocket连接URL
   */
  private getWebSocketUrl(): string {
    // 使用 HTTP 协议，SockJS 会自动处理协议升级
    const websocketUrl = import.meta.env.VITE_API_BASE_URL+'api/ws';
    return websocketUrl;
  }

  /**
   * 连接到STOMP服务器
   */
  public connect(headers: Record<string, string> = {}): Promise<void> {
    return new Promise((resolve, reject) => {
      try {
        // 检查是否已有全局的 SockJS 和 Stomp
        if (typeof window !== 'undefined' && window.SockJS && window.Stomp) {
          // 使用全局的 SockJS 和 Stomp (script标签引入的方式)
          this.socket = new window.SockJS(this.url);
          this.stompClient = window.Stomp.over(this.socket);
        } else {
          // 如果没有全局的SockJS和Stomp，抛出错误
          throw new Error('SockJS 或 STOMP 库未找到，请确保已通过script标签正确引入sockjs.min.js和stomp.min.js');
        }

        // 设置默认的连接头
        const connectHeaders = {
          'Authorization': `Bearer ${this.getAuthToken()}`,
          ...headers
        };

        // 建立 STOMP 连接
        this.stompClient.connect(
          connectHeaders,
          (frame: any) => {
            console.log('STOMP连接成功:', frame);
            this.isConnected = true;
            this.sessionId = frame.headers['session'] || '';
            resolve();
          },
          (error: any) => {
            console.error('STOMP连接失败:', error);
            this.isConnected = false;
            reject(error);
          }
        );

      } catch (error) {
        console.error('STOMP连接错误:', error);
        reject(error);
      }
    });
  }

  /**
   * 获取认证 token
   */
  private getAuthToken(): string {
    return localStorage.getItem('authentication') || 
           sessionStorage.getItem('authentication') || 
           '123456'; // 默认token，用于测试
  }

  /**
   * 断开STOMP连接
   */
  public disconnect(): void {
    if (this.stompClient && this.isConnected) {
      this.stompClient.disconnect(() => {
        console.log('STOMP连接已断开');
      });
      this.stompClient = null;
      this.socket = null;
      this.isConnected = false;
    }
  }

  /**
   * 订阅目的地
   */
  public subscribe(destination: string, callback: StompCallback): string {
    const id = `sub-${this.messageId++}`;
    
    if (this.isConnected && this.stompClient) {
      const subscription = this.stompClient.subscribe(destination, (message: any) => {
        try {
          const parsedBody = JSON.parse(message.body);
          callback(parsedBody);
        } catch (error) {
          // 如果不是JSON格式，直接传递原始消息体
          callback(message.body);
        }
      });

      // 存储订阅回调
      if (!this.subscriptions.has(destination)) {
        this.subscriptions.set(destination, []);
      }
      this.subscriptions.get(destination)?.push(callback);
    }

    return id;
  }

  /**
   * 取消订阅
   */
  public unsubscribe(subscriptionId: string): void {
    // STOMP.js 的取消订阅需要通过 subscription 对象
    // 这里简化处理，实际使用中可以存储 subscription 对象
    console.log('取消订阅:', subscriptionId);
  }

  /**
   * 发送消息到指定目的地
   */
  public send(destination: string, body: any, headers: Record<string, string> = {}): void {
    if (this.isConnected && this.stompClient) {
      // 自动添加认证头
      const sendHeaders = {
        'Authorization': `Bearer ${this.getAuthToken()}`,
        ...headers
      };
      this.stompClient.send(destination, sendHeaders, JSON.stringify(body));
    }
  }



  /**
   * 获取连接状态
   */
  public getConnectionState(): boolean {
    return this.isConnected;
  }
}

// 创建单例实例
export const stompService = new StompService();

export default StompService;
