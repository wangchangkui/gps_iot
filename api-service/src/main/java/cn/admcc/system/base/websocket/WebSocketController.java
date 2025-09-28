package cn.admcc.system.base.websocket;

import cn.admcc.system.base.websocket.onlily.Homeliness;
import cn.admcc.system.base.websocket.onlily.LinersUser;
import cn.admcc.util.R;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Collection;

/**
 * @author wck
 */
@Controller
@Slf4j
public class WebSocketController {

    private final SimpMessagingTemplate messagingTemplate;

    private final Homeliness homeliness;

    public WebSocketController(SimpMessagingTemplate messagingTemplate, Homeliness homeliness) {
        this.messagingTemplate = messagingTemplate;
        this.homeliness = homeliness;
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




    /**
     * 处理加入消息
     */
    @MessageMapping(value = MessageConstant.CHAT_HOME_HALL)
    @SendTo(value = MessageConstant.HOME_HALL)
    public void handlerHomeHallJoinMessage(ChatMessage chatMessage,MessageHeaders messageHeaders, MessageHeaderAccessor ma, StompHeaderAccessor st){
        ChatMessage welcome = new ChatMessage();
        welcome.setContent("Hello ！");
        welcome.setSender("系统");
        welcome.setTimestamp(LocalDateTime.now());
        messagingTemplate.convertAndSend(MessageConstant.HOME_HALL,welcome);
    }

    /**
     * 处理用户加入消息
     */
    @MessageMapping("/user/join")
    @SendTo(MessageConstant.HOME_HALL)
    public void handleUserJoin(ChatMessage message,MessageHeaders messageHeaders, MessageHeaderAccessor ma, StompHeaderAccessor st) {
        homeliness.joinHome(message,ma);
    }

    /**
     * 处理用户离开消息
     */
    @MessageMapping("/user/leave")
    @SendTo(MessageConstant.HOME_HALL)
    public void handleUserLeave(ChatMessage message, MessageHeaderAccessor ma) {
        homeliness.leaveHome(message,ma);
    }


    /**
     * 获取所有订阅的用户
     * @return LinersUser
     */
    @GetMapping("/all/home/user")
    @ResponseBody
    public R<Collection<LinersUser>> handleHomeAllJoinMessage() {
        return R.success(homeliness.getAllHomeUser());
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
