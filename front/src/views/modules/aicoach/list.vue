<template>
  <div class="main-content">
    <!-- 列表页 -->
    <div v-if="showFlag">
      <el-form :inline="true" :model="searchForm" class="form-content">
        <el-row :gutter="20" class="slt" :style="{justifyContent:contents.searchBoxPosition=='1'?'flex-start':contents.searchBoxPosition=='2'?'center':'flex-end'}">
          <el-form-item label="问题">
            <el-input v-model="searchForm.question" placeholder="问题" clearable></el-input>
          </el-form-item>
          <el-form-item label="分类">
            <el-input v-model="searchForm.category" placeholder="分类" clearable></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="success" icon="el-icon-search" @click="search()">查询</el-button>
          </el-form-item>
        </el-row>
        <el-row class="ad" :style="{justifyContent:contents.btnAdAllBoxPosition=='1'?'flex-start':contents.btnAdAllBoxPosition=='2'?'center':'flex-end'}">
          <el-form-item>
            <el-button v-if="isAuth('aicoach','新增')" type="success" icon="el-icon-plus" @click="addOrUpdateHandler()">新增</el-button>
            <el-button v-if="isAuth('aicoach','删除')" type="danger" icon="el-icon-delete" @click="deleteHandler()">删除</el-button>
          </el-form-item>
        </el-row>
      </el-form>
      <div class="table-content">
        <el-table class="tables" :size="contents.tableSize" :show-header="contents.tableShowHeader"
            :header-row-style="headerRowStyle" :header-cell-style="headerCellStyle"
            :border="contents.tableBorder" :fit="contents.tableFit"
            :stripe="contents.tableStripe"
            :row-style="rowStyle" :cell-style="cellStyle"
            :style="{width: '100%',fontSize:contents.tableFontSize}"
            v-if="dataList.length"
            :data="dataList"
            v-loading="dataListLoading"
            @selection-change="selectionChangeHandler">
          <el-table-column v-if="contents.tableSelection" type="selection" header-align="center" align="center" width="50">
          </el-table-column>
          <el-table-column label="序号" width="60" align="center">
            <template slot-scope="scope">
              {{ scope.$index + 1 }}
            </template>
          </el-table-column>
          <el-table-column :sortable="contents.tableSortable" align="center" label="问题" prop="question">
            <template slot-scope="scope">
              {{ scope.row.question }}
            </template>
          </el-table-column>
          <el-table-column :sortable="contents.tableSortable" align="center" label="答案" prop="answer">
            <template slot-scope="scope">
              <span v-if="scope.row.answer && scope.row.answer.length > 50">{{ scope.row.answer.substring(0, 50) }}...</span>
              <span v-else>{{ scope.row.answer }}</span>
            </template>
          </el-table-column>
          <el-table-column :sortable="contents.tableSortable" align="center" label="分类" prop="category">
            <template slot-scope="scope">
              {{ scope.row.category }}
            </template>
          </el-table-column>
          <el-table-column :sortable="contents.tableSortable" align="center" label="关键词" prop="keywords">
            <template slot-scope="scope">
              {{ scope.row.keywords }}
            </template>
          </el-table-column>
          <el-table-column :sortable="contents.tableSortable" align="center" label="排序" prop="sort">
            <template slot-scope="scope">
              {{ scope.row.sort }}
            </template>
          </el-table-column>
          <el-table-column width="180" label="操作">
            <template slot-scope="scope">
              <el-button v-if="isAuth('aicoach','修改')" type="text" size="small" icon="el-icon-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
              <el-button v-if="isAuth('aicoach','删除')" type="text" size="small" icon="el-icon-delete" @click="deleteHandler(scope.row.id)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <el-pagination
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="pageIndex"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pageSize"
          :total="totalPage"
          layout="total, sizes, prev, pager, next, jumper"
          class="pagination-content"
        ></el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchForm: {
        key: ""
      },
      showFlag: true,
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      contents: {
        searchBoxPosition: "1",
        btnAdAllBoxPosition: "2",
        inputTitle: "1",
        inputIcon: "1",
        inputIconPosition: "2",
        searchBtnFont: "1",
        searchBtnIcon: "1",
        tableShowHeader: true,
        tableBorder: true,
        tableFit: true,
        tableStripe: true,
        tableSize: "medium",
        tableSelection: true,
        tableSortable: true,
        tableFontSize: "14px"
      },
      dataListSelections: []
    };
  },
  mounted() {
    this.getDataList();
  },
  methods: {
    getDataList() {
      this.dataListLoading = true;
      var params = {
        page: this.pageIndex,
        limit: this.pageSize,
        sort: "id",
        order: "desc"
      };
      if (this.searchForm.question) {
        params["question"] = this.searchForm.question;
      }
      if (this.searchForm.category) {
        params["category"] = this.searchForm.category;
      }
      this.$http({
        url: "aicoach/knowledge/page",
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
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    addOrUpdateHandler(id) {
      // 使用路由导航到编辑页面
      if (id) {
        this.$router.push({ path: '/aicoach/add-or-update', query: { id: id } });
      } else {
        this.$router.push({ path: '/aicoach/add-or-update' });
      }
    },
    deleteHandler(id) {
      var ids = id ? [id] : this.dataListSelections.map(item => item.id);
      this.$confirm("确认删除?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "aicoach/knowledge/delete",
          method: "post",
          data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success("删除成功");
            this.getDataList();
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    rowStyle({ row, rowIndex }) {
      if (rowIndex % 2 == 1) {
        if (this.contents.tableStripe) {
          return { color: this.contents.tableFontColor };
        }
      } else {
        return "";
      }
    },
    cellStyle({ row, rowIndex }) {
      if (rowIndex % 2 == 1) {
        if (this.contents.tableStripe) {
          return { backgroundColor: this.contents.tableStripeBgColor };
        }
      } else {
        return "";
      }
    },
    headerRowStyle({ row, rowIndex }) {
      return { color: this.contents.tableHeaderFontColor };
    },
    headerCellStyle({ row, rowIndex }) {
      return { backgroundColor: this.contents.tableHeaderBgColor };
    }
  }
};
</script>

<style scoped>
.form-content {
  background: transparent;
}
</style>
