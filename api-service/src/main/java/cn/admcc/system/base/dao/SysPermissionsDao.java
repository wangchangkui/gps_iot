package cn.admcc.system.base.dao;

import cn.admcc.system.base.entity.SysPermissions;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:12
 */
@Mapper
public interface SysPermissionsDao extends BaseMapper<SysPermissions> {


    /**
     * 获取用户所有的权限
     * @param userId 用户id
     * @return 权限
     */
    List<SysPermissions> getUserAllPermissions(@Param("userId") Long userId);

}
