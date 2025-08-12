package cn.admcc.system.base.service.strategy;

import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.LoginUserDto;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:20
 */
public interface LoginHandler {

    /**
     * 用户登录
     * @param loginUserDto 登录
     * @return object
     */
    SysUser login(LoginUserDto loginUserDto);

}
