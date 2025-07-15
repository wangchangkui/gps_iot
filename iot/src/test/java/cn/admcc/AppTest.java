package cn.admcc;

import cn.admcc.gps.gp10.entity.RMCGNSSInfo;
import cn.admcc.gps.gp10.decrypt.GNRMCDecrypt;
import cn.admcc.gps.gp10.exception.TxtInfoException;
import junit.framework.TestCase;

import java.lang.reflect.InvocationTargetException;

/**
 * Unit test for simple App.
 */
public class AppTest extends TestCase {


    public void test(){
//        new TcpServerUtil().randomPortServer();
    }

  
    /**
     * Rigourous Test :-)
     */
    public void testApp() throws TxtInfoException, InvocationTargetException, IllegalAccessException, NoSuchMethodException, InstantiationException {
        String code = "$GNRMC,114953.000,A,3028.01359,N,10406.49962,E,0.00,0.00,150625,,,A,V*00*42";
        GNRMCDecrypt gnrmcDecrypt = new GNRMCDecrypt();
        RMCGNSSInfo decrypt = gnrmcDecrypt.decryptData(code, "1L");
        System.out.println(decrypt);
    }
}
