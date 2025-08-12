package cn.admcc.util;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.BoundValueOperations;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.RedisScript;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.function.Consumer;
import java.util.function.Supplier;

/**
 * RedisUtil工具类，泛型 V 代表值的类型
 *
 * @author LNX
 * @date 2021/11/9 16:57
 */
@Component
@RequiredArgsConstructor
public class RedisUtil<V> {

    private final RedisTemplate<String, V> redisTemplate;

    /**
     * 数据检查，如果不存在执行supplier返回得结果
     *
     * @param key      redis Key
     * @param supplier 制造者
     */
    public V get(String key, Supplier<V> supplier) {
        return Optional.ofNullable(get(key)).orElse(supplier.get());
    }

    /**
     * 数据检查，如果不存在执行supplier得结果，且执行consumer
     *
     * @param key      redis Key
     * @param supplier 制造者
     * @param consumer 消费者
     */
    public V get(String key, Supplier<V> supplier, Consumer<V> consumer) {
        V v = get(key);
        if (Objects.isNull(v)) {
            V check = supplier.get();
            consumer.accept(check);
            return check;
        }
        return v;
    }

    /**
     * 根据key获取值
     *
     * @param key 键
     * @return 值
     */
    public V get(String key) {
        return key == null ? null : redisTemplate.opsForValue().get(key);
    }

    /**
     * 获得一个Optional包装之后的结果
     *
     * @param key 键
     * @return Optional 中对应的值，可能为空
     */
    public Optional<V> getOpt(String key) {
        return Optional.ofNullable(get(key));
    }

    /**
     * 获取分文件夹后的key数据
     *
     * @param key 例如：token:
     * @return 具体的key
     */
    public Set<String> keys(String key) {
        return redisTemplate.keys(key.concat("*"));
    }

    /**
     * 将值放入缓存并设置时间
     *
     * @param key      键
     * @param value    值
     * @param time     时间 -1为无期限
     * @param timeUnit 时间格式
     */
    public void set(String key, V value, long time, TimeUnit timeUnit) {
        redisTemplate.opsForValue().set(key, value, time, timeUnit);
    }

    /**
     * 将值放入缓存
     *
     * @param key   键
     * @param value 值
     */
    public void set(String key, V value) {
        redisTemplate.opsForValue().set(key, value);
    }

    /**
     * 批量添加 key (重复的键会覆盖)
     *
     * @param kvMap 键值map
     */
    public void batchSet(Map<String, V> kvMap) {
        redisTemplate.opsForValue().multiSet(kvMap);
    }


    /**
     * 批量添加 key-value 只有在键不存在时,才添加
     * map 中只要有一个key存在,则全部不添加
     *
     * @param kvMap 键值map
     */
    public void batchSetIfAbsent(Map<String, V> kvMap) {
        redisTemplate.opsForValue().multiSetIfAbsent(kvMap);
    }

    /**
     * 对一个 key-value 的值进行加减操作,
     * 如果该 key 不存在 将创建一个key 并赋值该 number
     * 如果 key 存在,但 value 不是长整型 ,将报错
     *
     * @param key    键
     * @param number Long
     */
    public Long increment(String key, Long number) {
        return redisTemplate.opsForValue().increment(key, number);
    }

    /**
     * 对一个 key-value 的值进行加减操作,
     * 如果该 key 不存在 将创建一个key 并赋值该 number
     * 如果 key 存在,但 value 不是长整型 ,将报错
     *
     * @param key    键
     * @param number Double
     */
    public Double increment(String key, Double number) {
        return redisTemplate.opsForValue().increment(key, number);
    }

    /**
     * 删除key
     *
     * @param key 键
     */
    public Boolean delete(String key) {
        return redisTemplate.delete(key);
    }

    /**
     * 删除key
     *
     * @param key 键
     */
    public Long multiDelete(String key) {
        Set<String> keys = redisTemplate.keys(key);
        if (CollectionUtils.isEmpty(keys)) {
            return 0L;
        }
        return redisTemplate.delete(keys);
    }

    /**
     * 批量删除
     *
     * @param keys 键的集合
     */
    public Long delete(Collection<String> keys) {
        return redisTemplate.delete(keys);
    }

    /**
     * 判断key是否存在
     *
     * @param key 键
     */
    public Boolean hasKey(String key) {
        return redisTemplate.hasKey(key);
    }

    /**
     * 设置Key的过期时间
     *
     * @param key      键
     * @param time     过期时间
     * @param timeUnit 时间单位
     */
    public Boolean expire(String key, Long time, TimeUnit timeUnit) {
        return redisTemplate.expire(key, time, timeUnit);
    }

    /**
     * 获取key的过期时间
     *
     * @param key 键
     * @return 过期时间，单位分钟
     */
    public Long getExpire(String key) {
        return redisTemplate.opsForValue().getOperations().getExpire(key);
    }

    /**
     * 执行action
     *
     * @param action 回调接口
     * @return V
     */
    public V execute(RedisCallback<V> action) {
        return redisTemplate.execute(action);
    }

    /**
     *  执行Script
     * @param script 脚本
     * @param keys key
     * @param args 参数
     * @return 执行后的结果
     * @param <T> 结果类型
     */
    public <T> T execute(RedisScript<T> script, List<String> keys, Object... args) {
        return redisTemplate.execute(script, keys, args);
    }

    public List<V> range(String key, long start, long end) {
        return redisTemplate.opsForList().range(key, start, end);
    }

    public Long leftPush(String key, V v) {
        return redisTemplate.opsForList().leftPush(key, v);
    }

    public BoundValueOperations<String, V> boundValueOps(String key) {
        return redisTemplate.boundValueOps(key);
    }

    /**
     * 多重获取
     *
     * @param keys key
     * @return {@link List}<{@link V}>
     */
    public List<V> multiGet(Collection<String> keys) {
        return redisTemplate.opsForValue().multiGet(keys);
    }


    /**
     * 设置list
     * @param key key
     * @param value 值
     */
    public void setList(String key,Collection<V> value,Long time, TimeUnit timeUnit){
        redisTemplate.opsForList().rightPushAll(key, value);
        this.expire(key,time,timeUnit);

    }



}
