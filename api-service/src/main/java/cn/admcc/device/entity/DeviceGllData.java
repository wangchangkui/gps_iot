package cn.admcc.device.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 来自设备的GLL反馈的数据
 * @author wck
 */
@Data
@TableName("device_gll_data")
public class DeviceGllData {

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
     * 纬度
     */
    @TableField("lat")
    private String lat;

    /**
     * 经度
     */
    @TableField("lon")
    private String lon;

    /**
     * 北半球（N）或南半球（S）
     */
    @TableField("u_lat")
    private String uLat;

    /**
     * 东（E）半球或西（W）半球
     */
    @TableField("u_lon")
    private String uLon;

    /**
     * 定位模式 
     * A-自主模式
     * E-估算模式（航位推算）
     * N-数据无效
     * D-差分模式
     * M-未定位，但存在外部输入或历史保存的位置
     * PositionMode
     */
    @TableField("mode")
    private String mode;

    /**
     * 原始数据
     */
    @TableField("source_data")
    private String sourceData;
}
