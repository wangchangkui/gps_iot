package cn.admcc.system.base.service.strategy.impl;

import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.system.base.service.strategy.AbstractLoginHandler;
import cn.admcc.system.base.service.strategy.LoginHandler;
import cn.admcc.util.RsaUtil;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Component;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:21
 */
@Component("account")
public class AccountLogin extends AbstractLoginHandler implements LoginHandler {

    private final RsaUtil rsaUtil;



    public AccountLogin(RsaUtil rsaUtil) {
        this.rsaUtil = rsaUtil;

    }


    @Override
    public SysUser login(LoginUserDto loginUserDto) {



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
        StpUtil.login(user.getId());
        return user;
    }




    @Override
    public String getType() {
        return "account";
    }
}
