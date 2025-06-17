/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-06-15 20:03:25
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-06-16 15:10:33
 * @FilePath: \gps_iost\iot\src\main\java\cn\admcc\gps\TxtZzEnums.java
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
package cn.admcc.gps.gp10;



/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:03
 */

public enum TxtZzEnums {
    /**
     * 参见 TXTGNSSInfo 下ZZ字段
     */
    ERROR_MESSAGE("01","错误信息"),
    WARN_MESSAGE("02","警告信息"),
    NOTICE_MESSAGE("03","通知消息"),
    USER_MESSAGE("04","用户消息"),
    ;
    private final String code;

    private final String infoText;

    TxtZzEnums(String code, String infoText) {
        this.code = code;
        this.infoText = infoText;
    }


    public static String getMessageByCode(String code){
        TxtZzEnums[] values = TxtZzEnums.values();
        for (TxtZzEnums value : values) {
            if(value.code.equals(code)){
                return value.infoText;
            }
        }
        return null;
    }
}
