package cn.admcc.util;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 14:12
 */
public class RedisConsist {

    /**
     * 用户权限的key
     */
    public static final String PERMISSION_KEY="permission:";

    /**
     * 冷却时间60秒 60秒内同一个邮箱不允许重复提交
     */
    public static final int COOLDOWN_PERIOD = 60;


    /**
     * 验证码有效期6分钟
     */
    public static final int VALIDATE_PERIOD = 300;


    /**
     * 邮箱的冷却key
     */
    public static final String EMAIL_COOLDOWN_KEY = "email:cooldown:";

    /**
     * 邮箱验证码的key
     */
    public static final String EMAIL_CODE_KEY = "email:code:";

}
