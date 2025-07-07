Page({
  data: {
    userInfo: {},
    hasUserInfo: false
  },

  onLoad() {
    // 检查是否已经登录
    const userInfo = wx.getStorageSync('userInfo')
    if (userInfo) {
      this.setData({
        userInfo,
        hasUserInfo: true
      })
    }
  },

  getUserProfile() {
    wx.getUserProfile({
      desc: '用于完善用户资料',
      success: (res) => {
        const userInfo = res.userInfo
        wx.setStorageSync('userInfo', userInfo)
        this.setData({
          userInfo,
          hasUserInfo: true
        })
      }
    })
  },

  navigateToMyPets() {
    wx.navigateTo({
      url: '/pages/my-pets/my-pets'
    })
  },

  navigateToSettings() {
    wx.navigateTo({
      url: '/pages/settings/settings'
    })
  },

  navigateToAbout() {
    wx.navigateTo({
      url: '/pages/about/about'
    })
  }
}) 