package cn.admcc.util;

import jakarta.annotation.Resource;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 17:04
 */
@Component
public class EmailUtil {

    @Getter
    @Setter
    @Value("${spring.mail.username}")
    private String email;

    @Resource
    private JavaMailSender mailSender;

    public void sendEmail(String htmlContent,String toEmail, String subject){

        // 创建 MIME 邮件
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper;
        try {
            helper = new MimeMessageHelper(message, true, StandardCharsets.UTF_8.displayName());
            helper.setTo(toEmail);
            helper.setFrom(email);
            helper.setSubject(subject);
            helper.setText(htmlContent, true);
            mailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }


    }
}


