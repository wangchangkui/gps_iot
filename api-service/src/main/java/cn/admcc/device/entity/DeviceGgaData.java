package cn.admcc.device.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 来自GGA反馈的数据，该数据带有海拔高度和坐标信息
 * @author wck
 */
@Data
@TableName("device_gga_data")
public class DeviceGgaData {

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
     * 纬度方向 北半球（N）或南半球（S）
     */
    @TableField("u_lat")
    private String uLat;

    /**
     * 经度方向 东（E）半球或西（W）半球
     */
    @TableField("u_lon")
    private String uLon;

    /**
     * 定位卫星数量
     */
    @TableField("sv_num")
    private Integer svNum;

    /**
     * 水平精度因子（HDOP) 范围：0.5-99.9
     */
    @TableField("hdop")
    private Double hdop;

    /**
     * 海拔高度 单位m
     */
    @TableField("msl")
    private Double msl;

    /**
     * 参考椭球面与大地水准面之间的距离 单位m
     */
    @TableField("sep")
    private Double sep;

    /**
     * 差分时间
     */
    @TableField("diff_age")
    private String diffAge;

    /**
     * 差分站ID
     */
    @TableField("diffSta")
    private String diffSta;

    /**
     * 数据时间
     */
    @TableField("data_time")
    private LocalDateTime dataTime;

    /**
     * 原始数据
     */
    @TableField("source_data")
    private String sourceData;
}
