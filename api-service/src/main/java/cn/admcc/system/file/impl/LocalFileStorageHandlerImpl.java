package cn.admcc.system.file.impl;


import cn.admcc.config.StorageConfig;
import cn.admcc.storage.FileStorageHandlerI;
import cn.admcc.storage.FileTypeEnum;
import cn.admcc.system.file.dao.FileStorageRecordsMapper;
import cn.admcc.system.file.entity.FileStorageRecords;
import cn.admcc.system.file.exception.FileSystemException;
import cn.admcc.util.HttpServletResponseUtil;
import cn.hutool.core.io.*;
import cn.hutool.core.io.file.FileNameUtil;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.http.HttpStatus;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.function.Supplier;

/**
 * @author wck
 * @version 1.0.0
 * @Description
 * @createTime 2023年07月17日 21:14:00
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class LocalFileStorageHandlerImpl implements FileStorageHandlerI<String> {


    private final StorageConfig fileProperty;

    private final FileStorageRecordsMapper fileStorageRecordsMapper;


    @Override
    public File getFile(Long fileId) {
        FileStorageRecords fileStorageRecords = fileStorageRecordsMapper.selectById(fileId);
        if (Optional.ofNullable(fileStorageRecords).isEmpty()) {
            throw new FileSystemException("文件不存在");
        }
        return Paths.get(fileProperty.getLocalStorage(), fileStorageRecords.getFilePath()).toFile();
    }

    @Override
    public Long saveFile(InputStream inputStream, String fileName, Supplier<String> saveObject) {
        // 这里的saveObject 是一个存储地址
        String relationPath = saveObject.get();
        log.info("文件存储路径:{}", relationPath);
        String filePath = Paths.get(fileProperty.getLocalStorage(), relationPath).toString();
        // 如果文件夹不存在则创建文件夹
        Path path = Paths.get(filePath);
        if (!path.toFile().exists()) {
            if (path.toFile().mkdirs()) {
                log.info("创建文件夹成功");
            }
        }
        // 写入文件
        long fileNameId = IdUtil.getSnowflakeNextId();
        File file = new File(filePath, String.valueOf(fileNameId));
        try {
            FileUtil.writeFromStream(inputStream, file);
        } catch (IORuntimeException e) {
            log.error("文件写入失败", e);
            throw new RuntimeException(e);
        } finally {
            IoUtil.close(inputStream);
        }

        // 写入数据库
        long length = file.length();
        double mb = length / 1024.0 / 1024.0;
        FileStorageRecords build = FileStorageRecords.builder()
                .id(fileNameId)
                .fileName(String.valueOf(fileNameId))
                .filePath(relationPath + fileNameId)
                .fileSize(mb)
                .fileStorageType(getType())
                .uploadTime(LocalDateTime.now())
                .fileType(FileNameUtil.extName(fileName))
                .fileBaseName(FileNameUtil.getName(fileName))
                .build();
        try {
            fileStorageRecordsMapper.insert(build);
        } catch (Exception e) {
            FileUtil.del(file);
            log.error("文件写入数据库失败", e);
        }


        return fileNameId;
    }

    @Override
    public void downloadFile(Long fileId) {
        FileStorageRecords fileStorageRecords = fileStorageRecordsMapper.selectById(fileId);
        if (Optional.ofNullable(fileStorageRecords).isEmpty()) {
            throw new FileSystemException("文件不存在");
        }
        File file = Paths.get(fileProperty.getLocalStorage(), fileStorageRecords.getFilePath()).toFile();
        download(fileStorageRecords.getFileBaseName() + fileStorageRecords.getFileType(), file, false);
    }


    @Override
    public void downloadFile(String filePath, String fileName) {
        downloadFile(filePath, fileName, false);
    }

    @Override
    public void downloadFile(String filePath, String fileName, boolean isDelete) {
        File file = Paths.get(filePath).toFile();
        download(fileName, file, isDelete);
    }


    /**
     * 下载的核心方法
     *
     * @param fileName 文件名称
     * @param file     文件
     * @param isDelete 下载完成后是否删除文件
     */
    private void download(String fileName, File file, boolean isDelete) {
        HttpServletResponse response = HttpServletResponseUtil.getHttpServletResponse();
        try {
            // 设置response响应头
            response.reset();
            // 设置页面不缓存，清空buffer
            response.setCharacterEncoding(CharsetUtil.UTF_8);
            // 字符编码
            response.setContentType("application/octet-stream");
            response.addHeader("Access-Control-Allow-Origin", "*");
            response.addHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE");
            response.addHeader("Access-Control-Allow-Headers", "Content-Type");
            response.addHeader("Access-Control-Allow-Credentials", "true");
            // 设置响应头
            response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode(fileName, StandardCharsets.UTF_8));
            // 读取文件-输入流
            InputStream input = Files.newInputStream(file.toPath());
            // 写出文件-输出流
            OutputStream out = response.getOutputStream();
            IoUtil.copy(input, out, NioUtil.DEFAULT_BUFFER_SIZE, new StreamProgress() {
                @Override
                public void start() {
                    log.info("开始下载文件:{}", fileName);
                }

                @Override
                public void progress(long total, long progressSize) {
                }

                @Override
                public void finish() {
                    log.info("下载完成，是否删除文件：{}", isDelete);
                    if (isDelete) {

                        FileUtil.del(file);
                    }
                }
            });
            IoUtil.close(input);
            IoUtil.close(out);
        } catch (Exception e) {
            log.error("下载文件失败", e);
            response.setStatus(HttpStatus.HTTP_NOT_FOUND);
            if (isDelete) {
                FileUtil.del(file);
            }
            throw new FileSystemException("下载文件失败.", e);
        }
    }

    @Override
    public void deleteFile(Long fileId) {
        FileStorageRecords fileStorageRecords = new FileStorageRecords();
        fileStorageRecords.setId(fileId);
        fileStorageRecords.setOnDeleted(1);
        fileStorageRecordsMapper.updateById(fileStorageRecords);
    }

    @Override
    public void removeFile(List<Long> ids) {
        List<FileStorageRecords> fileStorageRecords = fileStorageRecordsMapper.selectList(new LambdaQueryWrapper<FileStorageRecords>().in(FileStorageRecords::getId, ids));
        if (Optional.ofNullable(fileStorageRecords).isEmpty()) {
            return;
        }
        for (FileStorageRecords fileStorageRecord : fileStorageRecords) {
            File file = Paths.get(fileProperty.getLocalStorage(), fileStorageRecord.getFilePath()).toFile();
            FileUtil.del(file);
        }
        fileStorageRecordsMapper.deleteByIds(ids);
    }


    @Override
    public void removeFile(Long fileId) {
        FileStorageRecords fileStorageRecords = fileStorageRecordsMapper.selectOne(new LambdaQueryWrapper<FileStorageRecords>().eq(FileStorageRecords::getId, fileId)
                .eq(FileStorageRecords::getOnDeleted, 0));
        if (Optional.ofNullable(fileStorageRecords).isEmpty()) {
            return;
        }
        File file = Paths.get(fileProperty.getLocalStorage(), fileStorageRecords.getFilePath()).toFile();
        FileUtil.del(file);
        fileStorageRecordsMapper.deleteById(fileId);
    }

    @Override
    public String getType() {
        return FileTypeEnum.LOCAL.name();
    }

    @Override
    public String getRootPath() {
        return fileProperty.getLocalStorage();
    }
}
