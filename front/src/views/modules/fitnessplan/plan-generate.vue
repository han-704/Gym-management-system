<template>
  <div class="main-content">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <i class="el-icon-c-scale-to-original"></i>
        <h1>智谱大模型健身计划生成</h1>
        <p>基于智谱AI大模型，为您生成个性化训练方案</p>
      </div>
    </div>

    <div class="content-wrapper">
      <!-- 输入表单区域 -->
      <div class="input-section">
        <el-card class="input-card" shadow="hover">
          <div slot="header" class="card-header">
            <i class="el-icon-edit-outline"></i>
            <span>身体数据录入</span>
          </div>

          <el-form :model="form" :rules="rules" ref="form" label-width="100px" class="plan-form">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="身高" prop="shengao">
                  <el-input v-model="form.shengao" placeholder="请输入身高(cm)" @input="calculateBMI">
                    <template slot="append">cm</template>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="体重" prop="tizhong">
                  <el-input v-model="form.tizhong" placeholder="请输入体重(kg)" @input="calculateBMI">
                    <template slot="append">kg</template>
                  </el-input>
                </el-form-item>
              </el-col>
            </el-row>

            <!-- BMI 展示 -->
            <el-form-item label="BMI指数">
              <div class="bmi-box">
                <div class="bmi-gauge">
                  <div class="gauge-track">
                    <div class="gauge-fill" :style="{width: gaugeWidth}"></div>
                    <div class="gauge-marker" :style="{left: gaugeWidth}"></div>
                  </div>
                  <div class="gauge-labels">
                    <span>偏瘦</span>
                    <span>正常</span>
                    <span>偏胖</span>
                    <span>肥胖</span>
                  </div>
                </div>
                <div class="bmi-result">
                  <span class="bmi-value" :class="bmiClass">{{ bmiValue }}</span>
                  <span class="bmi-tip">{{ bmiTip }}</span>
                </div>
              </div>
            </el-form-item>

            <el-divider></el-divider>

            <el-form-item label="健身目标" prop="jianshenmubiao">
              <el-radio-group v-model="form.jianshenmubiao" class="goal-group">
                <el-radio-button label="减脂">
                  <i class="el-icon-delete"></i> 减脂
                </el-radio-button>
                <el-radio-button label="增肌">
                  <i class="el-icon-plus"></i> 增肌
                </el-radio-button>
                <el-radio-button label="塑形">
                  <i class="el-icon-s-data"></i> 塑形
                </el-radio-button>
                <el-radio-button label="康复">
                  <i class="el-icon-first-aid-kit"></i> 康复
                </el-radio-button>
              </el-radio-group>
            </el-form-item>

            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="训练等级" prop="jianshendengji">
                  <el-select v-model="form.jianshendengji" placeholder="请选择" class="full-width">
                    <el-option label="初级 - 健身新手" value="初级">
                      <span>初级</span>
                      <span class="option-tip">健身新手</span>
                    </el-option>
                    <el-option label="中级 - 有基础" value="中级">
                      <span>中级</span>
                      <span class="option-tip">有基础</span>
                    </el-option>
                    <el-option label="高级 - 资深玩家" value="高级">
                      <span>高级</span>
                      <span class="option-tip">资深玩家</span>
                    </el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="每周训练" prop="meizhouxunliantian">
                  <el-slider v-model="form.meizhouxunliantian" :min="2" :max="6" :marks="sliderMarks" show-stops></el-slider>
                </el-form-item>
              </el-col>
            </el-row>

            <el-form-item label="备注">
              <el-input v-model="form.beizhu" type="textarea" :rows="2" placeholder="如有特殊情况请说明"></el-input>
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="generatePlan" :loading="loading" class="generate-btn">
                <i class="el-icon-magic-stick"></i> 智谱AI生成专属计划
              </el-button>
              <el-button @click="resetForm" class="reset-btn">
                <i class="el-icon-refresh"></i> 重置
              </el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>

      <!-- 生成的计划展示 -->
      <div v-if="generatedPlan" class="result-section">
        <el-card class="result-card" shadow="hover">
          <div slot="header" class="card-header success-header">
            <div class="header-left">
              <i class="el-icon-circle-check"></i>
              <span>健身计划详情</span>
            </div>
            <div class="header-actions">
              <el-button type="primary" size="small" @click="exportExcel">
                <i class="el-icon-download"></i> 导出CSV
              </el-button>
              <el-button size="small" @click="exportTxt">
                <i class="el-icon-document"></i> 导出Txt
              </el-button>
            </div>
          </div>

          <!-- 计划概览 -->
          <div class="plan-overview">
            <div class="overview-header">
              <h2>{{ generatedPlan.planName }}</h2>
              <el-tag :type="generatedPlan.status === '进行中' ? 'success' : 'info'" size="medium">{{ generatedPlan.status }}</el-tag>
            </div>
            <el-row :gutter="20" class="overview-stats">
              <el-col :span="6">
                <div class="stat-item">
                  <i class="el-icon-user"></i>
                  <div class="stat-info">
                    <span class="stat-value">{{ generatedPlan.shengao }}cm</span>
                    <span class="stat-label">身高</span>
                  </div>
                </div>
              </el-col>
              <el-col :span="6">
                <div class="stat-item">
                  <i class="el-icon重量"></i>
                  <div class="stat-info">
                    <span class="stat-value">{{ generatedPlan.tizhong }}kg</span>
                    <span class="stat-label">体重</span>
                  </div>
                </div>
              </el-col>
              <el-col :span="6">
                <div class="stat-item">
                  <i class="el-icon-data-line"></i>
                  <div class="stat-info">
                    <span class="stat-value">{{ generatedPlan.bmi.toFixed(1) }}</span>
                    <span class="stat-label">BMI</span>
                  </div>
                </div>
              </el-col>
              <el-col :span="6">
                <div class="stat-item">
                  <i class="el-icon-calendar"></i>
                  <div class="stat-info">
                    <span class="stat-value">{{ generatedPlan.meizhouxunliantian }}天</span>
                    <span class="stat-label">每周训练</span>
                  </div>
                </div>
              </el-col>
            </el-row>
            <div class="plan-period">
              <i class="el-icon-time"></i>
              <span>计划周期：{{ formatDate(generatedPlan.startDate) }} 至 {{ formatDate(generatedPlan.endDate) }}</span>
            </div>
          </div>

          <el-divider content-position="left">
            <i class="el-icon-s-order"></i> 每周训练安排
          </el-divider>

          <!-- 每周训练安排 -->
          <div class="weekly-plan">
            <el-collapse v-model="activeNames" accordion>
              <el-collapse-item v-for="day in weeklyPlanList" :key="day.day" :name="String(day.day)">
                <template slot="title">
                  <div class="day-header">
                    <div class="day-info">
                      <span class="day-badge" :class="day.isRest ? 'rest' : 'active'">{{ day.dayName }}</span>
                      <span class="day-type">{{ day.isRest ? '休息日' : '训练日' }}</span>
                    </div>
                    <div class="day-stats" v-if="!day.isRest && day.items.length > 0">
                      <span class="stat-tag">{{ day.items.length }}个训练</span>
                      <span class="stat-tag">{{ getTotalTime(day.items) }}分钟</span>
                    </div>
                  </div>
                </template>

                <div v-if="day.isRest" class="rest-content">
                  <i class="el-icon-moon-night"></i>
                  <div class="rest-tips">
                    <h4>休息是为了更好地训练</h4>
                    <p>{{ day.items[0] && day.items[0].beizhu ? day.items[0].beizhu : '建议：保持充足睡眠，注意饮食营养均衡' }}</p>
                  </div>
                </div>

                <div v-else class="training-content">
                  <el-timeline>
                    <el-timeline-item v-for="(item, index) in day.items" :key="index" :timestamp="item.shiduan" placement="top" :type="index === 0 ? 'primary' : 'info'">
                      <el-card class="training-card">
                        <div class="training-header">
                          <h4>{{ item.xiangmumingcheng }}</h4>
                          <el-tag size="mini" type="info">{{ item.xiangmuleixing }}</el-tag>
                        </div>
                        <div class="training-details">
                          <span><i class="el-icon-time"></i> {{ item.shichang }}分钟</span>
                          <span><i class="el-icon-s-data"></i> {{ item.zushu }}组 × {{ item.cishu }}次</span>
                          <span><i class="el-icon-bell"></i> 休息{{ item.xiuxishijian }}秒</span>
                        </div>
                        <div class="training-note" v-if="item.beizhu">
                          <i class="el-icon-warning"></i> {{ item.beizhu }}
                        </div>
                      </el-card>
                    </el-timeline-item>
                  </el-timeline>
                </div>
              </el-collapse-item>
            </el-collapse>
          </div>
        </el-card>
      </div>

      <!-- 空状态 -->
      <div v-else class="empty-section">
        <div class="empty-content">
          <i class="el-icon-fitness"></i>
          <h3>准备开始您的健身之旅</h3>
          <p>填写上方表单，生成专属健身计划</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      searchForm: {},
      form: {
        shengao: '',
        tizhong: '',
        jianshenmubiao: '塑形',
        jianshendengji: '初级',
        meizhouxunliantian: 3,
        beizhu: ''
      },
      rules: {
        shengao: [
          { required: true, message: '请输入身高', trigger: 'blur' },
          { pattern: /^(100|1[0-9]{2}|2[0-4]\d|250)$/, message: '请输入合理的身高(100-250)', trigger: 'blur' }
        ],
        tizhong: [
          { required: true, message: '请输入体重', trigger: 'blur' },
          { pattern: /^(30|[3-9]\d|1[0-9]{2}|200)$/, message: '请输入合理的体重(30-200)', trigger: 'blur' }
        ],
        jianshenmubiao: [{ required: true, message: '请选择健身目标', trigger: 'change' }],
        jianshendengji: [{ required: true, message: '请选择训练等级', trigger: 'change' }]
      },
      contents: {},
      showFlag: true,
      loading: false,
      bmiValue: '0.0',
      bmiTip: '请输入身高和体重',
      generatedPlan: null,
      weeklyPlanList: [],
      activeNames: ['1'],
      huiyuanInfo: null,
      sliderMarks: {
        2: '2天',
        3: '3天',
        4: '4天',
        5: '5天',
        6: '6天'
      }
    };
  },
  computed: {
    bmiClass: function() {
      var bmi = parseFloat(this.bmiValue);
      if (bmi < 18.5) return 'bmi-low';
      if (bmi < 24) return 'bmi-normal';
      if (bmi < 28) return 'bmi-overweight';
      return 'bmi-obese';
    },
    gaugeWidth: function() {
      var bmi = parseFloat(this.bmiValue);
      if (bmi <= 0) return '0%';
      if (bmi >= 35) return '100%';
      return ((bmi / 35) * 100) + '%';
    }
  },
  created: function() {
    this.init();
  },
  methods: {
    init: function() {
      this.getSession();
    },
    getSession: function() {
      var _this = this;
      this.$http({
        url: 'huiyuan/session',
        method: 'get'
      }).then(function(res) {
        if (res.data && res.data.code === 0) {
          _this.huiyuanInfo = res.data.data;
        } else {
          _this.$message.error('请先登录');
        }
      }).catch(function(err) {
        console.error('获取session失败:', err);
        _this.$message.error('请先登录');
      });
    },
    calculateBMI: function() {
      var shengao = parseFloat(this.form.shengao);
      var tizhong = parseFloat(this.form.tizhong);
      if (shengao > 0 && tizhong > 0) {
        var bmi = tizhong / Math.pow(shengao / 100, 2);
        this.bmiValue = bmi.toFixed(1);
        if (bmi < 18.5) {
          this.bmiTip = '偏瘦 - 建议增肌训练';
        } else if (bmi < 24) {
          this.bmiTip = '正常 - 保持训练习惯';
        } else if (bmi < 28) {
          this.bmiTip = '偏胖 - 建议减脂训练';
        } else {
          this.bmiTip = '肥胖 - 建议减脂训练';
        }
      } else {
        this.bmiValue = '0.0';
        this.bmiTip = '请输入身高和体重';
      }
    },
    generatePlan: function() {
      var _this = this;
      this.$refs.form.validate(function(valid) {
        if (valid) {
          if (!_this.huiyuanInfo) {
            _this.$message.error('请先登录');
            return;
          }
          _this.loading = true;
          // 显示AI生成中的提示
          _this.$message({
            message: '正在调用智谱AI生成健身计划，请稍候...',
            type: 'info',
            duration: 0,
            showClose: true
          });
          var params = {
            huiyuanId: _this.huiyuanInfo.id,
            huiyuanzhanghao: _this.huiyuanInfo.huiyuanzhanghao,
            shengao: _this.form.shengao,
            tizhong: _this.form.tizhong,
            jianshenmubiao: _this.form.jianshenmubiao,
            jianshendengji: _this.form.jianshendengji,
            meizhouxunliantian: _this.form.meizhouxunliantian,
            beizhu: _this.form.beizhu
          };
          _this.$http({
            url: 'fitness/plan/generate',
            method: 'post',
            data: params
          }).then(function(res) {
            _this.loading = false;
            // 关闭加载提示
            _this.$message.closeAll();
            if (res.data && res.data.code === 0 && res.data.data && res.data.data.plan) {
              _this.generatedPlan = res.data.data.plan;
              _this.loadPlanDetail(_this.generatedPlan.id);
              // 显示生成成功的提示
              _this.$message({
                message: '健身计划生成成功！',
                type: 'success',
                duration: 3000,
                showClose: true
              });
              // 自动展开第一个训练日
              setTimeout(function() {
                _this.activeNames = ['1'];
              }, 500);
            } else {
              _this.$message.error(res.data.msg || '生成失败');
            }
          }).catch(function(err) {
            _this.loading = false;
            // 关闭加载提示
            _this.$message.closeAll();
            _this.$message.error('生成失败，请稍后重试');
            console.error(err);
          });
        }
      });
    },
    loadPlanDetail: function(planId) {
      var _this = this;
      this.$http({
        url: 'fitness/plan/detail/' + planId,
        method: 'get'
      }).then(function(res) {
        if (res.data && res.data.code === 0 && res.data.data) {
          var weeklyPlan = res.data.data.weeklyPlan;
          _this.weeklyPlanList = _this.convertWeeklyPlan(weeklyPlan);
        }
      });
    },
    convertWeeklyPlan: function(weeklyPlan) {
      var weekDays = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];
      var result = [];
      for (var i = 1; i <= 7; i++) {
        var items = weeklyPlan[i] || weeklyPlan[String(i)] || [];
        var isRest = items.length > 0 && items[0].xiangmumingcheng === '休息';
        result.push({
          day: i,
          dayName: weekDays[i],
          isRest: isRest,
          items: items
        });
      }
      return result;
    },
    getTotalTime: function(items) {
      var total = 0;
      for (var i = 0; i < items.length; i++) {
        total += items[i].shichang || 0;
      }
      return total;
    },
    formatDate: function(date) {
      if (!date) return '';
      var d = new Date(date);
      var year = d.getFullYear();
      var month = (d.getMonth() + 1).toString().padStart(2, '0');
      var day = d.getDate().toString().padStart(2, '0');
      return year + '-' + month + '-' + day;
    },
    exportExcel: function() {
      if (!this.generatedPlan) return;
      this.$http({
        url: 'fitness/plan/export/excel/' + this.generatedPlan.id,
        method: 'get',
        responseType: 'blob'
      }).then(function(res) {
        var blob = new Blob([res.data], { type: 'application/vnd.ms-excel;charset=utf-8' });
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = 'fitness_plan_' + this.generatedPlan.id + '.csv';
        link.click();
      }.bind(this)).catch(function(err) {
        this.$message.error('导出失败');
        console.error(err);
      }.bind(this));
    },
    exportTxt: function() {
      if (!this.generatedPlan) return;
      this.$http({
        url: 'fitness/plan/export/txt/' + this.generatedPlan.id,
        method: 'get',
        responseType: 'blob'
      }).then(function(res) {
        var blob = new Blob([res.data], { type: 'text/plain;charset=utf-8' });
        var link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = 'fitness_plan_' + this.generatedPlan.id + '.txt';
        link.click();
      }.bind(this)).catch(function(err) {
        this.$message.error('导出失败');
        console.error(err);
      }.bind(this));
    },
    resetForm: function() {
      this.form = {
        shengao: '',
        tizhong: '',
        jianshenmubiao: '塑形',
        jianshendengji: '初级',
        meizhouxunliantian: 3,
        beizhu: ''
      };
      this.bmiValue = '0.0';
      this.bmiTip = '请输入身高和体重';
      this.generatedPlan = null;
      this.weeklyPlanList = [];
    }
  }
};
</script>

<style scoped>
.main-content {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 0;
}

/* 页面头部 */
.page-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 40px 20px;
  text-align: center;
  color: white;
}

.header-content {
  max-width: 600px;
  margin: 0 auto;
}

.header-content i {
  font-size: 48px;
  margin-bottom: 10px;
}

.header-content h1 {
  margin: 0 0 10px;
  font-size: 32px;
  font-weight: 600;
}

.header-content p {
  margin: 0;
  font-size: 16px;
  opacity: 0.9;
}

/* 内容区域 */
.content-wrapper {
  max-width: 1200px;
  margin: -30px auto 40px;
  padding: 0 20px;
  position: relative;
  z-index: 1;
}

/* 输入卡片 */
.input-section {
  margin-bottom: 30px;
}

.input-card {
  border-radius: 16px;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 18px;
  font-weight: 600;
}

.card-header i {
  font-size: 24px;
  color: #667eea;
}

.success-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 10px;
}

.header-left i {
  font-size: 24px;
  color: #67c23a;
}

.header-actions {
  display: flex;
  gap: 10px;
}

/* 表单样式 */
.plan-form {
  padding: 10px 0;
}

.full-width {
  width: 100%;
}

.option-tip {
  color: #999;
  font-size: 12px;
  margin-left: 8px;
}

/* 目标选择 */
.goal-group {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.goal-group .el-radio-button {
  margin: 0;
}

.goal-group .el-radio-button__inner {
  border: 1px solid #dcdfe6;
  border-radius: 8px !important;
  padding: 12px 20px;
}

.goal-group .el-radio-button__original-radio:checked + .el-radio-button__inner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-color: #667eea;
}

/* BMI 展示 */
.bmi-box {
  background: #f5f7fa;
  border-radius: 12px;
  padding: 20px;
}

.bmi-gauge {
  margin-bottom: 15px;
}

.gauge-track {
  height: 8px;
  background: linear-gradient(to right, #909399 0%, #67c23a 25%, #e6a23c 50%, #f56c6c 100%);
  border-radius: 4px;
  position: relative;
}

.gauge-fill {
  height: 100%;
  background: transparent;
  border-radius: 4px;
  position: relative;
}

.gauge-marker {
  position: absolute;
  top: -6px;
  width: 20px;
  height: 20px;
  background: white;
  border: 3px solid #667eea;
  border-radius: 50%;
  transform: translateX(-50%);
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

.gauge-labels {
  display: flex;
  justify-content: space-between;
  margin-top: 8px;
  font-size: 12px;
  color: #999;
}

.bmi-result {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 15px;
}

.bmi-value {
  font-size: 36px;
  font-weight: bold;
  padding: 5px 20px;
  border-radius: 8px;
}

.bmi-low { color: #909399; background: #f4f4f5; }
.bmi-normal { color: #67c23a; background: #f0f9eb; }
.bmi-overweight { color: #e6a23c; background: #fdf6ec; }
.bmi-obese { color: #f56c6c; background: #fef0f0; }

.bmi-tip {
  color: #606266;
  font-size: 14px;
}

/* 按钮样式 */
.generate-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  padding: 12px 40px;
  font-size: 16px;
}

.generate-btn:hover {
  background: linear-gradient(135deg, #5a6fd6 0%, #6a4190 100%);
}

.reset-btn {
  padding: 12px 30px;
}

/* 结果卡片 */
.result-section {
  animation: slideUp 0.5s ease;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.result-card {
  border-radius: 16px;
}

/* 计划概览 */
.plan-overview {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 12px;
  padding: 25px;
  color: white;
  margin-bottom: 20px;
}

.overview-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.overview-header h2 {
  margin: 0;
  font-size: 24px;
}

.overview-header .el-tag {
  background: rgba(255,255,255,0.2);
  border: none;
  color: white;
}

.overview-stats {
  margin-bottom: 15px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 15px;
  background: rgba(255,255,255,0.15);
  border-radius: 10px;
}

.stat-item i {
  font-size: 28px;
}

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-size: 20px;
  font-weight: bold;
}

.stat-label {
  font-size: 12px;
  opacity: 0.8;
}

.plan-period {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  opacity: 0.9;
}

/* 每周训练 */
.weekly-plan {
  margin-top: 20px;
}

.day-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.day-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.day-badge {
  padding: 4px 12px;
  border-radius: 20px;
  font-weight: 600;
}

.day-badge.rest {
  background: #f4f4f5;
  color: #909399;
}

.day-badge.active {
  background: #f0f9eb;
  color: #67c23a;
}

.day-type {
  color: #606266;
  font-size: 14px;
}

.day-stats {
  display: flex;
  gap: 10px;
}

.stat-tag {
  padding: 4px 10px;
  background: #ecf5ff;
  color: #409eff;
  border-radius: 12px;
  font-size: 12px;
}

/* 休息日内容 */
.rest-content {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 30px;
  background: linear-gradient(135deg, #f5f7fa 0%, #e8e8e8 100%);
  border-radius: 12px;
}

.rest-content i {
  font-size: 48px;
  color: #909399;
}

.rest-tips h4 {
  margin: 0 0 8px;
  color: #606266;
}

.rest-tips p {
  margin: 0;
  color: #909399;
}

/* 训练卡片 */
.training-content {
  padding: 10px 0;
}

.training-card {
  margin-bottom: 10px;
  border-radius: 10px;
}

.training-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.training-header h4 {
  margin: 0;
  color: #303133;
}

.training-details {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  margin-bottom: 10px;
}

.training-details span {
  display: flex;
  align-items: center;
  gap: 5px;
  color: #606266;
  font-size: 14px;
}

.training-note {
  padding: 10px;
  background: #fdf6ec;
  border-radius: 6px;
  color: #e6a23c;
  font-size: 13px;
}

.training-note i {
  margin-right: 5px;
}

/* 空状态 */
.empty-section {
  text-align: center;
  padding: 60px 20px;
}

.empty-content {
  background: white;
  border-radius: 16px;
  padding: 60px 40px;
  display: inline-block;
}

.empty-content i {
  font-size: 80px;
  color: #dcdfe6;
  margin-bottom: 20px;
}

.empty-content h3 {
  margin: 0 0 10px;
  color: #303133;
}

.empty-content p {
  margin: 0;
  color: #909399;
}

/* 分隔线 */
.el-divider__text {
  display: flex;
  align-items: center;
  gap: 8px;
}

.el-divider__text i {
  font-size: 18px;
}

/* 响应式 */
@media (max-width: 768px) {
  .header-content h1 {
    font-size: 24px;
  }

  .overview-stats .el-col {
    margin-bottom: 10px;
  }

  .header-actions {
    flex-direction: column;
  }
}
</style>
