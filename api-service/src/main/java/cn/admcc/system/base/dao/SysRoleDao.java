package cn.admcc.system.base.dao;

import cn.admcc.system.base.entity.SysRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:03
 */
@Mapper
public interface SysRoleDao extends BaseMapper<SysRole> {


    /**
     * 获取用户所有的角色信息
     * @param userId 用户id
     * @return 角色信息
     */
    List<SysRole> userRoleList(Long userId);
}
