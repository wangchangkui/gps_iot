
package cn.admcc.gps.gp10.utils;


import cn.admcc.gps.gp10.exception.TxtInfoException;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:06
 */
@Slf4j
public class DataOrderIndexUtil {

    public static void setValue(String gpsCode, Object targetValue) throws TxtInfoException, IllegalAccessException, NoSuchMethodException, InvocationTargetException, InstantiationException {
        String[] split = gpsCode.split(",");
        Class<?> targetValueClass = targetValue.getClass();
        Field[] declaredFields = targetValueClass.getDeclaredFields();
        for (Field field : declaredFields) {
            field.setAccessible(true);
            if (field.isAnnotationPresent(DataIndex.class)) {
                DataIndex order = field.getAnnotation(DataIndex.class);
                // 如果使用区间模式，则order 是 -1
                if (order.range().length < 1 && order.order() == -1) {
                    throw new TxtInfoException("使用范围需要传入区间，例如[2,4]");
                }
                // 如果使用order 模式则 不能为-1
                if (order.order() != -1) {
                    String orders;
                    try{
                        orders = split[order.order()];
                    }catch (ArrayIndexOutOfBoundsException e){
                        try{
                            orders = split[order.or()];
                        }catch (ArrayIndexOutOfBoundsException e1){
                            throw new TxtInfoException("无效的数据，从"+gpsCode+"中无法获取指定序列号的数据，序列号"+order.order()+","+order.or());
                        }
                    }
                    if (!StrUtil.isEmpty(orders)) {
                        ReflectUtil.setFieldValue(targetValue, field, orders);
                    }
                } else {
                    // 区间模式
                    int[] range = order.range();
                    if (range.length == 2 && range[0] != -1 && range[1] != -1 && range[0] != range[1]) {
                        int start = range[0];
                        // 防止越界
                        int end = Math.min(range[1], split.length - 1);
                        if(end == split.length-1){
                            end -- ;
                        }
                        List<String> groupData = new ArrayList<>(Arrays.asList(split).subList(start, end + 1));
                        // 获取List的泛型类型
                        ParameterizedType pt = (ParameterizedType) field.getGenericType();
                        Class<?> genericType = (Class<?>) pt.getActualTypeArguments()[0];
                        if (genericType == Integer.class) {
                            // List<Integer>
                            List<Integer> intList = new ArrayList<>();
                            for (String s : groupData) {
                                if (StrUtil.isNotEmpty(s)) {
                                    try {
                                        intList.add(Integer.parseInt(s));
                                    } catch (NumberFormatException e) {
                                        log.info("无法转换为Integer ,{}",s);
                                    }
                                }
                            }
                            field.set(targetValue, intList);
                        } else if (genericType == String.class) {
                            // List<String>
                            field.set(targetValue, groupData);
                        } else {
                            // 其他对象类型，按原有分组逻辑
                            int groupCount = (int) Math.ceil(groupData.size() / 4.0);
                            List<Object> satelliteList = new ArrayList<>();
                            for (int i = 0; i < groupCount; i++) {
                                Object satelliteInfo = genericType.getDeclaredConstructor().newInstance();
                                for (int j = 0; j < 4; j++) {
                                    int dataIndex = i * 4 + j;
                                    String value = dataIndex < groupData.size() ? groupData.get(dataIndex) : "";
                                    for (Field sf : genericType.getDeclaredFields()) {
                                        if (sf.isAnnotationPresent(DataIndex.class)) {
                                            DataIndex sfOrder = sf.getAnnotation(DataIndex.class);
                                            if (sfOrder.order() == j) {
                                                sf.setAccessible(true);
                                                sf.set(satelliteInfo, value);
                                            }
                                        }
                                    }
                                }
                                satelliteList.add(satelliteInfo);
                            }
                            field.set(targetValue, satelliteList);
                        }
                    }

                }
            }
        }
    }

}
