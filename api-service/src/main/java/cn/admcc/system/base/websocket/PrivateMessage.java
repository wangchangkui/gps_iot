package cn.admcc.system.base.websocket;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @author wck
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PrivateMessage {
    private String content;
    private String sender;
    private String recipient;
    private LocalDateTime timestamp;
}
