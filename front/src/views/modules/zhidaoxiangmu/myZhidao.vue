<template>
  <div class="main-content">
    <!-- 列表页 -->
    <div v-if="showFlag">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-left">
          <div class="page-title">
            <i class="el-icon-guide"></i>
            <h2>我的指导项目</h2>
          </div>
          <div class="page-subtitle">管理我负责的健身指导项目</div>
        </div>
        <div class="header-right">
          <div class="stats-cards">
            <div class="stat-item stat-records">
              <i class="el-icon-document"></i>
              <div class="stat-info">
                <span class="stat-value">{{ totalPage }}</span>
                <span class="stat-label">指导总数</span>
              </div>
            </div>
            <div class="stat-item stat-price">
              <i class="el-icon-money"></i>
              <div class="stat-info">
                <span class="stat-value">{{ avgPrice }}</span>
                <span class="stat-label">平均价格</span>
              </div>
            </div>
          </div>
        </div>
      </div>

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
                <label class="search-label">项目名称</label>
                <el-input 
                  v-model="searchForm.xiangmumingcheng" 
                  placeholder="请输入项目名称"
                  clearable
                  prefix-icon="el-icon-sport"
                  class="search-input"
                ></el-input>
              </div>
              <div class="search-field">
                <label class="search-label">项目类型</label>
                <el-input 
                  v-model="searchForm.xiangmuleixing" 
                  placeholder="请输入项目类型"
                  clearable
                  prefix-icon="el-icon-tickets"
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
          <el-button type="info" icon="el-icon-back" class="action-btn action-btn-back" @click="goBack()">
            <span class="btn-text">返回指导项目</span>
          </el-button>
          <el-button type="primary" icon="el-icon-plus" class="action-btn action-btn-add" @click="addOrUpdateHandler()">
            <span class="btn-text">新增项目</span>
          </el-button>
          <el-button 
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
            <span>指导项目列表</span>
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
          :style="{width: '100%',minWidth: '1000px'}"
          row-key="id"
        >
          <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
          <el-table-column type="index" width="50" label="#" align="center">
            <template slot-scope="scope">
              <span class="row-index">{{ scope.$index + 1 + (pageIndex - 1) * pageSize }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="xiangmubianhao" header-align="center" align="center" label="项目编号" min-width="100">
            <template slot-scope="scope">
              <span class="cell-code">{{ scope.row.xiangmubianhao || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="xiangmumingcheng" header-align="center" align="center" label="项目名称" min-width="100">
            <template slot-scope="scope">
              <div class="cell-name">
                <i class="el-icon-sport"></i>
                {{ scope.row.xiangmumingcheng || '-' }}
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="xiangmuleixing" header-align="center" align="center" label="项目类型" min-width="90">
            <template slot-scope="scope">
              <span class="cell-badge type-badge">{{ scope.row.xiangmuleixing || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="xiangmujiage" header-align="center" align="center" label="项目价格" min-width="90">
            <template slot-scope="scope">
              <div class="cell-price">
                <span class="price-value">¥{{ scope.row.xiangmujiage || '0' }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="keshishu" header-align="center" align="center" label="课时数" min-width="70">
            <template slot-scope="scope">
              <span class="cell-classes">{{ scope.row.keshishu || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="shoufeibiaozhun" header-align="center" align="center" label="收费标准" min-width="100">
            <template slot-scope="scope">
              <span class="cell-fee">{{ scope.row.shoufeibiaozhun || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="zhidaoxiangmu" header-align="center" align="center" label="指导项目" min-width="100">
            <template slot-scope="scope">
              <span class="cell-guide">{{ scope.row.zhidaoxiangmu || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column width="160" align="center" fixed="right" label="操作" class-name="action-column">
            <template slot-scope="scope">
              <div class="action-buttons">
                <el-button type="text" icon="el-icon-view" class="action-link action-view" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
                <el-button type="text" icon="el-icon-edit" class="action-link action-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
                <el-button type="text" icon="el-icon-delete" class="action-link action-del" @click="deleteHandler(scope.row.id)">删除</el-button>
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
      yuangongName: ''
    };
  },
  computed: {
    avgPrice() {
      if (!this.dataList || this.dataList.length === 0) return '¥0';
      const sum = this.dataList.reduce((acc, item) => acc + (parseFloat(item.xiangmujiage) || 0), 0);
      return '¥' + (sum / this.dataList.length).toFixed(0);
    }
  },
  created() {
    this.init();
    this.getYuangongInfo();
  },
  components: { 
    AddOrUpdate,
  },
  methods: {
    init() {},
    getYuangongInfo() {
      // 调用后端接口获取当前登录员工信息
      this.$http({
        url: "yuangong/session",
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          console.log('获取到的员工信息:', data.data);
          this.yuangongName = data.data.yuangongxingming || data.data.name || '';
          console.log('当前员工姓名:', this.yuangongName);
          // 获取到姓名后再查询数据
          this.getDataList();
        } else {
          console.error('获取员工信息失败:', data.msg);
          // 获取失败时也尝试查询
          this.getDataList();
        }
      });
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    resetSearch() {
      this.searchForm = { xiangmumingcheng: '', xiangmuleixing: '' };
      this.pageIndex = 1;
      this.getDataList();
    },
    getDataList() {
      this.dataListLoading = true;
      let params = {
        page: this.pageIndex,
        limit: this.pageSize,
        sort: 'id'
      }
      // 只有获取到员工姓名时才添加过滤条件
      if(this.yuangongName) {
        params['zhidaojiaolian'] = this.yuangongName;
      }
      if(this.searchForm.xiangmumingcheng) {
        params['xiangmumingcheng'] = '%' + this.searchForm.xiangmumingcheng + '%'
      }
      if(this.searchForm.xiangmuleixing) {
        params['xiangmuleixing'] = '%' + this.searchForm.xiangmuleixing + '%'
      }
      this.$http({
        url: "zhidaoxiangmu/page",
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
          url: "zhidaoxiangmu/delete", method: "post", data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({ message: "操作成功", type: "success", duration: 1500, onClose: () => { this.search(); } });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    goBack() {
      this.$router.push({ path: '/zhidaoxiangmu' });
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

.search-input >>> .el-input__prefix {
  color: #667eea;
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
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-color: transparent;
  color: #fff;
}

.action-btn-del:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
}

.action-btn-back {
  background: linear-gradient(135deg, #67C23A 0%, #5FB878 100%);
  border-color: transparent;
  color: #fff;
}

.action-btn-back:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(103, 194, 58, 0.4);
}

.btn-text {
  position: relative;
}

.selection-count {
  position: absolute;
  top: -8px;
  right: -18px;
  background: #fff;
  color: #667eea;
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

.cell-badge {
  display: inline-block;
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 500;
}

.type-badge {
  background: linear-gradient(135deg, #e8f4fd 0%, #d4edfc 100%);
  color: #667eea;
}

.cell-price {
  display: flex;
  align-items: center;
}

.price-value {
  font-size: 16px;
  font-weight: 700;
  color: #F56C6C;
}

.cell-classes {
  color: #67C23A;
  font-weight: 600;
}

.cell-guide {
  color: #909399;
}

.action-buttons {
  display: flex;
  gap: 4px;
}

.action-link {
  font-size: 12px;
  padding: 4px 8px;
  border-radius: 4px;
  transition: all 0.3s;
  text-decoration: none;
  white-space: nowrap;
}

.action-link:hover {
  transform: translateY(-1px);
}

.action-view { 
  color: #667eea; 
  background: rgba(102, 126, 234, 0.1);
}
.action-view:hover {
  background: rgba(102, 126, 234, 0.2);
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
