package cn.admcc.gaode.config;

import cn.admcc.gaode.api.GdApi;
import cn.admcc.util.JacksonUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.codec.json.Jackson2JsonEncoder;
import org.springframework.web.reactive.function.client.ExchangeStrategies;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;

import java.time.Duration;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 15:48
 */
@Slf4j
@Configuration
@RequiredArgsConstructor
public class ApiClientConfig {

    private final GdConfig gdConfig;


    @Bean
    public GdApi gdApi() {
        ObjectMapper snakeCaseOm = JacksonUtils.getSnakeCaseOm();

        // 实体解析
        ExchangeStrategies exchangeStrategies = ExchangeStrategies
                .builder()
                .codecs(configurer -> {
                    configurer.defaultCodecs().jackson2JsonEncoder(new Jackson2JsonEncoder(snakeCaseOm, MediaType.APPLICATION_JSON));
                }).build();
        final String domain = gdConfig.getBaseUrl();

        // 请求路径
        WebClientAdapter webClientAdapter = WebClientAdapter.create(
                WebClient.builder()
                        .baseUrl("%s/".formatted(domain))
                        .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                        .exchangeStrategies(exchangeStrategies)
                        .build()
        );
        // 超时
        webClientAdapter.setBlockTimeout(Duration.ofSeconds(60));
        var httpServiceProxyFactory = HttpServiceProxyFactory
                .builderFor(webClientAdapter)
                .build();

        log.info("高德API接口初始化成功");
        return httpServiceProxyFactory.createClient(GdApi.class);
    }

}
