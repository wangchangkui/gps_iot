package cn.admcc.gp10.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 来自设备GSA的数据
 * @author wck
 */
@Data
@TableName("device_gsa_data")
public class DeviceGsaData {

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
     * 定位模式 
     * 1-定位无效 
     * 2-2D定位 
     * 3-3D定位
     */
    @TableField("device_fs")
    private Short deviceFs;

    /**
     * 卫星使用(信号频道1)
     * 例如12，13,表示 编号12的卫星在使用信道1 编号13的卫星在使用信道2，最多12个信道
     */
    @TableField("satellite_chnnel")
    private String satelliteChannel;

    /**
     * 位置精度因子（PDOP）
     */
    @TableField("pdop")
    private Double pdop;

    /**
     * 垂直精度因子（VDOP）
     */
    @TableField("vdop")
    private Double vdop;

    /**
     * 水平精度因子（HDOP）
     */
    @TableField("hdop")
    private Double hdop;

    /**
     * 数据时间
     */
    @TableField("device_time")
    private LocalDateTime deviceTime;

    /**
     * 原始数据
     */
    @TableField("source_data")
    private String sourceData;

    /**
     * 卫星系统标识
     * 1-GPS系统 
     * 2-GLONASS系统 
     * 4-BDS系统
     */
    @TableField("system_id")
    private Short systemId;
}
