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
public class ChatMessage {
    private String content;
    private String sender;
    private LocalDateTime timestamp;
    private String type;


}

