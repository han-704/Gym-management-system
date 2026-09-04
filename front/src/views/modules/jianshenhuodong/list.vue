<template>
  <div class="main-content">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-left">
        <div class="page-title">
          <i class="el-icon-s-data"></i>
          <h2>健身活动管理</h2>
        </div>
        <div class="page-subtitle">管理会员健身活动记录</div>
      </div>
      <div class="header-right">
        <div class="stats-cards">
          <div class="stat-item stat-records">
            <i class="el-icon-document"></i>
            <div class="stat-info">
              <span class="stat-value">{{ totalPage }}</span>
              <span class="stat-label">活动记录</span>
            </div>
          </div>
          <div class="stat-item stat-today">
            <i class="el-icon-timer"></i>
            <div class="stat-info">
              <span class="stat-value">{{ todayCount }}</span>
              <span class="stat-label">今日活动</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="showFlag">
      <!-- 搜索区域 -->
      <div class="search-card">
        <div class="search-header">
          <div class="search-title">
            <i class="el-icon-search"></i>
            <span>筛选查询</span>
          </div>
          <el-button type="text" class="search-toggle" @click="searchExpanded = !searchExpanded">
            {{ searchExpanded ? '收起' : '展开' }}
            <i :class="searchExpanded ? 'el-icon-arrow-up' : 'el-icon-arrow-down'"></i>
          </el-button>
        </div>
        <el-collapse-transition>
          <el-form v-show="searchExpanded" :inline="true" :model="searchForm" class="form-content">
            <div class="search-row">
              <div class="search-field">
                <label class="search-label">会员账号</label>
                <el-input 
                  v-model="searchForm.huiyuanzhanghao" 
                  placeholder="请输入会员账号"
                  clearable
                  prefix-icon="el-icon-user"
                  class="search-input"
                ></el-input>
              </div>
              <div class="search-field">
                <label class="search-label">会员姓名</label>
                <el-input 
                  v-model="searchForm.huiyuanxingming" 
                  placeholder="请输入会员姓名"
                  clearable
                  prefix-icon="el-icon-postcard"
                  class="search-input"
                ></el-input>
              </div>
              <div class="search-actions">
                <el-button type="primary" class="search-btn" icon="el-icon-search" @click="search()">查询</el-button>
                <el-button class="reset-btn" icon="el-icon-refresh" @click="resetSearch()">重置</el-button>
              </div>
            </div>
          </el-form>
        </el-collapse-transition>
      </div>

      <!-- 操作栏 -->
      <div class="action-bar">
        <div class="action-bar-left">

          </el-button>
          <el-button v-if="$storage.get('sessionTable') == 'huiyuan'" type="warning" icon="el-icon-user" class="action-btn action-btn-mine" @click="goToMyActivity()">
            <span class="btn-text">管理我的活动</span>
          </el-button>
          <el-button 
            v-if="isAuth('jianshenhuodong','删除')"
            :disabled="dataListSelections.length <= 0" 
            type="danger" 
            icon="el-icon-delete" 
            class="action-btn action-btn-del"
            @click="deleteHandler()"
          >
            <span class="btn-text">批量删除</span>
            <span class="selection-count" v-if="dataListSelections.length > 0">{{ dataListSelections.length }}</span>
          </el-button>
        </div>
        <div class="action-bar-right">
          <el-tooltip content="刷新列表" placement="top">
            <el-button icon="el-icon-refresh" circle class="action-btn-circle" @click="search()"></el-button>
          </el-tooltip>
        </div>
      </div>

      <!-- 表格区域 -->
      <div class="table-card">
        <div class="table-header">
          <div class="table-title">
            <i class="el-icon-document-copy"></i>
            <span>活动列表</span>
          </div>
          <div class="table-info">
            共 <span class="info-highlight">{{ totalPage }}</span> 条记录
          </div>
        </div>
        <div class="table-container">
        <el-table 
          class="tables" 
          :data="dataList" 
          v-loading="dataListLoading"
          @selection-change="selectionChangeHandler" 
          stripe
          :header-cell-style="{background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', color: '#fff', fontWeight: '600'}"
          :style="{width: '100%',minWidth: '1200px'}"
          row-key="id"
        >
          <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
          <el-table-column type="index" width="50" label="#" align="center">
            <template slot-scope="scope">
              <span class="row-index">{{ scope.$index + 1 + (pageIndex - 1) * pageSize }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="bianhao" header-align="center" align="center" label="编号" min-width="100"></el-table-column>
          <el-table-column prop="jianshenshizhang" header-align="center" align="center" label="健身时长" min-width="80"></el-table-column>
          <el-table-column prop="jianshenxiangmu" header-align="center" align="center" label="健身项目" min-width="80"></el-table-column>
          <el-table-column prop="jianshenqicai" header-align="center" align="center" label="健身器材" min-width="80"></el-table-column>
          <el-table-column prop="shijian" header-align="center" align="center" label="时间" min-width="100"></el-table-column>
          <el-table-column prop="huiyuanzhanghao" header-align="center" align="center" label="会员账号" min-width="90"></el-table-column>
          <el-table-column prop="huiyuanxingming" header-align="center" align="center" label="会员姓名" min-width="80"></el-table-column>
          <el-table-column prop="shouji" header-align="center" align="center" label="手机" min-width="100"></el-table-column>
          <el-table-column prop="tizhong" header-align="center" align="center" label="体重" min-width="70"></el-table-column>
          <el-table-column prop="xinlv" header-align="center" align="center" label="心率" min-width="60"></el-table-column>
          <el-table-column prop="beizhu" header-align="center" align="center" label="备注" min-width="100" show-overflow-tooltip></el-table-column>
          <el-table-column width="260" align="center" fixed="right" label="操作" class-name="action-column">
            <template slot-scope="scope">
              <div class="action-buttons">
                <el-button type="text" icon="el-icon-view" class="action-link action-view" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
                <el-button v-if="isAuth('jianshenhuodong','修改')" type="text" icon="el-icon-edit" class="action-link action-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
                <el-button v-if="isAuth('jianshenhuodong','删除')" type="text" icon="el-icon-delete" class="action-link action-del" @click="deleteHandler(scope.row.id)">删除</el-button>
                <el-button v-if="$storage.get('sessionTable') == 'huiyuan'" type="text" icon="el-icon-chat-dot-round" class="action-link action-comment" @click="commentHandler(scope.row)">评论</el-button>
              </div>
            </template>
          </el-table-column>
        </el-table>
        </div>
        <div class="table-footer">
          <el-pagination 
            :layout="layouts" 
            @size-change="sizeChangeHandle" 
            @current-change="currentChangeHandle"
            :current-page="pageIndex" 
            :page-sizes="[10, 20, 50, 100]" 
            :page-size="pageSize"
            :total="totalPage" 
            class="pagination-content" 
            background
            prev-text="上一页"
            next-text="下一页"
          >
          </el-pagination>
        </div>
      </div>
    </div>

    <!-- 添加/修改页面 -->
    <add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>

    <!-- 评论对话框 -->
    <el-dialog 
      title="活动评论" 
      :visible.sync="commentDialogVisible" 
      width="600px"
      class="comment-dialog"
      :close-on-click-modal="false"
    >
      <div class="dialog-header-icon">
        <i class="el-icon-chat-dot-square"></i>
      </div>
      <div class="comment-empty" v-if="commentList.length === 0">
        <div class="empty-icon">
          <i class="el-icon-bell"></i>
        </div>
        <p>暂无评论，来发表第一条评论吧</p>
      </div>
      <div class="comment-list" v-else>
        <div class="comment-item" v-for="item in commentList" :key="item.id">
          <div class="comment-avatar" :style="{ background: getAvatarColor(item.huiyuanxingming) }">
            {{ item.huiyuanxingming ? item.huiyuanxingming.charAt(0) : '匿' }}
          </div>
          <div class="comment-body">
            <div class="comment-header">
              <span class="comment-author">{{ item.huiyuanxingming || '匿名用户' }}</span>
              <span class="comment-time">
                <i class="el-icon-time"></i>
                {{ item.pinglunshijian || '刚刚' }}
              </span>
            </div>
            <div class="comment-text">{{ item.pinglunneirong }}</div>
          </div>
        </div>
      </div>
      <el-form :model="commentForm" ref="commentForm" class="comment-form">
        <div class="comment-input-wrapper">
          <el-input 
            type="textarea" 
            v-model="commentForm.pinglunneirong" 
            placeholder="写下你的评论..." 
            :rows="3"
            maxlength="200"
            show-word-limit
            class="comment-textarea"
          ></el-input>
        </div>
        <div class="comment-submit-row">
          <el-button @click="commentDialogVisible = false">取消</el-button>
          <el-button type="primary" icon="el-icon-s-promotion" @click="submitComment">发表评论</el-button>
        </div>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
import AddOrUpdate from "./add-or-update";
export default {
  data() {
    return {
      searchForm: { key: "" },
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      showFlag: true,
      addOrUpdateFlag: false,
      searchExpanded: true,
      contents: {
        tableSelection: true,
        inputTitle: 1,
        searchBtnBgColor: "#409EFF",
        tableHeaderBgColor: "#409EFF",
        tableHeaderFontColor: "#fff",
      },
      layouts: 'total, sizes, prev, pager, next, jumper',
      commentDialogVisible: false,
      commentList: [],
      commentForm: { pinglunneirong: '', jianshenhuodongId: null },
    };
  },
  computed: {
    todayCount() {
      if (!this.dataList || this.dataList.length === 0) return 0;
      const today = new Date().toLocaleDateString();
      return this.dataList.filter(item => {
        if (item.shijian) {
          const itemDate = new Date(item.shijian).toLocaleDateString();
          return itemDate === today;
        }
        return false;
      }).length;
    }
  },
  created() {
    this.init();
    this.getDataList();
  },
  components: { AddOrUpdate },
  methods: {
    init() {},
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    resetSearch() {
      this.searchForm = { key: "" };
      this.pageIndex = 1;
      this.getDataList();
    },
    getDataList() {
      this.dataListLoading = true;
      let params = {
        page: this.pageIndex,
        limit: this.pageSize,
        sort: 'id',
      }
      if(this.searchForm.huiyuanzhanghao) {
        params['huiyuanzhanghao'] = '%' + this.searchForm.huiyuanzhanghao + '%'
      }
      if(this.searchForm.huiyuanxingming) {
        params['huiyuanxingming'] = '%' + this.searchForm.huiyuanxingming + '%'
      }
      this.$http({
        url: "jianshenhuodong/page",
        method: "get",
        params: params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.data.list;
          this.totalPage = data.data.total;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
    selectionChangeHandler(val) {
      this.dataListSelections = val;
    },
    addOrUpdateHandler(id, type) {
      this.showFlag = false;
      this.addOrUpdateFlag = true;
      if(type != 'info') { type = 'else'; }
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(id, type);
      });
    },
    deleteHandler(id) {
      var ids = id ? [Number(id)] : this.dataListSelections.map(item => Number(item.id));
      this.$confirm(`确定进行[${id ? "删除" : "批量删除"}]操作?`, "提示", {
        confirmButtonText: "确定", cancelButtonText: "取消", type: "warning"
      }).then(() => {
        this.$http({
          url: "jianshenhuodong/delete", method: "post", data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({ message: "操作成功", type: "success", duration: 1500, onClose: () => { this.search(); } });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    commentHandler(row) {
      this.commentForm.jianshenhuodongId = row.id;
      this.commentForm.pinglunneirong = '';
      this.getCommentList(row.id);
      this.commentDialogVisible = true;
    },
    getCommentList(jianshenhuodongId) {
      this.$http({ url: 'jianshenhuodongComment/listByJianshenhuodongId', method: "get", params: { jianshenhuodongId } }).then(({ data }) => {
        if (data && data.code === 0) { this.commentList = data.data; }
      });
    },
    submitComment() {
      if (!this.commentForm.pinglunneirong) { this.$message.error('评论内容不能为空'); return; }
      this.$http({ url: 'huiyuan/session', method: "get" }).then(({ data }) => {
        if (data && data.code === 0) {
          const huiyuan = data.data;
          const commentData = {
            jianshenhuodongId: this.commentForm.jianshenhuodongId,
            huiyuanzhanghao: huiyuan.huiyuanzhanghao,
            huiyuanxingming: huiyuan.huiyuanxingming,
            pinglunneirong: this.commentForm.pinglunneirong
          };
          this.$http({ url: 'jianshenhuodongComment/save', method: "post", data: commentData }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({ message: '评论成功', type: 'success', duration: 1500 });
              this.commentForm.pinglunneirong = '';
              this.getCommentList(this.commentForm.jianshenhuodongId);
            } else { this.$message.error(data.msg); }
          });
        }
      });
    },
    getAvatarText(name) {
      return name ? name.charAt(0).toUpperCase() : '?';
    },
    goToMyActivity() {
      this.$router.push('/jianshenhuodong/myList');
    },
    getAvatarColor(name) {
      const colors = ['#667eea', '#764ba2', '#f093fb', '#f5576c', '#4facfe', '#00f2fe', '#43e97b', '#38f9d7'];
      let hash = 0;
      if (name) {
        for (let i = 0; i < name.length; i++) {
          hash = name.charCodeAt(i) + ((hash << 5) - hash);
        }
      }
      return colors[Math.abs(hash) % colors.length];
    }
  }
};
</script>
<style scoped>
.main-content {
  padding: 24px;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ed 100%);
  min-height: calc(100vh - 84px);
}

/* 页面头部 */
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding: 20px 28px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(102, 126, 234, 0.35);
}

.header-left {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.page-title {
  display: flex;
  align-items: center;
  gap: 12px;
}

.page-title i {
  font-size: 28px;
  color: #fff;
}

.page-title h2 {
  margin: 0;
  font-size: 24px;
  font-weight: 700;
  color: #fff;
  letter-spacing: 2px;
}

.page-subtitle {
  margin-left: 40px;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.85);
}

.stats-cards {
  display: flex;
  gap: 20px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 20px;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.stat-item i {
  font-size: 24px;
  color: #fff;
}

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  line-height: 1.2;
}

.stat-label {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.8);
}

/* 搜索区域 */
.search-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px 24px;
  margin-bottom: 20px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  border: 1px solid rgba(0, 0, 0, 0.04);
}

.search-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.search-title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.search-title i {
  font-size: 18px;
  color: #667eea;
}

.search-toggle {
  color: #667eea;
  font-size: 13px;
}

.search-row {
  display: flex;
  align-items: flex-end;
  gap: 20px;
  flex-wrap: wrap;
}

.search-field {
  display: flex;
  flex-direction: column;
  gap: 6px;
  min-width: 180px;
}

.search-label {
  font-size: 13px;
  color: #606266;
  font-weight: 500;
}

.search-input {
  width: 100%;
}

.search-input >>> .el-input__inner {
  border-radius: 8px;
  border-color: #dcdfe6;
  transition: all 0.3s;
}

.search-input >>> .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

.search-actions {
  display: flex;
  gap: 12px;
  margin-left: auto;
}

.search-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  padding: 10px 24px;
  font-weight: 500;
  transition: all 0.3s;
}

.search-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.reset-btn {
  border-radius: 8px;
  padding: 10px 20px;
  border-color: #dcdfe6;
  color: #606266;
  transition: all 0.3s;
}

.reset-btn:hover {
  border-color: #667eea;
  color: #667eea;
}

/* 操作栏 */
.action-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.action-bar-left {
  display: flex;
  gap: 12px;
}

.action-bar-right {
  display: flex;
  gap: 10px;
}

.action-btn {
  border-radius: 8px;
  font-weight: 500;
  padding: 0 20px;
  height: 38px;
  display: flex;
  align-items: center;
  gap: 6px;
  transition: all 0.3s;
}

.action-btn-add {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-color: transparent;
  color: #fff;
}

.action-btn-add:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.action-btn-del {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
  border-color: transparent;
  color: #fff;
}

.action-btn-del:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(245, 87, 108, 0.4);
}

.action-btn-mine {
  background: linear-gradient(135deg, #E6A23C 0%, #F56C6C 100%);
  border-color: transparent;
  color: #fff;
}

.action-btn-mine:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(230, 162, 60, 0.4);
}

.btn-text {
  position: relative;
}

.selection-count {
  position: absolute;
  top: -8px;
  right: -18px;
  background: #fff;
  color: #f5576c;
  font-size: 11px;
  font-weight: 700;
  padding: 2px 6px;
  border-radius: 10px;
  min-width: 18px;
  text-align: center;
}

.action-btn-circle {
  width: 38px;
  height: 38px;
  border-radius: 8px;
  border: 1px solid #dcdfe6;
  background: #fff;
  transition: all 0.3s;
}

.action-btn-circle:hover {
  color: #667eea;
  border-color: #667eea;
  transform: rotate(180deg);
}

/* 表格区域 */
.table-card {
  background: #fff;
  border-radius: 12px;
  padding: 0;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  border: 1px solid rgba(0, 0, 0, 0.04);
  overflow: hidden;
}

.table-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 18px 24px;
  background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
  border-bottom: 1px solid #ebeef5;
}

.table-title {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 16px;
  font-weight: 600;
  color: #303133;
}

.table-title i {
  font-size: 20px;
  color: #667eea;
}

.table-info {
  font-size: 14px;
  color: #909399;
}

.info-highlight {
  color: #667eea;
  font-weight: 700;
}

.tables {
  width: 100%;
}

.table-container {
  overflow-x: auto;
  margin: 0 -1px;
}

.table-container::-webkit-scrollbar {
  height: 8px;
}

.table-container::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.table-container::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 4px;
}

.table-container::-webkit-scrollbar-thumb:hover {
  background: #a1a1a1;
}

.row-index {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  background: linear-gradient(135deg, #667eea20 0%, #764ba220 100%);
  border-radius: 6px;
  font-weight: 600;
  color: #667eea;
  font-size: 12px;
}

.cell-tag {
  font-weight: 600;
  color: #303133;
}

.cell-duration {
  display: flex;
  align-items: center;
  gap: 4px;
  color: #409EFF;
  font-weight: 500;
}

.cell-duration i {
  font-size: 14px;
}

.cell-badge {
  display: inline-block;
  padding: 4px 10px;
  background: linear-gradient(135deg, #e8f4fd 0%, #d4edfc 100%);
  border-radius: 12px;
  font-size: 12px;
  color: #409EFF;
  font-weight: 500;
}

.cell-equipment {
  display: flex;
  align-items: center;
  gap: 4px;
  color: #67C23A;
}

.cell-time {
  display: flex;
  align-items: center;
  gap: 4px;
  color: #909399;
  font-size: 13px;
}

.cell-user {
  display: flex;
  align-items: center;
  gap: 8px;
}

.user-avatar {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: 600;
}

.cell-data {
  color: #E6A23C;
  font-weight: 600;
}

.cell-heart {
  display: flex;
  align-items: center;
  gap: 4px;
  color: #F56C6C;
  font-weight: 600;
}

.cell-heart i {
  animation: heartbeat 1.5s ease-in-out infinite;
}

@keyframes heartbeat {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.2); }
}

.cell-remark {
  color: #606266;
  font-size: 13px;
}

.action-buttons {
  display: flex;
  gap: 2px;
  flex-wrap: nowrap;
}

.action-link {
  font-size: 12px;
  padding: 4px 6px;
  border-radius: 4px;
  transition: all 0.3s;
  text-decoration: none;
  white-space: nowrap;
}

.action-link:hover {
  transform: translateY(-1px);
}

.action-view { 
  color: #409EFF; 
  background: rgba(64, 158, 255, 0.1);
}
.action-view:hover {
  background: rgba(64, 158, 255, 0.2);
}

.action-edit { 
  color: #E6A23C; 
  background: rgba(230, 162, 60, 0.1);
}
.action-edit:hover {
  background: rgba(230, 162, 60, 0.2);
}

.action-del { 
  color: #F56C6C; 
  background: rgba(245, 108, 108, 0.1);
}
.action-del:hover {
  background: rgba(245, 108, 108, 0.2);
}

.action-comment { 
  color: #67C23A; 
  background: rgba(103, 194, 58, 0.1);
}
.action-comment:hover {
  background: rgba(103, 194, 58, 0.2);
}

.table-footer {
  padding: 16px 24px;
  border-top: 1px solid #ebeef5;
  display: flex;
  justify-content: flex-end;
}

.pagination-content >>> .el-pager li {
  border-radius: 6px;
  margin: 0 2px;
  font-weight: 500;
}

.pagination-content >>> .el-pager li.active {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
}

.pagination-content >>> .btn-prev,
.pagination-content >>> .btn-next {
  border-radius: 6px;
}

/* 评论对话框 */
.comment-dialog >>> .el-dialog__header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
}

.comment-dialog >>> .el-dialog__title {
  color: #fff;
  font-weight: 600;
}

.comment-dialog >>> .el-dialog__headerbtn .el-dialog__close {
  color: #fff;
}

.comment-dialog >>> .el-dialog__body {
  padding: 24px;
}

.dialog-header-icon {
  text-align: center;
  margin-bottom: 20px;
}

.dialog-header-icon i {
  font-size: 48px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.comment-empty {
  text-align: center;
  padding: 40px 0;
}

.empty-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea20 0%, #764ba220 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
}

.empty-icon i {
  font-size: 36px;
  color: #667eea;
}

.comment-empty p {
  color: #909399;
  font-size: 14px;
  margin: 0;
}

.comment-list {
  max-height: 280px;
  overflow-y: auto;
  margin-bottom: 20px;
  padding: 0 4px;
}

.comment-list::-webkit-scrollbar {
  width: 6px;
}

.comment-list::-webkit-scrollbar-thumb {
  background: #dcdfe6;
  border-radius: 3px;
}

.comment-item {
  display: flex;
  padding: 14px 0;
  border-bottom: 1px solid #f0f0f0;
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

.comment-item:last-child {
  border-bottom: none;
}

.comment-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  font-weight: 700;
  flex-shrink: 0;
  margin-right: 14px;
}

.comment-body {
  flex: 1;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.comment-author {
  font-size: 14px;
  font-weight: 600;
  color: #303133;
}

.comment-time {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  color: #909399;
}

.comment-text {
  font-size: 14px;
  color: #606266;
  line-height: 1.6;
  background: #f8f9ff;
  padding: 10px 14px;
  border-radius: 8px;
}

.comment-form {
  border-top: 1px solid #ebeef5;
  padding-top: 20px;
}

.comment-input-wrapper {
  margin-bottom: 14px;
}

.comment-textarea >>> .el-textarea__inner {
  border-radius: 10px;
  border-color: #dcdfe6;
  resize: none;
  transition: all 0.3s;
}

.comment-textarea >>> .el-textarea__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

.comment-submit-row {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

.comment-submit-row .el-button--primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  padding: 10px 24px;
}

.comment-submit-row .el-button--primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

/* 响应式适配 */
@media (max-width: 1200px) {
  .page-header {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }
  
  .header-left {
    align-items: center;
  }
  
  .page-subtitle {
    margin-left: 0;
  }
}

@media (max-width: 768px) {
  .main-content {
    padding: 16px;
  }
  
  .search-row {
    flex-direction: column;
    align-items: stretch;
  }
  
  .search-field {
    width: 100%;
  }
  
  .search-actions {
    margin-left: 0;
    justify-content: flex-end;
  }
  
  .action-bar {
    flex-direction: column;
    gap: 12px;
  }
  
  .action-bar-left,
  .action-bar-right {
    width: 100%;
    justify-content: center;
  }
}
</style>
