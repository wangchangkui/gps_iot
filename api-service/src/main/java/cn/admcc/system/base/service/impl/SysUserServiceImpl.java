package cn.admcc.system.base.service.impl;

import cn.admcc.config.StorageConfig;
import cn.admcc.storage.FileConsist;
import cn.admcc.storage.FileStorageHandlerI;
import cn.admcc.system.base.entity.SysRole;
import cn.admcc.system.base.entity.SysUserRole;
import cn.admcc.system.base.entity.dto.UserRegisterDto;
import cn.admcc.system.base.entity.dto.UserRoleManagerDto;
import cn.admcc.system.base.exception.NoAuthException;
import cn.admcc.system.base.service.SysUserRoleDaoServiceI;
import cn.admcc.system.file.strategy.FileStorageStrategy;
import cn.admcc.system.base.dao.SysUserDao;
import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.UserUploadDto;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.system.base.service.SysUserServiceI;
import cn.admcc.util.PageQuery;
import cn.admcc.util.RedisUtil;
import cn.admcc.util.RsaUtil;
import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.core.util.URLUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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
import java.util.List;
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

    private final SysUserRoleDaoServiceI sysUserRoleDaoServiceI;

    private final RsaUtil rsaUtil;





    @Override
    @Transactional(rollbackFor = Exception.class)
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

        // 添加角色
        SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setRoleId(3L);
        sysUserRole.setId(IdUtil.getSnowflakeNextId());
        sysUserRole.setUserId(sysUser.getId());
        sysUserRole.setCreatedTime(LocalDateTime.now());
        sysUserRoleDaoServiceI.save(sysUserRole);
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
            String savePath = uploadAvatar(avatar, userUploadDto.getAccount());
            String webPath = URLUtil.completeUrl(storageConfig.getWebBaseUrl(), savePath);
            user.setAvatarUrl(webPath);
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

        try {
            this.updateById(user);
        } catch (Exception e) {
            if(avatar!=null){
                 Paths.get(storageConfig.getSrc(), user.getAvatarUrl());
            }
            log.error("更新信息失败",e);
        }
    }

    @Override
    public SysUser getByAccount(String account) {
        SysUser user = this.getOne(new LambdaQueryWrapper<SysUser>().eq(SysUser::getUserName, account));
        if(user == null){
            throw new SystemException("用户不存在");
        }
        return user;
    }

    @Override
    public SysUser getUserInfo(Long userId) {
        SysUser user = this.getById(userId);
        if(user == null){
            throw new SystemException("用户不存在");
        }
        // 移除用户的密码信息
        user.setPassword("*");

        // 获取用户的所有角色
        List<SysRole> sysRoles =
                sysUserRoleDaoServiceI.userRoleList(userId);
        user.setSysRoles(sysRoles);
        return user;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String uploadUserAvatar(MultipartFile file) {
        String userId;
        try {
            userId = StpUtil.getLoginId().toString();
        } catch (NotLoginException e) {
            throw new NoAuthException("未登录");
        }
        SysUser user = getById(Long.parseLong(userId));
        String savePath = this.uploadAvatar(file, user.getUserName());
        log.info("保存地址：{}",savePath);
        // 保存用户的地址信息
        String webPath = URLUtil.completeUrl(storageConfig.getWebBaseUrl(), savePath);
        user.setAvatarUrl(webPath);
        try {
            this.updateById(user);
        } catch (Exception e) {
            FileUtil.del(Paths.get(storageConfig.getSrc(), savePath));
            log.error("更新头像失败",e);
        }
        return webPath;
    }

    @Override
    public void resetPassword(UserUploadDto userUploadDto) {
        String newPassword = userUploadDto.getNewPassword();
        if(StrUtil.isEmpty(newPassword)){
            throw new SystemException("请输入新密码");
        }

        SysUser user = getByAccount(userUploadDto.getAccount());
        String currentPassword = userUploadDto.getPassword();
        String dbPassword = user.getPassword();
        // 解密传入的常昊
        try {

            String decrypt1 = rsaUtil.decrypt(dbPassword);
            if(currentPassword.equals(decrypt1)){
                // 设置新密码
                String npw = rsaUtil.encrypt(newPassword);
                user.setPassword(npw);
            }else{
                throw new SystemException("旧密码错误");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        this.updateById(user);
    }


    @Override
    public void initPassword(String account, String newPassword){
        if(StrUtil.isEmpty(newPassword)){
            throw new SystemException("请输入新密码");
        }
        SysUser user = getByAccount(account);

        try {
            String wpd = rsaUtil.encrypt(newPassword);
            user.setPassword(wpd);
        } catch (Exception e) {
            throw new SystemException("加密失败,联系管理员",e);
        }

        this.updateById(user);


    }


    @Override
    public void resetEmail(UserUploadDto userUploadDto) {
        SysUser user = getByAccount(userUploadDto.getAccount());
        user.setEmail(userUploadDto.getNewEmail());
        try {
            this.updateById(user);
        } catch (Exception e) {
            throw new SystemException("改邮箱已被绑定，请更换");
        }
    }

    @Override
    public Page<SysUser> pageUser(PageQuery<SysUser, SysUser> query) {

        LambdaQueryWrapper<SysUser> userLambdaQueryWrapper = new LambdaQueryWrapper<>();
        Page<SysUser> pageObject = query.getPage();
        SysUser queryObject = query.getQuery();
        // 按照账号模糊查询
        Optional.ofNullable(queryObject.getUserName()).ifPresent(t->{
            userLambdaQueryWrapper.like(SysUser::getUserName, t);
        });
        // 按照邮箱模糊查询
        Optional.ofNullable(queryObject.getEmail()).ifPresent(t->{
            userLambdaQueryWrapper.like(SysUser::getEmail, t);
        });
        // 按照昵称模糊查询
        Optional.ofNullable(queryObject.getNickName()).ifPresent(t->{
            userLambdaQueryWrapper.like(SysUser::getNickName, t);
        });
        // 那招手机号模糊查询
        Optional.ofNullable(queryObject.getPhoneNumber()).ifPresent(t->{
            userLambdaQueryWrapper.like(SysUser::getPhoneNumber, t);
        });
        userLambdaQueryWrapper.orderByDesc(SysUser::getCreatedTime);
        this.page(pageObject,userLambdaQueryWrapper);

        for (SysUser user : pageObject.getRecords()) {
            user.setPassword("*");
        }


        return pageObject;
    }

    @Transactional(rollbackFor = Exception.class )
    @Override
    public void deleteUser(Long userId) {


        // 删除用户关联角色
        sysUserRoleDaoServiceI.remove(new LambdaQueryWrapper<SysUserRole>().eq(SysUserRole::getUserId,userId));
        // 删除
        this.removeById(userId);


    }

    @Override
    public void updateUserInfo(UserRegisterDto userRegisterDto) {
        SysUser user = getByAccount(userRegisterDto.getAccount());
        user.setNickName(userRegisterDto.getNickName());
        user.setPhoneNumber(userRegisterDto.getPhone());
        user.setIsActive(userRegisterDto.getIsActive());
        user.setLastLogin(LocalDateTime.now());
        user.setUpdatedTime(LocalDateTime.now());
        user.setEmail(userRegisterDto.getEmail());
        if(StrUtil.isNotEmpty(userRegisterDto.getPassword())){
            try {
                String nwp = rsaUtil.encrypt(userRegisterDto.getPassword());
                user.setPassword(nwp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        try {
            this.updateById(user);
        } catch (Exception e) {
            throw new SystemException("电话号码、邮箱、用户名中存在重复，请尝试修改");
        }
    }

    @Override
    public void managerUserRole(UserRoleManagerDto userRoleManagerDto) {
        String userAccount = userRoleManagerDto.getAccount();
        SysUser user = getByAccount(userAccount);
        // 表示删除所有的角色
        sysUserRoleDaoServiceI.remove(new LambdaQueryWrapper<SysUserRole>().eq(SysUserRole::getUserId,user.getId()));
        if(CollUtil.isEmpty(userRoleManagerDto.getRoleId())){
            return;
        }
        List<SysUserRole> userRole = userRoleManagerDto.getRoleId().stream().map(f -> {
            SysUserRole sysUserRole = new SysUserRole();
            sysUserRole.setId(IdUtil.getSnowflakeNextId());
            sysUserRole.setUserId(user.getId());
            sysUserRole.setRoleId(f);
            return sysUserRole;
        }).toList();
        sysUserRoleDaoServiceI.saveBatch(userRole);
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

        return Paths.get(FileConsist.USER, userAccount,fileName +"."+ suffix).toString();

    }
}
