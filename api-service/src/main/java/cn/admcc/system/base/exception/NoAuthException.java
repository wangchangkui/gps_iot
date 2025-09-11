package cn.admcc.system.base.exception;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 10:32
 */

public class NoAuthException extends RuntimeException{
    public NoAuthException() {
    }

    public NoAuthException(String message) {
        super(message);
    }

    public NoAuthException(String message, Throwable cause) {
        super(message, cause);
    }

    public NoAuthException(Throwable cause) {
        super(cause);
    }

    public NoAuthException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
