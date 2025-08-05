package cn.admcc.system.login.service;

import cn.admcc.system.login.entity.SysUser;
import cn.admcc.system.login.entity.dto.UserUploadDto;
import cn.admcc.system.login.exception.SystemException;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:03
 */
public interface SysUserServiceI extends IService<SysUser> {


    /**
     * 添加用户
     * @param sysUser 用户信息
     */
    void addUser(SysUser sysUser);


    /**
     * 获取该手机号的用户
     *
     * @param phone 用户电话
     * @return SysUser
     */
    SysUser getUserByPhone(String phone);

    /**
     * 获取该邮箱的用户
     *
     * @param mail 用户邮箱
     * @return SysUser
     */
    SysUser getUserByEmail(String mail);

    /**
     * 禁用用户
     * @param userId 用户id
     */
    void disableUser(Long userId);


    /**
     * 启用用户
     * @param userId 用户id
     */
    void enableUser(Long userId);


    /**
     * 检查用户是否是激活状态
     * @param userId 用户id
     * @return boolean
     */
    boolean checkUserActive(Long userId);


    /**
     * 跟新用户信息
     * @param sysUser 系统用户
     * @throws SystemException 找不到用户异常
     */
    void updateUser(SysUser sysUser) throws SystemException;

    /**
     * 更新用户基本信息 用户名称 性别
     * 该接口无法修改用户的邮箱 和 手机号
     * @param userUploadDto 用户数据
     */
    void updateUserBaseInfo(UserUploadDto userUploadDto);
}
