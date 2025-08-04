package cn.admcc.storage;

import cn.hutool.core.io.FileUtil;
import lombok.Data;

import java.io.File;
import java.nio.file.Paths;

/**
 * @author wck
 * @version 1.0.0
 * @Description
 * @createTime 2023年07月24日 14:37:00
 */
@Data
public class LocalStorageEntity {

    /**
     * 文件名
     */
    private Long fileName;

    /**
     * 相对地址
     */
    private String relPath;

    /**
     * 绝对地址
     */
    private String absPath;

    /**
     * 文件夹
     */
    private String dir;

    /**
     * 绝对文件夹
     */
    private String absDir;


    public LocalStorageEntity(Long fileName, String root, String dir) {
        this.fileName = fileName;
        this.relPath = Paths.get(dir, String.valueOf(fileName)).toString();
        this.absPath = Paths.get(root, relPath).toString();
        this.dir = dir;
        this.absDir = Paths.get(root, dir).toString();
        FileUtil.mkdir(absDir);
    }

    public File getFile() {
        return new File(absPath);
    }


    public boolean exits() {
        return FileUtil.exist(absPath);
    }

}
