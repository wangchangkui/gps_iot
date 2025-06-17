package cn.admcc.gp10.entity.enums;

import lombok.Getter;


/**
 * @author wck
 */

@Getter
public enum FixStatus {
    /**
     * 定位模式 来自GSA
     */
    INVALID((short) 1, "定位无效"),
    D2((short) 2, "2D定位"),
    D3((short) 3, "3D定位");

    private final short code;
    private final String description;

    FixStatus(short code, String description) {
        this.code = code;
        this.description = description;
    }

}


