<template>
    <div class="role-container">
        <el-card>
            <template #header>
                <div class="card-header">
                    <span class="header-title">角色管理</span>
                    <el-button type="primary" @click="handleAddRole">新增角色</el-button>
                </div>
            </template>

            <div class="role-content">
                <!-- 左侧角色列表 -->
                <div class="role-list-container">
                    <!-- 搜索框 -->
                    <div class="search-container">
                        <el-input v-model="searchKeyword" placeholder="请输入角色名称进行搜索" clearable
                            @keyup.enter="handleSearch" style="width: 300px; margin-right: 10px">
                            <template #prefix>
                                <el-icon>
                                    <Search />
                                </el-icon>
                            </template>
                        </el-input>
                        <el-button type="primary" @click="handleSearch" :loading="searchLoading">
                            <el-icon>
                                <Search />
                            </el-icon>
                            搜索
                        </el-button>
                        <el-button @click="handleReset" style="margin-left: 8px">
                            <el-icon>
                                <Refresh />
                            </el-icon>
                            重置
                        </el-button>
                    </div>

                    <el-table :data="paginatedRoleList" stripe style="width: 100%">
                        <el-table-column prop="roleName" label="角色名称" width="150" />
                        <el-table-column prop="roleCode" label="角色编码" width="150" />
                        <el-table-column prop="description" label="描述" show-overflow-tooltip />
                    
                        <el-table-column label="操作" width="150" fixed="right">
                            <template #default="{ row }">
                                <el-button type="primary" link size="small" @click.stop="handleEditRole(row)">
                                    编辑
                                </el-button>
                                <el-button type="danger" link size="small" @click.stop="handleDeleteRole(row)">
                                    删除
                                </el-button>
                            </template>
                        </el-table-column>
                    </el-table>

                    <!-- 分页组件 -->
                    <div class="pagination-container">
                        <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize"
                            :page-sizes="[5, 10, 20, 50]" :total="filteredRoleList.length"
                            layout="total, sizes, prev, pager, next, jumper" @size-change="handleSizeChange"
                            @current-change="handleCurrentChange" />
                    </div>
                </div>

            </div>
         </el-card>


         <!-- 添加/编辑角色对话框 -->
        <el-dialog v-model="roleDialogVisible" :title="roleDialogTitle" width="500px" @close="handleRoleDialogClose">
            <el-form ref="roleFormRef" :model="roleFormData" :rules="roleFormRules" label-width="100px">
                <el-form-item label="角色名称" prop="roleName">
                    <el-input v-model="roleFormData.roleName" placeholder="请输入角色名称" />
                </el-form-item>
                <el-form-item label="角色编码" prop="roleCode">
                    <el-input v-model="roleFormData.roleCode" placeholder="请输入角色编码，如：admin" />
                </el-form-item>
                <el-form-item label="描述" prop="description">
                    <el-input v-model="roleFormData.description" type="textarea" :rows="3" placeholder="请输入角色描述" />
                </el-form-item>
                <el-form-item label="权限设置">
                    <div class="permission-selection">
                        <div class="permission-actions">
                   
                
                            <el-button type="success" size="small" @click="handleRoleFormSelectAll">全选</el-button>
                            <el-button size="small" @click="handleRoleFormUnselectAll">取消全选</el-button>
                        </div>
                        <div class="permission-tree-container">
                            <el-tree
                                ref="roleFormPermissionTreeRef"
                                :data="menuTree"
                                :props="treeProps"
                                node-key="permissionId"
                                show-checkbox
                                :default-checked-keys="roleFormSelectedPermissions"
                                :default-expand-all="false"
                                @check="handleRoleFormPermissionCheck"
                                class="role-form-permission-tree"
                            >
                                <template #default="{ node, data }">
                                    <div class="tree-node">
                                        <div class="node-content">
                                            <span class="node-icon">{{ data.permType === 'MENU' ? '📁' : '🔗' }}</span>
                                            <span class="node-title">{{ data.permName }}</span>
                                            <el-tag v-if="data.permType === 'API'" size="small" type="info">API</el-tag>
                                            <el-tag v-if="data.isHidden" size="small" type="warning">隐藏</el-tag>
                                        </div>
                                    </div>
                                </template>
                            </el-tree>
                        </div>
                    </div>
                </el-form-item>
               
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="roleDialogVisible = false">取消</el-button>
                    <el-button type="primary" @click="handleRoleSubmit">确定</el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed, nextTick } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import { Search } from '@element-plus/icons-vue'
import ElMessage from 'element-plus/es/components/message/index'
import ElMessageBox from 'element-plus/es/components/message-box/index'
import { Permissions } from '../../utils/api/user/Permissions'
import { RoleType } from '../../utils/api/role/roleType'
import { PageQuery } from '../../utils/PageQuery'
 import { MenuApi } from '../../utils/api/menu/menuApi'

// 响应式数据
const allRoleList = ref<RoleType[]>([]) // 所有角色数据
const roleList = ref<RoleType[]>([]) // 当前显示的角色列表
const filteredRoleList = ref<RoleType[]>([]) // 过滤后的角色列表
const menuTree = ref<Permissions[]>([])
const roleDialogVisible = ref(false)
const isEditRole = ref(false)
const roleFormRef = ref<FormInstance>()

// 搜索和分页相关数据
const searchKeyword = ref('')
const currentPage = ref(1)
const pageSize = ref(10)
const searchLoading = ref(false)


// 角色表单权限选择相关
const roleFormSelectedPermissions = ref<string[]>([])
const roleFormPermissionTreeRef = ref()


// 树形组件配置
const treeProps = {
    children: 'children',
    label: 'permName'
}

// 角色表单数据
const roleFormData = reactive({
    id: '',
    roleName: '',
    roleCode: '',
    description: '',
    status: 1,
    permissions: [] as { permissionId: string }[]
})

// 角色表单验证规则
const roleFormRules: FormRules = {
    roleName: [
        { required: true, message: '请输入角色名称', trigger: 'blur' }
    ],
    roleCode: [
        { required: true, message: '请输入角色编码', trigger: 'blur' },
        { pattern: /^[a-zA-Z][a-zA-Z0-9_]*$/, message: '角色编码格式不正确', trigger: 'blur' }
    ],
    status: [
        { required: true, message: '请选择状态', trigger: 'change' }
    ]
}

// 计算属性
const roleDialogTitle = computed(() => isEditRole.value ? '编辑角色' : '新增角色')

// 分页后的角色列表
const paginatedRoleList = computed(() => {
    const start = (currentPage.value - 1) * pageSize.value
    const end = start + pageSize.value
    return filteredRoleList.value.slice(start, end)
})

// 初始化数据
onMounted(() => {
    loadRoleList()
    loadMenuTree()
})

// 加载角色列表（测试数据）
const loadRoleList = async () => {

    // 从后端请求数据
    const { RoleApi } = await import('../../utils/api/role/RoleApi')
    const response = await RoleApi.getRoleList(new RoleType(), new PageQuery(currentPage.value, pageSize.value))
    if (response.code === 10000 && response.data) {
        allRoleList.value = response.data.records
        // 处理分页
        currentPage.value = response.data.current
        pageSize.value = response.data.size
    }

    // 初始化时显示所有数据
    filteredRoleList.value = [...allRoleList.value]
    roleList.value = [...allRoleList.value]

}


// 分页大小改变
const handleSizeChange = (val: number) => {
    pageSize.value = val
    currentPage.value = 1
    loadRoleList()
}

// 当前页改变
const handleCurrentChange = (val: number) => {
    currentPage.value = val
    loadRoleList()
}

// 加载菜单树
const loadMenuTree = async () => {
   
    const response = await MenuApi.getMenuTree()
    if (response.code === 10000 && response.data) {
        menuTree.value = response.data
    }
    
}





// 处理搜索
const handleSearch = async () => {
    if (!searchKeyword.value.trim()) {
        ElMessage.warning('请输入搜索关键词')
        return
    }
    try {
        searchLoading.value = true
        const { RoleApi } = await import('../../utils/api/role/RoleApi')
        const roleType = new RoleType();
        roleType.roleName = searchKeyword.value
        const response = await RoleApi.getRoleList(roleType, new PageQuery(currentPage.value, pageSize.value))
        if (response.code === 10000 && response.data) {
            allRoleList.value = response.data.records
            // 处理分页
            currentPage.value = response.data.current
            pageSize.value = response.data.size
            roleList.value = response.data.records
            filteredRoleList.value = response.data.records
            ElMessage.success(`找到 ${response.data.records.length} 个角色`)  
        }
    } catch (error) {
        ElMessage.error('搜索失败')
    } finally {
        searchLoading.value = false
    }
}

// 处理重置
const handleReset = () => {
    searchKeyword.value = ''
    loadRoleList()
}


// 新增角色
const handleAddRole = async () => {
    resetRoleForm()
    isEditRole.value = false
    roleDialogVisible.value = true
    // 确保对话框和树组件完全渲染后再进行操作
    await nextTick()
    setTimeout(() => {
        console.log('对话框已打开，权限树引用:', roleFormPermissionTreeRef.value)
    }, 100)
}

// 编辑角色
const handleEditRole = async (role: RoleType) => {
    resetRoleForm()
    Object.assign(roleFormData, {
        roleId: role.id,
        roleName: role.roleName,
        roleCode: role.roleCode,
        description: role.description,
    })
    roleFormData.id = role.id
    isEditRole.value = true
    roleDialogVisible.value = true
    console.log('编辑角色:', role)
    // 加载角色的权限信息
    await loadRolePermissions(role.id)
    
    // 确保对话框和树组件完全渲染后再进行操作
    await nextTick()
    setTimeout(() => {
        console.log('编辑对话框已打开，权限树引用:', roleFormPermissionTreeRef.value)
    }, 100)
}

// 从嵌套的权限数据中提取所有权限ID（只提取叶子节点，避免级联选择问题）
const extractPermissionIds = (permissions: any[]): string[] => {
    const ids: string[] = []
    
    const extractFromPermission = (permission: any) => {
        // 只提取没有子节点的权限（叶子节点）
        if (permission.permissionId && (!permission.children || permission.children.length === 0)) {
            ids.push(permission.permissionId.toString())
        }
        if (permission.children && Array.isArray(permission.children)) {
            permission.children.forEach(extractFromPermission)
        }
    }
    
    permissions.forEach(extractFromPermission)
    return ids
}

// 加载角色权限
const loadRolePermissions = async (roleId: string) => {
    try {
        const { RoleApi } = await import('../../utils/api/role/RoleApi')
        const response = await RoleApi.getRolePermissions(roleId)
        if (response.code === 10000 && response.data) {
            console.log('角色权限数据:', response.data)
            
            // 从嵌套的权限数据中提取所有权限ID
            const permissionIds = extractPermissionIds((response.data as any).permissions || [])
            console.log('提取的权限ID:', permissionIds)
            
            // 设置选中的权限
            roleFormSelectedPermissions.value = permissionIds
            
            // 设置权限树的选中状态
            await nextTick()
            setTimeout(() => {
                const tree = roleFormPermissionTreeRef.value
                if (tree && typeof tree.setCheckedKeys === 'function') {
                    console.log('设置权限树选中状态:', permissionIds)
                    tree.setCheckedKeys(permissionIds)
                } else {
                    console.error('权限树引用无效或setCheckedKeys方法不存在')
                }
            }, 200)
        }
    } catch (error) {
        console.error('加载角色权限失败:', error)
        ElMessage.warning('加载角色权限失败')
    }
}

// 删除角色
const handleDeleteRole = async (role: RoleType) => {
    ElMessageBox.confirm(
        `确定要删除角色"${role.roleName}"吗？删除后不可恢复！`,
        '确认删除',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }
    ).then(async () => {
        // 模拟删除操作
        const { RoleApi } = await import('../../utils/api/role/RoleApi')
        const response = await RoleApi.deleteRole(role.id)
        if (response.code === 10000) {
            ElMessage.success('删除成功')
            loadRoleList()
        } else {
            ElMessage.error(response.message || '删除失败')
        }
    }).catch(() => {
        // 用户取消删除
    })
}

// 提交角色表单
const handleRoleSubmit = async () => {
    if (!roleFormRef.value) return

    try {
        await roleFormRef.value.validate((valid, fields) => {
            if (!valid) {
                throw new Error('表单验证失败')
            }
        })

        if (isEditRole.value) {
            // 编辑角色
            // 构建权限数据
            const permissions = roleFormSelectedPermissions.value.map(permissionId => ({
                permissionId: permissionId
            }))
            
            // 构建提交数据
            const roleType = new RoleType();
            roleType.id = roleFormData.id
            roleType.roleName = roleFormData.roleName
            roleType.roleCode = roleFormData.roleCode
            roleType.description = roleFormData.description
            roleType.permissions = permissions.map(p => {
                const perm = new Permissions()
                perm.permissionId = p.permissionId
                return perm
            })

            const { RoleApi } = await import('../../utils/api/role/RoleApi')

            const response = await RoleApi.updateRole(roleType)
            if (response.code === 10000) {
                // 刷新
                loadRoleList()
                ElMessage.success('编辑成功')
            } else {
                ElMessage.error(response.message || '编辑失败')
            }
        } else {
            // 新增角色
            // 构建权限数据
            const permissions = roleFormSelectedPermissions.value.map(permissionId => ({
                permissionId: permissionId
            }))
            
            // 构建提交数据
            const roleType = new RoleType();
            roleType.roleName = roleFormData.roleName
            roleType.roleCode = roleFormData.roleCode
            roleType.description = roleFormData.description
            roleType.permissions = permissions.map(p => {
                const perm = new Permissions()
                perm.permissionId = p.permissionId
                return perm
            })

            const { RoleApi } = await import('../../utils/api/role/RoleApi')

            const response = await RoleApi.createRole(roleType)
            if (response.code === 10000) {
                // 刷新角色列表
                loadRoleList()

                ElMessage.success('新增成功')
            } else {
                ElMessage.error('新增失败')
            }
           
        }

        roleDialogVisible.value = false
    } catch (error) {
        console.error('提交角色失败:', error)
    }
}

// 重置角色表单
const resetRoleForm = () => {
    Object.assign(roleFormData, {
        roleId: '',
        roleName: '',
        roleCode: '',
        description: '',
        status: 1,
        permissions: []
    })
    // 重置权限选择
    roleFormSelectedPermissions.value = []
    // 重置权限树选中状态
    if (roleFormPermissionTreeRef.value) {
        roleFormPermissionTreeRef.value.setCheckedKeys([])
    }
}

// 关闭角色对话框
const handleRoleDialogClose = () => {
    resetRoleForm()
}


// 获取所有节点键值
const getAllNodeKeys = (nodes: Permissions[]): string[] => {
    let keys: string[] = []
    nodes.forEach(node => {
        keys.push(node.permissionId)
        if (node.children && node.children.length > 0) {
            keys = keys.concat(getAllNodeKeys(node.children))
        }
    })
    console.log('获取到的所有节点键值:', keys)
    return keys
}



const handleRoleFormSelectAll = async () => {
    await nextTick()
    const tree = roleFormPermissionTreeRef.value
    if (tree && typeof tree.setCheckedKeys === 'function') {
        const allKeys = getAllNodeKeys(menuTree.value)
        console.log('全选所有节点:', allKeys)
        
        // 使用智能级联选择，只选择根节点，让级联逻辑自动处理子节点
        const rootKeys = menuTree.value.map(node => node.permissionId.toString())
        tree.setCheckedKeys(rootKeys)
        roleFormSelectedPermissions.value = allKeys
    } else {
        console.error('权限树引用无效或setCheckedKeys方法不存在')
        ElMessage.warning('权限树未正确初始化，请稍后再试')
    }
}

const handleRoleFormUnselectAll = async () => {
    await nextTick()
    const tree = roleFormPermissionTreeRef.value
    if (tree && typeof tree.setCheckedKeys === 'function') {
        tree.setCheckedKeys([])
        roleFormSelectedPermissions.value = []
    } else {
        console.error('权限树引用无效或setCheckedKeys方法不存在')
        ElMessage.warning('权限树未正确初始化，请稍后再试')
    }
}

// 获取节点的所有子节点ID
const getAllChildIds = (node: any, allNodes: any[]): string[] => {
    const childIds: string[] = []
    
    const findChildren = (parentId: string) => {
        allNodes.forEach(node => {
            if (node.parentId === parentId) {
                childIds.push(node.permissionId.toString())
                findChildren(node.permissionId.toString())
            }
        })
    }
    
    findChildren(node.permissionId.toString())
    return childIds
}

// 获取节点的所有父节点ID
const getAllParentIds = (node: any, allNodes: any[]): string[] => {
    const parentIds: string[] = []
    
    const findParent = (childId: string) => {
        const child = allNodes.find(n => n.permissionId.toString() === childId)
        if (child && child.parentId) {
            parentIds.push(child.parentId.toString())
            findParent(child.parentId.toString())
        }
    }
    
    findParent(node.permissionId.toString())
    return parentIds
}

// 检查节点的所有子节点是否都被选中
const areAllChildrenSelected = (node: any, checkedKeys: string[], allNodes: any[]): boolean => {
    const childIds = getAllChildIds(node, allNodes)
    return childIds.length > 0 && childIds.every(id => checkedKeys.includes(id))
}

// 检查节点的所有子节点是否都未被选中
const areAllChildrenUnselected = (node: any, checkedKeys: string[], allNodes: any[]): boolean => {
    const childIds = getAllChildIds(node, allNodes)
    return childIds.length > 0 && childIds.every(id => !checkedKeys.includes(id))
}

// 获取所有节点（扁平化树结构）
const getAllNodes = (tree: any[]): any[] => {
    const nodes: any[] = []
    
    const traverse = (nodeList: any[]) => {
        nodeList.forEach(node => {
            nodes.push(node)
            if (node.children && node.children.length > 0) {
                traverse(node.children)
            }
        })
    }
    
    traverse(tree)
    return nodes
}

const handleRoleFormPermissionCheck = (data: Permissions, checked: any) => {
    const tree = roleFormPermissionTreeRef.value
    if (tree) {
        // 获取当前选中的节点
        const checkedKeys = tree.getCheckedKeys() as string[]
        const halfCheckedKeys = tree.getHalfCheckedKeys() as string[]
        
        // 获取所有节点
        const allNodes = getAllNodes(menuTree.value)
        
        // 智能级联处理
        let finalCheckedKeys = [...checkedKeys]
        
        // 如果当前节点被选中，确保所有子节点也被选中
        if (checkedKeys.includes(data.permissionId.toString())) {
            const childIds = getAllChildIds(data, allNodes)
            childIds.forEach(id => {
                if (!finalCheckedKeys.includes(id)) {
                    finalCheckedKeys.push(id)
                }
            })
        }
        
        // 如果当前节点被取消选中，确保所有子节点也被取消选中
        if (!checkedKeys.includes(data.permissionId.toString())) {
            const childIds = getAllChildIds(data, allNodes)
            finalCheckedKeys = finalCheckedKeys.filter(id => !childIds.includes(id))
        }
        
        // 检查父节点状态
        const parentIds = getAllParentIds(data, allNodes)
        parentIds.forEach(parentId => {
            const parentNode = allNodes.find(n => n.permissionId.toString() === parentId)
            if (parentNode) {
                // 如果所有子节点都被选中，父节点也应该被选中
                if (areAllChildrenSelected(parentNode, finalCheckedKeys, allNodes)) {
                    if (!finalCheckedKeys.includes(parentId)) {
                        finalCheckedKeys.push(parentId)
                    }
                }
                // 如果所有子节点都未被选中，父节点也应该被取消选中
                else if (areAllChildrenUnselected(parentNode, finalCheckedKeys, allNodes)) {
                    finalCheckedKeys = finalCheckedKeys.filter(id => id !== parentId)
                }
            }
        })
        
        // 更新树组件的选中状态
        tree.setCheckedKeys(finalCheckedKeys)
        
        // 更新选中的权限列表
        roleFormSelectedPermissions.value = finalCheckedKeys
        
        console.log('智能级联权限勾选变化:', {
            node: data.permName,
            nodeId: data.permissionId,
            checked: checked.checkedKeys,
            finalChecked: finalCheckedKeys,
            childIds: getAllChildIds(data, allNodes),
            parentIds: getAllParentIds(data, allNodes)
        })
    }
}


</script>

<style scoped lang="scss">
.role-container {
    padding: 20px;

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;

        .header-title {
            font-size: 16px;
            font-weight: 600;
        }
    }

    .role-content {
        display: flex;
        gap: 20px;
        min-height: 600px;

        .role-list-container {
            flex: 1;
            border: 1px solid #e4e7ed;
            border-radius: 4px;
            padding: 16px;
            background-color: #fff;

            .search-container {
                margin-bottom: 16px;
                display: flex;
                align-items: center;
            }

            .pagination-container {
                margin-top: 16px;
                display: flex;
                justify-content: center;
            }
        }
    }

}

// 角色表单权限选择样式
.permission-selection {
    width: 100%;
    
    .permission-actions {
        display: flex;
        gap: 8px;
        margin-bottom: 12px;
        flex-wrap: wrap;
    }

    .permission-tree-container {
        border: 1px solid #e4e7ed;
        border-radius: 4px;
        padding: 12px;
        background-color: #fafafa;
        max-height: 300px;
        overflow-y: auto;
        width: 100%;

        .role-form-permission-tree {
            .tree-node {
                display: flex;
                align-items: center;
                width: 100%;

                .node-content {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    flex: 1;

                    .node-icon {
                        font-size: 14px;
                    }

                    .node-title {
                        font-weight: 500;
                        font-size: 14px;
                    }
                }
            }
        }
    }
}

.role-content {
    .el-table {
        .el-table__row {
            cursor: pointer;

            &:hover {
                background-color: #f5f7fa;
            }

            &.current-row {
                background-color: #ecf5ff;
            }
        }
    }
}

</style>
