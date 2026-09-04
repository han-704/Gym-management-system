<template>
  <div class="add-or-update">
    <!-- 详情模式 -->
    <div v-if="type === 'info'" class="detail-container">
      <!-- 页面头部 -->
      <div class="detail-header">
        <div class="header-icon">
          <i class="el-icon-document"></i>
        </div>
        <div class="header-info">
          <h3>活动详情</h3>
          <p>查看健身活动详细信息</p>
        </div>
        <el-button class="btn-back" @click="back()">
          <i class="el-icon-back"></i>
          返回列表
        </el-button>
      </div>

      <!-- 活动信息卡片 -->
      <div class="detail-card activity-card">
        <div class="card-header">
          <div class="card-icon">
            <i class="el-icon-calendar"></i>
          </div>
          <div class="card-title">
            <h4>活动信息</h4>
          </div>
        </div>
        <div class="card-body">
          <div class="info-grid">
            <div class="info-item">
              <div class="info-label">活动编号</div>
              <div class="info-value">{{ ruleForm.bianhao || '-' }}</div>
            </div>
            <div class="info-item">
              <div class="info-label">活动时间</div>
              <div class="info-value highlight">{{ ruleForm.shijian || '-' }}</div>
            </div>
            <div class="info-item">
              <div class="info-label">健身时长</div>
              <div class="info-value">{{ ruleForm.jianshenshizhang || '-' }} 分钟</div>
            </div>
          </div>
        </div>
      </div>

      <!-- 健身信息卡片 -->
      <div class="detail-card fitness-card">
        <div class="card-header">
          <div class="card-icon fitness">
            <i class="el-icon-sport"></i>
          </div>
          <div class="card-title">
            <h4>健身信息</h4>
          </div>
        </div>
        <div class="card-body">
          <div class="info-grid">
            <div class="info-item">
              <div class="info-label">健身项目</div>
              <div class="info-value">
                <el-tag type="primary" effect="plain">{{ ruleForm.jianshenxiangmu || '-' }}</el-tag>
              </div>
            </div>
            <div class="info-item">
              <div class="info-label">健身器材</div>
              <div class="info-value">
                <el-tag type="success" effect="plain">{{ ruleForm.jianshenqicai || '-' }}</el-tag>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 会员信息卡片 -->
      <div class="detail-card member-card">
        <div class="card-header">
          <div class="card-icon member">
            <i class="el-icon-user"></i>
          </div>
          <div class="card-title">
            <h4>会员信息</h4>
          </div>
        </div>
        <div class="card-body">
          <div class="member-info">
            <div class="member-avatar">
              <span>{{ (ruleForm.huiyuanxingming || '-').substring(0, 1) }}</span>
            </div>
            <div class="member-details">
              <div class="member-name">{{ ruleForm.huiyuanxingming || '-' }}</div>
              <div class="member-meta">
                <span><i class="el-icon-user"></i> {{ ruleForm.huiyuanzhanghao || '-' }}</span>
                <span><i class="el-icon-phone"></i> {{ ruleForm.shouji || '-' }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 健康数据卡片 -->
      <div class="detail-card health-card">
        <div class="card-header">
          <div class="card-icon health">
            <i class="el-icon-data-analysis"></i>
          </div>
          <div class="card-title">
            <h4>健康数据</h4>
          </div>
        </div>
        <div class="card-body">
          <div class="health-stats">
            <div class="stat-box">
              <div class="stat-icon weight">
                <i class="el-icon-data-analysis"></i>
              </div>
              <div class="stat-info">
                <span class="stat-label">体重</span>
                <span class="stat-value">{{ ruleForm.tizhong || '-' }} <small>kg</small></span>
              </div>
            </div>
            <div class="stat-box">
              <div class="stat-icon heart">
                <i class="el-icon-heart"></i>
              </div>
              <div class="stat-info">
                <span class="stat-label">心率</span>
                <span class="stat-value">{{ ruleForm.xinlv || '-' }} <small>bpm</small></span>
              </div>
            </div>
            <div class="stat-box">
              <div class="stat-icon duration">
                <i class="el-icon-timer"></i>
              </div>
              <div class="stat-info">
                <span class="stat-label">锻炼时长</span>
                <span class="stat-value">{{ ruleForm.jianshenshizhang || '-' }} <small>分钟</small></span>
              </div>
            </div>
          </div>
          <div class="remark-section" v-if="ruleForm.beizhu">
            <div class="remark-label"><i class="el-icon-document"></i> 备注</div>
            <div class="remark-content">{{ ruleForm.beizhu }}</div>
          </div>
        </div>
      </div>

      <!-- 评论区域 -->
      <div class="detail-card comment-card">
        <div class="card-header">
          <div class="card-icon comment">
            <i class="el-icon-chat-dot-round"></i>
          </div>
          <div class="card-title">
            <h4>活动评论</h4>
            <span class="comment-count">{{ commentList.length }} 条评论</span>
          </div>
        </div>
        <div class="card-body">
          <!-- 评论输入 -->
          <div class="comment-input-section" v-if="isCanComment">
            <div class="comment-avatar">
              <span>{{ currentUserAvatar }}</span>
            </div>
            <div class="comment-input-wrapper">
              <el-input
                type="textarea"
                v-model="commentContent"
                placeholder="发表一下你的看法..."
                :rows="3"
                maxlength="500"
                show-word-limit
              ></el-input>
              <div class="comment-actions">
                <el-button type="primary" size="small" @click="submitComment" :loading="commentLoading">
                  <i class="el-icon-s-promotion"></i> 发布评论
                </el-button>
              </div>
            </div>
          </div>

          <!-- 评论列表 -->
          <div class="comment-list" v-if="commentList.length > 0">
            <div class="comment-item" v-for="(item, index) in commentList" :key="index">
              <div class="comment-avatar">
                <span>{{ (item.huiyuanxingming || '游').substring(0, 1) }}</span>
              </div>
              <div class="comment-body">
                <div class="comment-header">
                  <span class="comment-user">{{ item.huiyuanxingming || '匿名用户' }}</span>
                  <span class="comment-time">{{ formatTime(item.pinglunshijian) }}</span>
                </div>
                <div class="comment-content">{{ item.pinglunneirong }}</div>
              </div>
            </div>
          </div>
          <div class="comment-empty" v-else>
            <i class="el-icon-chat-dot-round"></i>
            <p>暂无评论，来发表第一条评论吧</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 编辑/新增模式 -->
    <div v-else class="edit-container">
      <!-- 页面头部 -->
      <div class="form-header">
        <div class="header-icon">
          <i class="el-icon-document"></i>
        </div>
        <div class="header-info">
          <h3>{{ ruleForm.id ? '编辑活动' : '新增活动' }}</h3>
          <p>{{ ruleForm.id ? '修改活动记录' : '创建新的健身活动记录' }}</p>
        </div>
      </div>

      <el-form class="form-content" ref="ruleForm" :model="ruleForm" :rules="rules" label-width="120px">
        <div class="form-card">
          <div class="form-section-title">
            <i class="el-icon-info"></i>
            <span>基本信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="编号" prop="bianhao">
                <el-input v-model="ruleForm.bianhao" placeholder="系统自动生成" readonly class="readonly-input">
                  <template slot="prefix"><i class="el-icon-key"></i></template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="时间" prop="shijian">
                <el-date-picker format="yyyy-MM-dd" value-format="yyyy-MM-dd" v-model="ruleForm.shijian" type="date" placeholder="请选择活动时间" style="width: 100%;">
                </el-date-picker>
              </el-form-item>
            </el-col>
          </el-row>
          
          <div class="form-section-title">
            <i class="el-icon-s-data"></i>
            <span>健身信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="健身时长" prop="jianshenshizhang">
                <el-input v-model="ruleForm.jianshenshizhang" placeholder="请输入健身时长" clearable :readonly="ro.jianshenshizhang">
                  <template slot="prefix"><i class="el-icon-timer"></i></template>
                  <template slot="append">分钟</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="select" label="健身项目" prop="jianshenxiangmu">
                <el-select v-model="ruleForm.jianshenxiangmu" placeholder="请选择健身项目" style="width: 100%;" clearable>
                  <el-option v-for="(item,index) in jianshenxiangmuOptions" :key="index" :label="item" :value="item">
                    <span>{{ item }}</span>
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="select" label="健身器材" prop="jianshenqicai">
                <el-select v-model="ruleForm.jianshenqicai" placeholder="请选择健身器材" style="width: 100%;" clearable>
                  <el-option v-for="(item,index) in jianshenqicaiOptions" :key="index" :label="item" :value="item">
                    <span>{{ item }}</span>
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>

          <div class="form-section-title">
            <i class="el-icon-user"></i>
            <span>会员信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员账号" prop="huiyuanzhanghao">
                <el-input v-model="ruleForm.huiyuanzhanghao" placeholder="请输入会员账号" clearable :readonly="ro.huiyuanzhanghao">
                  <template slot="prefix"><i class="el-icon-user"></i></template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="会员姓名" prop="huiyuanxingming">
                <el-input v-model="ruleForm.huiyuanxingming" placeholder="请输入会员姓名" clearable :readonly="ro.huiyuanxingming">
                  <template slot="prefix"><i class="el-icon-postcard"></i></template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="手机" prop="shouji">
                <el-input v-model="ruleForm.shouji" placeholder="请输入手机号码" clearable :readonly="ro.shouji">
                  <template slot="prefix"><i class="el-icon-mobile-phone"></i></template>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <el-button class="btn-cancel" @click="back()">
            <i class="el-icon-close"></i>
            取消
          </el-button>
          <el-button type="primary" class="btn-submit" @click="onSubmit">
            <i class="el-icon-check"></i>
            提交
          </el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      id: '',
      type: '',
      ro: {
        bianhao: false, jianshenshizhang: false, jianshenxiangmu: false,
        jianshenqicai: false, shijian: false, huiyuanzhanghao: false,
        huiyuanxingming: false, shouji: false,
      },
      ruleForm: {
        bianhao: '', jianshenshizhang: '', jianshenxiangmu: '',
        jianshenqicai: '', shijian: '', huiyuanzhanghao: '', huiyuanxingming: '', shouji: '',
      },
      jianshenxiangmuOptions: [],
      jianshenqicaiOptions: [],
      rules: {
        bianhao: [],
        jianshenshizhang: [],
        jianshenxiangmu: [],
        jianshenqicai: [{ required: true, message: '健身器材不能为空', trigger: 'blur' }],
        shijian: [],
        huiyuanzhanghao: [],
        huiyuanxingming: [],
        shouji: [],
      },
      // 评论相关
      commentList: [],
      commentContent: '',
      commentLoading: false,
      currentUserAvatar: '我',
      isCanComment: false
    };
  },
  props: ["parent"],
  created() {
    this.getUUID = () => new Date().getTime().toString();
  },
  methods: {
    init(id, type) {
      if (id) { this.id = id; this.type = type; }
      if (this.type == 'info' || this.type == 'else') { this.info(id); }
      if (this.type == 'cross') {
        var obj = this.$storage.getObj('crossObj');
        if (obj.huiyuanzhanghao) {
          this.ruleForm.huiyuanzhanghao = obj.huiyuanzhanghao;
          this.ro.huiyuanzhanghao = true;
        }
        if (obj.huiyuanxingming) {
          this.ruleForm.huiyuanxingming = obj.huiyuanxingming;
          this.ro.huiyuanxingming = true;
        }
        if (obj.shouji) {
          this.ruleForm.shouji = obj.shouji;
          this.ro.shouji = true;
        }
      }
      this.$http({ url: `option/jianshenxiangmu/xiangmumingcheng`, method: "get" }).then(({ data }) => {
        if (data && data.code === 0) { this.jianshenxiangmuOptions = data.data; }
      });
      this.$http({ url: `option/jianshenqicai/qicaimingcheng`, method: "get" }).then(({ data }) => {
        if (data && data.code === 0) { this.jianshenqicaiOptions = data.data; }
      });
    },
    info(id) {
      this.$http({ url: `jianshenhuodong/info/${id}`, method: "get" }).then(({ data }) => {
        if (data && data.code === 0) {
          this.ruleForm = data.data;
          this.loadComments();
          this.checkCanComment();
        }
      });
    },
    loadComments() {
      this.$http({
        url: 'jianshenhuodongComment/listByJianshenhuodongId',
        method: 'get',
        params: { jianshenhuodongId: this.id }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.commentList = data.data || [];
        }
      });
    },
    checkCanComment() {
      let table = this.$storage.get('sessionTable');
      this.isCanComment = table === 'huiyuan' || table === 'users';
      if (this.isCanComment) {
        this.$http({ url: `${table}/session`, method: 'get' }).then(({ data }) => {
          if (data && data.code === 0) {
            let name = data.data.huiyuanxingming || data.data.yuangongxingming || data.data.name || '我';
            this.currentUserAvatar = name.substring(0, 1);
          }
        });
      }
    },
    submitComment() {
      if (!this.commentContent.trim()) {
        this.$message.warning('请输入评论内容');
        return;
      }
      this.commentLoading = true;
      let table = this.$storage.get('sessionTable');
      let user = this.$storage.get('user');
      this.$http({
        url: 'jianshenhuodongComment/save',
        method: 'post',
        data: {
          jianshenhuodongId: this.id,
          pinglunneirong: this.commentContent,
          huiyuanzhanghao: (user && user.huiyuanzhanghao) || (user && user.username) || '',
          huiyuanxingming: (user && user.huiyuanxingming) || (user && user.name) || ''
        }
      }).then(({ data }) => {
        this.commentLoading = false;
        if (data && data.code === 0) {
          this.$message.success('评论发布成功');
          this.commentContent = '';
          this.loadComments();
        } else {
          this.$message.error(data.msg || '评论发布失败');
        }
      }).catch(() => {
        this.commentLoading = false;
      });
    },
    formatTime(time) {
      if (!time) return '';
      let date = new Date(time);
      let now = new Date();
      let diff = now - date;
      if (diff < 60000) return '刚刚';
      if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前';
      if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前';
      if (diff < 604800000) return Math.floor(diff / 86400000) + '天前';
      return date.toLocaleDateString();
    },
    onSubmit() {
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          if (!this.ruleForm.bianhao) {
            this.ruleForm.bianhao = this.getUUID();
          }
          this.$http({ url: `jianshenhuodong/${!this.ruleForm.id ? "save" : "update"}`, method: "post", data: this.ruleForm }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({ message: "操作成功", type: "success", duration: 1500, onClose: () => {
                this.parent.showFlag = true;
                this.parent.addOrUpdateFlag = false;
                this.parent.jianshenhuodongCrossAddOrUpdateFlag = false;
                this.parent.search();
              }});
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
      this.parent.jianshenhuodongCrossAddOrUpdateFlag = false;
    }
  }
};
</script>
<style scoped>
.add-or-update {
  padding: 24px;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ed 100%);
  min-height: calc(100vh - 84px);
}

/* ============ 详情页样式 ============ */
.detail-container {
  max-width: 900px;
  margin: 0 auto;
}

.detail-header {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 24px 28px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  margin-bottom: 24px;
  box-shadow: 0 8px 24px rgba(102, 126, 234, 0.35);
}

.detail-header .header-icon {
  width: 60px;
  height: 60px;
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
}

.detail-header .header-icon i {
  font-size: 28px;
  color: #fff;
}

.detail-header .header-info {
  flex: 1;
}

.detail-header .header-info h3 {
  margin: 0 0 6px 0;
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  letter-spacing: 1px;
}

.detail-header .header-info p {
  margin: 0;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.85);
}

.detail-header .btn-back {
  border-radius: 10px;
  padding: 12px 24px;
  background: rgba(255, 255, 255, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.3);
  color: #fff;
  transition: all 0.3s;
}

.detail-header .btn-back:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

/* 详情卡片 */
.detail-card {
  background: #fff;
  border-radius: 16px;
  padding: 24px 28px;
  margin-bottom: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  border: 1px solid rgba(0, 0, 0, 0.04);
  transition: all 0.3s;
}

.detail-card:hover {
  box-shadow: 0 6px 24px rgba(0, 0, 0, 0.1);
}

.card-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 2px solid #f0f2ff;
}

.card-icon {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  color: #fff;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.card-icon.fitness { background: linear-gradient(135deg, #409EFF 0%, #66b1ff 100%); }
.card-icon.member { background: linear-gradient(135deg, #67C23A 0%, #85ce61 100%); }
.card-icon.health { background: linear-gradient(135deg, #E6A23C 0%, #f5c77e 100%); }
.card-icon.comment { background: linear-gradient(135deg, #F56C6C 0%, #f78989 100%); }

.card-title {
  flex: 1;
}

.card-title h4 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #303133;
}

.comment-count {
  font-size: 12px;
  color: #909399;
  margin-left: 10px;
}

/* 信息网格 */
.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.info-item {
  padding: 16px;
  background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
  border-radius: 12px;
}

.info-label {
  font-size: 13px;
  color: #909399;
  margin-bottom: 8px;
}

.info-value {
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.info-value.highlight {
  color: #667eea;
}

/* 会员信息 */
.member-info {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
  border-radius: 12px;
}

.member-avatar {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 22px;
  font-weight: 600;
}

.member-details {
  flex: 1;
}

.member-name {
  font-size: 18px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 6px;
}

.member-meta {
  display: flex;
  gap: 20px;
  font-size: 13px;
  color: #909399;
}

.member-meta span {
  display: flex;
  align-items: center;
  gap: 4px;
}

/* 健康数据统计 */
.health-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  margin-bottom: 20px;
}

.stat-box {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 18px;
  background: #fff;
  border-radius: 12px;
  border: 1px solid #ebeef5;
  transition: all 0.3s;
}

.stat-box:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
}

.stat-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
  color: #fff;
}

.stat-icon.weight { background: linear-gradient(135deg, #409EFF 0%, #66b1ff 100%); }
.stat-icon.heart { background: linear-gradient(135deg, #F56C6C 0%, #f78989 100%); }
.stat-icon.duration { background: linear-gradient(135deg, #67C23A 0%, #85ce61 100%); }

.stat-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-info .stat-label {
  font-size: 12px;
  color: #909399;
}

.stat-info .stat-value {
  font-size: 18px;
  font-weight: 700;
  color: #303133;
}

.stat-info .stat-value small {
  font-size: 12px;
  font-weight: normal;
  color: #909399;
}

/* 备注区域 */
.remark-section {
  padding: 16px;
  background: linear-gradient(135deg, #fff7e6 0%, #fff3e6 100%);
  border-radius: 12px;
  border-left: 4px solid #E6A23C;
}

.remark-label {
  font-size: 13px;
  color: #E6A23C;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.remark-content {
  font-size: 14px;
  color: #606266;
  line-height: 1.6;
}

/* 评论区域 */
.comment-input-section {
  display: flex;
  gap: 14px;
  padding: 16px;
  background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
  border-radius: 12px;
  margin-bottom: 20px;
}

.comment-avatar {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  flex-shrink: 0;
}

.comment-input-wrapper {
  flex: 1;
}

.comment-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 12px;
}

.comment-actions .el-button {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
}

/* 评论列表 */
.comment-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.comment-item {
  display: flex;
  gap: 14px;
  padding: 16px;
  background: #fafafa;
  border-radius: 12px;
  transition: all 0.3s;
}

.comment-item:hover {
  background: #f5f5f5;
}

.comment-body {
  flex: 1;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.comment-user {
  font-size: 14px;
  font-weight: 600;
  color: #303133;
}

.comment-time {
  font-size: 12px;
  color: #909399;
}

.comment-content {
  font-size: 14px;
  color: #606266;
  line-height: 1.6;
}

.comment-empty {
  text-align: center;
  padding: 40px 20px;
  color: #909399;
}

.comment-empty i {
  font-size: 48px;
  margin-bottom: 12px;
  display: block;
  opacity: 0.5;
}

.comment-empty p {
  margin: 0;
  font-size: 14px;
}

/* ============ 编辑页样式 ============ */
.edit-container {
  max-width: 900px;
  margin: 0 auto;
}

.form-header {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 24px 28px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  margin-bottom: 24px;
  box-shadow: 0 8px 24px rgba(102, 126, 234, 0.35);
}

.header-icon {
  width: 60px;
  height: 60px;
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.header-icon i {
  font-size: 28px;
  color: #fff;
}

.header-info h3 {
  margin: 0 0 6px 0;
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  letter-spacing: 1px;
}

.header-info p {
  margin: 0;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.85);
}

.form-content {
  max-width: 900px;
  margin: 0 auto;
}

.form-card {
  background: #fff;
  border-radius: 16px;
  padding: 28px 32px;
  margin-bottom: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  border: 1px solid rgba(0, 0, 0, 0.04);
}

.form-section-title {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 22px;
  padding-bottom: 12px;
  border-bottom: 2px solid #667eea20;
}

.form-section-title i {
  font-size: 20px;
  color: #667eea;
}

.el-form-item {
  margin-bottom: 22px;
}

.el-input, .el-select {
  width: 100%;
}

.el-input >>> .el-input__inner {
  border-radius: 10px;
  border: 1px solid #dcdfe6;
  padding: 0 15px;
  height: 42px;
  line-height: 42px;
  transition: all 0.3s;
}

.el-input >>> .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.el-input >>> .el-input__inner:hover {
  border-color: #667eea;
}

.el-input >>> .el-input__group__append {
  border-radius: 0 10px 10px 0;
  background: #667eea;
  color: #fff;
  border-color: #667eea;
}

.readonly-input >>> .el-input__inner {
  background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
  color: #909399;
}

.el-select >>> .el-input__inner {
  padding-right: 30px;
}

.el-select >>> .el-input__suffix {
  right: 12px;
}

.el-date-editor >>> .el-input__inner {
  padding-right: 15px;
}

.form-actions {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-top: 30px;
}

.btn-submit {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 10px;
  padding: 14px 36px;
  font-size: 15px;
  font-weight: 600;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-submit:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
}

.btn-cancel {
  border-radius: 10px;
  padding: 14px 28px;
  font-size: 15px;
  border: 1px solid #dcdfe6;
  color: #606266;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-cancel:hover {
  border-color: #667eea;
  color: #667eea;
}

/* 响应式 */
@media (max-width: 768px) {
  .add-or-update {
    padding: 16px;
  }
  
  .detail-header, .form-header {
    flex-direction: column;
    text-align: center;
    gap: 16px;
  }
  
  .detail-header .btn-back {
    width: 100%;
  }
  
  .health-stats {
    grid-template-columns: 1fr;
  }
  
  .info-grid {
    grid-template-columns: 1fr;
  }
  
  .member-meta {
    flex-direction: column;
    gap: 8px;
  }
  
  .form-card {
    padding: 20px;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .form-actions .el-button {
    width: 100%;
  }
}
</style>
