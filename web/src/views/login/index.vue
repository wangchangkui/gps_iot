<template>
  <div class="login-container">
    <div class="login-box">
      <!-- 左侧品牌区域 -->
      <div class="login-brand">
        <div class="brand-content">
          <h1 class="brand-title">ADMCC</h1>
          <p class="brand-desc">开源物联网定位系统</p>
          <div class="brand-features">
            <div class="feature-item">
              <i class="el-icon-location"></i>
              <span>高精度定位</span>
            </div>
            <div class="feature-item">
              <i class="el-icon-data-analysis"></i>
              <span>数据分析</span>
            </div>
            <div class="feature-item">
              <i class="el-icon-monitor"></i>
              <span>设备监控</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 右侧登录表单区域 -->
      <div class="login-form-container">
        <div class="login-form-header">
          <img src="/marker.png" alt="Logo" class="login-logo" />
          <h2>系统登录</h2>
          <p class="welcome-text">欢迎使用ADMCC物联网定位系统</p>
        </div>

        <!-- 登录方式切换 -->
        <div class="login-tabs">
          <div class="login-tab-item" :class="{ active: loginType === 'account' }" @click="loginType = 'account'">
            账号密码
          </div>
          <div class="login-tab-item" :class="{ active: loginType === 'email' }" @click="loginType = 'email'">
            邮箱登录
          </div>
        </div>

        <!-- 账号密码登录 -->
        <el-form v-if="loginType === 'account'" ref="loginFormRef" :model="loginForm" :rules="loginRules"
          class="login-form">
          <el-form-item prop="username">
            <el-input v-model="loginForm.username" placeholder="请输入用户名" :prefix-icon="User" size="large" />
          </el-form-item>

          <el-form-item prop="password">
            <el-input v-model="loginForm.password" type="password" placeholder="请输入密码" :prefix-icon="Lock" show-password
              size="large" />
          </el-form-item>

          <!-- 图形验证码 -->
          <el-form-item prop="captcha">
            <div class="verification-code-container">
              <el-input v-model="loginForm.captcha" placeholder="请输入图形验证码" size="large">
                <template #prefix>
                  <i class="el-icon-picture"></i>
                </template>
              </el-input>
              <div class="captcha-image" @click="refreshCaptcha">
                <img :src="'data:image/png;base64,' + captchaUrl" alt="验证码" />
              </div>
            </div>
          </el-form-item>

          <div class="login-options">
            <el-checkbox v-model="loginForm.remember">记住密码</el-checkbox>
            <a href="#" class="forgot-password">忘记密码?</a>
          </div>

          <el-button type="primary" class="login-button" size="large" @click="handleLogin" :loading="loading">
            登录
          </el-button>
        </el-form>

        <!-- 邮箱验证码登录 -->
        <el-form v-if="loginType === 'email'" ref="emailFormRef" :model="emailForm" :rules="emailRules"
          class="login-form">
          <el-form-item prop="username">
            <el-input v-model="emailForm.username" placeholder="请输入登录账号" size="large">
              <template #prefix>
                <i class="el-icon-user"></i>
              </template>
            </el-input>
          </el-form-item>

          <!-- 图形验证码 -->
          <el-form-item prop="captcha">
            <div class="verification-code-container">
              <el-input v-model="loginForm.captcha" placeholder="请输入图形验证码" size="large">
                <template #prefix>
                  <i class="el-icon-picture"></i>
                </template>
              </el-input>
              <div class="captcha-image" @click="refreshCaptcha">
                <img :src="'data:image/png;base64,' + captchaUrl" alt="验证码" />
              </div>
            </div>
          </el-form-item>

          <el-form-item prop="code">
            <div class="verification-code-container">
              <el-input v-model="emailForm.code" placeholder="请输入邮箱验证码" size="large">
                <template #prefix>
                  <i class="el-icon-key"></i>
                </template>
              </el-input>
              <el-button type="primary" class="get-code-button" size="large" :disabled="codeButtonDisabled"
                @click="getVerificationCode">
                {{ codeButtonText }}
              </el-button>
            </div>
          </el-form-item>

          <el-button type="primary" class="login-button" size="large" @click="handleEmailLogin" :loading="loading"
            :disabled="!emailForm.code || !loginForm.captcha">
            登录
          </el-button>
        </el-form>


        <div class="login-footer">
          <span>还没有账号? <a href="#" @click.prevent="goToRegister">立即注册</a></span>
          <span class="footer-divider">|</span>
          <span><a href="#" @click.prevent="goToHome">返回首页</a></span>
        </div>

        <div class="login-copyright">
          © 2025 ADMCC.cn. All rights reserved.
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import type { FormInstance, FormRules } from 'element-plus'
import { User, Lock } from '@element-plus/icons-vue'
import ElMessage from 'element-plus/es/components/message/index'
import { get_captcha, send_email, login, send_login_email } from '../../utils/api/user/login_user_api'
import { LoginUser } from '../../utils/api/user/login_user'


const router = useRouter()
const loginFormRef = ref<FormInstance>()
const emailFormRef = ref<FormInstance>()
const loading = ref(false)

// 登录方式
const loginType = ref('account') // 'account', 'email'

// 账号密码登录表单
const loginForm = reactive({
  username: '',
  password: '',
  captcha: '',
  captchaCode: '',
  remember: false
})

// 邮箱验证码登录表单
const emailForm = reactive({
  username: '',
  code: ''
})

// 验证码按钮状态
const codeButtonText = ref('获取验证码')
const codeButtonDisabled = ref(false)
const countdown = ref(60)

// 图片验证码URL
const captchaUrl = ref('')

// 账号密码登录验证规则
const loginRules: FormRules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  captcha: [
    { required: true, message: '请输入图形验证码', trigger: 'blur' },
    { min: 4, max: 6, message: '验证码长度不正确', trigger: 'blur' }
  ]
}

// 邮箱验证码登录验证规则
const emailRules: FormRules = {
  username: [
    { required: true, message: '请输入登录账号', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  code: [
    { required: true, message: '请输入邮箱验证码', trigger: 'blur' },
    { pattern: /^\d{6}$/, message: '验证码为6位数字', trigger: 'blur' }
  ]
}

// 获取图形验证码
const getCaptcha = async () => {
  try {
    const res = await get_captcha()
    if (res.code === 10000) {
      captchaUrl.value = res.data.captchaBase64
      loginForm.captchaCode = res.data.captchaId
    } else {
      ElMessage.error('获取验证码失败')
    }
  } catch (error) {
    ElMessage.error('获取验证码失败')
  }
}

// 刷新图形验证码
const refreshCaptcha = () => {
  getCaptcha()
}

// 账号密码登录
const handleLogin = async () => {
  if (!loginFormRef.value) return

  loading.value = true

  try {
    await loginFormRef.value.validate(async (valid, fields) => {
      if (valid) {
        let loginUser = new LoginUser(loginForm.username, loginForm.password, loginForm.captchaCode, loginForm.captcha, "", 'account')
        const res = await login(loginUser)
        if (res.code === 10000) {
          localStorage.setItem('authentication', res.data.loginToken)
          localStorage.setItem('permissions', JSON.stringify(res.data.userAllPermissions))
          localStorage.setItem('nickName', res.data.nickName)
          localStorage.setItem('avatar', res.data.avatar)
          

          ElMessage.success('登录成功')
          loading.value = false
          router.push('/manage')
        } else {

          ElMessage.error(res.message)
          // 刷新验证码
          refreshCaptcha()
        }
      } else {
        loading.value = false
        // 刷新验证码
        refreshCaptcha()
      }
    })
  } catch (error) {
    loading.value = false
    // 刷新验证码
    refreshCaptcha()
  }
}

// 邮箱验证码登录
const handleEmailLogin = async () => {
  if (!emailFormRef.value) return

  loading.value = true

  try {
    await emailFormRef.value.validate(async (valid, fields) => {
      if (valid) {

        let loginUser = new LoginUser(emailForm.username, "",loginForm.captchaCode, loginForm.captcha,emailForm.code, 'email')
        const res = await login(loginUser)
        if (res.code === 10000) {
          localStorage.setItem('authentication', res.data.loginToken)
          localStorage.setItem('permissions', JSON.stringify(res.data.userAllPermissions))
          localStorage.setItem('nickName', res.data.nickName)
          localStorage.setItem('avatar', res.data.avatar)
          ElMessage.success('登录成功')
          loading.value = false
          router.push('/manage')
        } else {

          ElMessage.error(res.message)
          // 刷新验证码
          refreshCaptcha()
        }
      } else {
        // 刷新验证码
        refreshCaptcha()
        loading.value = false
      }
    })
  } catch (error) {
    // 刷新验证码
    refreshCaptcha()
    loading.value = false
  }
}

// 获取邮箱验证码
const getVerificationCode = async () => {
  // 验证账号
  if (!emailForm.username || emailForm.username.length < 3) {
    ElMessage.error('请输入正确的登录账号')
    return
  }

  // 验证图形验证码
  if (!loginForm.captcha) {
    ElMessage.error('请先输入图形验证码')
    return
  }

  // 开始倒计时
  codeButtonDisabled.value = true
  codeButtonText.value = `${countdown.value}秒后重新获取`

  const timer = setInterval(() => {
    countdown.value--
    codeButtonText.value = `${countdown.value}秒后重新获取`

    if (countdown.value <= 0) {
      clearInterval(timer)
      codeButtonDisabled.value = false
      codeButtonText.value = '获取验证码'
      countdown.value = 60
    }
  }, 1000)

  // 调用发送验证码的API，这里需要根据用户名获取对应的邮箱
  try {

    // 暂时使用一个示例邮箱，实际应该从后端获取
    const res = await send_login_email(emailForm.username)
    if (res.code === 10000) {
      ElMessage.success('验证码已发送到邮箱')
    } else {
      ElMessage.error(res.message || '发送验证码失败')
      // 发送失败时重置倒计时
      clearInterval(timer)
      codeButtonDisabled.value = false
      codeButtonText.value = '获取验证码'
      countdown.value = 60
    }
  } catch (error) {
    ElMessage.error('发送验证码失败')
    // 发送失败时重置倒计时
    clearInterval(timer)
    codeButtonDisabled.value = false
    codeButtonText.value = '获取验证码'
    countdown.value = 60
  }
}

// 跳转到注册页面
const goToRegister = () => {
  router.push('/register')
}

// 跳转到首页
const goToHome = () => {
  router.push('/')
}

// 组件挂载时获取图形验证码
onMounted(() => {
  getCaptcha()
})
</script>

<style scoped lang="scss">
.login-container {
  height: 100vh;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f5f7fa;
  overflow: hidden;
}

.login-box {
  display: flex;
  width: 900px;
  height: 700px;
  border-radius: 12px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

// 左侧品牌区域
.login-brand {
  flex: 1;
  background: linear-gradient(135deg, #1890ff, #0050b3);
  color: white;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 40px;
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0) 60%);
    z-index: 1;
  }

  .brand-content {
    position: relative;
    z-index: 2;
  }

  .brand-title {
    font-size: 36px;
    font-weight: 700;
    margin-bottom: 10px;
  }

  .brand-desc {
    font-size: 16px;
    opacity: 0.8;
    margin-bottom: 40px;
  }

  .brand-features {
    margin-top: 40px;

    .feature-item {
      display: flex;
      align-items: center;
      margin-bottom: 20px;

      i {
        font-size: 24px;
        margin-right: 12px;
      }

      span {
        font-size: 16px;
      }
    }
  }
}

// 右侧登录表单区域
.login-form-container {
  flex: 1;
  background-color: white;
  padding: 40px;
  display: flex;
  flex-direction: column;
  overflow-y: auto;

  // 自定义滚动条样式 - 默认隐藏，滚动时显示
  &::-webkit-scrollbar {
    width: 6px;
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  &::-webkit-scrollbar-track {
    background: transparent;
    border-radius: 3px;
  }

  &::-webkit-scrollbar-thumb {
    background: rgba(193, 193, 193, 0.6);
    border-radius: 3px;
    transition: background 0.3s ease;

    &:hover {
      background: rgba(168, 168, 168, 0.8);
    }
  }

  // 鼠标悬停时显示滚动条
  &:hover::-webkit-scrollbar {
    opacity: 1;
  }

  // 滚动时显示滚动条
  &:hover::-webkit-scrollbar-thumb {
    background: rgba(193, 193, 193, 0.8);
  }
}

.login-form-header {
  text-align: center;
  margin-bottom: 20px;

  .login-logo {
    width: 60px;
    height: 60px;
    margin-bottom: 15px;
  }

  h2 {
    font-size: 24px;
    color: #303133;
    margin-bottom: 10px;
  }

  .welcome-text {
    color: #909399;
    font-size: 14px;
  }
}

// 登录方式切换选项卡
.login-tabs {
  display: flex;
  border-bottom: 1px solid #ebeef5;
  margin-bottom: 20px;

  .login-tab-item {
    flex: 1;
    text-align: center;
    padding: 12px 0;
    font-size: 14px;
    color: #606266;
    cursor: pointer;
    transition: all 0.3s;
    position: relative;

    &:hover {
      color: #1890ff;
    }

    &.active {
      color: #1890ff;
      font-weight: 500;

      &::after {
        content: '';
        position: absolute;
        bottom: -1px;
        left: 50%;
        transform: translateX(-50%);
        width: 40%;
        height: 2px;
        background-color: #1890ff;
      }
    }
  }
}

.login-form {
  flex: 1;

  :deep(.el-form-item) {
    margin-bottom: 20px;
  }

  :deep(.el-input__wrapper) {
    padding: 0 15px;
    height: 50px;
    box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.1) inset;

    &:hover,
    &.is-focus {
      box-shadow: 0 0 0 1px #1890ff inset;
    }
  }

  :deep(.el-input__prefix) {
    font-size: 18px;
  }
}

// 验证码输入框容器
.verification-code-container {
  display: flex;
  align-items: center;

  .el-input {
    flex: 2;
  }

  .get-code-button {
    flex: 1;
    margin-left: 10px;
    height: 50px;
    white-space: nowrap;
    padding: 0 8px;
    font-size: 14px;
  }

  .captcha-image {
    flex: 1;
    height: 50px;
    margin-left: 10px;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    overflow: hidden;
    cursor: pointer;
    transition: all 0.3s;

    &:hover {
      border-color: #1890ff;
      box-shadow: 0 0 0 1px #1890ff;
    }

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }
}

// 微信扫码登录
.wechat-login-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  .qrcode-container {
    width: 200px;
    height: 200px;
    border: 1px solid #ebeef5;
    padding: 10px;
    margin-bottom: 20px;

    .qrcode-img {
      width: 100%;
      height: 100%;
      object-fit: contain;
    }
  }

  .qrcode-tip {
    font-size: 16px;
    color: #303133;
    margin-bottom: 10px;
  }

  .qrcode-status {
    font-size: 14px;
    color: #909399;
    margin-bottom: 15px;
  }

  .refresh-qrcode {
    font-size: 14px;

    i {
      margin-right: 5px;
    }
  }
}

.login-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;

  .forgot-password {
    color: #1890ff;
    text-decoration: none;
    font-size: 14px;

    &:hover {
      text-decoration: underline;
    }
  }
}

.login-button {
  width: 100%;
  height: 50px;
  font-size: 16px;
  border-radius: 4px;
  background: linear-gradient(to right, #1890ff, #096dd9);
  border: none;

  &:hover {
    background: linear-gradient(to right, #40a9ff, #1890ff);
  }
}

.login-footer {
  margin-top: 20px;
  text-align: center;
  font-size: 14px;
  color: #606266;
  display: flex;
  justify-content: center;
  align-items: center;

  .footer-divider {
    margin: 0 10px;
    color: #dcdfe6;
  }

  a {
    color: #1890ff;
    text-decoration: none;

    &:hover {
      text-decoration: underline;
    }
  }
}

.login-copyright {
  margin-top: 20px;
  text-align: center;
  font-size: 12px;
  color: #909399;
}
</style>