<template>
  <div class="register-container">
    <div class="register-box">
      <!-- 左侧品牌区域 -->
      <div class="register-brand">
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
      
      <!-- 右侧注册表单区域 -->
      <div class="register-form-container">
        <div class="register-form-header">
          <img src="/marker.png" alt="Logo" class="register-logo" />
          <h2>账号注册</h2>
          <p class="welcome-text">欢迎加入ADMCC物联网定位系统</p>
        </div>
        
        <el-form 
          :model="form" 
          :rules="rules" 
          ref="formRef" 
          class="register-form"
          label-position="top"
        >
          <!-- 用户名称 -->
          <el-form-item label="用户名称" prop="nickname">
            <el-input 
              v-model="form.nickname" 
              placeholder="请输入您的姓名" 
              size="large"
            >
              <template #prefix>
                <i class="el-icon-user"></i>
              </template>
            </el-input>
          </el-form-item>
          
          <!-- 性别 -->
          <el-form-item label="性别" prop="gender">
            <el-radio-group v-model="form.gender" class="gender-group">
              <el-radio label="male">男</el-radio>
              <el-radio label="female">女</el-radio>
    
            </el-radio-group>
          </el-form-item>
          
          <!-- 账号 -->
          <el-form-item label="登录账号" prop="username">
            <el-input 
              v-model="form.username" 
              placeholder="请输入登录账号" 
              size="large"
            >
              <template #prefix>
                <i class="el-icon-user"></i>
              </template>
            </el-input>
          </el-form-item>
          
          <!-- 密码 -->
          <el-form-item label="密码" prop="password">
            <el-input 
              v-model="form.password" 
              type="password" 
              placeholder="请输入密码" 
              size="large"
              show-password
            >
              <template #prefix>
                <i class="el-icon-lock"></i>
              </template>
            </el-input>
          </el-form-item>
          
          <!-- 确认密码 -->
          <el-form-item label="确认密码" prop="confirmPassword">
            <el-input 
              v-model="form.confirmPassword" 
              type="password" 
              placeholder="请确认密码" 
              size="large"
              show-password
            >
              <template #prefix>
                <i class="el-icon-lock"></i>
              </template>
            </el-input>
          </el-form-item>
          
          <!-- 手机号 -->
          <el-form-item label="手机号" prop="phone">
            <el-input 
              v-model="form.phone" 
              placeholder="请输入手机号" 
              size="large"
            >
              <template #prefix>
                <i class="el-icon-mobile-phone"></i>
              </template>
            </el-input>
          </el-form-item>
          
          <!-- 手机验证码 -->
          <el-form-item label="手机验证码" prop="phoneCode">
            <div class="verification-code-container">
              <el-input 
                v-model="form.phoneCode" 
                placeholder="请输入手机验证码" 
                size="large"
              >
                <template #prefix>
                  <i class="el-icon-message"></i>
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
          
          <!-- 图片验证码 -->
          <el-form-item label="图片验证码" prop="captcha">
            <div class="verification-code-container">
              <el-input 
                v-model="form.captcha" 
                placeholder="请输入图片验证码" 
                size="large"
              >
                <template #prefix>
                  <i class="el-icon-picture"></i>
                </template>
              </el-input>
              <div class="captcha-image" @click="refreshCaptcha">
                <img :src="captchaUrl" alt="验证码" />
              </div>
            </div>
          </el-form-item>
          
          <!-- 用户协议 -->
          <el-form-item prop="agreement">
            <el-checkbox v-model="form.agreement">
              我已阅读并同意 <a href="#" @click.prevent="showAgreement">《用户协议》</a> 和 <a href="#" @click.prevent="showPrivacy">《隐私政策》</a>
            </el-checkbox>
          </el-form-item>
          
          <el-form-item class="register-actions">
            <el-button 
              type="primary" 
              class="register-button" 
              size="large" 
              @click="handleRegister"
              :loading="loading"
            >
              立即注册
            </el-button>
          </el-form-item>
          
          <div class="register-footer">
            <span>已有账号? <a href="#" @click.prevent="goToLogin">返回登录</a></span>
          </div>
        </el-form>
        
        <div class="register-copyright">
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
import ElMessage from 'element-plus/es/components/message/index'

const router = useRouter()
const formRef = ref<FormInstance>()
const loading = ref(false)

// 验证码按钮状态
const codeButtonText = ref('获取验证码')
const codeButtonDisabled = ref(false)
const countdown = ref(60)

// 图片验证码URL
const captchaUrl = ref('/api/captcha?t=' + new Date().getTime())

// 表单数据
const form = reactive({
  nickname: '',
  gender: 'male', // 默认选择男性
  username: '',
  password: '',
  confirmPassword: '',
  phone: '',
  phoneCode: '',
  captcha: '',
  agreement: false
})

// 密码验证
const validatePass = (rule: any, value: string, callback: any) => {
  if (value === '') {
    callback(new Error('请输入密码'))
  } else {
    if (form.confirmPassword !== '') {
      // 使用可选链和类型断言来避免TypeScript错误
      (formRef.value as any)?.validateField?.('confirmPassword')
    }
    callback()
  }
}

// 确认密码验证
const validatePass2 = (rule: any, value: string, callback: any) => {
  if (value === '') {
    callback(new Error('请再次输入密码'))
  } else if (value !== form.password) {
    callback(new Error('两次输入密码不一致!'))
  } else {
    callback()
  }
}

// 手机号验证
const validatePhone = (rule: any, value: string, callback: any) => {
  if (value === '') {
    callback(new Error('请输入手机号'))
  } else if (!/^1[3-9]\d{9}$/.test(value)) {
    callback(new Error('请输入正确的手机号'))
  } else {
    callback()
  }
}

// 协议验证
const validateAgreement = (rule: any, value: boolean, callback: any) => {
  if (!value) {
    callback(new Error('请阅读并同意用户协议和隐私政策'))
  } else {
    callback()
  }
}

// 表单验证规则
const rules = {
  nickname: [
    { required: true, message: '请输入用户名称', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  gender: [
    { required: true, message: '请选择性别', trigger: 'change' }
  ],
  username: [
    { required: true, message: '请输入登录账号', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  password: [
    { validator: validatePass, trigger: 'blur' },
    { min: 6, message: '密码长度不能小于6位', trigger: 'blur' }
  ],
  confirmPassword: [
    { validator: validatePass2, trigger: 'blur' }
  ],
  phone: [
    { validator: validatePhone, trigger: 'blur' }
  ],
  phoneCode: [
    { required: true, message: '请输入手机验证码', trigger: 'blur' },
    { pattern: /^\d{6}$/, message: '验证码为6位数字', trigger: 'blur' }
  ],
  captcha: [
    { required: true, message: '请输入图片验证码', trigger: 'blur' },
    { min: 4, max: 6, message: '验证码长度不正确', trigger: 'blur' }
  ],
  agreement: [
    { validator: validateAgreement, trigger: 'change' }
  ]
}

// 获取手机验证码
const getVerificationCode = () => {
  // 验证手机号
  if (!/^1[3-9]\d{9}$/.test(form.phone)) {
    ElMessage.error('请输入正确的手机号')
    return
  }
  
  // 验证图片验证码
  if (!form.captcha) {
    ElMessage.error('请先输入图片验证码')
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

// 刷新图片验证码
const refreshCaptcha = () => {
  captchaUrl.value = '/api/captcha?t=' + new Date().getTime()
}

// 显示用户协议
const showAgreement = () => {
  ElMessage.info('用户协议内容')
  // TODO: 显示用户协议弹窗
}

// 显示隐私政策
const showPrivacy = () => {
  ElMessage.info('隐私政策内容')
  // TODO: 显示隐私政策弹窗
}

// 注册提交
const handleRegister = async () => {
  if (!formRef.value) return
  
  loading.value = true
  
  try {
    await formRef.value.validate((valid) => {
      if (valid) {
        // TODO: 实现注册逻辑
        setTimeout(() => {
          ElMessage.success('注册成功，即将跳转到登录页')
          setTimeout(() => {
            router.push('/login')
          }, 1500)
        }, 1000) // 模拟注册延迟
      } else {
        loading.value = false
      }
    })
  } catch (error) {
    loading.value = false
  }
}

// 跳转到登录页
const goToLogin = () => {
  router.push('/login')
}

// 组件挂载时刷新验证码
onMounted(() => {
  refreshCaptcha()
})
</script>

<style scoped lang="scss">
.register-container {
  height: 100vh;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f5f7fa;
  overflow: hidden;
}

.register-box {
  display: flex;
  width: 1000px;
  height: 700px;
  border-radius: 12px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

// 左侧品牌区域
.register-brand {
  width: 40%;
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

// 右侧注册表单区域
.register-form-container {
  width: 60%;
  background-color: white;
  padding: 30px 40px;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.register-form-header {
  text-align: center;
  margin-bottom: 15px;
  
  .register-logo {
    width: 50px;
    height: 50px;
    margin-bottom: 10px;
  }
  
  h2 {
    font-size: 24px;
    color: #303133;
    margin-bottom: 5px;
  }
  
  .welcome-text {
    color: #909399;
    font-size: 14px;
  }
}

.register-form {
  flex: 1;
  
  :deep(.el-form-item) {
    margin-bottom: 15px;
  }
  
  :deep(.el-form-item__label) {
    padding-bottom: 5px;
    font-weight: 500;
    line-height: 1;
  }
  
  :deep(.el-input__wrapper) {
    padding: 0 15px;
    height: 45px;
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
    height: 45px;
    white-space: nowrap;
    padding: 0 8px;
    font-size: 14px;
  }
  
  .captcha-image {
    flex: 1;
    height: 45px;
    margin-left: 10px;
    border: 1px solid #dcdfe6;
    border-radius: 4px;
    overflow: hidden;
    cursor: pointer;
    
    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }
}

.register-actions {
  margin-top: 20px;
}

.register-button {
  width: 100%;
  height: 45px;
  font-size: 16px;
  border-radius: 4px;
  background: linear-gradient(to right, #1890ff, #096dd9);
  border: none;
  
  &:hover {
    background: linear-gradient(to right, #40a9ff, #1890ff);
  }
}

.register-footer {
  margin-top: 15px;
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

.register-copyright {
  margin-top: 15px;
  text-align: center;
  font-size: 12px;
  color: #909399;
}

.gender-group {
  display: flex;
  justify-content: flex-start;
  
  :deep(.el-radio) {
    margin-right: 30px;
    
    &:last-child {
      margin-right: 0;
    }
  }
}
</style> 