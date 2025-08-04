package cn.admcc.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Objects;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 20:33
 */
public class HttpServletResponseUtil {

    /**
     * 从连接中获取Response 对象
     * @return HttpServletResponse
     */
    public static HttpServletResponse getHttpServletResponse(){
        return ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getResponse();
    }

    /**
     * HttpServletRequest 对象
     *
     * @return HttpServletRequest
     */
    public static HttpServletRequest getHttpServletRequest(){
        return ((ServletRequestAttributes) Objects.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
    }


    public static void setDownloadHeader(String fileName,Long size,HttpServletResponse response){
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, StandardCharsets.UTF_8) + ";filename*=utf-8''");
        response.setContentType("application/octet-stream");
        response.addHeader("Content-Length", "" + size);
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
    }

}
