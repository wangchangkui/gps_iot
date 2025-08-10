package cn.admcc.system.login.controller;

import cn.admcc.system.login.entity.dto.UserEmailPhoneDto;
import cn.admcc.system.login.entity.dto.UserRegisterDto;
import cn.admcc.system.login.entity.dto.UserUploadDto;
import cn.admcc.system.login.service.LoginServiceI;
import cn.admcc.system.login.service.SysUserServiceI;
import cn.admcc.util.R;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 10:56
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/user")
public class UserController {

    private final SysUserServiceI sysUserServiceI;

    private final LoginServiceI loginServiceI;


    /**
     * 更新用户头像以及用户的基本信息
     * @param userUploadDto 更新信息
     * @return success
     */
    @PostMapping("/update/base")
    public R<String> uploadUser(UserUploadDto userUploadDto) {
        sysUserServiceI.updateUserBaseInfo(userUploadDto);
        return R.success();
    }


    /**
     * 更新用户的手机号或邮箱
     * @param userUploadDto 用户的新的信息
     * @return success
     */
    @PostMapping("/update/email/phone")
    public R<String> updateUserEmailAndPhone(UserEmailPhoneDto userUploadDto) {
        loginServiceI.updateUserEmailAndPhone(userUploadDto);
        return R.success();
    }


}
