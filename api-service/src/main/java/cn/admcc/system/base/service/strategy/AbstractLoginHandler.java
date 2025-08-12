package cn.admcc.system.base.service.strategy;

import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import cn.admcc.system.base.service.SysPermissionServiceI;
import cn.admcc.util.JacksonUtils;
import cn.admcc.util.RedisUtil;
import lombok.Getter;
import lombok.Setter;
import org.hsqldb.rights.User;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:24
 */
@Getter
public abstract class AbstractLoginHandler implements LoginHandler {



    @Setter(onMethod_ = {@Autowired})
    protected  RedisUtil<String> redisUtil;


    @Setter(onMethod_ = {@Autowired})
    protected SysPermissionServiceI permissionServiceI;



    public Object loginUser(LoginUserDto loginUserDto){

        // 执行登录
        SysUser user = this.login(loginUserDto);

        // 设置权限
        List<SysPermissions> userAllPermissions = permissionServiceI.getUserAllPermissions(user.getId());
        List<String> permission = userAllPermissions.stream().map(JacksonUtils::toJSONString).toList();
        redisUtil.setList(user.getId().toString(),permission,6L,TimeUnit.HOURS);

        return user;
    }




}
