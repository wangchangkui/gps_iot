package cn.admcc.gps.gp10.exception;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:11
 */
public class TxtInfoException extends RuntimeException{
    public TxtInfoException(String message) {
        super(message);
    }

    public TxtInfoException(String message, Throwable cause) {
        super(message, cause);
    }
}
