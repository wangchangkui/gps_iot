package cn.admcc.system.login.service.impl;

import cn.admcc.config.StorageConfig;
import cn.admcc.storage.FileConsist;
import cn.admcc.storage.FileStorageHandlerI;
import cn.admcc.system.file.strategy.FileStorageStrategy;
import cn.admcc.system.login.dao.SysUserDao;
import cn.admcc.system.login.entity.SysUser;
import cn.admcc.system.login.entity.dto.UserUploadDto;
import cn.admcc.system.login.exception.SystemException;
import cn.admcc.system.login.service.SysUserServiceI;
import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
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
@RequiredArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserDao, SysUser> implements SysUserServiceI {

    private final FileStorageStrategy fileStorageStrategy;

    private final StorageConfig storageConfig;


    @Override
    public void addUser(SysUser sysUser) {
        sysUser.setId(IdUtil.getSnowflakeNextId());
        sysUser.setLastLogin(LocalDateTime.now());
        try {
            this.save(sysUser);
        } catch (Exception e) {
            // 数据库设置了唯一建，失败的原因只能是冲突或数据库结构变化
            log.error("注册用户失败了,违反了唯一定理",e);
            throw new SystemException("无法注册用户，手机号或邮箱已经被使用");
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

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUserBaseInfo(UserUploadDto userUploadDto) {
        if(StrUtil.isEmpty(userUploadDto.getAccount())){
            throw new SystemException("请必须传入用户的账号");
        }

        SysUser user = getByAccount(userUploadDto.getAccount());
        // 跟新头像
        MultipartFile avatar = userUploadDto.getAvatar();
        if(avatar != null){
            uploadAvatar(avatar,userUploadDto.getAccount());
        }
        // 更新用户名
        if(!StrUtil.isEmpty(userUploadDto.getNickName())){
            user.setNickName(userUploadDto.getNickName());
        }

        // 更新性别
        if(userUploadDto.getGender() != null){
            if(userUploadDto.getGender() == 1 ||  userUploadDto.getGender() == 0){
                user.setSex(userUploadDto.getGender());
            }
        }

        this.updateById(user);
    }

    @Override
    public SysUser getByAccount(String account) {
        SysUser user = this.getOne(new LambdaQueryWrapper<SysUser>().eq(SysUser::getUserName, account));
        if(user == null){
            throw new SystemException("用户不存在");
        }
        return user;
    }


    @Transactional(rollbackFor = Exception.class)
    public String uploadAvatar(MultipartFile avatar,String userAccount) {
        // 获取默认的存储器,并生成一个随机的名称,保存到数据库

        FileStorageHandlerI<Object> defaultFileStorageHandler = fileStorageStrategy.getDefaultFileStorageHandler();
        String fileName = IdUtil.randomUUID().substring(0, 6);
        String suffix = FileNameUtil.getSuffix(avatar.getOriginalFilename());

        String savePath = Paths.get(storageConfig.getSrc(), FileConsist.USER, userAccount).toString();
        try(InputStream is = avatar.getInputStream()){
          defaultFileStorageHandler.saveFile(is, fileName +"."+ suffix, () ->savePath);
        } catch (IOException e) {
            throw new SystemException("上传用户头像失败",e);
        }

        return Paths.get(FileConsist.USER, userAccount).toString();

    }
}
