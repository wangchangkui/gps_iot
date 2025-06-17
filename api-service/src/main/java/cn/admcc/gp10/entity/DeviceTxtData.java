package cn.admcc.gp10.entity;

import cn.admcc.gps.gp10.entity.TXTGNSSInfo;
import cn.admcc.gps.gp10.TxtZzEnums;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 设备GPS文本信息实体类
 * @author wck
 */
@Data
@TableName("device_txt_data")
public class DeviceTxtData {

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 设备id
     */
    @TableField("device_id")
    private Long deviceId;

    /**
     * 当前消息的语句总数
     */
    @TableField("device_xx")
    private Integer deviceXx;

    /**
     * 当前消息编号
     */
    @TableField("device_yy")
    private Integer deviceYy;

    /**
     * 消息类型：00=错误信息；01=警告信息；02=通知信息；07=用户信息
     */
    @TableField("device_zz")
    private String deviceZz;

    /**
     * 设备状态信息：ANTENNA_OPEN=天线开路,ANTENNA_OK=天线良好,ANTENNA_SHORT=天线短路
     */
    @TableField("device_info")
    private String deviceInfo;

    /**
     * 消息创建时间
     */
    @TableField("create_time")
    private LocalDateTime createTime;


    /**
     * 获取对应的错误信息Code
     * @return String
     */
    public String getDeviceZzTxt(){
        return TxtZzEnums.getMessageByCode(this.deviceZz);
    }

    /**
     * 获取 对应错误信息的解释
     * @return String
     * @throws TxtInfoException 无效信息
     */
    public  String getDeviceInfoTxt() throws TxtInfoException {
        return TXTGNSSInfo.getInfoTxt(this.deviceInfo);
    }

}
