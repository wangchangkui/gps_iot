package cn.admcc.system.base.service.strategy.impl;

import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.system.base.service.strategy.AbstractLoginHandler;
import cn.admcc.system.base.service.strategy.LoginHandler;
import cn.admcc.util.RsaUtil;
import cn.hutool.core.util.StrUtil;
import org.hsqldb.rights.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:21
 */
@Component("account")
public class AccountLogin extends AbstractLoginHandler implements LoginHandler {

    private final RsaUtil rsaUtil;

    private final SysUserServiceI sysUserServiceI;

    public AccountLogin(RsaUtil rsaUtil, SysUserServiceI sysUserServiceI) {
        this.rsaUtil = rsaUtil;
        this.sysUserServiceI = sysUserServiceI;
    }


    @Override
    public SysUser login(LoginUserDto loginUserDto) {

        // 检查验证码
        checkCapture(loginUserDto);

        // 获取用户的账号或密码
        String userAccount = loginUserDto.getAccount();
        String password = loginUserDto.getPassword();
        if(StrUtil.isEmpty(userAccount)){
            throw new SystemException("账号不能为空");
        }
        if(StrUtil.isEmpty(password)){
            throw new SystemException("密码不能为空");
        }

        SysUser user = sysUserServiceI.getByAccount(userAccount);
        if(user == null){
            throw new SystemException("用户名或密码不正确");
        }
        String decryptPassword;
        try {
            decryptPassword = rsaUtil.decrypt(user.getPassword());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if (!decryptPassword.equals(password)) {
            throw new SystemException("用户名或者密码不正确");
        }

        // 登录




        return user;
    }



    public void checkCapture(LoginUserDto loginUserDto){
        String capture = loginUserDto.getCapture();
        Long captureId = loginUserDto.getCaptureId();
        if (StrUtil.isEmpty(capture)) {
            throw new SystemException("验证码不能为空");
        }

        if(captureId == null){
            throw new SystemException("验证码id不能为空");
        }

        String captureContent = getRedisUtil().get(captureId.toString());
        // 删除验证码
        redisUtil.delete(captureId.toString());
        if(!captureContent.equals(capture)){
            throw new SystemException("无效验证码");
        }

    }
}
