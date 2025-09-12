import type { PageQuery } from "@/utils/PageQuery";
import { Permissions } from "../user/Permissions";

/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-09-12 10:06:37
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-09-12 14:51:37
 * @FilePath: \web\src\views\roles\roleType.ts
 * @Description: 
 */
export class RoleType {

    id:string="";
    roleName:string="";
    createdTime:string="";
    updatedTime:string="";
    description:string="";
    roleCode:string="";
    permissions:Permissions[]=[];

}





export class RoleResponse{
    records:RoleType[];
    total:number;
    pages:number;
    current:number;
    size:number;

    constructor(records:RoleType[],total:number,pages:number,current:number,size:number){
        this.records = records;
        this.total = total;
        this.pages = pages;
        this.current = current;
        this.size = size;
    }
    
}