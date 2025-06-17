package cn.admcc.gps.gp10.utils;

import java.lang.annotation.*;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 22:02
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD, ElementType.ANNOTATION_TYPE})
public @interface DataIndex {

    int order() default -1;

    int or() default  -1;

    int[] range() default {};
}
