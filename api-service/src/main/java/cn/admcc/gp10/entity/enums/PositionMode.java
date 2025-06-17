package cn.admcc.gp10.entity.enums;

import lombok.Getter;

/**
 * @author wck
 */

@Getter
public enum PositionMode {
    /**
     * GII数据的定位模式
     */
    A("自主模式"),
    E("估算模式"),
    N("数据无效"),
    D("差分模式"),
    M("未定位");
    
    private final String description;

    PositionMode(String description) {
        this.description = description;
    }
    // 构造方法、getter等
}
