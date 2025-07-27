package cn.admcc.entity;

import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:07
 */
@Data
public class CaptchaObject {


    /**
     * 图片的base64编码
     */
    private String captchaBase64;




    /**
     * redis唯一的id
     */
    private Long captchaId;
}
