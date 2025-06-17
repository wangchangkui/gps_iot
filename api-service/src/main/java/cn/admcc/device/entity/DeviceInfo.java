package cn.admcc.device.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 设备信息表实体类
 * @author wck
 */
@Data
@TableName("public.device_info")
public class DeviceInfo {

    /**
     * 主键 设备id
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 设备名称
     */
    @TableField("device_name")
    private String deviceName;

    /**
     * 设备注册时间
     */
    @TableField("init_time")
    private LocalDateTime initTime;

    /**
     * 关联的用户id
     */
    @TableField("user_id")
    private Long userId;

    /**
     * 设备mac地址
     */
    @TableField("mac")
    private String mac;
}
