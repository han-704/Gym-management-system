<template>
<div class="home-container">
  <!-- 欢迎横幅 -->
  <div class="welcome-banner">
    <div class="welcome-left">
      <div class="welcome-avatar" :style="{background: avatarColor}">
        {{ avatarText }}
      </div>
      <div class="welcome-info">
        <h2 class="welcome-title">{{ greeting }}，{{ userName }}</h2>
        <p class="welcome-sub">{{ roleName }} | {{ this.$project.projectName }}</p>
      </div>
    </div>
    <div class="welcome-right">
      <div class="clock-display">
        <div class="clock-time">{{ currentTime }}</div>
        <div class="clock-date">{{ currentDate }}</div>
      </div>
    </div>
  </div>

  <!-- 数据统计图表 -->
  <div class="charts-row">
    <!-- 柱状图 -->
    <div class="chart-card">
      <div class="chart-title">数据统计</div>
      <div ref="barChart" class="chart-container"></div>
    </div>
    <!-- 饼图 -->
    <div class="chart-card">
      <div class="chart-title">数据占比</div>
      <div ref="pieChart" class="chart-container"></div>
    </div>
  </div>

  <!-- 快捷入口 -->
  <div class="section-title">快捷入口</div>
  <div class="quick-grid">
    <div class="quick-card" v-for="(item, index) in quickList" :key="index" @click="goPage(item.route)">
      <div class="quick-icon" :style="{background: item.bg}">
        <i :class="item.icon"></i>
      </div>
      <span class="quick-label">{{ item.label }}</span>
    </div>
  </div>

  <!-- 励志标语 -->
  <div class="quote-card">
    <div class="quote-icon"><i class="el-icon-chat-line-round"></i></div>
    <p class="quote-text">{{ currentQuote }}</p>
    <button class="quote-refresh" @click="refreshQuote">
      <i class="el-icon-refresh-right"></i> 换一句
    </button>
  </div>
</div>
</template>
<script>
import router from '@/router/router-static'
import * as echarts from 'echarts'
export default {
  data() {
    return {
      currentTime: '',
      currentDate: '',
      userName: '',
      roleName: '',
      greeting: '',
      timer: null,
      quoteIndex: 0,
      currentQuote: '',
      statsList: [
        { label: '会员总数', value: 0, icon: 'el-icon-user-solid', color: '#667eea' },
        { label: '教练数量', value: 0, icon: 'el-icon-s-cooperation', color: '#f093fb' },
        { label: '健身项目', value: 0, icon: 'el-icon-s-flag', color: '#4facfe' },
        { label: '健身活动', value: 0, icon: 'el-icon-s-order', color: '#43e97b' }
      ],
      quotes: [
        '没有什么比健康更宝贵的财富。',
        '坚持运动，是对自己最好的投资。',
        '每天进步一点点，就是成功的开始。',
        '自律给我自由，运动让我更强。',
        '身体是革命的本钱，健身是最好的保养。',
        '流下的每一滴汗水，都是对未来的投资。',
        '今天流汗，是为了明天更轻松地生活。',
        '健身不是一阵子，而是一辈子。'
      ]
    }
  },
  computed: {
    avatarText() {
      return this.userName ? this.userName.charAt(0) : '?'
    },
    avatarColor() {
      var colors = ['#667eea', '#f093fb', '#4facfe', '#43e97b', '#fa709a', '#feb47b']
      var idx = this.userName ? this.userName.charCodeAt(0) % colors.length : 0
      return colors[idx]
    },
    quickList() {
      var base = [
        { label: '会员管理', icon: 'el-icon-user', bg: 'linear-gradient(135deg, #667eea, #764ba2)', route: '/huiyuan' },
        { label: '教练信息', icon: 'el-icon-s-custom', bg: 'linear-gradient(135deg, #f093fb, #f5576c)', route: '/jiaolianxinxi' },
        { label: '健身项目', icon: 'el-icon-s-flag', bg: 'linear-gradient(135deg, #4facfe, #00f2fe)', route: '/jianshenxiangmu' },
        { label: '健身器材', icon: 'el-icon-s-platform', bg: 'linear-gradient(135deg, #43e97b, #38f9d7)', route: '/jianshenqicai' },
        { label: '健身活动', icon: 'el-icon-s-order', bg: 'linear-gradient(135deg, #fa709a, #fee140)', route: '/jianshenhuodong' },
        { label: 'AI教练', icon: 'el-icon-chat-dot-round', bg: 'linear-gradient(135deg, #a18cd1, #fbc2eb)', route: '/aicoachChat' },
        { label: '健身心得', icon: 'el-icon-document', bg: 'linear-gradient(135deg, #ffecd2, #fcb69f)', route: '/xindefu' },
        { label: '附近健身房', icon: 'el-icon-location', bg: 'linear-gradient(135deg, #84fab0, #8fd3f4)', route: '/gymmap' }
      ]
      return base
    }
  },
  mounted() {
    this.init()
    this.updateClock()
    this.timer = setInterval(this.updateClock, 1000)
    this.refreshQuote()
    this.$nextTick(() => {
      this.initCharts()
    })
  },
  beforeDestroy() {
    if (this.timer) clearInterval(this.timer)
    if (this.barChart) this.barChart.dispose()
    if (this.pieChart) this.pieChart.dispose()
  },
  methods: {
    init() {
      var that = this
      this.userName = this.$storage.get('adminName') || ''
      this.roleName = this.$storage.get('role') || ''
      if (this.$storage.get('Token')) {
        this.$http({
          url: this.$storage.get('sessionTable') + '/session',
          method: 'get'
        }).then(function(res) {
          var data = res.data
          if (data && data.code === 0) {
            that.userName = data.data.huiyuanName || data.data.yuangongName || data.data.usersName || data.data.username || ''
          } else {
            router.push({ name: 'login' })
          }
        })
        this.loadStatistics()
      } else {
        router.push({ name: 'login' })
      }
    },
    updateClock() {
      var now = new Date()
      var h = now.getHours()
      var m = now.getMinutes().toString().padStart(2, '0')
      var s = now.getSeconds().toString().padStart(2, '0')
      this.currentTime = h + ':' + m + ':' + s

      if (h < 6) this.greeting = '夜深了'
      else if (h < 9) this.greeting = '早上好'
      else if (h < 12) this.greeting = '上午好'
      else if (h < 14) this.greeting = '中午好'
      else if (h < 18) this.greeting = '下午好'
      else this.greeting = '晚上好'

      var week = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
      var y = now.getFullYear()
      var mon = (now.getMonth() + 1).toString().padStart(2, '0')
      var d = now.getDate().toString().padStart(2, '0')
      this.currentDate = y + '年' + mon + '月' + d + '日 ' + week[now.getDay()]
    },
    loadStatistics() {
      var that = this
      var modules = ['huiyuan', 'jiaolianxinxi', 'jianshenxiangmu', 'jianshenhuodong']
      modules.forEach(function(mod, index) {
        that.$http({
          url: mod + '/page',
          method: 'get',
          params: { page: 1, limit: 1 }
        }).then(function(res) {
          if (res.data && res.data.code === 0 && res.data.data) {
            that.$set(that.statsList[index], 'value', res.data.data.total)
            that.$nextTick(() => {
              that.updateCharts()
            })
          }
        })
      })
    },
    initCharts() {
      // 等待 DOM 元素渲染完成
      if (!this.$refs.barChart || !this.$refs.pieChart) {
        setTimeout(() => { this.initCharts() }, 100)
        return
      }
      this.barChart = echarts.init(this.$refs.barChart)
      this.pieChart = echarts.init(this.$refs.pieChart)
      this.updateCharts()
      window.addEventListener('resize', () => {
        if (this.barChart) this.barChart.resize()
        if (this.pieChart) this.pieChart.resize()
      })
    },
    updateCharts() {
      if (!this.barChart || !this.pieChart) return

      var labels = this.statsList.map(item => item.label)
      var values = this.statsList.map(item => item.value)
      var colors = this.statsList.map(item => item.color)

      // 柱状图配置
      this.barChart.setOption({
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'shadow' }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: labels,
          axisLine: { lineStyle: { color: '#999' } },
          axisLabel: { color: '#666', fontSize: 12 }
        },
        yAxis: {
          type: 'value',
          axisLine: { show: false },
          axisLabel: { color: '#999' },
          splitLine: { lineStyle: { type: 'dashed', color: '#eee' } }
        },
        series: [{
          data: values.map((val, idx) => ({
            value: val,
            itemStyle: { color: colors[idx] }
          })),
          type: 'bar',
          barWidth: '40%',
          itemStyle: {
            borderRadius: [8, 8, 0, 0]
          },
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowColor: 'rgba(0,0,0,0.2)'
            }
          }
        }]
      })

      // 饼图配置
      this.pieChart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{b}: {c} ({d}%)'
        },
        legend: {
          orient: 'vertical',
          right: '5%',
          top: 'center',
          textStyle: { color: '#666' }
        },
        series: [{
          type: 'pie',
          radius: ['40%', '70%'],
          center: ['40%', '50%'],
          avoidLabelOverlap: false,
          itemStyle: {
            borderRadius: 8,
            borderColor: '#fff',
            borderWidth: 2
          },
          label: {
            show: false,
            position: 'center'
          },
          emphasis: {
            label: {
              show: true,
              fontSize: 16,
              fontWeight: 'bold',
              formatter: '{b}\n{c}'
            }
          },
          labelLine: { show: false },
          data: this.statsList.map((item, idx) => ({
            value: item.value,
            name: item.label,
            itemStyle: { color: item.color }
          }))
        }]
      })
    },
    goPage(route) {
      this.$router.push(route)
    },
    refreshQuote() {
      var idx = Math.floor(Math.random() * this.quotes.length)
      if (idx === this.quoteIndex && this.quotes.length > 1) {
        idx = (idx + 1) % this.quotes.length
      }
      this.quoteIndex = idx
      this.currentQuote = this.quotes[idx]
    }
  }
}
</script>

<style lang="scss" scoped>
.home-container {
  padding: 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
  min-height: calc(100vh - 140px);
  border-radius: 12px;
}

/* 欢迎横幅 */
.welcome-banner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  padding: 28px 32px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  box-shadow: 0 8px 24px rgba(102, 126, 234, 0.3);
  animation: slideDown 0.6s ease-out;

  .welcome-left {
    display: flex;
    align-items: center;
    gap: 18px;

    .welcome-avatar {
      width: 56px;
      height: 56px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 24px;
      font-weight: 700;
      color: #fff;
      border: 3px solid rgba(255, 255, 255, 0.4);
      flex-shrink: 0;
    }

    .welcome-info {
      .welcome-title {
        font-size: 22px;
        font-weight: 600;
        color: #fff;
        margin: 0 0 4px 0;
      }
      .welcome-sub {
        font-size: 14px;
        color: rgba(255, 255, 255, 0.75);
        margin: 0;
      }
    }
  }

  .welcome-right {
    .clock-display {
      text-align: right;

      .clock-time {
        font-size: 36px;
        font-weight: 700;
        color: #fff;
        font-variant-numeric: tabular-nums;
        letter-spacing: 2px;
        line-height: 1.2;
      }
      .clock-date {
        font-size: 13px;
        color: rgba(255, 255, 255, 0.7);
        margin-top: 2px;
      }
    }
  }
}

/* 统计图表 */
.charts-row {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  margin-bottom: 24px;
}

.chart-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  animation: fadeUp 0.5s ease-out backwards;

  &:nth-child(1) { animation-delay: 0.1s; }
  &:nth-child(2) { animation-delay: 0.2s; }

  .chart-title {
    font-size: 16px;
    font-weight: 600;
    color: #303133;
    margin-bottom: 16px;
    padding-left: 10px;
    border-left: 3px solid #667eea;
  }

  .chart-container {
    width: 100%;
    height: 300px;
  }
}

/* 区域标题 */
.section-title {
  font-size: 17px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 14px;
  padding-left: 10px;
  border-left: 3px solid #667eea;
}

/* 快捷入口 */
.quick-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.quick-card {
  background: #fff;
  border-radius: 12px;
  padding: 22px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  cursor: pointer;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
  animation: fadeUp 0.5s ease-out backwards;

  &:nth-child(1) { animation-delay: 0.15s; }
  &:nth-child(2) { animation-delay: 0.2s; }
  &:nth-child(3) { animation-delay: 0.25s; }
  &:nth-child(4) { animation-delay: 0.3s; }
  &:nth-child(5) { animation-delay: 0.35s; }
  &:nth-child(6) { animation-delay: 0.4s; }
  &:nth-child(7) { animation-delay: 0.45s; }
  &:nth-child(8) { animation-delay: 0.5s; }

  &:hover {
    transform: translateY(-6px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  }

  .quick-icon {
    width: 48px;
    height: 48px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;

    i {
      font-size: 24px;
      color: #fff;
    }
  }

  .quick-label {
    font-size: 14px;
    color: #303133;
    font-weight: 500;
  }
}

/* 励志标语 */
.quote-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px 28px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  animation: fadeUp 0.6s ease-out 0.5s backwards;

  .quote-icon {
    width: 44px;
    height: 44px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea, #764ba2);
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;

    i {
      font-size: 20px;
      color: #fff;
    }
  }

  .quote-text {
    flex: 1;
    font-size: 15px;
    color: #606266;
    font-style: italic;
    margin: 0;
    line-height: 1.6;
  }

  .quote-refresh {
    background: transparent;
    border: 1px solid #dcdfe6;
    border-radius: 8px;
    padding: 6px 14px;
    font-size: 13px;
    color: #909399;
    cursor: pointer;
    white-space: nowrap;
    transition: all 0.3s ease;
    flex-shrink: 0;

    &:hover {
      border-color: #667eea;
      color: #667eea;
    }
    i {
      font-size: 13px;
    }
  }
}

/* 动画 */
@keyframes slideDown {
  from { opacity: 0; transform: translateY(-20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
