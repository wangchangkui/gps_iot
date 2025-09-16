package cn.admcc.system.base.entity.dto;

import lombok.Data;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:41
 */
@Data
public class UserRoleManagerDto {

    /**
     * 账号
     */
    private String account;

    /**
     * 角色id
     */
    private List<Long> roleId;
}
