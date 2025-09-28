package cn.admcc.system.base.websocket.onlily;

import lombok.Data;
import org.locationtech.jts.geom.Geometry;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:53
 */
@Data
public class LinersUser {

    /**
     * session id
     */
    private String sessionId;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 前端生成的唯一id
     */
    private String onlyId;

    /**
     * 点位
     */
    private Geometry coordinate;

}
