package cn.admcc.system.file.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @author wck
 * @version 1.0.0
 * @Description
 * @createTime 2023年07月17日 21:48:00
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName("file_storage_records")
public class FileStorageRecords {

    @TableId("id")
    private Long id;

    @TableField("file_name")
    private String fileName;

    @TableField("file_type")
    private String fileType;

    @TableField("file_size")
    private Double fileSize;

    @TableField("file_path")
    private String filePath;

    @TableField("on_deleted")
    private Integer onDeleted;

    @TableField("upload_time")
    private LocalDateTime uploadTime;

    @TableField("file_storage_type")
    private String fileStorageType;

    @TableField("file_base_name")
    private String fileBaseName;

}
