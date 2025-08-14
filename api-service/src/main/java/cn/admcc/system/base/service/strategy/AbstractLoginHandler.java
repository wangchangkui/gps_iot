package cn.admcc.system.base.service.strategy;

import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import cn.admcc.system.base.entity.vo.LoginUserVo;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.SysPermissionServiceI;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.system.util.RedisConsist;
import cn.admcc.util.JacksonUtils;
import cn.admcc.util.RedisUtil;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import lombok.Getter;
import lombok.Setter;
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

    @Setter(onMethod_ = {@Autowired})
    protected   SysUserServiceI sysUserServiceI;



    public Object loginUser(LoginUserDto loginUserDto){

        // 检查验证码
        checkCapture(loginUserDto);

        // 执行登录
        SysUser user = this.login(loginUserDto);

        // 设置权限
        List<SysPermissions> userAllPermissions = permissionServiceI.getUserAllPermissions(user.getId());
        List<String> permission = userAllPermissions.stream().map(JacksonUtils::toJSONString).toList();

        // 删除之前的权限集合
        redisUtil.delete(RedisConsist.PERMISSION_KEY+ user.getId());

        // 设置新的权限
        redisUtil.setList(RedisConsist.PERMISSION_KEY+user.getId(),permission,6L,TimeUnit.HOURS);

        // 返回登录权限以及token
        String loginToken = StpUtil.getTokenValue();
        LoginUserVo loginUserVo = new LoginUserVo();
        loginUserVo.setLoginToken(loginToken);
        loginUserVo.setUserAllPermissions(userAllPermissions);


        return loginUserVo;
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
        if(StrUtil.isEmpty(captureContent)){
            throw new SystemException("验证码已过期");
        }
        // 删除验证码
        redisUtil.delete(captureId.toString());
        if(!captureContent.equals(capture)){
            throw new SystemException("无效验证码");
        }

    }

    /**
     * 登录的类型
     * @return 类型
     */
    public abstract String getType();




}
