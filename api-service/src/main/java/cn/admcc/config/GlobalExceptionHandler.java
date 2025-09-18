package cn.admcc.config;

import cn.admcc.gaode.exception.GdException;
import cn.admcc.system.base.exception.NoAuthException;
import cn.admcc.system.base.exception.SystemException;
import cn.admcc.util.R;

import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.exception.NotPermissionException;
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
     * 未登录验证
     * @param ex NotLoginException
     * @return String
     */
    @ExceptionHandler(value = NotLoginException.class)
    public R<String> validationNotLoginExceptionException(NotLoginException ex) {
        setResponseStatus(HttpStatus.UNAUTHORIZED);
        return R.failed("你没有登录，无法访问接口！"+ex.getMessage());
    }

    /**
     * 没有权限
     * @param ex NotLoginException
     * @return String
     */
    @ExceptionHandler(value = NotPermissionException.class)
    public R<String> validationNotPermissionException(NotPermissionException ex) {
        log.warn("没有权限：{}",ex.getMessage());
        setResponseStatus(HttpStatus.FORBIDDEN);
        return R.failed("你没有权限访问该接口，请联系管理员！");
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
