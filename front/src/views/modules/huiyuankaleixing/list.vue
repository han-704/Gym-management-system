<template>
  <div class="main-content card-type-page">
    <!-- 列表页 -->
    <div v-if="showFlag">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-content">
          <div class="header-left">
            <i class="el-icon-postcard header-icon"></i>
            <div class="header-text">
              <h2 class="header-title">会员卡类型管理</h2>
              <p class="header-desc">管理系统中的会员卡类型信息</p>
            </div>
          </div>
          <div class="header-stats">
            <div class="stat-card">
              <i class="el-icon-s-grid stat-icon"></i>
              <div class="stat-info">
                <span class="stat-value">{{ totalPage }}</span>
                <span class="stat-label">卡类型总数</span>
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
                prefix-icon="el-icon-postcard"
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
          <el-button type="success" icon="el-icon-plus" class="add-btn" @click="addOrUpdateHandler()">新增卡类型</el-button>
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
            :style="{width: '100%', minWidth: '900px'}"
            row-key="id"
          >
            <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
            <el-table-column type="index" width="50" label="#" align="center">
              <template slot-scope="scope">
                <span class="row-index">{{ scope.$index + 1 + (pageIndex - 1) * pageSize }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankamingcheng" header-align="center" align="center" label="会员卡名称" min-width="140">
              <template slot-scope="scope">
                <span class="cell-name">{{ scope.row.huiyuankamingcheng || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankatupian" header-align="center" align="center" label="会员卡图片" min-width="140">
              <template slot-scope="scope">
                <div v-if="scope.row.huiyuankatupian" class="cell-image">
                  <el-image 
                    :src="scope.row.huiyuankatupian.split(',')[0]" 
                    fit="cover"
                    class="table-image"
                    :preview-src-list="scope.row.huiyuankatupian.split(',')"
                  >
                    <div slot="error" class="image-error">
                      <i class="el-icon-picture-outline"></i>
                    </div>
                  </el-image>
                </div>
                <div v-else class="cell-no-image">
                  <i class="el-icon-picture-outline"></i>
                </div>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankaleixing" header-align="center" align="center" label="会员卡类型" min-width="120">
              <template slot-scope="scope">
                <span class="cell-type">{{ scope.row.huiyuankaleixing || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankajiage" header-align="center" align="center" label="会员卡价格" min-width="120">
              <template slot-scope="scope">
                <span class="cell-price">
                  <i class="el-icon-coin"></i>
                  ¥{{ scope.row.huiyuankajiage || '0' }}
                </span>
              </template>
            </el-table-column>
            <el-table-column prop="youxiaoshijian" header-align="center" align="center" label="有效时间" min-width="100">
              <template slot-scope="scope">
                <span class="cell-time">
                  <i class="el-icon-time"></i>
                  {{ scope.row.youxiaoshijian || '-' }}
                </span>
              </template>
            </el-table-column>
            <el-table-column prop="huiyuankagongneng" header-align="center" align="center" label="会员卡功能" min-width="150">
              <template slot-scope="scope">
                <span class="cell-feature">{{ scope.row.huiyuankagongneng || '-' }}</span>
              </template>
            </el-table-column>
            <el-table-column width="200" align="center" fixed="right" label="操作" class-name="action-column">
              <template slot-scope="scope">
                <div class="action-buttons">
                  <el-button type="text" icon="el-icon-edit" class="action-link action-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
                  <el-button type="text" icon="el-icon-delete" class="action-link action-del" @click="deleteHandler(scope.row.id)">删除</el-button>
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
  </div>
</template>

<script>
import AddOrUpdate from "./add-or-update";

export default {
  data() {
    return {
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
      addOrUpdateFlag: false,
    };
  },
  created() {
    this.init();
    this.getDataList();
  },
  components: {
    AddOrUpdate,
  },
  methods: {
    init () {},
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    resetSearch() {
      this.searchForm = {
        huiyuankamingcheng: ''
      };
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
        url: "huiyuankaleixing/page",
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
          url: "huiyuankaleixing/delete",
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
.card-type-page {
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

.cell-name {
  color: #333;
  font-weight: 600;
}

.cell-type {
  display: inline-flex;
  align-items: center;
  padding: 4px 12px;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
  color: #667eea;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
}

.cell-image {
  display: flex;
  justify-content: center;
}

.table-image {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  object-fit: cover;
  transition: all 0.3s;
  cursor: pointer;
  border: 3px solid #e8f8f5;
}

.table-image:hover {
  transform: scale(1.1);
  border-color: #667eea;
}

.image-error {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  background: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ccc;
  font-size: 24px;
}

.cell-no-image {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  background: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ccc;
  font-size: 24px;
  margin: 0 auto;
}

.cell-price {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  color: #f56c6c;
  font-weight: 700;
  font-size: 15px;
}

.cell-price i {
  color: #f56c6c;
}

.cell-time {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #666;
}

.cell-time i {
  color: #667eea;
}

.cell-feature {
  color: #333;
  font-size: 13px;
  line-height: 1.4;
}

/* 操作按钮 */
.action-buttons {
  display: flex;
  gap: 2px;
  flex-wrap: nowrap;
  justify-content: center;
}

.action-link {
  font-size: 12px;
  padding: 5px 8px;
  border-radius: 4px;
  transition: all 0.3s;
  white-space: nowrap;
}

.action-edit {
  color: #667eea;
}

.action-edit:hover {
  background: rgba(102, 126, 234, 0.1);
}

.action-del {
  color: #f56c6c;
}

.action-del:hover {
  background: rgba(245, 108, 108, 0.1);
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
  .card-type-page {
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
