// 获取应用实例
const app = getApp()

// 格式化日期函数
function formatDate(date) {
  const year = date.getFullYear()
  const month = (date.getMonth() + 1).toString().padStart(2, '0')
  const day = date.getDate().toString().padStart(2, '0')
  return `${year}-${month}-${day}`
}

Page({
  data: {
    motto: 'Hello World',

    hasUserInfo: false,
    canIUseGetUserProfile: wx.canIUse('getUserProfile'),
    canIUseNicknameComp: wx.canIUse('input.type.nickname'),
    longitude: 104.104281,
    latitude: 30.489069,
    markers: [],
    polylines: [], // 轨迹线路
    pets: [
      // 测试数据，实际应该从后端获取
      {
        id: 1,
        name: '小白',
        avatar: '/assets/images/marker.png',
        latitude: 30.489069,
        longitude: 	104.104281,
        address: '四川省成都市万安街道',
        updateTime: '2025-07-11 14:30:00'
      }
    ],
    includePoints: [], // 用于自动缩放地图
    scale: 14,
    // 日期时间选择相关
    startDate: '',
    startTime: '00:00',
    endDate: '',
    endTime: '23:59',
    currentPickerType: '' // 'start' 或 'end'
  },
  bindViewTap() {
    wx.navigateTo({
      url: '../logs/logs'
    })
  },
  onLoad() {
    // 初始化日期
    const today = new Date()
    this.setData({
      startDate: formatDate(today),
      endDate: formatDate(today)
    })

    this.mapCtx = wx.createMapContext('map')
    this.getCurrentLocation()
    this.loadPetsLocation()
  },
  onShow() {
    // 每次页面显示时刷新位置
    this.loadPetsLocation()
  },
  getCurrentLocation() {
    wx.getLocation({
      type: 'gcj02',
      success: (res) => {
        const { longitude, latitude } = res
        this.setData({ longitude, latitude }, () => {
          this.updateMapView()
        })
      },
      fail: () => {
        wx.showToast({
          title: '获取位置失败',
          icon: 'none'
        })
      }
    })
  },
  loadPetsLocation() {
    // TODO: 实际项目中这里应该调用后端API获取宠物位置
    // 这里使用模拟数据
    wx.showLoading({
      title: '加载中...'
    })

    // 模拟API请求延迟
    setTimeout(() => {
      const pets = this.data.pets
      this.setData({ pets }, () => {
        this.updateMarkers()
        this.updateMapView()
        wx.hideLoading()
      })
    }, 500)
  },
  updateMarkers() {
    const markers = this.data.pets.map(pet => ({
      id: pet.id,
      latitude: pet.latitude,
      longitude: pet.longitude,
      width: 40,
      height: 40,
      iconPath: '/assets/images/marker.png', // 自定义图标
      callout: {
        content: pet.name,
        color: '#ffffff',
        fontSize: 14,
        borderRadius: 4,
        bgColor: '#1989fa',
        padding: 8,
        display: 'ALWAYS'
      }
    }))
    this.setData({ markers })
  },
  updateMapView() {
    // 计算所有需要包含的点（宠物位置和当前位置）
    const includePoints = [
      ...this.data.pets.map(pet => ({
        latitude: pet.latitude,
        longitude: pet.longitude
      })),
      {
        latitude: this.data.latitude,
        longitude: this.data.longitude
      }
    ]

    // 更新地图视野
    this.setData({ includePoints }, () => {
      this.mapCtx.includePoints({
        points: includePoints,
        padding: [80, 80, 80, 80] // 设置地图边距，使所有点都在视野内
      })
    })
  },
  refreshLocations() {
    wx.showLoading({
      title: '刷新中...'
    })
    
    this.loadPetsLocation()
    
    setTimeout(() => {
      wx.hideLoading()
      wx.showToast({
        title: '位置已更新',
        icon: 'success'
      })
    }, 500)
  },
  handleMarkerTap(e) {
    const markerId = e.markerId
    const pet = this.data.pets.find(p => p.id === markerId)
    if (pet) {
      this.showPetDetail(pet)
    }
  },
  showPetDetail(e) {
    const pet = e.currentTarget ? e.currentTarget.dataset.pet : e
    wx.showModal({
      title: pet.name,
      content: `位置：${pet.address}\n更新时间：${pet.updateTime}`,
      showCancel: false
    })
  },
  navigateToPet(e) {
    const pet = e.currentTarget.dataset.pet
    wx.openLocation({
      latitude: pet.latitude,
      longitude: pet.longitude,
      name: pet.name,
      address: pet.address,
      scale: 18
    })
  },

  // 显示开始时间选择器
  showStartPicker() {
    this.setData({ currentPickerType: 'start' })
    wx.showActionSheet({
      itemList: ['选择日期', '选择时间'],
      success: (res) => {
        if (res.tapIndex === 0) {
          this.showDatePicker('start')
        } else {
          this.showTimePicker('start')
        }
      }
    })
  },
  // 显示结束时间选择器
  showEndPicker() {
    this.setData({ currentPickerType: 'end' })
    wx.showActionSheet({
      itemList: ['选择日期', '选择时间'],
      success: (res) => {
        if (res.tapIndex === 0) {
          this.showDatePicker('end')
        } else {
          this.showTimePicker('end')
        }
      }
    })
  },
  // 显示日期选择器
  showDatePicker(type) {
    const currentDate = type === 'start' ? this.data.startDate : this.data.endDate
    wx.showDatePicker({
      current: currentDate,
      success: (res) => {
        const date = formatDate(new Date(res.value))
        if (type === 'start') {
          this.setData({ startDate: date })
        } else {
          this.setData({ endDate: date })
        }
      }
    })
  },
  // 显示时间选择器
  showTimePicker(type) {
    const currentTime = type === 'start' ? this.data.startTime : this.data.endTime
    wx.showTimePickerView({
      value: currentTime,
      success: (res) => {
        if (type === 'start') {
          this.setData({ startTime: res.value })
        } else {
          this.setData({ endTime: res.value })
        }
      }
    })
  },
  // 查询轨迹
  searchTrack() {
    const { startDate, startTime, endDate, endTime } = this.data
    const startDateTime = `${startDate} ${startTime}`
    const endDateTime = `${endDate} ${endTime}`

    // 验证时间范围
    if (new Date(startDateTime) > new Date(endDateTime)) {
      wx.showToast({
        title: '开始时间不能大于结束时间',
        icon: 'none'
      })
      return
    }

    wx.showLoading({
      title: '查询中...'
    })

    // 模拟轨迹数据
    setTimeout(() => {
      // 真实轨迹点数据
      const trackPoints = [
        { longitude: 104.08239557187153, latitude: 30.485066557925229 },
        { longitude: 104.082595466144753, latitude: 30.485093059640345 },
        { longitude: 104.082795360418004, latitude: 30.485053307064966 },
        { longitude: 104.082918372278442, latitude: 30.484920798363106 },
        { longitude: 104.08313364303423, latitude: 30.484788289480832 },
        { longitude: 104.083195148964435, latitude: 30.484602776742562 },
        { longitude: 104.083333537307439, latitude: 30.484324506972168 },
        { longitude: 104.083471925650443, latitude: 30.484019734406029 },
        { longitude: 104.083410419720224, latitude: 30.483820969174833 },
        { longitude: 104.083518055098111, latitude: 30.483516195031978 },
        { longitude: 104.083610313993461, latitude: 30.483251173262449 },
        { longitude: 104.083810208266669, latitude: 30.482906643883258 },
        { longitude: 104.083917843644556, latitude: 30.482707876379003 },
        { longitude: 104.084025479022444, latitude: 30.482482606050159 },
        { longitude: 104.084240749778232, latitude: 30.482336842618384 },
        { longitude: 104.084348385156119, latitude: 30.482389847527919 },
        { longitude: 104.084394514603787, latitude: 30.482588615681621 },
        { longitude: 104.08445602053402, latitude: 30.482707876379003 },
        { longitude: 104.084640538324663, latitude: 30.482986150771318 },
        { longitude: 104.084732797220013, latitude: 30.483290926573876 },
        { longitude: 104.084748173702565, latitude: 30.483476441812545 },
        { longitude: 104.084886562045568, latitude: 30.483622203537735 },
        { longitude: 104.084963444458353, latitude: 30.483807718144995 },
        { longitude: 104.085101832801357, latitude: 30.483900475316023 },
        { longitude: 104.085224844661795, latitude: 30.483900475316023 },
        { longitude: 104.085440115417583, latitude: 30.483728211928039 },
        { longitude: 104.085701515621025, latitude: 30.483608952480829 },
        { longitude: 104.085901409894248, latitude: 30.483516195031978 },
        { longitude: 104.086009045272121, latitude: 30.483343930963869 },
        { longitude: 104.086116680650022, latitude: 30.483184917707312 },
        { longitude: 104.086193563062807, latitude: 30.483025904190985 },
        { longitude: 104.086208939545358, latitude: 30.482760881086492 },
        { longitude: 104.086301198440694, latitude: 30.482535610880319 },
        { longitude: 104.086362704370913, latitude: 30.482323591386489 },
        { longitude: 104.086378080853478, latitude: 30.481873048428728 },
        { longitude: 104.086408833818581, latitude: 30.48156826818655 },
        { longitude: 104.086424210301146, latitude: 30.48130324111332 }
      ]

      // 更新轨迹线路
      this.setData({
        polylines: [{
          points: trackPoints,
          color: '#1989fa',
          width: 4,
          arrowLine: true,
          borderColor: '#fff',
          borderWidth: 1
        }]
      })

      // 调整地图视野以显示完整轨迹
      this.mapCtx.includePoints({
        points: trackPoints,
        padding: [80, 80, 80, 80]
      })

      wx.hideLoading()
    }, 1000)
  },
})
