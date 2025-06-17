package cn.admcc.gp10.entity.enums;

import lombok.Getter; /**
 * @author wck
 */

@Getter
public enum GnssSystem {
    /**
     * 来自GSA systemId的枚举
     */
    GPS((short) 1, "GPS系统"),
    GLONASS((short) 2, "GLONASS系统"),
    BDS((short) 4, "BDS系统");

    private final short code;
    private final String description;

    GnssSystem(short code, String description) {
        this.code = code;
        this.description = description;
    }
}
