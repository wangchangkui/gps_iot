package cn.admcc;

import cn.admcc.gaode.service.PathPlanningServiceI;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:43
 */
@SpringBootTest(classes = ApplicationMain.class)
public class ApplicationMainTest {

    @Autowired
    private PathPlanningServiceI pathPlanningServiceI;


    @Test
    void test(){
        String start  = "104.107498,30.480487";
        String end = "104.086164,30.592694";

        Object o = pathPlanningServiceI.pathPlanning(start, end);
        System.out.println(o);


    }



}
