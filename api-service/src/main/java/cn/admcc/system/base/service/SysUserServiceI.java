package cn.admcc.system.base.service;

import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.entity.dto.UserUploadDto;
import cn.admcc.system.base.exception.SystemException;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

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

    /**
     * 根据账号获取用户信息
     * @param account 账号
     * @return SysUser
     */
    SysUser getByAccount(String account);

    /**
     * 获取用户的详细信息
     * @param userId 用户id
     * @return SysUser
     */
    SysUser getUserInfo(Long userId);

    /**
     * 更新用户头像
     *
     * @param file 用户信息
     * @return 访问地址
     */
    String uploadUserAvatar(MultipartFile file);

    /**
     * 更新密码
     * @param userUploadDto url
     */
    void resetPassword(UserUploadDto userUploadDto);

    /**
     * 初始化重置密码
     * @param account 重置账号
     * @param newPassword 密码
     */
    void initPassword(String account, String newPassword);

    /**
     * 更新邮箱
     * @param userUploadDto 更新参数
     */
    void resetEmail(UserUploadDto userUploadDto);
}
