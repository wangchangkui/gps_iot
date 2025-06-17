package cn.admcc.gp10.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 卫星的方位角以及倾角信息，与device_gsv_data表关联
 * @author wck
 */
@Data
@TableName("device_gsv_satellite_data")
public class DeviceGsvSatelliteData {

    /**
     * 主键ID
     */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 数据id 来自device_gsv_data表data_id字段
     */
    @TableField("data_id")
    private Long dataId;

    /**
     * 卫星编号
     */
    @TableField("satellite_code")
    private String satelliteCode;

    /**
     * 卫星仰角
     */
    @TableField("satellite_ele")
    private String satelliteElevation;

    /**
     * 卫星方位角
     */
    @TableField("satellite_az")
    private String satelliteAzimuth;

    /**
     * 讯号噪声比
     */
    @TableField("satellite_cno")
    private String satelliteCno;
}
