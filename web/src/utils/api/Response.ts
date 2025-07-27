/*
 * @Author: coder_wang 17360402335@163.com
 * @Date: 2025-07-24 16:05:52
 * @LastEditors: coder_wang 17360402335@163.com
 * @LastEditTime: 2025-07-24 16:06:09
 * @FilePath: \web\src\utils\api\Response.ts
 * @Description: 
 */
export interface ApiResponse<T> {
    code: number;
    message: string;
    data: T;
}