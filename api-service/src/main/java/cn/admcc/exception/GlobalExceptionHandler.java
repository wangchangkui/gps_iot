package cn.admcc.exception;

import cn.admcc.gaode.exception.GdException;
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
        setResponseStatus();
        return R.failed("高德服务异常！请联系管理员处理！"+ex.getMessage());
    }


    /**
     * 设置全局错误码
     */
    private void setResponseStatus() {
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        ServletRequestAttributes at = (ServletRequestAttributes) attributes;
        if (at != null) {
            HttpServletResponse resp = at.getResponse();
            if (resp != null){
                resp.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            }
        }
    }


}
