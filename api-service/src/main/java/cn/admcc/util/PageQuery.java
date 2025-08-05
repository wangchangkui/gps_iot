package cn.admcc.util;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

/**
 * @author wck
 * @version 1.0.0
 * @Description
 * @createTime 2023年04月10日 11:27:00
 */
@Data
public class PageQuery<T, M> {

    private T query;

    private Page<M> page;

}
