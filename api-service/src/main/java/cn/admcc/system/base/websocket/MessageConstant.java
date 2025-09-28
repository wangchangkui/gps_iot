package cn.admcc.system.base.websocket;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:17
 */
public class MessageConstant {

    public final static String APP = "/app";

    public final  static  String MENU_CHANGE = "/topic/menu-change" ;

    public final static String MESSAGE = "/topic/message";

    public final static String HOME_HALL = "/topic/home";

    public final static String CHAT_HOME_HALL = "/chat/home";

    // 用户加入和离开消息类型
    public final static String USER_JOIN = "join";
    public final static String USER_LEAVE = "leave";

}
