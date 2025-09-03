package cn.admcc.system.base.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.time.LocalDateTime;
/**
 * @author wck
 */
@Controller
@Slf4j
public class WebSocketController {

    private final SimpMessagingTemplate messagingTemplate;

    public WebSocketController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    /**
     * 处理发送到 /app/chat 的消息
     */
    @MessageMapping("/chat")
    @SendTo(MessageConstant.MESSAGE)
    public ChatMessage handleChatMessage(ChatMessage message, Principal principal) {
        log.info("收到消息: {} ", message.getContent());
        message.setTimestamp(LocalDateTime.now());
        message.setSender(principal.getName());
        return message;
    }



    /**
     * 处理私人消息
     */
    @MessageMapping("/private")
    public void handlePrivateMessage(@Payload PrivateMessage message, Principal principal) {
        message.setTimestamp(LocalDateTime.now());
        message.setSender(principal.getName());
        // 发送给特定用户
        messagingTemplate.convertAndSendToUser(
                message.getRecipient(),
                "/queue/private",
                message
        );
    }

    /**
     * 处理订阅事件
     */
    @SubscribeMapping(MessageConstant.MESSAGE)
    public ChatMessage handleSubscribe() {
        ChatMessage welcome = new ChatMessage();
        welcome.setContent("注册成功 ！");
        welcome.setSender("系统");
        welcome.setTimestamp(LocalDateTime.now());
        return welcome;
    }



    @MessageMapping(value = MessageConstant.MENU_CHANGE)
    @SendTo(value = MessageConstant.MENU_CHANGE)
    public ChatMessage handleMenuChangeMessage(ChatMessage message, Principal principal) {

        return message;
    }


    @SubscribeMapping(value = MessageConstant.MENU_CHANGE)
    public ChatMessage handleMenuChangeSubscribe() {
        ChatMessage welcome = new ChatMessage();
        welcome.setContent("更新了菜单消息 ！");
        welcome.setSender("系统");
        welcome.setTimestamp(LocalDateTime.now());
        return welcome;
    }





}
