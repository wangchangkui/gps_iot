package cn.admcc.system.base.entity.dto;


import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 10:57
 */
@EqualsAndHashCode(callSuper = false)
@Data
public class UserUploadDto extends UserRegisterDto {

    private MultipartFile avatar;

    /**
     * 新密码
     */
    private String newPassword;


    /**
     * 新邮箱
     */
    private String newEmail;



}
