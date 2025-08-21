package cn.admcc.system.base.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 权限表实体类
 * @author wck
 */
@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
@TableName("public.sys_permissions")
public class SysPermissions {

    /**
     * 权限ID（主键）
     * 使用数据库序列 permissions_permission_id_seq 自动生成
     */
    @TableId(value = "permission_id", type = IdType.INPUT)
    private Long permissionId;

    /**
     * 权限键（唯一标识）
     * 示例: menu:sysmgmt, func:user:create
     */
    @TableField("perm_key")
    private String permKey;

    /**
     * 权限显示名称
     */
    @TableField("perm_name")
    private String permName;

    /**
     * 权限类型 (枚举值: MENU, BUTTON, API, DATA)
     */
    @TableField("perm_type")
    private String permType;

    /**
     * 父权限ID（外键关联自身表）
     */
    @TableField("parent_id")
    private Long parentId;

    /**
     * 组件访问路径
     */
    @TableField("component_path")
    private String componentPath;

    /**
     * 排序序号（默认0）
     */
    @TableField("sort_order")
    private Integer sortOrder = 0;

    /**
     * 是否隐藏（默认false）
     */
    @TableField("is_hidden")
    private Boolean isHidden = false;

    /**
     * 创建时间（插入时自动填充）
     */
    @TableField(value = "created_time", fill = FieldFill.INSERT)
    private LocalDateTime createdTime;

    /**
     * 更新时间（插入和更新时自动填充）
     */
    @TableField(value = "updated_time", fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedTime;

    /**
     * 允许被删除吗？ 0 允许 1 不允许
     */
    @TableField("allow_delete")
    private Integer allowDelete;


    /**
     * 子权限列表
     */
    @TableField(exist = false)
    private List<SysPermissions> children = new ArrayList<>();


}
