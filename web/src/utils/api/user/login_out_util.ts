import router from "@/router";
import { logout } from "./login_user_api";

export const loginOut = async () => {
  // 调用接口
  const res  = await logout();

  // 删除存储
  localStorage.removeItem('authentication')
  localStorage.removeItem('permissions')
  localStorage.removeItem('nickName')
  localStorage.removeItem('avatar')

  router.push('/')

}