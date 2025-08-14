package cn.admcc.system.base.entity.vo;

import cn.admcc.system.base.entity.SysPermissions;
import lombok.Data;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:13
 */
@Data
public class LoginUserVo {

    /**
     * 登录成功后获取的token
     */
    private String loginToken;


    /**
     * 获取到的用户权限
     */
    private List<SysPermissions> userAllPermissions;

}
