package cn.admcc.gaode.entity;

import lombok.Data;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:32
 */
@Data
public class StepsVo {

    private String instruction;

    private String orientation;

    private Double stepDistance;

    private List<TmcsVo> tmcs;
}
