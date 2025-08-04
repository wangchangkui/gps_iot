package cn.admcc.storage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.function.Supplier;

/**
 * @author wck
 * @version 1.0.0
 * @Description
 * @createTime 2023年07月17日 21:12:00
 */
public interface FileStorageHandlerI<T> {


    /**
     * 获取一个文件
     * @param fileId 文件id
     * @return 文件
     */
    File getFile(Long fileId);


    /**
     * 存储一个文件
     * @param inputStream 文件流
     * @param fileName 文件名称
     * @param saveObject 存储对象
     * @return 存储结果的文件id
     * @throws IOException io异常
     */
    Long  saveFile(InputStream inputStream, String fileName, Supplier<T> saveObject) throws IOException;

    /**
     * 下载文件
     * @param filePath 文件地址
     * @param fileName 下载文件名称
     */
    void downloadFile(String filePath, String fileName);


    /**
     * 下载完成后删除文件
     *
     * @param filePath 文件地址
     * @param fileName 下载文件名称
     * @param isDelete 是否删除
     */
    void downloadFile(String filePath, String fileName, boolean isDelete);
    /**
     * 下载文件
     * @param fileId 文件id
     */
    void downloadFile(Long fileId);
    /**
     * 删除文件
     *
     * @param fileId 文件id
     */
    void deleteFile(Long fileId);

    /**
     * 删除文件
     *
     * @param fileId 文件id
     */
    void removeFile(Long fileId);

    /**
     * 删除文件
     *
     * @param fileIds 文件id
     */
    void removeFile(List<Long> fileIds);

    /**
     * 返回存储文件类型
     *
     * @return 存储文件类型
     */
    String getType();

    /**
     * 获取根目录
     *
     * @return 根目录
     */
    String getRootPath();

}
