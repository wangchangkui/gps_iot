package cn.admcc.system.base.entity.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 13:59
 */
@EqualsAndHashCode(callSuper = false)
@Data

public class UserEmailPhoneDto extends UserRegisterDto {


    /**
     * 新邮箱
     */
    private String newEmail;

    /**
     * 新电话
     */
    private String newPhone;
}
