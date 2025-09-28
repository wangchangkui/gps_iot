package cn.admcc.system.base.websocket;

import cn.dev33.satoken.stp.StpUtil;
import lombok.NonNull;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketTransportRegistration;

import java.security.Principal;

/**
 * @author wck
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {



    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        // 启用简单的内存消息代理，目的地前缀为 /topic
        config.enableSimpleBroker("/topic");
        // 配置应用程序目的地前缀 前端访问必须要携带/app前缀
        config.setApplicationDestinationPrefixes("/app");
        config.setUserDestinationPrefix("/user");
    }



    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // 注册 STOMP 端点
        registry.addEndpoint("/ws")
                .setAllowedOriginPatterns("*")
                .withSockJS();

        // 可选：添加备用端点
        registry.addEndpoint("/ws-simple")
                .setAllowedOriginPatterns("*");
    }

    @Override
    public void configureWebSocketTransport(WebSocketTransportRegistration registration) {
        registration.setMessageSizeLimit(512 * 1024);
        registration.setSendTimeLimit(20 * 1000);
        registration.setSendBufferSizeLimit(512 * 1024);
    }

    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.interceptors(new ChannelInterceptor() {
            @Override
            public Message<?> preSend(@NonNull  Message<?> message,@NonNull MessageChannel channel) {
                // 可以在这里添加认证和授权逻辑
                StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
                if (StompCommand.CONNECT.equals(accessor.getCommand())) {
                    // 处理连接时的认证
                    String authToken = accessor.getFirstNativeHeader("Authorization");
                    Principal principal;
                    if (authToken != null && authToken.startsWith("Bearer ")) {
                        String token = authToken.substring(7);
                        // 这里可以验证 token 并设置认证信息
                        principal =  createPrincipalFromSaToken(token);

                    } else {
                        // 允许匿名连接，设置匿名用户
                        principal = createAnonymousPrincipal();
                    }
                    accessor.setUser(principal);
                    accessor.setSessionId(principal.getName());
                }
                return message;
            }
        });
    }


    /**
     * 使用 Sa-Token 创建 Principal
     */
    private Principal createPrincipalFromSaToken(String token) {
        try {
            // 验证 token
            // 如果是登录 token，获取用户信息
            Object loginId = StpUtil.getLoginIdByToken(token);
            if (loginId != null) {
                return new SaTokenPrincipal(loginId.toString(), token);
            }
            // 如果 token 无效，返回匿名用户
            return createAnonymousPrincipal();
        } catch (Exception e) {
            // token 验证失败，返回匿名用户
            return createAnonymousPrincipal();
        }
    }

    /**
     * 创建匿名 Principal
     */
    private Principal createAnonymousPrincipal() {
        return new SaTokenPrincipal("anonymous", null);
    }

}
