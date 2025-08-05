package cn.admcc.system.login.controller;

import cn.admcc.system.login.entity.dto.UserUploadDto;
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


    /**
     * 跟新用户头像以及用户的基本信息
     * @param userUploadDto 更新信息
     * @return success
     */
    @PostMapping("/update/base")
    public R<String> uploadUser(UserUploadDto userUploadDto) {
        sysUserServiceI.updateUserBaseInfo(userUploadDto);
        return R.success();
    }


}
