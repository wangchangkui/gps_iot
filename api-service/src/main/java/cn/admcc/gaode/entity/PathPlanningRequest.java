package cn.admcc.gaode.entity;

import lombok.Data;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:34
 */
@Data
public class PathPlanningRequest {

    /**
     * 高德Api Key
     */
    private String key;

    /**
     * 起点经纬度
     * 经度在前，纬度在后，经度和纬度用","分割，经纬度小数点后不得超过6位
     */
    private String origin;

    /**
     * 目的地
     * 经度在前，纬度在后，经度和纬度用","分割，经纬度小数点后不得超过6位
     */
    private String destination;

    /**
     * 终点的 poi 类别
     * 当用户知道终点 POI 的类别时候，建议填充此值
     */
    private String destinationType;

    /**
     * 起点 POI ID
     * 起点为 POI 时，建议填充此值，可提升路线规划准确性
     */
    private String originId;

    /**
     * 目的地 POI ID
     * 目的地为 POI 时，建议填充此值，可提升路径规划准确性
     */
    private String destinationId;

    /**
     * 驾车算路策略
     * 0：速度优先（只返回一条路线），此路线不一定距离最短
     * 1：费用优先（只返回一条路线），不走收费路段，且耗时最少的路线
     * 2：常规最快（只返回一条路线）综合距离/耗时规划结果
     * 32：默认，高德推荐，同高德地图APP默认
     * 33：躲避拥堵
     * 34：高速优先
     * 35：不走高速
     * 36：少收费
     * 37：大路优先
     * 38：速度最快
     * 39：躲避拥堵＋高速优先
     * 40：躲避拥堵＋不走高速
     * 41：躲避拥堵＋少收费
     * 42：少收费＋不走高速
     * 43：躲避拥堵＋少收费＋不走高速
     * 44：躲避拥堵＋大路优先
     * 45：躲避拥堵＋速度最快
     */
    private Integer strategy;

    /**
     * 途经点
     * 途径点坐标串，默认支持1个有序途径点。多个途径点坐标按顺序以英文分号;分隔。最大支持16个途经点。
     */
    private String waypoints;

    /**
     * 避让区域
     * 区域避让，默认支持1个避让区域，每个区域最多可有16个顶点；多个区域坐标按顺序以英文竖线符号“|”分隔，如果是四边形则有四个坐标点，如果是五边形则有五个坐标点；最大支持32个避让区域。
     * 每个避让区域不能超过81平方公里，否则避让区域会失效。
     */
    private String avoidPolygons;

    /**
     * 车牌号码
     * 车牌号，如 京AHA322，支持6位传统车牌和7位新能源车牌，用于判断限行相关。
     */
    private String plate;

    /**
     * 车辆类型
     * 0：普通燃油汽车
     * 1：纯电动汽车
     * 2：插电式混动汽车
     */
    private Integer carType;

    /**
     * 是否使用轮渡
     * 0:使用渡轮
     * 1:不使用渡轮
     */
    private Integer ferry;

    /**
     * 返回结果控制
     * show_fields 用来筛选 response 结果中可选字段。
     * 1、具体可指定返回的字段类请见下方返回结果说明中的“show_fields”内字段类型；
     * 2、多个字段间采用“,”进行分割；
     * 3、show_fields 未设置时，只返回基础信息类内字段；
     */
    private String showFields;

    /**
     * 数字签名
     * 请参考 数字签名获取和使用方法
     */
    private String sig;

    /**
     * 返回结果格式类型
     * 可选值：JSON
     */
    private String output;

    /**
     * 回调函数
     * callback 值是用户定义的函数名称，此参数只在 output 参数设置为 JSON 时有效。
     */
    private String callback;

    /**
     * 必须传入高德的Api key 以及目标地址
     * @param key Api的key
     * @param origin 起始位置 经度在前，纬度在后，经度和纬度用","分割，经纬度小数点后不得超过6位
     * @param destination 结束位置 经度在前，纬度在后，经度和纬度用","分割，经纬度小数点后不得超过6位
     */
    public PathPlanningRequest(String key, String origin, String destination) {
        this.key = key;
        this.origin = origin;
        this.destination = destination;
    }


}
