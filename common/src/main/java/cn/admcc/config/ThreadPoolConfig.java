package cn.admcc.config;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

import java.util.concurrent.Executor;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 18:32
 */
@Configuration
@Data
@Slf4j
@ConfigurationProperties("thread")
public class ThreadPoolConfig {
    private Integer core;

    private Integer max;

    @Bean
    @Qualifier("defExecutor")
    public Executor customExecutor() {
        return new ThreadPoolExecutor(
                core,
                max,
                10,
                TimeUnit.SECONDS,
                new LinkedBlockingDeque<>(1000),
                new ThreadPoolExecutor.AbortPolicy());
    }


    @Bean("threadPoolTaskScheduler")
    public ThreadPoolTaskScheduler createSchedulerPool() {
        ThreadPoolTaskScheduler threadPoolTaskScheduler = new ThreadPoolTaskScheduler();
        threadPoolTaskScheduler.setPoolSize(core);
        threadPoolTaskScheduler.setThreadNamePrefix("cron_work_thread");
        threadPoolTaskScheduler.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
        threadPoolTaskScheduler.setWaitForTasksToCompleteOnShutdown(Boolean.TRUE);
        threadPoolTaskScheduler.setAwaitTerminationMillis(120);
        threadPoolTaskScheduler.setRemoveOnCancelPolicy(Boolean.TRUE);
        threadPoolTaskScheduler.setErrorHandler((th) -> log.error("定时任务出现问题", th));
        threadPoolTaskScheduler.initialize();
        return threadPoolTaskScheduler;
    }

    @Bean
    public TaskExecutor taskExecutor() {
        return createSchedulerPool();
    }
}

