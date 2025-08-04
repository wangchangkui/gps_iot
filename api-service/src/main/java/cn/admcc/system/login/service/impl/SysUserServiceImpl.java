package cn.admcc.system.login.service.impl;

import cn.admcc.system.login.dao.SysUserDao;
import cn.admcc.system.login.entity.SysUser;
import cn.admcc.system.login.exception.SystemException;
import cn.admcc.system.login.service.SysUserServiceI;
import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:03
 */
@Service
@Slf4j
public class SysUserServiceImpl extends ServiceImpl<SysUserDao, SysUser> implements SysUserServiceI {
    @Override
    public void addUser(SysUser sysUser) {
        sysUser.setId(IdUtil.getSnowflakeNextId());
        sysUser.setLastLogin(LocalDateTime.now());
        try {
            this.save(sysUser);
        } catch (Exception e) {
            // 数据库设置了唯一建，失败的原因只能是冲突或数据库结构变化
            log.error("注册用户失败了,违反了唯一定理");
            throw new SystemException("无法注册用户");
        }
    }

    @Override
    public SysUser getUserByPhone(String phone) {
        LambdaQueryWrapper<SysUser> userPhone = new LambdaQueryWrapper<SysUser>().eq(SysUser::getPhoneNumber, phone);
        try {
            return getOne(userPhone);
        } catch (Exception e) {
            throw new SystemException("无法获取该手机号的用户");
        }
    }

    @Override
    public SysUser getUserByEmail(String mail) {
        LambdaQueryWrapper<SysUser> userMail = new LambdaQueryWrapper<SysUser>().eq(SysUser::getEmail, mail);
        try {
            return getOne(userMail);
        } catch (Exception e) {
            throw new SystemException("无法获取邮箱的用户");
        }
    }

    @Override
    public void disableUser(Long userId) {
        SysUser user = this.getById(userId);
        if(user == null){
            throw new SystemException("用户不存在");
        }
        user.setIsActive(false);
        this.updateById(user);
    }

    @Override
    public void enableUser(Long userId) {
        SysUser user = this.getById(userId);
        if(user == null){
            throw new SystemException("用户不存在");
        }
        user.setIsActive(true);
        this.updateById(user);
    }

    @Override
    public boolean checkUserActive(Long userId) {
        SysUser user = this.getById(userId);
        if(user == null){
            throw new SystemException("用户不存在");
        }
        return user.getIsActive();
    }

    @Override
    public void updateUser(SysUser user) throws SystemException {
        Long userId = Optional.ofNullable(user.getId()).orElseThrow(() -> new SystemException("请传入用户的id"));
        SysUser us = this.getById(userId);
        if(us == null){
            throw new SystemException("用户不存在");
        }
        this.updateById(user);
    }
}
