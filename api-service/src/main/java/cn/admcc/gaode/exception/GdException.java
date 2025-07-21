package cn.admcc.gaode.exception;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:30
 */
public class GdException extends RuntimeException{
    public GdException(String message) {
        super(message);
    }

    public GdException() {
    }

    public GdException(String message, Throwable cause) {
        super(message, cause);
    }

    public GdException(Throwable cause) {
        super(cause);
    }

    public GdException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
