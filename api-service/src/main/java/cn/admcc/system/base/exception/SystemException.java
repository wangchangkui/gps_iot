package cn.admcc.system.base.exception;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:58
 */

public class SystemException extends RuntimeException{
    public SystemException() {
    }

    public SystemException(String message) {
        super(message);
    }

    public SystemException(String message, Throwable cause) {
        super(message, cause);
    }

    public SystemException(Throwable cause) {
        super(cause);
    }

    public SystemException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
