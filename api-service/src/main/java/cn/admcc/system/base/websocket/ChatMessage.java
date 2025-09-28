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
    /**
     * 全局唯一id,这个标识是前端发送过来的，每次刷新都将获取一个全系的id
     */
    private String onlyId;


    public ChatMessage(String content, String sender, LocalDateTime timestamp, String type) {
        this.content = content;
        this.sender = sender;
        this.timestamp = timestamp;
        this.type = type;
        this.onlyId = "-1L";
    }
}

