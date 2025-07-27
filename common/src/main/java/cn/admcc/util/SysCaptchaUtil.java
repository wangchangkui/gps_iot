package cn.admcc.util;

import cn.admcc.entity.CaptchaObject;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import cn.hutool.core.util.IdUtil;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

/**
 * @author coder wang
 * @version 1.0.0
 * @description 验证码
 * @createTime 19:00
 */
@Component
public class SysCaptchaUtil {

    private final RedisUtil<String> redisUtil;

    public SysCaptchaUtil(RedisUtil<String> redisUtil) {
        this.redisUtil = redisUtil;
    }


    /**
     * 生成验证码
     * @return 返回图片的base64
     */
    public CaptchaObject createPicCaptcha(){
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(200, 100, 4, 20);
        String code = captcha.getCode();
        long captchaId = IdUtil.getSnowflakeNextId();
        CaptchaObject captchaObject = new CaptchaObject();
        captchaObject.setCaptchaId(captchaId);
        captchaObject.setCaptchaBase64(captcha.getImageBase64());
        // 把code设置到缓存中 80秒过期
        redisUtil.set(String.valueOf(captchaId),code,80, TimeUnit.SECONDS);
        return captchaObject;
    }


    /**
     * 检查是否正确
     * @param captchaId 编码id
     * @param captchaCode 验证码
     * @return boolean 是否成果
     */
    public boolean checkCaptcha(String captchaId, String captchaCode){
        String code = redisUtil.get(captchaId);
        return code.equals(captchaCode);
    }

}
