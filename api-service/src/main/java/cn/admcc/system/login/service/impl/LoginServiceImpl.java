package cn.admcc.system.login.service.impl;

import cn.admcc.config.EmailConfig;
import cn.admcc.entity.CaptchaObject;
import cn.admcc.system.login.exception.SystemException;
import cn.admcc.system.login.service.LoginServiceI;
import cn.admcc.util.EmailUtil;
import cn.admcc.util.RedisUtil;
import cn.admcc.util.SysCaptchaUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.concurrent.TimeUnit;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:13
 */
@Service
@Slf4j
public class LoginServiceImpl implements LoginServiceI {

    private final SysCaptchaUtil captchaUtil;

    private final RedisUtil<String> redisUtil;


    /**
     * 冷却时间60秒 60秒内同一个邮箱不允许重复提交
     */
    private static final int COOLDOWN_PERIOD = 60;


    /**
     * 验证码有效期6分钟
     */
    private static final int VALIDATE_PERIOD = 300;


    /**
     * 邮箱的冷却key
     */
    private static final String EMAIL_COOLDOWN_KEY = "email:cooldown:";

    /**
     * 邮箱验证码的key
     */
    private static final String EMAIL_CODE_KEY = "email:code:";



    private final ResourceLoader resourceLoader;

    private final EmailConfig emailConfig;

    private final EmailUtil emailUtil;



    public LoginServiceImpl(SysCaptchaUtil captchaUtil, RedisUtil<String> redisUtil, ResourceLoader resourceLoader, EmailConfig emailConfig, EmailUtil emailUtil) {
        this.captchaUtil = captchaUtil;
        this.redisUtil = redisUtil;
        this.resourceLoader = resourceLoader;
        this.emailConfig = emailConfig;
        this.emailUtil = emailUtil;
    }


    @Override
    public CaptchaObject getCaptcha() {
        return captchaUtil.createPicCaptcha();
    }


    @Override
    public void sendRegisterEmail(String email) {
        // 60s内不允许重复获取验证码
        if (redisUtil.hasKey(EMAIL_COOLDOWN_KEY+email)) {
            throw new SystemException("重复提交，请1分钟后再试");
        }

        // 删除以前的信息
        redisUtil.delete(EMAIL_CODE_KEY+email);
        // 获取一个6位数的验证码
        String captcha = RandomUtil.randomNumbers(6);
        // 获取当前目录下的邮件模板
        String emailContent = writeCodeToTemplate(captcha);
        // 发送邮件
        emailUtil.sendEmail(emailContent,email,"Admcc 注册");
        // 设置过期时间
        redisUtil.set(EMAIL_COOLDOWN_KEY+email,email,COOLDOWN_PERIOD,TimeUnit.SECONDS);
        // 设置key
        redisUtil.set(EMAIL_CODE_KEY+email,captcha,VALIDATE_PERIOD,TimeUnit.SECONDS);
    }

    @Override
    public void removeAllEmailCode(String email) {

    }


    /**
     * 写入Email验证码邮箱模板
     * @param code 验证码
     * @return  String
     */
    public String writeCodeToTemplate(String code){
        // 加载资源文件
        Resource resource = resourceLoader.getResource("classpath:" + emailConfig.getTemplateConfig());
        String template;
        // 检查资源是否存在
        if (resource.exists()) {
            // 读取文件内容
            try {
                template = new String(Files.readAllBytes(Paths.get(resource.getURI())));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            throw new RuntimeException("配置模板文件不见了，请检查后重新部署服务");
        }
        HashMap<String, String> stringStringHashMap = new HashMap<>(1);
        stringStringHashMap.put("code", code);
        return StrUtil.format(template, stringStringHashMap);
    }


}
