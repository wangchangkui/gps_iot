package cn.admcc.system.base.service.strategy.impl;

import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.strategy.AbstractLoginHandler;
import cn.admcc.system.base.service.strategy.LoginHandler;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Component;

import static cn.admcc.util.RedisConsist.EMAIL_CODE_KEY;
import static cn.admcc.util.RedisConsist.EMAIL_COOLDOWN_KEY;


/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:21
 */
@Component("email")
public class EmailLogin extends AbstractLoginHandler implements LoginHandler {


    @Override
    public SysUser login(LoginUserDto loginUserDto) {
        // 获取用户的账号或密码
        String userAccount = loginUserDto.getAccount();
        String password = loginUserDto.getEmailCode();
        if(StrUtil.isEmpty(userAccount)){
            throw new SystemException("账号不能为空");
        }
        if(StrUtil.isEmpty(password)){
            throw new SystemException("邮箱码不能为空");
        }

        // 检查邮箱
        SysUser user = sysUserServiceI.getByAccount(userAccount);
        if(user == null){
            throw new SystemException("用户名或密码不正确");
        }
        String email = user.getEmail();
        String mailCode = redisUtil.get(EMAIL_CODE_KEY + email);

        // 如果邮箱验证码是空 或者 不匹配则结束 移除所有的邮箱信息
        if(StrUtil.isEmpty(mailCode) || !mailCode.equals(password)){
            redisUtil.delete(EMAIL_CODE_KEY+email);
            redisUtil.delete(EMAIL_COOLDOWN_KEY+email);
            throw new SystemException("邮箱验证码错误，请重新获取");
        }

        return user;
    }

    @Override
    public String getType() {
        return "email";
    }
}
