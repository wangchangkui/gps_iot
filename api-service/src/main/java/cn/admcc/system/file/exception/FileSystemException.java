package cn.admcc.system.file.exception;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:32
 */
public class FileSystemException extends RuntimeException{

    public FileSystemException() {
    }

    public FileSystemException(String message) {
        super(message);
    }

    public FileSystemException(String message, Throwable cause) {
        super(message, cause);
    }

    public FileSystemException(Throwable cause) {
        super(cause);
    }

    public FileSystemException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
