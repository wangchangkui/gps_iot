<template>
  <div class="profile-page">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-left">
        <h1 class="page-title">个人信息</h1>
      </div>
    </div>

    <!-- 主要内容区域 -->
    <div class="profile-main">
      <!-- 左侧导航 -->
      <div class="profile-sidebar">
        <div class="user-card">
          <div class="user-avatar">
            <div class="avatar">
              <img 
                v-if="userInfo && userInfo.avatarUrl" 
                crossorigin="anonymous" 
                :src="userInfo.avatarUrl" 
                alt="用户头像"
                @error="handleAvatarError"
              />
              <el-icon v-else><User /></el-icon>
            </div>
            <el-button 
              type="primary" 
              size="small" 
              @click="showAvatarDialog = true"
              class="avatar-edit-btn"
            >
            <el-icon><UploadFilled /></el-icon>
            </el-button>
        
          </div>
          <div class="user-info">
            <h3>{{ userInfo?.nickName || '未设置昵称' }}</h3>
            <p>{{ userInfo?.userName || '' }}</p>
          </div>
        </div>

        <el-menu
          :default-active="activeTab"
          class="profile-menu"
          @select="handleMenuSelect"
        >
          <el-menu-item index="profile">
            <el-icon><User /></el-icon>
            <span>个人信息</span>
          </el-menu-item>
          <el-menu-item index="password">
            <el-icon><Lock /></el-icon>
            <span>修改密码</span>
          </el-menu-item>
          <el-menu-item index="email">
            <el-icon><Link /></el-icon>
            <span>修改绑定邮箱</span>
            
          </el-menu-item>
        </el-menu>
      </div>

      <!-- 右侧内容区域 -->
      <div class="profile-content">
        <!-- 个人信息 -->
        <div v-show="activeTab === 'profile'" class="content-section">
          <el-card class="content-card">
            <template #header>
              <div class="card-header">
                <span>个人信息</span>
                <el-button 
                  type="primary" 
                  @click="editMode = true" 
                  v-if="!editMode"
                >
                  <el-icon><i class="el-icon-edit"></i></el-icon>
                  编辑
                </el-button>
              </div>
            </template>

            <el-form
              :model="userInfo"
              :rules="rules"
              ref="formRef"
              label-width="120px"
              class="profile-form"
            >
       
              <el-row :gutter="24">
                <el-col :span="12">
                  <el-form-item label="昵称" prop="nickName">
                    <el-input
                      v-model="userInfo.nickName"
                      :disabled="!editMode"
                      placeholder="请输入昵称"
                    />
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="账号" prop="userName">
                    <el-input
                      v-model="userInfo.userName"
                      disabled
                      placeholder="账号不可修改"
                    />
                  </el-form-item>
                </el-col>
              </el-row>

              <el-row :gutter="24">
                <el-col :span="12">
                  <el-form-item label="邮箱" prop="email">
                    <el-input
                      v-model="userInfo.email"
                      disabled
                      placeholder="邮箱不可修改"
                    />
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="手机号" prop="phoneNumber">
                    <el-input
                      v-model="userInfo.phoneNumber"
                      disabled
                      placeholder="手机号不可修改"
                    />
                  </el-form-item>
                </el-col>
              </el-row>

              <el-row :gutter="24">
                <el-col :span="12">
                  <el-form-item label="性别" prop="sex">
                    <el-select
                      v-model="userInfo.sex"
                      :disabled="!editMode"
                      placeholder="请选择性别"
                      style="width: 100%"
                    >
                      <el-option label="男" :value="1" />
                      <el-option label="女" :value="0" />
                    </el-select>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="状态">
                    <el-tag :type="userInfo.isActive ? 'success' : 'danger'">
                      {{ userInfo?.isActive ? '正常' : '禁用' }}
                    </el-tag>
                  </el-form-item>
                </el-col>
              </el-row>

              <el-row :gutter="24">
                <el-col :span="12">
                  <el-form-item label="创建时间">
                    <el-input :value="formatDate(userInfo?.createdTime)" disabled />
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item label="最后登录">
                    <el-input :value="formatDate(userInfo?.lastLogin)" disabled />
                  </el-form-item>
                </el-col>
              </el-row>

              <div class="form-actions" v-if="editMode">
                <el-button @click="cancelEdit">取消</el-button>
                <el-button type="primary" @click="saveProfile" :loading="loading">
                  保存
                </el-button>
              </div>
            </el-form>
          </el-card>
        </div>

        <!-- 修改密码 -->
        <div v-show="activeTab === 'password'" class="content-section">
          <el-card class="content-card">
            <template #header>
              <div class="card-header">
                <span>修改密码</span>
              </div>
            </template>

            <el-form
              :model="passwordForm"
              :rules="passwordRules"
              ref="passwordFormRef"
              label-width="120px"
              class="password-form"
            >
              <el-form-item label="当前密码" prop="password">
                <el-input
                  v-model="passwordForm.password"
                  type="password"
                  placeholder="请输入当前密码"
                  show-password
                />
              </el-form-item>
              <el-form-item label="新密码" prop="newPassword">
                <el-input
                  v-model="passwordForm.newPassword"
                  type="password"
                  placeholder="请输入新密码"
                  show-password
                />
              </el-form-item>
              <el-form-item label="确认密码" prop="confirmPassword">
                <el-input
                  v-model="passwordForm.confirmPassword"
                  type="password"
                  placeholder="请再次输入新密码"
                  show-password
                />
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="changePassword" :loading="passwordLoading">
                  修改密码
                </el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </div>

        <!-- 修改绑定邮箱 -->
        <div v-show="activeTab === 'email'" class="content-section">
          <el-card class="content-card">
            <template #header>
              <div class="card-header">
                <span>修改绑定邮箱</span>
              </div>
            </template>

            <el-form
              :model="emailForm"
              :rules="emailRules"
              ref="emailFormRef"
              label-width="120px"
              class="email-form"
            >
              <el-form-item label="当前邮箱">
                <el-input :value="userInfo?.email" disabled />
              </el-form-item>
              <el-form-item label="新邮箱" prop="newEmail">
                <el-input
                  v-model="emailForm.newEmail"
                  placeholder="请输入新邮箱"
                />
              </el-form-item>
              <el-form-item label="验证码" prop="emailCode">
                <div class="verification-input">
                  <el-input
                    v-model="emailForm.emailCode"
                    placeholder="请输入验证码"
                    style="flex: 1; margin-right: 12px;"
                  />
                  <el-button 
                    type="primary" 
                    @click="sendVerificationCode"
                    :disabled="!emailForm.newEmail || emailCountdown > 0"
                    :loading="sendingCode"
                  >
                    {{ emailCountdown > 0 ? `${emailCountdown}s后重发` : '发送验证码' }}
                  </el-button>
                </div>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="changeEmail" :loading="emailLoading">
                  修改邮箱
                </el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </div>
      </div>
    </div>

    <!-- 头像上传对话框 -->
    <el-dialog
      v-model="showAvatarDialog"
      title="更换头像"
      width="400px"
      :close-on-click-modal="false"
    >
      <div class="avatar-upload">
        <el-upload
          class="avatar-uploader"
          :show-file-list="false"
          :before-upload="beforeAvatarUpload"
          :http-request="uploadAvatar"
          accept="image/*"
        >
          <img v-if="avatarPreview" :src="avatarPreview" class="avatar-preview" />
          <el-icon v-else class="avatar-uploader-icon"><i class="el-icon-plus"></i></el-icon>
        </el-upload>
        <div class="upload-tips">
          <p>支持 JPG、PNG 格式，文件大小不超过 2MB</p>
        </div>
      </div>
      <template #footer>
        <el-button @click="showAvatarDialog = false">取消</el-button>
        <el-button type="primary" @click="confirmAvatarUpload" :loading="avatarLoading">
          确定
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import ElMessage from 'element-plus/es/components/message/index'
import ElMessageBox from 'element-plus/es/components/message-box/index'
import { User, Lock } from '@element-plus/icons-vue'
import { getUserInfo, updateUserInfo, changePassword as changePasswordApi, uploadUserAvatar, sendEmailVerificationCode, changeEmail as changeEmailApi } from '../../utils/api/user/profile_api'
import type { UserInfoResponse, UpdateUserInfoRequest, ChangePasswordRequest, ChangeEmailRequest } from '../../utils/api/user/profile_api'

const router = useRouter()

// 用户信息
const userInfo = ref<UserInfoResponse>({
  id: 0,
  userName: '',
  email: '',
  nickName: '',
  phoneNumber: '',
  sex: 0,
  avatarUrl: '',
  isActive: true,
  lastLogin: '',
  createdTime: '',
  updatedTime: ''
})

// 当前激活的标签页
const activeTab = ref('profile')

// 编辑模式
const editMode = ref(false)
const loading = ref(false)

// 密码修改相关
const passwordForm = reactive<ChangePasswordRequest>({
  password: '',
  newPassword: '',
  confirmPassword: '',
  account: ''
})
const passwordLoading = ref(false)

// 邮箱修改相关
const emailForm = reactive<ChangeEmailRequest>({
  account: '',
  email: '',
  newEmail: '',
  emailCode: ''
})
const emailLoading = ref(false)
const sendingCode = ref(false)
const emailCountdown = ref(0)

// 头像上传相关
const showAvatarDialog = ref(false)
const avatarPreview = ref('')
const avatarLoading = ref(false)

// 表单引用
const formRef = ref()
const passwordFormRef = ref()
const emailFormRef = ref()

// 表单验证规则
const rules = {
  nickName: [
    { required: true, message: '请输入昵称', trigger: 'blur' },
    { min: 2, max: 20, message: '昵称长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  sex: [
    { required: true, message: '请选择性别', trigger: 'change' }
  ]
}

const passwordRules = {
  password: [
    { required: true, message: '请输入当前密码', trigger: 'blur' }
  ],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    {
      validator: (rule: any, value: string, callback: Function) => {
        if (value !== passwordForm.newPassword) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      },
      trigger: 'blur'
    }
  ]
}

const emailRules = {
  newEmail: [
    { required: true, message: '请输入新邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
  ],
  emailCode: [
    { required: true, message: '请输入验证码', trigger: 'blur' },
    { len: 6, message: '验证码为6位数字', trigger: 'blur' }
  ]
}

// 返回上一页
const goBack = () => {
  router.go(-1)
}

// 处理菜单选择
const handleMenuSelect = (key: string) => {
  activeTab.value = key
  // 切换标签页时重置编辑模式
  editMode.value = false
}

// 获取用户信息
const fetchUserInfo = async () => {
  try {
    const response = await getUserInfo()
    if (response.code === 10000) {
      // 确保 response.data 存在且不为 null
      if (response.data) {
        userInfo.value = response.data
      } else {
        ElMessage.error('用户信息数据为空')
      }
    } else {
      ElMessage.error(response.message || '获取用户信息失败')
    }
  } catch (error) {
    ElMessage.error('获取用户信息失败')
  }
}

// 保存个人信息
const saveProfile = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    loading.value = true
    
    const updateData: UpdateUserInfoRequest = {
      nickName: userInfo.value?.nickName || '',
      email: userInfo.value?.email || '',
      phoneNumber: userInfo.value?.phoneNumber || '',
      sex: userInfo.value?.sex || 0,
      account: userInfo.value?.userName || ''
    }
    
    const response = await updateUserInfo(updateData)
    if (response.code === 10000) {
      ElMessage.success('个人信息更新成功')
      editMode.value = false
      // 更新缓存
      localStorage.setItem('nickName', updateData.nickName)
      // 刷新页面
      window.location.reload()
    } else {
      ElMessage.error(response.message || '更新失败')
    }
  } catch (error) {
    ElMessage.error('更新失败')
  } finally {
    loading.value = false
  }
}

// 取消编辑
const cancelEdit = () => {
  editMode.value = false
  fetchUserInfo() // 重新获取用户信息，恢复原始数据
}

// 修改密码
const changePassword = async () => {
  if (!passwordFormRef.value) return
  
  try {
    await passwordFormRef.value.validate()
    passwordLoading.value = true
    passwordForm.account = userInfo.value?.userName || ''
    const response = await changePasswordApi(passwordForm)
    if (response.code === 10000) {
      ElMessage.success('密码修改成功')
      // 清空表单
      Object.assign(passwordForm, {
        password: '',
        newPassword: '',
        confirmPassword: ''
      })
    } else {
      ElMessage.error(response.message || '密码修改失败')
    }
  } catch (error) {
    ElMessage.error('密码修改失败')
  } finally {
    passwordLoading.value = false
  }
}

// 发送邮箱验证码
const sendVerificationCode = async () => {
  if (!emailForm.newEmail) {
    ElMessage.warning('请先输入新邮箱')
    return
  }
  
  try {
    sendingCode.value = true
    const response = await sendEmailVerificationCode(userInfo.value.email)
    if (response.code === 10000) {
      ElMessage.success('验证码已发送')
      startCountdown()
    } else {
      ElMessage.error(response.message || '发送验证码失败')
    }
  } catch (error) {
    ElMessage.error('发送验证码失败')
  } finally {
    sendingCode.value = false
  }
}

// 开始倒计时
const startCountdown = () => {
  emailCountdown.value = 60
  const timer = setInterval(() => {
    emailCountdown.value--
    if (emailCountdown.value <= 0) {
      clearInterval(timer)
    }
  }, 1000)
}

// 修改邮箱
const changeEmail = async () => {
  if (!emailFormRef.value) return
  
  try {
    await emailFormRef.value.validate()
    emailLoading.value = true
    
    // 设置邮箱修改所需的参数
    emailForm.account = userInfo.value?.userName || ''
    emailForm.email = userInfo.value?.email || ''
    
    const response = await changeEmailApi(emailForm)
    if (response.code === 10000) {
      ElMessage.success('邮箱修改成功')
      // 清空表单
      Object.assign(emailForm, {
        account: '',
        email: '',
        newEmail: '',
        emailCode: ''
      })
      // 重新获取用户信息
      await fetchUserInfo()
    } else {
      ElMessage.error(response.message || '邮箱修改失败')
    }
  } catch (error) {
    ElMessage.error('邮箱修改失败')
  } finally {
    emailLoading.value = false
  }
}

// 头像上传前验证
const beforeAvatarUpload = (file: File) => {
  const isImage = file.type.startsWith('image/')
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isImage) {
    ElMessage.error('只能上传图片文件!')
    return false
  }
  if (!isLt2M) {
    ElMessage.error('图片大小不能超过 2MB!')
    return false
  }
  
  // 预览图片
  const reader = new FileReader()
  reader.onload = (e) => {
    avatarPreview.value = e.target?.result as string
  }
  reader.readAsDataURL(file)
  
  return false // 阻止自动上传
}

// 上传头像
const uploadAvatar = async (options: any) => {
  // 这里不需要实现，因为我们在 beforeAvatarUpload 中返回了 false
}

// 确认头像上传
const confirmAvatarUpload = async () => {
  if (!avatarPreview.value) {
    ElMessage.warning('请先选择图片')
    return
  }
  
  // 检查 userInfo 是否存在
  if (!userInfo.value) {
    ElMessage.error('用户信息未加载，请刷新页面重试')
    return
  }
  
  try {
    avatarLoading.value = true
    
    // 将预览图片转换为文件
    const response = await fetch(avatarPreview.value)
    const blob = await response.blob()
    const file = new File([blob], 'avatar.jpg', { type: 'image/jpeg' })
    
    const uploadResponse = await uploadUserAvatar(file)
  
    if (uploadResponse.code === 10000) {
      userInfo.value.avatarUrl = uploadResponse.data;
      // 更新localStorage
      localStorage.setItem('avatar', uploadResponse.data)
      // 通知顶部导航栏更新头像
      window.dispatchEvent(new CustomEvent('user-info-update', {
        detail: { avatarUrl: uploadResponse.data }
      }))
      ElMessage.success('头像更新成功')
      showAvatarDialog.value = false
    } else {
      ElMessage.error(uploadResponse.message)
    }
  } catch (error) {
    console.log(error)
    ElMessage.error('头像更新失败')
  } finally {
    avatarLoading.value = false
  }
}

// 头像加载失败处理
const handleAvatarError = () => {
  console.log('头像加载失败，使用默认头像')
  // 可以在这里设置一个默认头像URL或者清空avatarUrl
  // userInfo.value.avatarUrl = ''
}

// 格式化日期
const formatDate = (dateString: string) => {
  if (!dateString) return '未设置'
  return new Date(dateString).toLocaleString('zh-CN')
}

// 组件挂载时获取用户信息
onMounted(() => {
  fetchUserInfo()
})
</script>

<style scoped>
.profile-page {
  min-height: 100vh;

  padding: 20px;
}

.page-header {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 12px;
  padding: 16px 24px;
  margin-bottom: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.back-button {
  font-size: 16px;
  color: #666;
  padding: 8px 12px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.back-button:hover {
  background: #f5f5f5;
  color: #333;
}

.page-title {
  margin: 0;
  font-size: 24px;
  font-weight: 600;
  color: #333;
}

.profile-main {
  display: flex;
  gap: 20px;
  height: calc(100vh - 120px);
}

.profile-sidebar {
  width: 280px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.user-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 24px;
  text-align: center;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.user-avatar {
  position: relative;
  display: inline-block;
  margin-bottom: 16px;
}

.avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  border: 4px solid #fff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f7fa;
  
  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .el-icon {
    font-size: 32px;
    color: #909399;
  }
}

.avatar-edit-btn {
  position: absolute;
  bottom: -5px;
  right: -5px;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  padding: 0;
  min-width: 32px;
}

.user-info h3 {
  margin: 0 0 8px 0;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.user-info p {
  margin: 0;
  color: #666;
  font-size: 14px;
}

.profile-menu {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  border: none;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.profile-menu .el-menu-item {
  height: 56px;
  line-height: 56px;
  border-radius: 12px;
  margin: 4px 8px;
  transition: all 0.3s ease;
}

.profile-menu .el-menu-item:hover {
  background: #f0f9ff;
  color: #1890ff;
}

.profile-menu .el-menu-item.is-active {
  background: linear-gradient(135deg, #1890ff, #40a9ff);
  color: white;
}

.profile-content {
  flex: 1;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  overflow-y: auto;
}

.content-section {
  animation: fadeIn 0.3s ease-in-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.content-card {
  border: none;
  box-shadow: none;
  background: transparent;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 16px;
 
  margin-bottom: 24px;
}

.card-header span {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.profile-form,
.password-form,
.email-form {
  max-width: 600px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid #f0f0f0;
}

.verification-input {
  display: flex;
  align-items: center;
}

.avatar-upload {
  text-align: center;
}

.avatar-uploader {
  display: inline-block;
}

.avatar-uploader :deep(.el-upload) {
  border: 2px dashed #d9d9d9;
  border-radius: 8px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
  width: 200px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.avatar-uploader :deep(.el-upload:hover) {
  border-color: #1890ff;
}

.avatar-preview {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
}

/* 头像显示样式 */
.avatar-display {
  display: flex;
  align-items: center;
  gap: 12px;
}

.form-avatar {
  border: 2px solid #e6f7ff;
  transition: all 0.3s ease;
}

.form-avatar:hover {
  border-color: #1890ff;
  transform: scale(1.05);
}

.avatar-text {
  color: #666;
  font-size: 14px;
}

.upload-tips {
  margin-top: 12px;
  color: #666;
  font-size: 14px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .profile-main {
    flex-direction: column;
    height: auto;
  }
  
  .profile-sidebar {
    width: 100%;
  }
  
  .profile-menu {
    display: flex;
    overflow-x: auto;
  }
  
  .profile-menu .el-menu-item {
    white-space: nowrap;
    margin: 4px;
  }
}
</style>