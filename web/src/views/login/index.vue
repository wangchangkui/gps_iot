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
          <div 
            class="login-tab-item" 
            :class="{ active: loginType === 'account' }" 
            @click="loginType = 'account'"
          >
            账号密码
          </div>
          <div 
            class="login-tab-item" 
            :class="{ active: loginType === 'phone' }" 
            @click="loginType = 'phone'"
          >
            手机验证码
          </div>
          <div 
            class="login-tab-item" 
            :class="{ active: loginType === 'wechat' }" 
            @click="loginType = 'wechat'"
          >
            微信扫码
          </div>
        </div>
        
        <!-- 账号密码登录 -->
        <el-form
          v-if="loginType === 'account'"
          ref="loginFormRef"
          :model="loginForm"
          :rules="loginRules"
          class="login-form"
        >
          <el-form-item prop="username">
            <el-input
              v-model="loginForm.username"
              placeholder="请输入用户名"
              :prefix-icon="User"
              size="large"
            />
          </el-form-item>
          
          <el-form-item prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              placeholder="请输入密码"
              :prefix-icon="Lock"
              show-password
              size="large"
            />
          </el-form-item>
          
          <div class="login-options">
            <el-checkbox v-model="loginForm.remember">记住密码</el-checkbox>
            <a href="#" class="forgot-password">忘记密码?</a>
          </div>
          
          <el-button type="primary" class="login-button" size="large" @click="handleLogin" :loading="loading">
            登录
          </el-button>
        </el-form>
        
        <!-- 手机验证码登录 -->
        <el-form
          v-if="loginType === 'phone'"
          ref="phoneFormRef"
          :model="phoneForm"
          :rules="phoneRules"
          class="login-form"
        >
          <el-form-item prop="phone">
            <el-input
              v-model="phoneForm.phone"
              placeholder="请输入手机号"
              size="large"
            >
              <template #prefix>
                <i class="el-icon-mobile-phone"></i>
              </template>
            </el-input>
          </el-form-item>
          
          <el-form-item prop="code">
            <div class="verification-code-container">
              <el-input
                v-model="phoneForm.code"
                placeholder="请输入验证码"
                size="large"
              >
                <template #prefix>
                  <i class="el-icon-key"></i>
                </template>
              </el-input>
              <el-button 
                type="primary" 
                class="get-code-button" 
                size="large"
                :disabled="codeButtonDisabled"
                @click="getVerificationCode"
              >
                {{ codeButtonText }}
              </el-button>
            </div>
          </el-form-item>
          
          <el-button type="primary" class="login-button" size="large" @click="handlePhoneLogin" :loading="loading">
            登录
          </el-button>
        </el-form>
        
        <!-- 微信扫码登录 -->
        <div v-if="loginType === 'wechat'" class="wechat-login-container">
          <div class="qrcode-container">
            <img src="/wx.png" alt="微信扫码" class="qrcode-img" />
          </div>
          <p class="qrcode-tip">请使用微信扫一扫登录</p>
          <p class="qrcode-status">{{ qrcodeStatus }}</p>
          <el-button type="text" class="refresh-qrcode" @click="refreshQRCode">
            <i class="el-icon-refresh"></i> 刷新二维码
          </el-button>
        </div>
        
        <div class="login-footer">
          <span>还没有账号? <a href="#" @click.prevent="goToRegister">立即注册</a></span>
        </div>
        
        <div class="login-copyright">
          © 2025 ADMCC.cn. All rights reserved.
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import type { FormInstance, FormRules } from 'element-plus'
import { User, Lock } from '@element-plus/icons-vue'
import ElMessage from 'element-plus/es/components/message/index'

const router = useRouter()
const loginFormRef = ref<FormInstance>()
const phoneFormRef = ref<FormInstance>()
const loading = ref(false)

// 登录方式
const loginType = ref('account') // 'account', 'phone', 'wechat'

// 账号密码登录表单
const loginForm = reactive({
  username: '',
  password: '',
  remember: false
})

// 手机验证码登录表单
const phoneForm = reactive({
  phone: '',
  code: ''
})

// 验证码按钮状态
const codeButtonText = ref('获取验证码')
const codeButtonDisabled = ref(false)
const countdown = ref(60)

// 微信二维码状态
const qrcodeStatus = ref('等待扫码')

// 账号密码登录验证规则
const loginRules: FormRules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
  ]
}

// 手机验证码登录验证规则
const phoneRules: FormRules = {
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ],
  code: [
    { required: true, message: '请输入验证码', trigger: 'blur' },
    { pattern: /^\d{6}$/, message: '验证码为6位数字', trigger: 'blur' }
  ]
}

// 账号密码登录
const handleLogin = async () => {
  if (!loginFormRef.value) return
  
  loading.value = true
  
  try {
    await loginFormRef.value.validate((valid, fields) => {
      if (valid) {
        // TODO: 实现登录逻辑
        setTimeout(() => {
          router.push('/')
          loading.value = false
        }, 1000) // 模拟登录延迟
      } else {
        loading.value = false
      }
    })
  } catch (error) {
    loading.value = false
  }
}

// 手机验证码登录
const handlePhoneLogin = async () => {
  if (!phoneFormRef.value) return
  
  loading.value = true
  
  try {
    await phoneFormRef.value.validate((valid, fields) => {
      if (valid) {
        // TODO: 实现手机验证码登录逻辑
        setTimeout(() => {
          router.push('/')
          loading.value = false
        }, 1000) // 模拟登录延迟
      } else {
        loading.value = false
      }
    })
  } catch (error) {
    loading.value = false
  }
}

// 获取验证码
const getVerificationCode = () => {
  // 验证手机号
  if (!/^1[3-9]\d{9}$/.test(phoneForm.phone)) {
    ElMessage.error('请输入正确的手机号')
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
  
  // TODO: 调用发送验证码的API
  ElMessage.success('验证码已发送')
}

// 刷新二维码
const refreshQRCode = () => {
  qrcodeStatus.value = '二维码已刷新，请扫码'
  // TODO: 实现刷新二维码的逻辑
}

// 跳转到注册页面
const goToRegister = () => {
  router.push('/register')
}
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
  height: 560px;
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
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 60%);
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
  
  :deep(.el-input__wrapper) {
    padding: 0 15px;
    height: 50px;
    box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.1) inset;
    
    &:hover, &.is-focus {
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