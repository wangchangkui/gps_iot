package cn.admcc.gps.gp10.entity;

import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:08
 */
@Data
public class BaseGpsInfo {


    /**
     * 设备id信息
     */
    private Object deviceId;

    /**
     * 检验和 $和*之间（不包括$和*）所有字
     * 符的异或结果
     */
    private String cs;


}
