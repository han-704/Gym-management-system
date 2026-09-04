<template>
  <div class="main-content card-list-page">
    <!-- 列表页 -->
    <div v-if="showFlag">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-content">
          <div class="header-left">
            <i class="el-icon-postcard header-icon"></i>
            <div class="header-text">
              <h2 class="header-title">会员卡管理</h2>
              <p class="header-desc">管理健身房会员卡信息</p>
            </div>
          </div>
          <div class="header-stats">
            <div class="stat-card">
              <i class="el-icon-tickets stat-icon"></i>
              <div class="stat-info">
                <span class="stat-value">{{ totalPage }}</span>
                <span class="stat-label">会员卡总数</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 搜索区域 -->
      <div class="search-card">
        <el-form :inline="true" :model="searchForm" class="form-content">
          <div class="search-row">
            <el-form-item>
              <el-input 
                v-model="searchForm.huiyuankamingcheng" 
                placeholder="会员卡名称" 
                clearable
                class="search-input"
                prefix-icon="el-icon-search"
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="success" icon="el-icon-search" class="search-btn" @click="search()">查询</el-button>
              <el-button icon="el-icon-refresh" class="reset-btn" @click="resetSearch()">重置</el-button>
            </el-form-item>
          </div>
        </el-form>
      </div>

      <!-- 操作按钮区域 -->
      <div class="action-bar">
        <div class="action-left">
          <el-button type="success" icon="el-icon-plus" class="add-btn" @click="addOrUpdateHandler()">新增会员卡</el-button>
          <el-button 
            type="danger" 
            icon="el-icon-delete" 
            class="del-btn" 
            :disabled="dataListSelections.length <= 0"
            @click="deleteHandler()"
          >
            批量删除
            <span v-if="dataListSelections.length > 0" class="selection-badge">{{ dataListSelections.length }}</span>
          </el-button>
        </div>
        <div class="action-right">
          <span class="total-text">共 <span class="highlight">{{ totalPage }}</span> 条记录</span>
        </div>
      </div>

      <!-- 表格区域 -->
      <div class="table-card">
        <div class="table-container">
          <el-table 
            class="tables" 
            :data="dataList" 
            v-loading="dataListLoading"
            @selection-change="selectionChangeHandler"
            stripe
            :header-cell-style="{background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', color: '#fff', fontWeight: '600'}"
            :style="{width: '100%', minWidth: '1000px'}"
            row-key="id"
          >
            <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
            <el-table-column type="index" width="50" label="#" align="center">
              <template slot-scope="scope">
                <span class="row-index">{{ scope.$index + 1 + (pageIndex - 1) * pageSize }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankabianhao" header-align="center" align="center" label="会员卡编号" min-width="150">
              <template slot-scope="scope">
                <span class="cell-code">{{ scope.row.huiyuankabianhao || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankamingcheng" header-align="center" align="center" label="会员卡名称" min-width="120">
              <template slot-scope="scope">
                <span class="cell-name">{{ scope.row.huiyuankamingcheng || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankaleixing" header-align="center" align="center" label="会员卡类型" min-width="100">
              <template slot-scope="scope">
                <span class="cell-tag">{{ scope.row.huiyuankaleixing || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankajiage" header-align="center" align="center" label="会员卡价格" min-width="100">
              <template slot-scope="scope">
                <span class="cell-price">¥{{ scope.row.huiyuankajiage || '0' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="youxiaoshijian" header-align="center" align="center" label="有效时间" min-width="100">
              <template slot-scope="scope">
                <span class="cell-time">{{ scope.row.youxiaoshijian || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="xiaofeijine" header-align="center" align="center" label="消费金额" min-width="100">
              <template slot-scope="scope">
                <span class="cell-consume">¥{{ scope.row.xiaofeijine || '0' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuanzhanghao" header-align="center" align="center" label="会员账号" min-width="110">
              <template slot-scope="scope">
                <span class="cell-account">{{ scope.row.huiyuanzhanghao || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuanxingming" header-align="center" align="center" label="会员姓名" min-width="90">
              <template slot-scope="scope">
                <span class="cell-member">{{ scope.row.huiyuanxingming || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="sfsh" header-align="center" align="center" label="审核状态" min-width="100">
              <template slot-scope="scope">
                <span class="cell-status" :class="{
                  'approved': scope.row.sfsh === '通过',
                  'rejected': scope.row.sfsh === '不通过',
                  'pending': scope.row.sfsh === '待审核'
                }">
                  <i :class="{
                    'el-icon-circle-check': scope.row.sfsh === '通过',
                    'el-icon-circle-close': scope.row.sfsh === '不通过',
                    'el-icon-time': scope.row.sfsh === '待审核'
                  }"></i>
                  {{ scope.row.sfsh || '待审核' }}
                </span>
              </template>
            </el-table-column>
            <el-table-column width="220" align="center" fixed="right" label="操作" class-name="action-column">
              <template slot-scope="scope">
                <div class="action-buttons">
                  <el-button type="text" size="mini" icon="el-icon-view" class="action-link action-view" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
                  <el-button type="text" size="mini" icon="el-icon-edit" class="action-link action-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
                  <el-button v-if="$storage.get('sessionTable') != 'huiyuan'" type="text" size="mini" icon="el-icon-circle-check" class="action-link action-audit" @click="shDialog(scope.row)">审核</el-button>
                  <el-button type="text" size="mini" icon="el-icon-delete" class="action-link action-del" @click="deleteHandler(scope.row.id)">删除</el-button>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>
        <!-- 分页器 -->
        <div class="pagination-wrapper">
          <el-pagination
            :layout="'total, sizes, prev, pager, next, jumper'"
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
          ></el-pagination>
        </div>
      </div>
    </div>

    <!-- 添加/修改页面 -->
    <add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>

    <!-- 审核弹窗 -->
    <el-dialog
      title="审核会员卡"
      :visible.sync="sfshVisiable"
      width="500px"
      class="audit-dialog"
    >
      <el-form ref="shFormRef" :model="shForm" label-width="100px">
        <el-form-item label="审核状态">
          <el-radio-group v-model="shForm.sfsh" class="status-radio">
            <el-radio label="待审核">待审核</el-radio>
            <el-radio label="通过">通过</el-radio>
            <el-radio label="不通过">不通过</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="审核回复">
          <el-input type="textarea" :rows="4" v-model="shForm.shhf" placeholder="请输入审核回复"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="sfshVisiable = false" class="dialog-btn-cancel">取 消</el-button>
        <el-button type="primary" @click="shHandler" class="dialog-btn-confirm">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import AddOrUpdate from "./add-or-update";
export default {
  data() {
    return {
      huiyuankamingchengOptions: [],
      searchForm: {
        huiyuankamingcheng: ''
      },
      form:{},
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      showFlag: true,
      sfshVisiable: false,
      shForm: {},
      chartVisiable: false,
      addOrUpdateFlag:false,
    };
  },
  created() {
    this.init();
    this.getDataList();
  },
  filters: {
    htmlfilter: function (val) {
      return val.replace(/<[^>]*>/g).replace(/undefined/g,'');
    }
  },
  components: {
    AddOrUpdate,
  },
  methods: {
    init () {
      this.$http({
        url: `option/huiyuankaleixing/huiyuankamingcheng`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.huiyuankamingchengOptions = data.data;
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    resetSearch() {
      this.searchForm.huiyuankamingcheng = '';
      this.search();
    },
    getDataList() {
      this.dataListLoading = true;
      let params = {
        page: this.pageIndex,
        limit: this.pageSize,
        sort: 'id',
      }
      if(this.searchForm.huiyuankamingcheng!='' && this.searchForm.huiyuankamingcheng!=undefined){
        params['huiyuankamingcheng'] = '%' + this.searchForm.huiyuankamingcheng + '%'
      }
      this.$http({
        url: "huiyuanka/page",
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
    addOrUpdateHandler(id,type) {
      this.showFlag = false;
      this.addOrUpdateFlag = true;
      this.crossAddOrUpdateFlag = false;
      if(type!='info'){
        type = 'else';
      }
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(id,type);
      });
    },
    shDialog(row){
      this.sfshVisiable = !this.sfshVisiable;
      if(row){
        this.shForm = {
          huiyuankabianhao: row.huiyuankabianhao,
          huiyuankamingcheng: row.huiyuankamingcheng,
          huiyuankaleixing: row.huiyuankaleixing,
          huiyuankajiage: row.huiyuankajiage,
          youxiaoshijian: row.youxiaoshijian,
          xiaofeijine: row.xiaofeijine,
          ticeqingkuang: row.ticeqingkuang,
          huiyuanzhanghao: row.huiyuanzhanghao,
          huiyuanxingming: row.huiyuanxingming,
          beizhu: row.beizhu,
          sfsh: row.sfsh || '待审核',
          shhf: row.shhf,
          id: row.id
        }
      }
    },
    shHandler(){
      this.$confirm(`确定操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "huiyuanka/update",
          method: "post",
          data: this.shForm
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.getDataList();
                this.sfshVisiable = false;
              }
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    download(file){
      window.open(`${file}`)
    },
    deleteHandler(id) {
      var ids = id
        ? [Number(id)]
        : this.dataListSelections.map(item => {
            return Number(item.id);
          });
      this.$confirm(`确定进行[${id ? "删除" : "批量删除"}]操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "huiyuanka/delete",
          method: "post",
          data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.search();
              }
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
  }
};
</script>

<style lang="scss" scoped>
.card-list-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
  padding: 20px;
}

/* 页面头部 */
.page-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  padding: 30px 35px;
  margin-bottom: 24px;
  box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.header-icon {
  font-size: 48px;
  color: rgba(255, 255, 255, 0.9);
}

.header-text {
  color: #fff;
}

.header-title {
  margin: 0;
  font-size: 26px;
  font-weight: 600;
  letter-spacing: 1px;
}

.header-desc {
  margin: 6px 0 0;
  font-size: 14px;
  opacity: 0.85;
}

.header-stats {
  display: flex;
  gap: 20px;
}

.stat-card {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  border-radius: 12px;
  padding: 16px 24px;
  display: flex;
  align-items: center;
  gap: 14px;
  color: #fff;
  transition: all 0.3s;
}

.stat-card:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.stat-icon {
  font-size: 32px;
  opacity: 0.9;
}

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  line-height: 1;
}

.stat-label {
  font-size: 13px;
  opacity: 0.85;
  margin-top: 4px;
}

/* 搜索区域 */
.search-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px 28px;
  margin-bottom: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.search-row {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  align-items: center;
}

.search-input {
  width: 200px;
}

.search-input ::v-deep .el-input__inner {
  border-radius: 8px;
  border: 1px solid #e4e7ed;
  transition: all 0.3s;
}

.search-input ::v-deep .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

.search-input ::v-deep .el-input__prefix {
  color: #667eea;
}

.search-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  padding: 10px 20px;
  font-weight: 500;
  transition: all 0.3s;
}

.search-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

.reset-btn {
  border-radius: 8px;
  border: 1px solid #e4e7ed;
  color: #666;
  padding: 10px 20px;
  margin-left: 10px;
  transition: all 0.3s;
}

.reset-btn:hover {
  border-color: #667eea;
  color: #667eea;
}

/* 操作按钮区域 */
.action-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.action-left {
  display: flex;
  gap: 12px;
}

.add-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  padding: 12px 24px;
  font-weight: 500;
  transition: all 0.3s;
  position: relative;
}

.add-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

.del-btn {
  border-radius: 8px;
  padding: 12px 24px;
  position: relative;
  transition: all 0.3s;
}

.del-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.selection-badge {
  background: rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  padding: 2px 8px;
  margin-left: 8px;
  font-size: 12px;
}

.action-right {
  display: flex;
  align-items: center;
}

.total-text {
  color: #666;
  font-size: 14px;
}

.highlight {
  color: #667eea;
  font-weight: 600;
  font-size: 16px;
}

/* 表格区域 */
.table-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
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

.tables {
  width: 100%;
}

.row-index {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
}

.cell-code {
  font-family: 'Monaco', 'Consolas', monospace;
  color: #666;
  font-size: 13px;
}

.cell-name {
  color: #333;
  font-weight: 600;
}

.cell-tag {
  display: inline-block;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
}

.cell-price {
  color: #f5222d;
  font-weight: 700;
  font-size: 15px;
}

.cell-time {
  color: #666;
}

.cell-consume {
  color: #fa8c16;
  font-weight: 600;
}

.cell-account {
  color: #1890ff;
  font-family: 'Monaco', 'Consolas', monospace;
}

.cell-member {
  color: #333;
  font-weight: 500;
}

.cell-status {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
}

.cell-status.approved {
  background: #f6ffed;
  color: #52c41a;
}

.cell-status.rejected {
  background: #fff2f0;
  color: #ff4d4f;
}

.cell-status.pending {
  background: #fff7e6;
  color: #faad14;
}

/* 操作按钮 */
.action-buttons {
  display: flex;
  gap: 1px;
  flex-wrap: nowrap;
  justify-content: center;
  flex-shrink: 0;
}

.action-link {
  font-size: 11px;
  padding: 2px 4px;
  border-radius: 4px;
  transition: all 0.3s;
  white-space: nowrap;
}

.action-view {
  color: #1890ff;
}

.action-view:hover {
  background: rgba(24, 144, 255, 0.1);
}

.action-audit {
  color: #52c41a;
}

.action-audit:hover {
  background: rgba(82, 196, 26, 0.1);
}

.action-edit {
  color: #faad14;
}

.action-edit:hover {
  background: rgba(250, 173, 20, 0.1);
}

.action-del {
  color: #f5222d;
}

.action-del:hover {
  background: rgba(245, 34, 45, 0.1);
}

/* 分页器 */
.pagination-wrapper {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

.pagination-content {
  display: flex;
  align-items: center;
}

.pagination-content ::v-deep .el-pagination__total {
  margin-right: 20px;
  color: #666;
}

.pagination-content ::v-deep .el-pagination__sizes {
  margin-right: 10px;
}

.pagination-content ::v-deep .el-pager li {
  border-radius: 8px;
  margin: 0 3px;
  transition: all 0.3s;
}

.pagination-content ::v-deep .el-pager li:hover {
  background: rgba(102, 126, 234, 0.1);
}

.pagination-content ::v-deep .el-pager li.active {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
}

.pagination-content ::v-deep .btn-prev,
.pagination-content ::v-deep .btn-next {
  border-radius: 8px;
  margin: 0 3px;
}

.pagination-content ::v-deep .el-pagination__jump {
  margin-left: 15px;
}

/* 审核弹窗 */
.audit-dialog ::v-deep .el-dialog {
  border-radius: 16px;
}

.audit-dialog ::v-deep .el-dialog__header {
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
  border-radius: 16px 16px 0 0;
}

.audit-dialog ::v-deep .el-dialog__title {
  color: #fff;
  font-weight: 600;
}

.audit-dialog ::v-deep .el-dialog__close {
  color: #fff;
}

.status-radio ::v-deep .el-radio__input.is-checked .el-radio__inner {
  background-color: #667eea;
  border-color: #667eea;
}

.status-radio ::v-deep .el-radio__input.is-checked + .el-radio__label {
  color: #667eea;
}

.dialog-btn-cancel {
  border-radius: 8px;
  padding: 10px 20px;
}

.dialog-btn-confirm {
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
  border: none;
  border-radius: 8px;
  padding: 10px 20px;
}

.dialog-btn-confirm:hover {
  box-shadow: 0 6px 20px rgba(17, 153, 142, 0.4);
}

/* 响应式 */
@media (max-width: 1200px) {
  .header-content {
    flex-direction: column;
    align-items: flex-start;
    gap: 20px;
  }

  .header-stats {
    width: 100%;
  }

  .stat-card {
    flex: 1;
  }
}

@media (max-width: 768px) {
  .card-list-page {
    padding: 12px;
  }

  .page-header {
    padding: 20px;
  }

  .header-title {
    font-size: 20px;
  }

  .search-row {
    flex-direction: column;
    align-items: stretch;
  }

  .search-input {
    width: 100%;
  }

  .action-bar {
    flex-direction: column;
    gap: 12px;
    align-items: stretch;
  }

  .action-left {
    flex-wrap: wrap;
  }
}
</style>
