package cn.admcc.system.base.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionSubscribeEvent;

import java.time.LocalDateTime;

/**
 * @author wck
 */
@Component
@Slf4j
public class WebSocketEventListener {
 
    private final SimpMessagingTemplate messagingTemplate;
 
    public WebSocketEventListener(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }
 
    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event) {
        StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());
        log.info("STOMP连接建立: {}", sha.getSessionId());
        
        // 发送连接成功消息
        messagingTemplate.convertAndSend(MessageConstant.MESSAGE,
            new ChatMessage("新用户连接", "系统", LocalDateTime.now(), "JOIN"));
    }
 
    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());
        log.info("STOMP连接断开: {}", sha.getSessionId());
        
        messagingTemplate.convertAndSend(MessageConstant.MESSAGE,
            new ChatMessage("用户断开连接", "系统", LocalDateTime.now(), "LEAVE"));
    }
 
    @EventListener
    public void handleWebSocketSubscribeListener(SessionSubscribeEvent event) {
        StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());
        log.info("用户订阅: {} -> {}", sha.getSessionId(), sha.getDestination());
    }
}