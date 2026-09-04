<template>
  <div class="main-content coach-page">
    <!-- 列表页 -->
    <div v-if="showFlag">
      <!-- 页面头部 -->
      <div class="page-header">
        <div class="header-content">
          <div class="header-left">
            <i class="el-icon-user-solid header-icon"></i>
            <div class="header-text">
              <h2 class="header-title">教练信息管理</h2>
              <p class="header-desc">管理健身房教练团队信息</p>
            </div>
          </div>
          <div class="header-stats">
            <div class="stat-card">
              <i class="el-icon-medal stat-icon"></i>
              <div class="stat-info">
                <span class="stat-value">{{ totalPage }}</span>
                <span class="stat-label">教练总数</span>
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
                v-model="searchForm.yuangongxingming" 
                placeholder="员工姓名" 
                clearable
                class="search-input"
                prefix-icon="el-icon-user"
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-input 
                v-model="searchForm.jiaolianleixing" 
                placeholder="教练类型" 
                clearable
                class="search-input"
                prefix-icon="el-icon-collection-tag"
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-input 
                v-model="searchForm.jiaolianjiage" 
                placeholder="教练价格" 
                clearable
                class="search-input"
                prefix-icon="el-icon-coin"
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-input 
                v-model="searchForm.gongzuolvli" 
                placeholder="工作履历" 
                clearable
                class="search-input"
                prefix-icon="el-icon-document"
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
          <el-button v-if="isAuth('jiaolianxinxi','新增')" type="success" icon="el-icon-plus" class="add-btn" @click="addOrUpdateHandler()">新增教练</el-button>
          <el-button 
            v-if="isAuth('jiaolianxinxi','删除')"
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
          :style="{width: '100%', minWidth: '1100px'}"
          row-key="id"
        >
          <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
          <el-table-column type="index" width="50" label="#" align="center">
            <template slot-scope="scope">
              <span class="row-index">{{ scope.$index + 1 + (pageIndex - 1) * pageSize }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="gonghao" header-align="center" align="center" label="工号" min-width="80">
            <template slot-scope="scope">
              <span class="cell-tag">{{ scope.row.gonghao || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="yuangongxingming" header-align="center" align="center" label="姓名" min-width="80">
            <template slot-scope="scope">
              <div class="cell-user">
                <div class="user-avatar" :style="{background: getAvatarColor(scope.row.yuangongxingming)}">
                  {{ getAvatarText(scope.row.yuangongxingming) }}
                </div>
                <span>{{ scope.row.yuangongxingming || '-' }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="xingbie" header-align="center" align="center" label="性别" min-width="60">
            <template slot-scope="scope">
              <span class="cell-gender" :class="scope.row.xingbie === '男' ? 'male' : 'female'">
                {{ scope.row.xingbie || '-' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="shengao" header-align="center" align="center" label="身高" min-width="70">
            <template slot-scope="scope">
              <span class="cell-data">{{ scope.row.shengao || '-' }}cm</span>
            </template>
          </el-table-column>
          <el-table-column prop="tizhong" header-align="center" align="center" label="体重" min-width="70">
            <template slot-scope="scope">
              <span class="cell-data">{{ scope.row.tizhong || '-' }}kg</span>
            </template>
          </el-table-column>
          <el-table-column prop="shoujihao" header-align="center" align="center" label="手机号" min-width="110">
            <template slot-scope="scope">
              <span class="cell-phone">{{ scope.row.shoujihao || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="jiaolianleixing" header-align="center" align="center" label="教练类型" min-width="90">
            <template slot-scope="scope">
              <span class="cell-badge">{{ scope.row.jiaolianleixing || '-' }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="jiaolianjiage" header-align="center" align="center" label="价格" min-width="80">
            <template slot-scope="scope">
              <span class="cell-price" v-if="scope.row.jiaolianjiage">¥{{ scope.row.jiaolianjiage }}</span>
              <span v-else>-</span>
            </template>
          </el-table-column>
          <el-table-column prop="shangkeshijian" header-align="center" align="center" label="上课时间" min-width="100">
            <template slot-scope="scope">
              <div class="cell-time">
                <i class="el-icon-time"></i>
                {{ scope.row.shangkeshijian || '-' }}
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="tupian" header-align="center" align="center" label="照片" min-width="120">
            <template slot-scope="scope">
              <div v-if="scope.row.tupian" class="cell-image">
                <el-image 
                  :src="scope.row.tupian.split(',')[0]" 
                  fit="cover"
                  class="table-image"
                  :preview-src-list="scope.row.tupian.split(',')"
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
          <el-table-column width="280" align="center" fixed="right" label="操作" class-name="action-column">
            <template slot-scope="scope">
              <div class="action-buttons">
                <el-button type="text" icon="el-icon-view" class="action-link action-view" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
                <el-button v-if="isAuth('jiaolianxinxi','修改')" type="text" icon="el-icon-edit" class="action-link action-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
                <el-button v-if="isAuth('jiaolianxinxi','修改')" type="text" icon="el-icon-user-remove" class="action-link action-fire" @click="jiepinCrossAddOrUpdateHandler(scope.row,'cross')">解聘</el-button>
                <el-button v-if="isAuth('jiaolianxinxi','删除')" type="text" icon="el-icon-delete" class="action-link action-del" @click="deleteHandler(scope.row.id)">删除</el-button>
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

    <!-- 解聘页面 -->
    <jiepin-cross-add-or-update v-if="jiepinCrossAddOrUpdateFlag" :parent="this" ref="jiepinCrossaddOrUpdate"></jiepin-cross-add-or-update>
  </div>
</template>

<script>
import AddOrUpdate from "./add-or-update";
import jiepinCrossAddOrUpdate from "../jiepin/add-or-update";

export default {
  data() {
    return {
      searchForm: {
        yuangongxingming: '',
        jiaolianleixing: '',
        jiaolianjiage: '',
        gongzuolvli: ''
      },
      form: {},
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      showFlag: true,
      addOrUpdateFlag: false,
      jiepinCrossAddOrUpdateFlag: false,
      layouts: 'total, sizes, prev, pager, next, jumper'
    };
  },
  created() {
    this.getDataList();
  },
  components: {
    AddOrUpdate,
    jiepinCrossAddOrUpdate
  },
  methods: {
    getAvatarText(name) {
      if (!name) return '?';
      return name.slice(0, 1).toUpperCase();
    },
    getAvatarColor(name) {
      if (!name) return '#909399';
      const colors = ['#667eea', '#764ba2', '#f093fb', '#f5576c', '#4facfe', '#00f2fe', '#43e97b', '#38f9d7'];
      let hash = 0;
      for (let i = 0; i < name.length; i++) {
        hash = name.charCodeAt(i) + ((hash << 5) - hash);
      }
      return colors[Math.abs(hash) % colors.length];
    },
    resetSearch() {
      this.searchForm = {
        yuangongxingming: '',
        jiaolianleixing: '',
        jiaolianjiage: '',
        gongzuolvli: ''
      };
      this.search();
    },
    jiepinCrossAddOrUpdateHandler(row, type) {
      this.$confirm(`确定要解聘教练 "${row.yuangongxingming}" 吗？解聘后将删除该教练信息并添加解聘记录。`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "jiaolianxinxi/delete",
          method: "post",
          data: [row.id]
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.showFlag = false;
            this.addOrUpdateFlag = false;
            this.jiepinCrossAddOrUpdateFlag = true;
            this.$storage.set('crossObj', row);
            this.$storage.set('crossTable', 'jiaolianxinxi');
            this.$nextTick(() => {
              this.$refs.jiepinCrossaddOrUpdate.init(row.id, type);
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    search() {
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
      if (this.searchForm.yuangongxingming != '' && this.searchForm.yuangongxingming != undefined) {
        params['yuangongxingming'] = '%' + this.searchForm.yuangongxingming + '%'
      }
      if (this.searchForm.jiaolianleixing != '' && this.searchForm.jiaolianleixing != undefined) {
        params['jiaolianleixing'] = '%' + this.searchForm.jiaolianleixing + '%'
      }
      if (this.searchForm.jiaolianjiage != '' && this.searchForm.jiaolianjiage != undefined) {
        params['jiaolianjiage'] = '%' + this.searchForm.jiaolianjiage + '%'
      }
      if (this.searchForm.gongzuolvli != '' && this.searchForm.gongzuolvli != undefined) {
        params['gongzuolvli'] = '%' + this.searchForm.gongzuolvli + '%'
      }
      this.$http({
        url: "jiaolianxinxi/page",
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
      this.crossAddOrUpdateFlag = false;
      if (type != 'info') {
        type = 'else';
      }
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(id, type);
      });
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
          url: "jiaolianxinxi/delete",
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
    }
  }
};
</script>

<style lang="scss" scoped>
.coach-page {
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
  width: 180px;
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

.cell-tag {
  color: #666;
  font-weight: 500;
}

.cell-user {
  display: flex;
  align-items: center;
  gap: 8px;
}

.user-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-weight: 600;
  font-size: 14px;
}

.cell-gender {
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
}

.cell-gender.male {
  background: #e6f7ff;
  color: #1890ff;
}

.cell-gender.female {
  background: #fff1f0;
  color: #ff4d4f;
}

.cell-data {
  color: #333;
  font-weight: 500;
}

.cell-phone {
  font-family: 'Monaco', 'Consolas', monospace;
  color: #444;
}

.cell-badge {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 500;
}

.cell-price {
  color: #f5222d;
  font-weight: 700;
  font-size: 15px;
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

.cell-image {
  display: flex;
  justify-content: center;
}

.table-image {
  width: 70px;
  height: 70px;
  border-radius: 10px;
  object-fit: cover;
  transition: all 0.3s;
  cursor: pointer;
}

.table-image:hover {
  transform: scale(1.1);
}

.image-error {
  width: 70px;
  height: 70px;
  border-radius: 10px;
  background: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ccc;
  font-size: 24px;
}

.cell-no-image {
  width: 70px;
  height: 70px;
  border-radius: 10px;
  background: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ccc;
  font-size: 24px;
}

/* 操作按钮 */
.action-buttons {
  display: flex;
  gap: 4px;
  flex-wrap: nowrap;
}

.action-link {
  font-size: 12px;
  padding: 4px 8px;
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

.action-edit {
  color: #faad14;
}

.action-edit:hover {
  background: rgba(250, 173, 20, 0.1);
}

.action-fire {
  color: #ff6b6b;
}

.action-fire:hover {
  background: rgba(255, 107, 107, 0.1);
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
  .coach-page {
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
