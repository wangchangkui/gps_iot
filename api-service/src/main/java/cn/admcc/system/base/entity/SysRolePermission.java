package cn.admcc.system.base.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 10:50
 */
@Data
@TableName("sys_role_permission")
public class SysRolePermission {

    @TableId("id")
    private Long id;

    @TableField("role_id")
    private Long roleId;

    @TableField("permission_id")
    private Long permissionId;

    @TableField(value = "created_time",fill = FieldFill.INSERT)
    private LocalDateTime createdTime;


}
