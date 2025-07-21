package cn.admcc.gaode.entity;

import lombok.Data;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:33
 */
@Data
public class PathsVo {

    /**
     * 距离
     */
    private String distance;


    /**
     *
     * 0 代表限行已规避或未限行，即该路线没有限行路段
     * 1 代表限行无法规避，即该线路有限行路段
     */
    private String restriction;


    /**
     * 步骤
     */
    private List<StepsVo> steps;
}
