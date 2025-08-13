package cn.admcc.system.base.service.strategy;

import cn.admcc.config.StorageConfig;
import cn.admcc.storage.FileStorageHandlerI;
import cn.admcc.system.base.entity.dto.LoginUserDto;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 10:23
 */
@Component
public class LoginStrategy  implements ApplicationContextAware {


    private final Map<String, AbstractLoginHandler> strategyMap = new HashMap<>(8);

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        Map<String, AbstractLoginHandler> beansOfType = applicationContext.getBeansOfType(AbstractLoginHandler.class);
        beansOfType.forEach((k,v)->strategyMap.put(v.getType(),v));
    }


    public Object login(LoginUserDto loginUserDto){
        AbstractLoginHandler abstractLoginHandler = this.strategyMap.get(loginUserDto.getType());
        return abstractLoginHandler.loginUser(loginUserDto);
    }
}
