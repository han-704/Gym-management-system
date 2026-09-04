<template>
  <div class="main-content forum-container">
    <!-- 列表页 - 论坛形式 -->
    <div v-if="showFlag">
      <!-- 顶部搜索区域 -->
      <div class="forum-header">
        <div class="header-top">
          <div class="forum-title">
            <div class="title-icon">
              <i class="el-icon-chat-square"></i>
            </div>
            <span>健身心得社区</span>
          </div>
          <p class="title-sub">分享你的健身故事，记录每一步成长</p>
        </div>
        
        <el-row :gutter="20" class="forum-search">
          <el-col :span="8">
            <div class="search-wrapper">
              <i class="el-icon-search search-icon"></i>
              <el-input
                v-model="searchForm.title"
                placeholder="搜索健身心得..."
                clearable
                @keyup.enter.native="search()"
                class="search-input"
              ></el-input>
            </div>
          </el-col>
          <el-col :span="5">
            <el-select v-model="searchForm.fenlei" placeholder="选择分类" clearable style="width: 100%">
              <el-option label="全部" value=""></el-option>
              <el-option label="增肌" value="增肌"></el-option>
              <el-option label="减脂" value="减脂"></el-option>
              <el-option label="塑形" value="塑形"></el-option>
              <el-option label="营养恢复" value="营养恢复"></el-option>
              <el-option label="训练心得" value="训练心得"></el-option>
              <el-option label="器材使用" value="器材使用"></el-option>
              <el-option label="其他" value="其他"></el-option>
            </el-select>
          </el-col>
          <el-col :span="3">
            <el-button type="primary" icon="el-icon-search" @click="search()" class="search-btn">搜索</el-button>
          </el-col>
          <el-col :span="4" style="text-align: right;">
            <div class="button-group">
              <!-- 我的心得页面显示返回按钮 -->
              <el-button
                v-if="isMyList"
                icon="el-icon-user"
                @click="goToAllList()"
                class="back-all-btn"
              >
                <i class="el-icon-arrow-left"></i>返回全部
              </el-button>
              <!-- 全部心得页面显示我的心得按钮 -->
              <el-button
                v-else
                icon="el-icon-user"
                @click="handleMyListClick()"
                class="my-list-btn"
              >
                我的心得
              </el-button>
              <!-- 我的收藏按钮 -->
              <el-button
                icon="el-icon-star-on"
                @click="goToMyCollect()"
                class="my-collect-btn"
              >
                我的收藏
              </el-button>
              <el-button
                v-if="isAuth('xindefu','新增')"
                type="primary"
                icon="el-icon-edit"
                @click="addOrUpdateHandler()"
                class="publish-btn"
              >
                <i class="el-icon-plus"></i>发布心得
              </el-button>
            </div>
          </el-col>
        </el-row>
        
        <!-- 分类标签 -->
        <div class="category-tags">
          <div class="tag-item"
            :class="{ active: searchForm.fenlei === '' }"
            @click="searchForm.fenlei = ''; search()"
          >
            <span class="tag-icon">🏠</span>
            全部
          </div>
          <div class="tag-item"
            v-for="item in categoryList"
            :key="item"
            :class="{ active: searchForm.fenlei === item }"
            :style="getTagStyle(item)"
            @click="searchForm.fenlei = item; search()"
          >
            <span class="tag-icon">{{ getTagEmoji(item) }}</span>
            {{ item }}
          </div>
        </div>
      </div>

      <!-- 帖子列表 -->
      <div class="post-list" v-loading="dataListLoading">
        <div v-if="dataList.length === 0" class="empty-state">
          <div class="empty-illustration">
            <div class="empty-icon">📝</div>
          </div>
          <h3>暂无心得</h3>
          <p>快来发布第一篇健身心得吧！</p>
          <el-button v-if="isAuth('xindefu','新增')" type="primary" round @click="addOrUpdateHandler()">
            分享心得
          </el-button>
        </div>
        
        <div class="post-grid">
          <el-card
            v-for="(item, index) in dataList"
            :key="item.id"
            class="post-card"
            :class="{ 'animate-in': true }"
            :style="{ animationDelay: (index * 0.1) + 's' }"
            shadow="hover"
            @click.native="$router.push({ path: '/xindefu/detail', query: { id: item.id } })"
          >
            <!-- 封面图 -->
            <div class="post-cover">
              <img v-if="item.fengmian" :src="item.fengmian" alt="封面" class="cover-img">
              <div v-else class="no-cover">
                <i class="el-icon-picture-outline"></i>
                <span>暂无封面</span>
              </div>
              <div class="category-badge" :style="getBadgeStyle(item.fenlei)">
                {{ item.fenlei }}
              </div>
            </div>
            
            <!-- 内容区域 -->
            <div class="post-content">
              <h3 class="post-title">{{ item.title }}</h3>
              <p class="post-summary" v-if="item.content">
                {{ getContentSummary(item.content) }}
              </p>
              
              <!-- 用户信息 -->
              <div class="post-author">
                <div class="author-avatar">
                  <span>{{ (item.fabuxingming || item.fabuzhanghao || '匿名').charAt(0) }}</span>
                </div>
                <span class="author-name">{{ item.fabuxingming || item.fabuzhanghao }}</span>
                <span class="post-time">
                  <i class="el-icon-time"></i>
                  {{ item.fabushijian }}
                </span>
              </div>
              
              <!-- 互动数据 -->
              <div class="post-stats">
                <div class="stat-item views">
                  <i class="el-icon-view"></i>
                  <span>{{ item.clicknum || 0 }}</span>
                </div>
                <div class="stat-item likes" @click.stop="thumbsupOrCancle(item)" :class="{ active: item.thumbsupFlag === 1 }">
                  <i :class="item.thumbsupFlag === 1 ? 'el-icon-star-on heart-active' : 'el-icon-star-off'"></i>
                  <span>{{ item.thumbsupnum || 0 }}</span>
                </div>
                <div class="stat-item collects" @click.stop="collectOrCancle(item)" :class="{ active: item.collectFlag === 1 }">
                  <i :class="item.collectFlag === 1 ? 'el-icon-collection-tag collect-active' : 'el-icon-collection'"></i>
                  <span>{{ item.collectnum || 0 }}</span>
                </div>
                <div class="stat-item comments" @click.stop="commentHandler(item)">
                  <i class="el-icon-chat-dot-round"></i>
                  <span>{{ item.commentnum || 0 }}</span>
                </div>
              </div>
              
              <!-- 操作按钮 -->
              <div class="post-actions" v-if="(!isHuiyuan || isMyList) && (isAuth('xindefu','修改') || isAuth('xindefu','删除'))">
                <el-button v-if="(!isHuiyuan || isMyList) && isAuth('xindefu','修改')" size="mini" icon="el-icon-edit" @click.stop="addOrUpdateHandler(item.id)" class="action-btn edit-btn">
                  编辑
                </el-button>
                <el-button v-if="(!isHuiyuan || isMyList) && isAuth('xindefu','删除')" size="mini" icon="el-icon-delete" @click.stop="deleteHandler(item.id)" class="action-btn delete-btn">
                  删除
                </el-button>
              </div>
            </div>
          </el-card>
        </div>

        <!-- 分页 -->
        <el-pagination
          v-if="totalPage > 0"
          :layout="layouts"
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="pageIndex"
          :page-sizes="[10, 20, 50]"
          :page-size="pageSize"
          :total="totalPage"
          class="pagination-content"
          background
          style="margin-top: 30px; justify-content: center;"
        ></el-pagination>
      </div>
    </div>
    <!-- 添加/修改页面  将父组件的search方法传递给子组件-->
    <add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>

    <!-- 评论对话框 -->
    <el-dialog :title="'评论' " :visible.sync="commentDialogVisible" width="60%" class="comment-dialog">
      <div class="comment-list">
        <div v-if="commentList.length === 0" class="no-comments">
          <i class="el-icon-chat-dot-round"></i>
          <p>暂无评论，快来抢沙发吧~</p>
        </div>
        <div v-else class="comment-items">
          <div v-for="comment in commentList" :key="comment.id" class="comment-item">
            <div class="comment-avatar">
              <span>{{ (comment.huiyuanxingming || '游客').charAt(0) }}</span>
            </div>
            <div class="comment-body">
              <div class="comment-header">
                <span class="comment-author">{{ comment.huiyuanxingming || '游客' }}</span>
                <span class="comment-time">{{ comment.pinglunshijian }}</span>
              </div>
              <div class="comment-content">{{ comment.pinglunneirong }}</div>
            </div>
          </div>
        </div>
      </div>
      <el-form :model="commentForm" ref="commentForm" class="comment-form">
        <el-form-item label="发表评论">
          <el-input type="textarea" v-model="commentForm.pinglunneirong" placeholder="写下你的评论..." :rows="3"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitComment" class="submit-comment-btn">发布评论</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

  </div>
</template>
<script>
import AddOrUpdate from "./add-or-update";
export default {
  data() {
    return {
      searchForm: {
        key: "",
        fenlei: ""
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
      contents:{"searchBtnFontColor":"#333","pagePosition":"1","inputFontSize":"14px","inputBorderRadius":"22px","tableBtnDelFontColor":"#333","tableBtnIconPosition":"1","searchBtnHeight":"40px","inputIconColor":"rgba(66, 130, 129, 1)","searchBtnBorderRadius":"22px","tableStripe":false,"btnAdAllWarnFontColor":"#333","tableBtnDelBgColor":"rgba(244, 150, 150, 1)","searchBtnIcon":"1","tableSize":"medium","searchBtnBorderStyle":"solid","tableSelection":true,"searchBtnBorderWidth":"1px","tableContentFontSize":"14px","searchBtnBgColor":"rgba(153, 239, 237, 1)","inputTitleSize":"14px","btnAdAllBorderColor":"#DCDFE6","pageJumper":true,"btnAdAllIconPosition":"1","searchBoxPosition":"1","tableBtnDetailFontColor":"#333","tableBtnHeight":"40px","pagePager":true,"searchBtnBorderColor":"#DCDFE6","tableHeaderFontColor":"rgba(33, 34, 35, 1)","inputTitle":"1","tableBtnBorderRadius":"22px","btnAdAllFont":"1","btnAdAllDelFontColor":"rgba(21, 20, 20, 1)","tableBtnIcon":"1","btnAdAllHeight":"40px","btnAdAllWarnBgColor":"rgba(238, 236, 126, 1)","btnAdAllBorderWidth":"1px","tableStripeFontColor":"#606266","tableBtnBorderStyle":"solid","inputHeight":"40px","btnAdAllBorderRadius":"22px","btnAdAllDelBgColor":"rgba(234, 93, 93, 0.69)","pagePrevNext":true,"btnAdAllAddBgColor":"rgba(153, 239, 237, 1)","searchBtnFont":"1","tableIndex":true,"btnAdAllIcon":"1","tableSortable":true,"pageSizes":true,"tableFit":true,"pageBtnBG":true,"searchBtnFontSize":"14px","tableBtnEditBgColor":"rgba(240, 242, 124, 1)","inputBorderWidth":"1px","inputFontPosition":"1","inputFontColor":"#333","pageEachNum":10,"tableHeaderBgColor":"rgba(152, 129, 129, 1)","inputTitleColor":"#333","btnAdAllBoxPosition":"1","tableBtnDetailBgColor":"rgba(171, 239, 239, 1)","inputIcon":"0","searchBtnIconPosition":"1","btnAdAllFontSize":"14px","inputBorderStyle":"solid","inputBgColor":"rgba(197, 174, 174, 0.32)","pageStyle":false,"pageTotal":true,"btnAdAllAddFontColor":"#333","tableBtnFont":"1","tableContentFontColor":"rgba(22, 22, 23, 1)","inputBorderColor":"rgba(152, 129, 129, 1)","tableShowHeader":true,"tableBtnFontSize":"14px","tableBtnBorderColor":"rgba(196, 210, 244, 1)","inputIconPosition":"1","tableBorder":true,"btnAdAllBorderStyle":"solid","tableBtnBorderWidth":"1px","tableStripeBgColor":"rgba(213, 197, 197, 1)","tableBtnEditFontColor":"#333","tableAlign":"center"},
      layouts: '',
      commentDialogVisible: false,
      commentList: [],
      commentForm: {
        pinglunneirong: '',
        xindefuId: null
      },
      isMyList: false,
      isHuiyuan: false,
      categoryList: ['增肌', '减脂', '塑形', '营养恢复', '训练心得', '器材使用', '其他'],

    };
  },
  created() {
    // 判断是否是myList模式 - 只根据路由路径判断
    this.isMyList = this.$route.path === '/xindefu/myList';
    // 判断是否是会员端
    let sessionTable = this.$storage.get('sessionTable');
    this.isHuiyuan = sessionTable === 'huiyuan';
    this.init();
    this.getDataList();
    this.contentStyleChange()
  },
  beforeRouteUpdate(to, from, next) {
    // 路由更新时重新判断是否是myList模式
    this.isMyList = to.path === '/xindefu/myList';
    this.searchForm.title = '';
    this.searchForm.fenlei = '';
    this.pageIndex = 1;
    next();
    this.getDataList();
  },
  mounted() {

  },
  watch: {
    // 监听路由变化，解决同一组件不同路由不刷新问题
    '$route': {
      handler(to, from) {
        // 当路由变化时，重新判断是否是myList模式
        if (to.path === '/xindefu/myList') {
          this.isMyList = true;
        } else {
          this.isMyList = false;
        }
        // 重置搜索条件
        this.searchForm.title = '';
        this.searchForm.fenlei = '';
        this.pageIndex = 1;
        // 重新获取数据
        this.getDataList();
      },
      immediate: true,
      deep: true
    }
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
    // 获取标签样式
    getTagStyle(tag) {
      const styles = {
        '增肌': { '--tag-color': '#FF6B6B', '--tag-bg': '#FFE8E8' },
        '减脂': { '--tag-color': '#4ECDC4', '--tag-bg': '#E8F8F7' },
        '塑形': { '--tag-color': '#9B59B6', '--tag-bg': '#F3E8FF' },
        '营养恢复': { '--tag-color': '#F39C12', '--tag-bg': '#FFF4E0' },
        '训练心得': { '--tag-color': '#3498DB', '--tag-bg': '#EBF5FB' },
        '器材使用': { '--tag-color': '#E74C3C', '--tag-bg': '#FDEDEC' },
        '其他': { '--tag-color': '#95A5A6', '--tag-bg': '#F4F6F6' }
      };
      const style = styles[tag] || { '--tag-color': '#FF8C69', '--tag-bg': '#FFF0E8' };
      if (this.searchForm.fenlei === tag) {
        return {
          background: `linear-gradient(135deg, ${style['--tag-color']} 0%, ${style['--tag-color']}dd 100%)`,
          color: '#fff'
        };
      }
      return {
        background: style['--tag-bg'],
        color: style['--tag-color']
      };
    },
    
    // 获取标签表情
    getTagEmoji(tag) {
      const emojis = {
        '增肌': '💪',
        '减脂': '🔥',
        '塑形': '✨',
        '营养恢复': '🥗',
        '训练心得': '📝',
        '器材使用': '🏋️',
        '其他': '📌'
      };
      return emojis[tag] || '📌';
    },
    
    // 获取徽章样式
    getBadgeStyle(fenlei) {
      const styles = {
        '增肌': { background: 'linear-gradient(135deg, #FF6B6B 0%, #EE5A5A 100%)' },
        '减脂': { background: 'linear-gradient(135deg, #4ECDC4 0%, #3DBDB5 100%)' },
        '塑形': { background: 'linear-gradient(135deg, #9B59B6 0%, #8E44AD 100%)' },
        '营养恢复': { background: 'linear-gradient(135deg, #F39C12 0%, #E67E22 100%)' },
        '训练心得': { background: 'linear-gradient(135deg, #3498DB 0%, #2980B9 100%)' },
        '器材使用': { background: 'linear-gradient(135deg, #E74C3C 0%, #C0392B 100%)' },
        '其他': { background: 'linear-gradient(135deg, #95A5A6 0%, #7F8C8D 100%)' }
      };
      return styles[fenlei] || { background: 'linear-gradient(135deg, #FF8C69 0%, #FF7F50 100%)' };
    },
    
    // 处理我的心得点击
    handleMyListClick() {
      // 先更新状态
      this.isMyList = true;
      this.searchForm.title = '';
      this.searchForm.fenlei = '';
      this.pageIndex = 1;
      // 然后跳转路由
      this.$router.push('/xindefu/myList');
    },
    
    // 返回全部心得列表
    goToAllList() {
      // 先更新状态
      this.isMyList = false;
      this.searchForm.title = '';
      this.searchForm.fenlei = '';
      this.pageIndex = 1;
      // 然后跳转路由
      this.$router.push('/xindefu');
    },
    
    // 跳转到我的收藏
    goToMyCollect() {
      this.$router.push('/xindefu/myCollect');
    },
    contentStyleChange() {
      this.contentSearchStyleChange()
      this.contentBtnAdAllStyleChange()
      this.contentSearchBtnStyleChange()
      this.contentTableBtnStyleChange()
      this.contentPageStyleChange()
    },
    contentSearchStyleChange() {
      this.$nextTick(()=>{
        document.querySelectorAll('.form-content .slt .el-input__inner').forEach(el=>{
          let textAlign = 'left'
          if(this.contents.inputFontPosition == 2) textAlign = 'center'
          if(this.contents.inputFontPosition == 3) textAlign = 'right'
          el.style.textAlign = textAlign
          el.style.height = this.contents.inputHeight
          el.style.lineHeight = this.contents.inputHeight
          el.style.color = this.contents.inputFontColor
          el.style.fontSize = this.contents.inputFontSize
          el.style.borderWidth = this.contents.inputBorderWidth
          el.style.borderStyle = this.contents.inputBorderStyle
          el.style.borderColor = this.contents.inputBorderColor
          el.style.borderRadius = this.contents.inputBorderRadius
          el.style.backgroundColor = this.contents.inputBgColor
        })
        if(this.contents.inputTitle) {
          document.querySelectorAll('.form-content .slt .el-form-item__label').forEach(el=>{
            el.style.color = this.contents.inputTitleColor
            el.style.fontSize = this.contents.inputTitleSize
            el.style.lineHeight = this.contents.inputHeight
          })
        }
        setTimeout(()=>{
          document.querySelectorAll('.form-content .slt .el-input__prefix').forEach(el=>{
            el.style.color = this.contents.inputIconColor
            el.style.lineHeight = this.contents.inputHeight
          })
          document.querySelectorAll('.form-content .slt .el-input__suffix').forEach(el=>{
            el.style.color = this.contents.inputIconColor
            el.style.lineHeight = this.contents.inputHeight
          })
          document.querySelectorAll('.form-content .slt .el-input__icon').forEach(el=>{
            el.style.lineHeight = this.contents.inputHeight
          })
        },10)

      })
    },
    // 搜索按钮
    contentSearchBtnStyleChange() {
      this.$nextTick(()=>{
        document.querySelectorAll('.form-content .slt .el-button--success').forEach(el=>{
          el.style.height = this.contents.searchBtnHeight
          el.style.color = this.contents.searchBtnFontColor
          el.style.fontSize = this.contents.searchBtnFontSize
          el.style.borderWidth = this.contents.searchBtnBorderWidth
          el.style.borderStyle = this.contents.searchBtnBorderStyle
          el.style.borderColor = this.contents.searchBtnBorderColor
          el.style.borderRadius = this.contents.searchBtnBorderRadius
          el.style.backgroundColor = this.contents.searchBtnBgColor
        })
      })
    },
    // 新增、批量删除
    contentBtnAdAllStyleChange() {
      this.$nextTick(()=>{
        document.querySelectorAll('.form-content .ad .el-button--success').forEach(el=>{
          el.style.height = this.contents.btnAdAllHeight
          el.style.color = this.contents.btnAdAllAddFontColor
          el.style.fontSize = this.contents.btnAdAllFontSize
          el.style.borderWidth = this.contents.btnAdAllBorderWidth
          el.style.borderStyle = this.contents.btnAdAllBorderStyle
          el.style.borderColor = this.contents.btnAdAllBorderColor
          el.style.borderRadius = this.contents.btnAdAllBorderRadius
          el.style.backgroundColor = this.contents.btnAdAllAddBgColor
        })
        document.querySelectorAll('.form-content .ad .el-button--danger').forEach(el=>{
          el.style.height = this.contents.btnAdAllHeight
          el.style.color = this.contents.btnAdAllDelFontColor
          el.style.fontSize = this.contents.btnAdAllFontSize
          el.style.borderWidth = this.contents.btnAdAllBorderWidth
          el.style.borderStyle = this.contents.btnAdAllBorderStyle
          el.style.borderColor = this.contents.btnAdAllBorderColor
          el.style.borderRadius = this.contents.btnAdAllBorderRadius
          el.style.backgroundColor = this.contents.btnAdAllDelBgColor
        })
        document.querySelectorAll('.form-content .ad .el-button--warning').forEach(el=>{
          el.style.height = this.contents.btnAdAllHeight
          el.style.color = this.contents.btnAdAllWarnFontColor
          el.style.fontSize = this.contents.btnAdAllFontSize
          el.style.borderWidth = this.contents.btnAdAllBorderWidth
          el.style.borderStyle = this.contents.btnAdAllBorderStyle
          el.style.borderColor = this.contents.btnAdAllBorderColor
          el.style.borderRadius = this.contents.btnAdAllBorderRadius
          el.style.backgroundColor = this.contents.btnAdAllWarnBgColor
        })
      })
    },
    // 表格
    rowStyle({ row, rowIndex}) {
      if (rowIndex % 2 == 1) {
        if(this.contents.tableStripe) {
          return {color:this.contents.tableStripeFontColor}
        }
      } else {
        return ''
      }
    },
    cellStyle({ row, rowIndex}){
      if (rowIndex % 2 == 1) {
        if(this.contents.tableStripe) {
          return {backgroundColor:this.contents.tableStripeBgColor}
        }
      } else {
        return ''
      }
    },
    headerRowStyle({ row, rowIndex}){
      return {color: this.contents.tableHeaderFontColor}
    },
    headerCellStyle({ row, rowIndex}){
      return {backgroundColor: this.contents.tableHeaderBgColor}
    },
    // 表格按钮
    contentTableBtnStyleChange(){
    },
    // 分页
    contentPageStyleChange(){
      let arr = []

      if(this.contents.pageTotal) arr.push('total')
      if(this.contents.pageSizes) arr.push('sizes')
      if(this.contents.pagePrevNext){
        arr.push('prev')
        if(this.contents.pagePager) arr.push('pager')
        arr.push('next')
      }
      if(this.contents.pageJumper) arr.push('jumper')
      this.layouts = arr.join()
      this.contents.pageEachNum = 10
    },

    init () {
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      let params = {
        page: this.pageIndex,
        limit: this.pageSize,
        sort: 'fabushijian',
        order: 'desc',
      }
      if(this.searchForm.title!='' && this.searchForm.title!=undefined){
        params['title'] = '%' + this.searchForm.title + '%'
      }
      if(this.searchForm.fenlei!='' && this.searchForm.fenlei!=undefined){
        params['fenlei'] = this.searchForm.fenlei
      }
      // 根据模式调用不同的接口
      let url = this.isMyList ? "xindefu/myList" : "xindefu/page";
      this.$http({
        url: url,
        method: "get",
        params: params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.data.list;
          this.totalPage = data.data.total;
          // 获取点赞状态
          this.getThumbsupStatus();
          // 获取收藏状态
          this.getCollectStatus();
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },
    // 获取点赞状态
    getThumbsupStatus() {
      let username = this.$storage.get('adminName');
      if (!username) return;
      this.dataList.forEach(item => {
        this.$http({
          url: 'xindefuThumbsup/list',
          method: 'get',
          params: {
            xindefuId: item.id,
            huiyuanzhanghao: username
          }
        }).then(({ data }) => {
          if (data && data.code === 0 && data.data.list.length > 0) {
            item.thumbsupFlag = data.data.list[0].thumbsupTypes;
          } else {
            item.thumbsupFlag = 0;
          }
        });
      });
    },
    // 获取收藏状态
    getCollectStatus() {
      let username = this.$storage.get('adminName');
      console.log('获取收藏状态，当前用户名:', username);
      if (!username) return;
      this.dataList.forEach(item => {
        console.log('获取收藏状态，心得ID:', item.id);
        this.$http({
          url: 'xindefuCollect/list',
          method: 'get',
          params: {
            xindefuId: item.id,
            huiyuanzhanghao: username
          }
        }).then(({ data }) => {
          console.log('收藏状态接口返回:', data);
          if (data && data.code === 0 && data.data.list.length > 0) {
            item.collectFlag = 1;
          } else {
            item.collectFlag = 0;
          }
        }).catch(error => {
          console.error('获取收藏状态失败:', error);
          item.collectFlag = 0;
        });
      });
    },
    // 获取内容摘要
    getContentSummary(content) {
      if (!content) return '';
      let plainText = content.replace(/<[^>]*>/g, '');
      if (plainText.length > 80) {
        return plainText.substring(0, 80) + '...';
      }
      return plainText;
    },
    // 收藏/取消收藏
    collectOrCancle(item) {
      console.log('点击收藏按钮，item:', item);
      let tableName = this.$storage.get('sessionTable');
      console.log('当前用户类型:', tableName);
      if (!tableName) {
        this.$message.warning('请先登录');
        return;
      }
      console.log('调用收藏接口:', `xindefu/collect/${item.id}`);
      this.$http({
        url: `xindefu/collect/${item.id}`,
        method: 'get'
      }).then(({ data }) => {
        console.log('收藏接口返回:', data);
        if (data && data.code === 0) {
          if (item.collectFlag === 1) {
            item.collectFlag = 0;
            item.collectnum = (item.collectnum || 1) - 1;
            this.$message.success('取消收藏');
          } else {
            item.collectFlag = 1;
            item.collectnum = (item.collectnum || 0) + 1;
            this.$message.success('收藏成功');
          }
        } else {
          this.$message.error(data.msg || '操作失败');
        }
      }).catch(error => {
        console.error('收藏接口调用失败:', error);
        console.log('错误详情:', error.response);
        this.$message.error((error.response && error.response.data && error.response.data.msg) || '网络错误，请稍后重试');
      });
    },
    // 每页数
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    // 当前页
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
    // 多选
    selectionChangeHandler(val) {
      this.dataListSelections = val;
    },
    // 添加/修改
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
    // 下载
    download(file){
      window.open(`${file}`)
    },
    // 删除
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
          url: "xindefu/delete",
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
    // 点赞/取消点赞
    thumbsupOrCancle(item) {
      let tableName = this.$storage.get('sessionTable');
      if (!tableName) {
        this.$message.warning('请先登录');
        return;
      }
      let username = this.$storage.get('adminName');
      let params = {
        xindefuId: item.id,
        huiyuanzhanghao: username,
        thumbsupTypes: item.thumbsupFlag === 1 ? 2 : 1
      };
      this.$http({
        url: 'xindefuThumbsup/add',
        method: 'post',
        data: params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          if (item.thumbsupFlag === 1) {
            item.thumbsupnum--;
            item.thumbsupFlag = 0;
            this.$message.success('取消点赞');
          } else {
            item.thumbsupnum++;
            item.thumbsupFlag = 1;
            this.$message.success('点赞成功');
          }
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    // 评论相关方法
    commentHandler(row) {
      this.commentForm.xindefuId = row.id;
      this.commentForm.pinglunneirong = '';
      this.getCommentList(row.id);
      this.commentDialogVisible = true;
    },
    getCommentList(xindefuId) {
      this.$http({
        url: 'xindefuComment/listByXindefuId',
        method: "get",
        params: { xindefuId }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.commentList = data.data;
        }
      });
    },
    submitComment() {
      if (!this.commentForm.pinglunneirong) {
        this.$message.error('评论内容不能为空');
        return;
      }
      this.$http({
        url: 'huiyuan/session',
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          const commentData = {
            xindefuId: this.commentForm.xindefuId,
            huiyuanzhanghao: data.data.huiyuanzhanghao,
            huiyuanxingming: data.data.huiyuanxingming,
            pinglunneirong: this.commentForm.pinglunneirong
          };
          this.$http({
            url: 'xindefuComment/save',
            method: "post",
            data: commentData
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: '评论成功',
                type: 'success',
                duration: 1500
              });
              this.commentForm.pinglunneirong = '';
              this.getCommentList(this.commentForm.xindefuId);
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    }
  }

};
</script>
<style lang="scss" scoped>
// 温暖社区风（小红书风格）样式
// 变量定义
$coral: #FF8C69;  // 珊瑚橙
$coral-light: #FFB299;
$coral-dark: #E67750;
$cream: #FFF8F0;  // 米白
$warm-white: #FFFCF8;
$text-primary: #5D4E37;  // 深棕色
$text-secondary: #8B7355;
$text-light: #A69580;
$border-color: #F5E6D3;
$shadow-color: rgba(255, 140, 105, 0.15);
$gradient-warm: linear-gradient(135deg, #FF8C69 0%, #FFA07A 50%, #FFD4B8 100%);

.slt {
  margin: 0 !important;
  display: flex;
}

.ad {
  margin: 0 !important;
  display: flex;
}

.pages {
  & ::v-deep el-pagination__sizes{
    & ::v-deep el-input__inner {
      height: 22px;
      line-height: 22px;
    }
  }
}

.el-button+.el-button {
  margin:0;
} 

// 论坛容器
.forum-container {
  padding: 24px;
  background: linear-gradient(180deg, #FFF8F0 0%, #FFF5EB 100%);
  min-height: calc(100vh - 84px);
}

// 顶部区域
.forum-header {
  background: #fff;
  padding: 28px 32px;
  border-radius: 20px;
  margin-bottom: 24px;
  box-shadow: 0 4px 20px $shadow-color;
  border: 1px solid $border-color;
}

.header-top {
  margin-bottom: 24px;
}

.forum-title {
  font-size: 28px;
  font-weight: 700;
  color: $text-primary;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 12px;
  
  .title-icon {
    width: 48px;
    height: 48px;
    background: $gradient-warm;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 12px rgba(255, 140, 105, 0.3);
    
    i {
      margin: 0;
      color: #fff;
      font-size: 26px;
    }
  }
  
  span {
    background: $gradient-warm;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
}

.title-sub {
  font-size: 14px;
  color: $text-light;
  margin-left: 60px;
}

// 搜索区域
.forum-search {
  margin-bottom: 20px;
  
  .el-select .el-input__inner {
    border-radius: 24px;
    border-color: $border-color;
    background: $cream;
  }
}

.search-wrapper {
  position: relative;
  width: 100%;
  
  .search-icon {
    position: absolute;
    left: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: $coral;
    font-size: 18px;
    z-index: 1;
  }
  
  .search-input {
    ::v-deep .el-input__inner {
      padding-left: 44px;
      height: 44px;
      border-radius: 22px;
      border: 2px solid $border-color;
      background: $cream;
      font-size: 14px;
      transition: all 0.3s;
      
      &:focus {
        border-color: $coral;
        background: #fff;
        box-shadow: 0 0 0 3px rgba(255, 140, 105, 0.1);
      }
    }
  }
}

.search-btn {
  height: 44px;
  padding: 0 24px;
  border-radius: 22px;
  background: $gradient-warm;
  border: none;
  font-weight: 600;
  box-shadow: 0 4px 12px rgba(255, 140, 105, 0.3);
  transition: all 0.3s;
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(255, 140, 105, 0.4);
  }
}

.publish-btn {
  height: 44px;
  padding: 0 24px;
  border-radius: 22px;
  background: $gradient-warm;
  border: none;
  font-weight: 600;
  box-shadow: 0 4px 12px rgba(255, 140, 105, 0.3);
  transition: all 0.3s;
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(255, 140, 105, 0.4);
  }
  
  i {
    margin-right: 6px;
  }
}

.button-group {
  display: flex;
  gap: 12px;
  justify-content: flex-end;
  flex-wrap: wrap;
}

.my-list-btn {
  height: 44px;
  padding: 0 20px;
  border-radius: 22px;
  background: linear-gradient(135deg, #FFE4D6 0%, #FFF0E8 100%);
  border: 2px solid $border-color;
  color: $coral;
  font-weight: 600;
  transition: all 0.3s;
  
  &:hover {
    background: $gradient-warm;
    border-color: $coral;
    color: #fff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(255, 140, 105, 0.3);
  }
  
  i {
    margin-right: 6px;
  }
}

.back-all-btn {
  height: 44px;
  padding: 0 20px;
  border-radius: 22px;
  background: linear-gradient(135deg, #E8F5E9 0%, #F1F8E9 100%);
  border: 2px solid #C8E6C9;
  color: #2E7D32;
  font-weight: 600;
  transition: all 0.3s;
  
  &:hover {
    background: linear-gradient(135deg, #C8E6C9 0%, #A5D6A7 100%);
    border-color: #81C784;
    color: #1B5E20;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
  }
  
  i {
    margin-right: 6px;
  }
}

.my-collect-btn {
  height: 44px;
  padding: 0 20px;
  border-radius: 22px;
  background: linear-gradient(135deg, #FFF8E1 0%, #FFECB3 100%);
  border: 2px solid #FFD54F;
  color: #F57F17;
  font-weight: 600;
  transition: all 0.3s;
  
  &:hover {
    background: linear-gradient(135deg, #FFD54F 0%, #FFCA28 100%);
    border-color: #FFC107;
    color: #E65100;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3);
  }
  
  i {
    margin-right: 6px;
  }
}

// 分类标签
.category-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  padding-top: 16px;
  border-top: 1px solid $border-color;
}

.tag-item {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 18px;
  border-radius: 20px;
  background: $cream;
  color: $text-secondary;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.3s;
  border: 1px solid transparent;
  
  .tag-icon {
    font-size: 16px;
  }
  
  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px $shadow-color;
  }
  
  &.active {
    background: $gradient-warm;
    color: #fff;
    box-shadow: 0 4px 12px rgba(255, 140, 105, 0.3);
  }
}

// 帖子列表
.post-list {
  min-height: 400px;
}

.post-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 20px;
}

// 帖子卡片
.post-card {
  background: #fff;
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  border: 1px solid $border-color;
  box-shadow: 0 2px 12px $shadow-color;
  
  &:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 12px 32px $shadow-color;
    
    .cover-img {
      transform: scale(1.1);
    }
  }
  
  &.animate-in {
    animation: cardFadeIn 0.6s ease-out both;
  }
}

@keyframes cardFadeIn {
  from {
    opacity: 0;
    transform: translateY(30px) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

// 封面图
.post-cover {
  position: relative;
  width: 100%;
  height: 180px;
  overflow: hidden;
  background: linear-gradient(135deg, #FFE4D6 0%, #FFF0E8 100%);
  
  .cover-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.6s;
  }
  
  .no-cover {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: $coral-light;
    
    i {
      font-size: 48px;
      margin-bottom: 8px;
    }
    
    span {
      font-size: 12px;
    }
  }
}

.category-badge {
  position: absolute;
  top: 12px;
  left: 12px;
  padding: 6px 14px;
  border-radius: 16px;
  font-size: 12px;
  font-weight: 600;
  color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

// 内容区域
.post-content {
  padding: 20px;
}

.post-title {
  font-size: 18px;
  font-weight: 700;
  color: $text-primary;
  margin: 0 0 12px 0;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.post-summary {
  font-size: 14px;
  color: $text-secondary;
  line-height: 1.7;
  margin-bottom: 16px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

// 用户信息
.post-author {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 16px;
  padding-bottom: 16px;
  border-bottom: 1px solid $border-color;
  
  .author-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: $gradient-warm;
    display: flex;
    align-items: center;
    justify-content: center;
    
    span {
      color: #fff;
      font-size: 14px;
      font-weight: 600;
    }
  }
  
  .author-name {
    font-size: 14px;
    color: $text-primary;
    font-weight: 600;
    flex: 1;
  }
  
  .post-time {
    font-size: 12px;
    color: $text-light;
    
    i {
      margin-right: 4px;
    }
  }
}

// 统计数据
.post-stats {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 12px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  color: $text-light;
  transition: all 0.3s;
  
  i {
    font-size: 16px;
  }
  
  &.views i {
    color: #909399;
  }
  
  &.likes:hover, &.likes.active {
    color: #FF6B81;
    i {
      transform: scale(1.2);
    }
  }
  
  &.collects:hover, &.collects.active {
    color: #FFA500;
    i {
      transform: scale(1.2);
    }
  }
  
  &.comments:hover {
    color: $coral;
  }
}

.heart-active {
  color: #FF6B81;
  animation: heartBeat 0.6s ease-in-out;
}

.collect-active {
  color: #FFA500;
}

@keyframes heartBeat {
  0% { transform: scale(1); }
  25% { transform: scale(1.4); }
  50% { transform: scale(1); }
  75% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

// 操作按钮
.post-actions {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
  
  .action-btn {
    border-radius: 16px;
    font-size: 12px;
    padding: 6px 14px;
  }
  
  .edit-btn {
    background: linear-gradient(135deg, #87CEEB 0%, #B0E0E6 100%);
    border: none;
    color: #4682B4;
  }
  
  .delete-btn {
    background: linear-gradient(135deg, #FFB6C1 0%, #FFC0CB 100%);
    border: none;
    color: #DB7093;
  }
}

// 空状态
.empty-state {
  text-align: center;
  padding: 80px 20px;
  background: #fff;
  border-radius: 20px;
  border: 1px dashed $border-color;
  
  .empty-illustration {
    margin-bottom: 20px;
    
    .empty-icon {
      font-size: 64px;
    }
  }
  
  h3 {
    font-size: 20px;
    color: $text-primary;
    margin: 0 0 12px 0;
  }
  
  p {
    font-size: 14px;
    color: $text-light;
    margin-bottom: 24px;
  }
}

// 评论对话框
.comment-dialog {
  ::v-deep .el-dialog {
    border-radius: 20px;
    overflow: hidden;
  }
  
  ::v-deep .el-dialog__header {
    background: $gradient-warm;
    padding: 20px 24px;
    
    .el-dialog__title {
      color: #fff;
      font-weight: 700;
    }
    
    .el-dialog__headerbtn .el-dialog__close {
      color: #fff;
    }
  }
}

.no-comments {
  text-align: center;
  padding: 40px;
  color: $text-light;
  
  i {
    font-size: 48px;
    margin-bottom: 16px;
    color: $coral-light;
  }
  
  p {
    font-size: 14px;
  }
}

.comment-items {
  max-height: 400px;
  overflow-y: auto;
  margin-bottom: 20px;
}

.comment-item {
  display: flex;
  gap: 12px;
  padding: 16px 0;
  border-bottom: 1px solid $border-color;
  
  &:last-child {
    border-bottom: none;
  }
}

.comment-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: $gradient-warm;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  
  span {
    color: #fff;
    font-size: 16px;
    font-weight: 600;
  }
}

.comment-body {
  flex: 1;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  
  .comment-author {
    font-size: 14px;
    font-weight: 600;
    color: $text-primary;
  }
  
  .comment-time {
    font-size: 12px;
    color: $text-light;
  }
}

.comment-content {
  font-size: 14px;
  color: $text-secondary;
  line-height: 1.6;
}

.comment-form {
  padding-top: 16px;
  border-top: 1px solid $border-color;
  
  .el-textarea__inner {
    border-radius: 12px;
    border-color: $border-color;
    background: $cream;
    
    &:focus {
      border-color: $coral;
    }
  }
}

.submit-comment-btn {
  background: $gradient-warm;
  border: none;
  border-radius: 20px;
  padding: 10px 28px;
  
  &:hover {
    opacity: 0.9;
  }
}

// 分页
.pagination-content {
  ::v-deep .el-pagination__total {
    color: $text-secondary;
  }
  
  ::v-deep .el-pagination__sizes .el-input__inner {
    border-radius: 16px;
  }
  
  ::v-deep .el-pagination.is-background .el-pager li {
    border-radius: 16px;
    
    &.active {
      background: $gradient-warm;
    }
  }
}

// 响应式
@media (max-width: 768px) {
  .forum-header {
    padding: 20px;
    border-radius: 16px;
  }
  
  .forum-title {
    font-size: 22px;
    
    .title-icon {
      width: 40px;
      height: 40px;
      
      i {
        font-size: 22px;
      }
    }
  }
  
  .title-sub {
    margin-left: 0;
    margin-top: 8px;
  }
  
  .post-grid {
    grid-template-columns: 1fr;
  }
  
  .post-cover {
    height: 160px;
  }
}
</style>
