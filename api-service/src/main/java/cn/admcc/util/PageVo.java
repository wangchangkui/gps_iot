package cn.admcc.util;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

import java.util.List;

/**
 * @author wck
 * @version 1.0.0
 * @Description
 * @createTime 2023年04月10日 11:54:00
 */
@Data
public class PageVo<T> {

    private List<T> records;
    private Long size;
    private Long total;
    private Long pages;
    private Long current;


    /**
     * 多封装一层 Page 对象有些参数不需要返给前端
     * @param responsePage page 对象
     * @return this
     * @param <T> Object
     */
    public static <T> PageVo<T> getPage(Page<T> responsePage) {
        PageVo<T> tPageVo = new PageVo<>();
        tPageVo.current = responsePage.getCurrent();
        tPageVo.records = responsePage.getRecords();
        tPageVo.pages = responsePage.getPages();
        tPageVo.size = responsePage.getSize();
        tPageVo.total = responsePage.getTotal();
        return tPageVo;
    }
}
