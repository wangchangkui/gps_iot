package cn.admcc.gp10.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 来自设备的GSV的数据，关联device_gsv_satellite_data
 * @author wck
 */
@Data
@TableName("device_gsv_data")
public class DeviceGsvData {

    /**
     * 主键
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 设备id
     */
    @TableField("device_id")
    private Long deviceId;

    /**
     * 数据时间
     */
    @TableField("data_time")
    private LocalDateTime dataTime;

    /**
     * 卫星数量
     */
    @TableField("satellite_num")
    private Short satelliteNum;

    /**
     * 数据id 与device_gsv_satellite_data表关联查询
     */
    @TableField("data_id")
    private Long dataId;

    /**
     * 原始数据
     */
    @TableField("source_data")
    private String sourceData;


    /**
     * 对应数据的卫星数据
     */
    @TableField(exist = false)
    private List<DeviceGsvSatelliteData> gsvSatelliteData;
}
