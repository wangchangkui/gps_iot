package cn.admcc.util;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

/**
 * 响应信息主体
 *
 * @author tianyuheng
 */
@Data
@NoArgsConstructor
public class R<T> implements Serializable {
    @Serial
    private static final long serialVersionUID = 911052339912237900L;

    public static final int SUCCESS_CODE = 10000;

    public static final int FAIL_CODE = 500;


    public static final String SUCCESS_MESSAGE = "success";

    /**
     * 响应码
     */
    private Integer code;

    /**
     * 消息
     */
    private String message;

    /**
     * 数据
     */
    private T data;

    public static <Void> R<Void> success() {
        return restResult(SUCCESS_CODE, SUCCESS_MESSAGE, null);
    }

    public static <T> R<T> success(T data) {
        return restResult(SUCCESS_CODE, SUCCESS_MESSAGE, data);
    }


    public static <T> R<T> successByData(T data) {
        return restResult(SUCCESS_CODE, SUCCESS_MESSAGE, data);
    }

    public static <T> R<T> success(String message) {
        return restResult(SUCCESS_CODE, message, null);
    }


    public static <Void> R<Void> failed(String message) {
        return failed(message, null);
    }



    public static <T> R<T> failed(String message, T data) {
        return restResult(FAIL_CODE, message, data);
    }

    @JsonIgnore
    public boolean isSuccessful() {
        return SUCCESS_CODE == this.code;
    }

    private static <T> R<T> restResult(Integer code, String message, T data) {
        R<T> r = new R<>();
        r.setCode(code);
        r.setMessage(message);
        r.setData(data);
        return r;
    }
}
