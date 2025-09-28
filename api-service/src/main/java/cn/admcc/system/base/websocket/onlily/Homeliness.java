package cn.admcc.system.base.websocket.onlily;

import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.system.base.websocket.ChatMessage;
import cn.admcc.system.base.websocket.MessageConstant;
import cn.admcc.util.gis.GeoToolsUtils;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Point;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:04
 */
@Slf4j
@Component
public class Homeliness {


    private final SimpMessagingTemplate messagingTemplate;

    private final SysUserServiceI sysUserServiceI;


    /**
     * 当前在线的用户
     */
    private final Map<String,LinersUser> ann =new HashMap<>();


    public Homeliness(SimpMessagingTemplate messagingTemplate, SysUserServiceI sysUserServiceI) {
        this.messagingTemplate = messagingTemplate;
        this.sysUserServiceI = sysUserServiceI;
    }

    /**
     * 加入受恶意的业务逻辑
     * @param message message里面需要携带坐标位置，x,y
     * @param ma 认证头
     */
    public  void joinHome(ChatMessage message, MessageHeaderAccessor ma){
        log.info("有新用户访问页面，位置: {}", message.getContent());
        ChatMessage joinMessage = new ChatMessage();
        String header = ((StompHeaderAccessor) ma).getFirstNativeHeader("Authorization");
        // 设置登录用户
        String ano = "anonymous" +"_"+ ((StompHeaderAccessor) ma).getSessionId();
        if(StrUtil.isEmpty(header)){
            joinMessage.setSender(ano);
        }else{
            Object userId = StpUtil.getLoginIdByToken(header.substring(7));
            if(userId != null){
                SysUser userInf = sysUserServiceI.getUserInfo(Long.parseLong(userId.toString()));
                joinMessage.setSender(userInf.getNickName());
            }else {
                joinMessage.setSender(ano);
            }
        }

        LinersUser linersUser = new LinersUser();
        linersUser.setSessionId(((StompHeaderAccessor) ma).getSessionId());
        linersUser.setUserName(joinMessage.getSender());
        linersUser.setOnlyId(message.getOnlyId());
        String content = message.getContent();
        if(StrUtil.isEmpty(content)){
            return;
        }
        // x,y
        String[] split = content.split(",");
        int xyLeng = 2;
        if(split.length < xyLeng){
            return;
        }

        // 转为double
        try {
            Double x = Double.valueOf(split[0]);
            Double y = Double.valueOf(split[1]);
            Point point = GeoToolsUtils.creatPoint(x, y);
            linersUser.setCoordinate(point);
        } catch (NumberFormatException e) {
            log.error("传入的content有误",e);
            return;
        }

        ann.put(((StompHeaderAccessor) ma).getSessionId(),linersUser);

        joinMessage.setType(MessageConstant.USER_JOIN);
        joinMessage.setContent(message.getContent());
        joinMessage.setTimestamp(LocalDateTime.now());

        // 广播给所有用户
        messagingTemplate.convertAndSend(MessageConstant.HOME_HALL, joinMessage);
    }

    /**
     * 离开信息
     * @param message 无任何意义
     * @param ma 认证头
     */
    public void leaveHome(ChatMessage message, MessageHeaderAccessor ma){
        log.info("用户离开 位置: {}", message.getContent());

        LinersUser linersUser = ann.get(((StompHeaderAccessor) ma).getSessionId());
        ChatMessage leaveMessage = new ChatMessage();
        leaveMessage.setType(MessageConstant.USER_LEAVE);
        leaveMessage.setSender(linersUser.getUserName());
        leaveMessage.setContent(message.getContent());
        leaveMessage.setTimestamp(LocalDateTime.now());

        ann.remove(((StompHeaderAccessor) ma).getSessionId());
        // 广播给所有用户
        messagingTemplate.convertAndSend(MessageConstant.HOME_HALL, leaveMessage);
    }

    /**
     * 离开信息
     * @param sessionId 唯一id
     */
    public void leaveHome(String sessionId){
        LinersUser user = ann.get(sessionId);
        if(user != null){
            log.info("用户离开 : {}", user.getUserName());


            ChatMessage leaveMessage = new ChatMessage();
            leaveMessage.setType(MessageConstant.USER_LEAVE);
            leaveMessage.setSender(user.getUserName());
            Point centroid = user.getCoordinate().getCentroid();
            String content = centroid.getX() + "," + centroid.getY();
            leaveMessage.setContent(content);
            leaveMessage.setTimestamp(LocalDateTime.now());

            ann.remove(sessionId);
            // 广播给所有用户
            messagingTemplate.convertAndSend(MessageConstant.HOME_HALL, leaveMessage);
        }

    }



    /**
     * 获取所有的在线用户
     * @return LinersUser
     */
    public Collection<LinersUser> getAllHomeUser(){
        return ann.values();
    }

}
