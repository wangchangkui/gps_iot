package cn.admcc.system.base.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * @author wck
 */
@Component
@Slf4j
public class MyWebSocketHandler extends TextWebSocketHandler {

    private final Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        log.info("WebSocket连接建立: {}", session.getId());
        
        // 发送欢迎消息
        session.sendMessage(new TextMessage("连接成功！"));
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        log.info("收到消息: {}", payload);
        
        // 处理消息并广播
        String response = "服务器收到: " + payload;
        broadcastMessage(response);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        log.info("WebSocket连接关闭: {}, 状态: {}", session.getId(), status);
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        log.error("WebSocket传输错误: {}", session.getId(), exception);
        sessions.remove(session);
    }

    /**
     * 广播消息给所有连接的客户端
     */
    public void broadcastMessage(String message) {
        synchronized (sessions) {
            for (WebSocketSession session : sessions) {
                if (session.isOpen()) {
                    try {
                        session.sendMessage(new TextMessage(message));
                    } catch (IOException e) {
                        log.error("发送消息失败: {}", session.getId(), e);
                    }
                }
            }
        }
    }

    /**
     * 获取当前连接数
     */
    public int getConnectionCount() {
        return sessions.size();
    }
}
