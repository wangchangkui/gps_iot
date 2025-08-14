export class Permissions{
      /**
     * 权限ID（主键）
     * 使用数据库序列 permissions_permission_id_seq 自动生成
     */
   
        permissionId:string="";
  
      /**
       * 权限键（唯一标识）
       * 示例: menu:sysmgmt, func:user:create
       */
   
        permKey:string="";
  
      /**
       * 权限显示名称
       */
     
        permName:string="";
  
      /**
       * 权限类型 (枚举值: MENU, BUTTON, API, DATA)
       */
     
        permType:string="";
  
      /**
       * 父权限ID（外键关联自身表）
       */  
        parentId:string="";
  
      /**
       * 组件访问路径
       */
    
        componentPath:string="";
  
      /**
       * 排序序号（默认0）
       */
     
        sortOrder:number = 0;
  
      /**
       * 是否隐藏（默认false）
       */
     
        isHidden:boolean = false;
  
      /**
       * 创建时间（插入时自动填充）
       */
     
        createdTime:string="";
  
      /**
       * 更新时间（插入和更新时自动填充）
       */
     
        updatedTime:string="";
  
 ;
  
      /**
       * 子权限列表
       */
    
        children:Permissions[] = [];








}