package cn.admcc.gp10.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 来自设备的RMC格式的数据
 * @author wck
 */
@Data
@TableName("device_rmc_data")
public class DeviceRmcData {

    /**
     * 主键ID
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 设备id
     */
    @TableField("device_id")
    private Long deviceId;

    /**
     * 定位数据时间
     */
    @TableField("data_time")
    private LocalDateTime dataTime;

    /**
     * 经度
     */
    @TableField("lon")
    private String longitude;

    /**
     * 纬度
     */
    @TableField("lat")
    private String latitude;

    /**
     * 南北半球标识符 N 北半球 S 南半球
     */
    @TableField("u_lat")
    private String latitudeHemisphere;

    /**
     * 经度方向 E 东半球 W 西半球
     */
    @TableField("u_lon")
    private String longitudeDirection;

    /**
     * 速度 单位 节
     */
    @TableField("speed")
    private Double speed;

    /**
     * 对地真航向
     */
    @TableField("cog")
    private Double courseOverGround;

    /**
     * 磁偏角
     */
    @TableField("mv")
    private Double magneticVariation;

    /**
     * 磁偏角方向
     */
    @TableField("mv_e")
    private String magneticVariationDirection;

    /**
     * 原始数据
     */
    @TableField("source_data")
    private String sourceData;
}
