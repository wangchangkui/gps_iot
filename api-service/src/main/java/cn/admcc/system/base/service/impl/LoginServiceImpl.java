package cn.admcc.system.base.service.impl;

import cn.admcc.config.EmailConfig;
import cn.admcc.entity.CaptchaObject;
import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.UserEmailPhoneDto;
import cn.admcc.system.base.entity.dto.UserRegisterDto;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.LoginServiceI;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.util.EmailUtil;
import cn.admcc.util.RedisUtil;
import cn.admcc.util.RsaUtil;
import cn.admcc.util.SysCaptchaUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
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
@RequiredArgsConstructor
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

    private final RsaUtil rsaUtil;

    private final SysUserServiceI sysUserService;
    private final SysUserServiceI sysUserServiceI;


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
        redisUtil.delete(EMAIL_CODE_KEY+email);
        redisUtil.delete(EMAIL_COOLDOWN_KEY+email);
    }



    @Override
    public void registerUser(UserRegisterDto userRegisterDto) {
        // 校验验证码是否正确 如果验证码不存在或者不匹配 则结束
        String captchaCode = userRegisterDto.getCaptchaCode();
        String code = redisUtil.get(captchaCode);

        if(StrUtil.isEmpty(code)||!code.equals(userRegisterDto.getCaptcha())){
            throw new SystemException("验证码不正确，请重新获取");
        }
        // 删除验证码
        redisUtil.delete(captchaCode);

        // 校验邮箱验证码
        String email = userRegisterDto.getEmail();
        if(StrUtil.isEmpty(email)){
            throw new SystemException("邮箱不能为空");
        }
        String emailCode = userRegisterDto.getEmailCode();
        checkEmail(email,emailCode);

        // 注册用户
        SysUser sysUser = new SysUser();
        sysUser.setUserName(userRegisterDto.getAccount());
        sysUser.setNickName(userRegisterDto.getNickName());
        sysUser.setEmail(email);
        String encryptPassword;
        try {
            encryptPassword = rsaUtil.encrypt(userRegisterDto.getPassword());
        } catch (Exception e) {
            log.error("加密密码失败",e);
            return;
        }
        sysUser.setPassword(encryptPassword);
        // 添加默认的头像
        sysUser.setAvatarUrl("/marker.png");
        sysUser.setSex(userRegisterDto.getGender());
        sysUser.setPhoneNumber(userRegisterDto.getPhone());
        sysUser.setLastLogin(LocalDateTime.now());
        sysUserService.addUser(sysUser);
    }

    @Override
    public void updateUserEmailAndPhone(UserEmailPhoneDto userUploadDto) {
        if(StrUtil.isEmpty(userUploadDto.getAccount())){
            throw new SystemException("必须传入账号");
        }
        // 获取当前用户的信息
        SysUser user = sysUserServiceI.getByAccount(userUploadDto.getAccount());
        // 获取验证码
        checkEmail(user.getEmail(),userUploadDto.getEmailCode());
        // 跟新用户的手机号或邮箱
        if(StrUtil.isNotEmpty(userUploadDto.getNewEmail())){
            user.setEmail(userUploadDto.getNewEmail());
        }
        if(StrUtil.isNotEmpty(userUploadDto.getNewPhone())){
            user.setPhoneNumber(userUploadDto.getNewPhone());
        }
        sysUserService.updateById(user);
    }


    public void checkEmail(String email,String emailCode){
        if(StrUtil.isEmpty(emailCode)){
            throw new SystemException("请输入邮箱验证码");
        }
        String mailCode = redisUtil.get(EMAIL_CODE_KEY + email);

        // 如果邮箱验证码是空 或者 不匹配则结束 移除所有的邮箱信息
        if(StrUtil.isEmpty(mailCode) || !mailCode.equals(emailCode)){
            removeAllEmailCode(email);
            throw new SystemException("邮箱验证码错误，请重新获取");
        }
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
