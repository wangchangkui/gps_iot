package cn.admcc.system.file.strategy;


import cn.admcc.config.StorageConfig;
import cn.admcc.storage.FileStorageHandlerI;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.EnvironmentAware;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @author wck
 * @version 1.0.0
 * @Description
 * @createTime 2023年07月18日 16:24:00
 */

@Component
public class FileStorageStrategy implements ApplicationContextAware {


    private final  Map<String, FileStorageHandlerI<?>> fileStorageHandlerMap = new HashMap<>(8);

    private   StorageConfig storageConfig;

    @Override
    @SuppressWarnings("all")
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        Map<String, FileStorageHandlerI> beansOfType = applicationContext.getBeansOfType(FileStorageHandlerI.class);
        beansOfType.forEach((k,v)->fileStorageHandlerMap.put(v.getType(),v));
        storageConfig = applicationContext.getBean(StorageConfig.class);

    }

    public FileStorageHandlerI<?> getFileStorageHandler(String type){
        return fileStorageHandlerMap.get(type);
    }


    public FileStorageHandlerI<?> getDefaultFileStorageHandler(){
        return fileStorageHandlerMap.get(storageConfig.getType());
    }

}
