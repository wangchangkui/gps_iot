package cn.admcc.gp10.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 18:38
 */
@Data
@TableName("device_temp_data")
public class DeviceTempData {
    /**
     * 主键
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 数据时间
     */
    @TableField("time")
    private LocalDateTime time;

    /**
     * 设备id
     */
    @TableField("device_id")
    private Long deviceId;

    /**
     * 获取到的临时数据
     */
    @TableField("temp_data")
    private String tempData;

}



