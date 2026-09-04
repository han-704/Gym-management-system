<template>
  <div class="main-content">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-left">
        <div class="page-title">
          <i class="el-icon-box"></i>
          <h2>健身器材管理</h2>
        </div>
        <div class="page-subtitle">管理健身房器材信息</div>
      </div>
      <div class="header-right">
        <div class="stats-cards">
          <div class="stat-item stat-records">
            <i class="el-icon-document"></i>
            <div class="stat-info">
              <span class="stat-value">{{ totalPage }}</span>
              <span class="stat-label">器材总数</span>
            </div>
          </div>
          <div class="stat-item stat-types">
            <i class="el-icon-menu"></i>
            <div class="stat-info">
              <span class="stat-value">{{ typeCount }}</span>
              <span class="stat-label">器材类型</span>
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
                <label class="search-label">器材名称</label>
                <el-input 
                  v-model="searchForm.qicaimingcheng" 
                  placeholder="请输入器材名称"
                  clearable
                  prefix-icon="el-icon-box"
                  class="search-input"
                ></el-input>
              </div>
              <div class="search-field">
                <label class="search-label">器材类型</label>
                <el-input 
                  v-model="searchForm.qicaileixing" 
                  placeholder="请输入器材类型"
                  clearable
                  prefix-icon="el-icon-menu"
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
          <el-button v-if="isAuth('jianshenqicai','新增')" type="primary" icon="el-icon-plus" class="action-btn action-btn-add" @click="addOrUpdateHandler()">
            <span class="btn-text">新增器材</span>
          </el-button>
          <el-button 
            v-if="isAuth('jianshenqicai','删除')"
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
            <i class="el-icon-tickets"></i>
            <span>器材列表</span>
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
          :style="{width: '100%',minWidth: '900px'}"
          row-key="id"
        >
          <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
          <el-table-column type="index" width="50" label="#" align="center">
            <template slot-scope="scope">
              <span class="row-index">{{ scope.$index + 1 + (pageIndex - 1) * pageSize }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="qicaibianhao" header-align="center" align="center" label="器材编号" min-width="100">
            <template slot-scope="scope">
              <span class="cell-code">{{ scope.row.qicaibianhao || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="qicaimingcheng" header-align="center" align="center" label="器材名称" min-width="100">
            <template slot-scope="scope">
              <div class="cell-name">
                <i class="el-icon-box"></i>
                {{ scope.row.qicaimingcheng || '-' }}
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="qicaitupian" header-align="center" align="center" label="器材图片" min-width="120">
            <template slot-scope="scope">
              <div v-if="scope.row.qicaitupian" class="cell-image">
                <el-image 
                  :src="scope.row.qicaitupian.split(',')[0]" 
                  fit="cover"
                  :preview-src-list="scope.row.qicaitupian.split(',')"
                  class="equipment-image"
                >
                  <div slot="placeholder" class="image-placeholder">
                    <i class="el-icon-loading"></i>
                  </div>
                  <div slot="error" class="image-error">
                    <i class="el-icon-picture-outline"></i>
                  </div>
                </el-image>
              </div>
              <div v-else class="cell-no-image">
                <i class="el-icon-picture-outline"></i>
                <span>暂无图片</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="qicaileixing" header-align="center" align="center" label="器材类型" min-width="90">
            <template slot-scope="scope">
              <span class="cell-badge type-badge">{{ scope.row.qicaileixing || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="pinpai" header-align="center" align="center" label="品牌" min-width="80">
            <template slot-scope="scope">
              <span class="cell-brand">{{ scope.row.pinpai || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="shoushenxiaoguo" header-align="center" align="center" label="瘦身效果" min-width="100">
            <template slot-scope="scope">
              <div class="cell-effect">
                <div class="effect-bar">
                  <div class="effect-fill" :style="{width: getEffectWidth(scope.row.shoushenxiaoguo)}"></div>
                </div>
                <span class="effect-text">{{ scope.row.shoushenxiaoguo || '-' }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column width="220" align="center" fixed="right" label="操作" class-name="action-column">
            <template slot-scope="scope">
              <div class="action-buttons">
                <el-button type="text" icon="el-icon-view" class="action-link action-view" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
                <el-button v-if="isAuth('jianshenqicai','修改')" type="text" icon="el-icon-edit" class="action-link action-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
                <el-button v-if="isAuth('jianshenqicai','删除')" type="text" icon="el-icon-delete" class="action-link action-del" @click="deleteHandler(scope.row.id)">删除</el-button>
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
      layouts: 'total, sizes, prev, pager, next, jumper',
    };
  },
  computed: {
    typeCount() {
      if (!this.dataList || this.dataList.length === 0) return 0;
      const types = new Set(this.dataList.map(item => item.qicaileixing).filter(Boolean));
      return types.size;
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
      if(this.searchForm.qicaimingcheng) {
        params['qicaimingcheng'] = '%' + this.searchForm.qicaimingcheng + '%'
      }
      if(this.searchForm.qicaileixing) {
        params['qicaileixing'] = '%' + this.searchForm.qicaileixing + '%'
      }
      this.$http({
        url: "jianshenqicai/page",
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
          url: "jianshenqicai/delete", method: "post", data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({ message: "操作成功", type: "success", duration: 1500, onClose: () => { this.search(); } });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    getEffectWidth(effect) {
      if (!effect) return '0%';
      const map = { '优': '100%', '良': '75%', '中': '50%', '差': '25%' };
      return map[effect] || '50%';
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

.table-container {
  overflow-x: auto;
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

.tables {
  width: 100%;
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

.cell-code {
  font-weight: 600;
  color: #303133;
  font-family: monospace;
}

.cell-name {
  display: flex;
  align-items: center;
  gap: 6px;
  font-weight: 600;
  color: #303133;
}

.cell-name i {
  color: #667eea;
}

.cell-image {
  display: flex;
  justify-content: center;
}

.equipment-image {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  border: 2px solid #f0f0f0;
}

.cell-no-image {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  color: #c0c4cc;
  font-size: 12px;
}

.cell-no-image i {
  font-size: 24px;
}

.cell-badge {
  display: inline-block;
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 500;
}

.type-badge {
  background: linear-gradient(135deg, #e8f4fd 0%, #d4edfc 100%);
  color: #409EFF;
}

.cell-brand {
  color: #E6A23C;
  font-weight: 500;
}

.cell-effect {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.effect-bar {
  width: 80px;
  height: 6px;
  background: #ebeef5;
  border-radius: 3px;
  overflow: hidden;
}

.effect-fill {
  height: 100%;
  background: linear-gradient(90deg, #67C23A 0%, #85ce61 100%);
  border-radius: 3px;
  transition: width 0.3s;
}

.effect-text {
  font-size: 12px;
  color: #67C23A;
  font-weight: 500;
}

.action-buttons {
  display: flex;
  gap: 2px;
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
