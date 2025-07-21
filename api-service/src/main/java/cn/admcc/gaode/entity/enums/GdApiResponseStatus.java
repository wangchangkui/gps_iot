package cn.admcc.gaode.entity.enums;

import lombok.Getter;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:01
 */
@Getter
public enum GdApiResponseStatus {

    /**
     * API 状态
     */
    ERROR(0),SUCCESS(1)
    ;
    private final Integer code;

    GdApiResponseStatus(Integer code) {
        this.code = code;
    }
}
