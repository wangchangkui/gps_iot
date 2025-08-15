package cn.admcc.device.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 来自设备的VTG数据
 * @author wck
 */
@Data
@TableName("device_vtg_data")
public class DeviceVtgData {

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
     * 数据时间
     */
    @TableField("data_time")
    private LocalDateTime dataTime;

    /**
     * 对地真北航向,单位为度，范围：000-359度
     */
    @TableField("cogt")
    private Float courseOverGroundTrue;

    /**
     * 对地磁北航向,单位为度，范围：000-359度
     */
    @TableField("cogm")
    private Float courseOverGroundMagnetic;

    /**
     * 对地速度,单位为节，范围：00.0-999.9节
     */
    @TableField("sog")
    private Float speedOverGround;

    /**
     * 单位为千米每小时，00.0至1851公里／小时
     */
    @TableField("kph")
    private Float speedInKilometersPerHour;

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
    private String positioningMode;
}
