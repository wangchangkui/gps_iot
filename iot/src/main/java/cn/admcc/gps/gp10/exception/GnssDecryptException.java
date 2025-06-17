package cn.admcc.gps.gp10.exception;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 19:55
 */
public class GnssDecryptException extends RuntimeException{

    public GnssDecryptException() {
    }

    public GnssDecryptException(String message) {
        super(message);
    }

    public GnssDecryptException(String message, Throwable cause) {
        super(message, cause);
    }

    public GnssDecryptException(Throwable cause) {
        super(cause);
    }

    public GnssDecryptException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
