package cn.admcc.system.base.entity.enums;

import lombok.Getter;

/**
 * 权限类型枚举
 * @author wck
 */
@Getter
public enum PermissionType {
    /**
     * 权限类型
     */
    MENU("MENU", "菜单权限"),
    BUTTON("BUTTON", "按钮权限"),
    API("API", "接口权限"),
    DATA("DATA", "数据权限");
 
    private final String code;
    private final String desc;
 
    PermissionType(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

 
    /**
     * 检查是否为有效权限类型
     */
    public static boolean isValidType(String type) {
        for (PermissionType t : values()) {
            if (t.code.equals(type)) {
                return true;
            }
        }
        return false;
    }
}