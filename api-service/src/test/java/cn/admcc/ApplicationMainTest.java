package cn.admcc;

import cn.admcc.system.base.dao.SysPermissionsDao;
import cn.admcc.system.base.dao.SysUserDao;
import cn.admcc.system.base.entity.SysPermissions;
import cn.admcc.system.base.entity.SysUser;
import cn.admcc.system.base.websocket.ChatMessage;
import cn.admcc.system.base.websocket.MessageConstant;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.converter.SimpleMessageConverter;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import java.time.LocalDateTime;
import java.util.*;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 16:43
 */
@SpringBootTest(classes = ApplicationMain.class)
public class ApplicationMainTest {


    @Autowired
    private SysUserDao sysUserDao;

    @Autowired
    private  SimpMessagingTemplate messagingTemplate;

    @Autowired
    private SysPermissionsDao sysPermissionsDao;


    @Test
    void test02(){
        ChatMessage welcome = new ChatMessage();
        welcome.setContent("Hello ！");
        welcome.setSender("系统");
        welcome.setTimestamp(LocalDateTime.now());
        messagingTemplate.convertAndSend(MessageConstant.APP+MessageConstant.HOME_HALL,welcome);
    }

    @Test
    void test(){
        SysUser admin = sysUserDao.getUserInfoAndRulers("admin");
        List<SysPermissions> userAllPermissions = sysPermissionsDao.getUserAllPermissions(admin.getId());
        List<SysPermissions> sysPermissions = buildPermissionTree(userAllPermissions);
        System.out.println(sysPermissions);

    }


    /**
     * 构建权限树结构
     * @param permissions 平铺权限列表
     * @return 树形结构
     */
    private List<SysPermissions> buildPermissionTree(List<SysPermissions> permissions) {
        // 创建ID到权限节点的映射
        Map<Long, SysPermissions> permissionMap = new HashMap<>();
        List<SysPermissions> rootNodes = new ArrayList<>();

        // 第一遍遍历：初始化所有节点
        for (SysPermissions perm : permissions) {
            perm.setChildren(new ArrayList<>()); // 初始化子节点列表
            permissionMap.put(perm.getPermissionId(), perm);
        }

        // 第二遍遍历：建立父子关系
        for (SysPermissions perm : permissions) {
            Long parentId = perm.getParentId();
            if (parentId != null && parentId > 0) {
                SysPermissions parent = permissionMap.get(parentId);
                if (parent != null) {
                    parent.getChildren().add(perm);
                    // 保持子节点排序
                    parent.getChildren().sort(Comparator.comparingInt(SysPermissions::getSortOrder));
                }
            } else {
                rootNodes.add(perm);
            }
        }

        // 根节点排序
        rootNodes.sort(Comparator.comparingInt(SysPermissions::getSortOrder));
        return rootNodes;
    }
}
