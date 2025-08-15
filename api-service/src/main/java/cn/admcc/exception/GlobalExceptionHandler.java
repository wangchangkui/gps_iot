package cn.admcc.exception;

import cn.admcc.gaode.exception.GdException;
import cn.admcc.system.base.exception.NoAuthException;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.util.R;

import jakarta.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * 全局异常处理器
 *
 * @author ruoyi
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {


    /**
     * 高德服务异常
     *
     * @param ex GdException GD
     * @return ResponseResult
     */
    @ExceptionHandler(value = GdException.class)
    public R<String> validationException(GdException ex) {
        log.error("高德服务存在异常", ex);
        setResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        return R.failed("高德服务异常！请联系管理员处理！"+ex.getMessage());
    }


    /**
     * 系统服务模块
     *
     * @param ex GdException GD
     * @return ResponseResult
     */
    @ExceptionHandler(value = SystemException.class)
    public R<String> validationException(SystemException ex) {
        setResponseStatus(HttpStatus.BAD_REQUEST);
        return R.failed(ex.getMessage());
    }

    @ExceptionHandler(value = NoAuthException.class)
    public R<String> validationException(NoAuthException ex) {
        setResponseStatus(HttpStatus.UNAUTHORIZED);
        return R.failed(ex.getMessage());
    }

    /**
     * 设置全局错误码
     */
    private void setResponseStatus(HttpStatus httpStatus) {
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes at = (ServletRequestAttributes) attributes;
        if (at != null) {
            HttpServletResponse resp = at.getResponse();
            if (resp != null){
                resp.setStatus(httpStatus.value());
            }
        }
    }


}
