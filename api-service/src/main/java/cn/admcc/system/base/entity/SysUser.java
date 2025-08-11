package cn.admcc.system.base.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 系统用户表实体类
 * @author wck
 */
@Data
@TableName("public.sys_users")
public class SysUser {

    /**
     * 用户ID
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 用户名称
     */
    @TableField("user_name")
    private String userName;

    /**
     * 邮箱
     */
    @TableField("email")
    private String email;

    /**
     * 密码
     */
    @TableField("password")
    private String password;

    /**
     * 昵称
     */
    @TableField("nick_name")
    private String nickName;

    /**
     * 电话号码
     */
    @TableField("phone_number")
    private String phoneNumber;

    /**
     * 性别 1 男 0 女
     */
    @TableField("sex")
    private Integer sex;

    /**
     * 头像URL
     */
    @TableField("avatar_url")
    private String avatarUrl;

    /**
     * 是否允许使用
     */
    @TableField("is_active")
    private Boolean isActive = true;

    /**
     * 最后一次登录时间
     */
    @TableField("last_login")
    private LocalDateTime lastLogin;

    /**
     * 创建时间
     */
    @TableField(value = "created_time",fill = FieldFill.INSERT)
    private LocalDateTime createdTime;

    /**
     * 更新时间
     */
    @TableField(value = "updated_time",fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedTime;

    /**
     * 用户拥有的角色
     */
    @TableField(exist = false)
    private List<SysRole> sysRoles;
}
