
package cn.admcc.device.controller;

import cn.admcc.device.entity.dto.IotGpsData;
import cn.admcc.gp10.service.DeviceTempDataServiceI;
import cn.admcc.util.R;
import org.springframework.web.bind.annotation.*;


/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 18:47
 */
@RestController
@RequestMapping("/data")
public class DataController {


    private final DeviceTempDataServiceI deviceTempDataServiceI;

    public DataController(DeviceTempDataServiceI deviceTempDataServiceI) {
        this.deviceTempDataServiceI = deviceTempDataServiceI;
    }

    @PostMapping("/upload")
    public R<String> upload(@RequestBody IotGpsData data) {
        deviceTempDataServiceI.addData(data);
        return R.success();
    }
}
