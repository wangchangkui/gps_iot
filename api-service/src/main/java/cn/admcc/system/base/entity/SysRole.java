package cn.admcc.system.base.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @author wck
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName("public.sys_role")
public class SysRole {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    
    @TableField("role_name")
    private String roleName;
    
    @TableField(value = "created_time",fill = FieldFill.INSERT)
    private LocalDateTime createdTime;
    
    @TableField(value = "updated_time",fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedTime;

    @TableField(exist = false)
    private List<SysPermissions> permissions;


}
