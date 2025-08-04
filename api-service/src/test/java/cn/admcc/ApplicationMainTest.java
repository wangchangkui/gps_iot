package cn.admcc;

import cn.admcc.gaode.service.PathPlanningServiceI;
import cn.admcc.util.RsaUtil;
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

    @Autowired
    private RsaUtil rsaUtil;


    @Test
    void test(){
        String start  = "104.107498,30.480487";
        try {
            String encrypt = rsaUtil.encrypt(start);
            System.out.println(encrypt);
            String decrypt = rsaUtil.decrypt(encrypt);
            System.out.println(decrypt);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }


    }



}
