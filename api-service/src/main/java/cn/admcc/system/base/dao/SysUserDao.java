package cn.admcc.system.base.dao;

import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.entity.SysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:02
 */
@Mapper
public interface SysUserDao extends BaseMapper<SysUser> {


    /**
     * 获取用户的信息包括权限以及角色
     * @param account 账号
     * @return 用户
     */
    SysUser getUserInfoAndRulers(@Param("account") String account);



}
