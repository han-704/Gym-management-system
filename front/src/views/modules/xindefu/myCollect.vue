<template>
  <div class="main-content forum-container">
    <div v-if="showFlag">
      <!-- 顶部区域 -->
      <div class="forum-header">
        <div class="header-top">
          <div class="forum-title">
            <div class="title-icon">
              <i class="el-icon-star-on"></i>
            </div>
            <span>我的收藏</span>
          </div>
          <p class="title-sub">收藏你喜欢的健身心得，随时回顾</p>
        </div>
        
        <div class="back-bar">
          <el-button icon="el-icon-arrow-left" @click="goBack" class="back-btn">
            返回社区
          </el-button>
        </div>
        
        <el-row :gutter="20" class="forum-search">
          <el-col :span="10">
            <div class="search-wrapper">
              <i class="el-icon-search search-icon"></i>
              <el-input
                v-model="searchForm.title"
                placeholder="搜索收藏的心得..."
                clearable
                @keyup.enter.native="search()"
                class="search-input"
              ></el-input>
            </div>
          </el-col>
          <el-col :span="4">
            <el-button type="primary" icon="el-icon-search" @click="search()" class="search-btn">搜索</el-button>
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

      <!-- 收藏列表 -->
      <div class="post-list" v-loading="dataListLoading">
        <div v-if="dataList.length === 0" class="empty-state">
          <div class="empty-illustration">
            <div class="empty-icon">⭐</div>
          </div>
          <h3>暂无收藏</h3>
          <p>去社区逛逛，收藏你喜欢的健身心得吧！</p>
          <el-button type="primary" round @click="goBack">
            去社区
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
            @click.native="goToDetail(item)"
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
              <div class="collect-badge">
                <i class="el-icon-star-on"></i>
              </div>
            </div>
            
            <!-- 内容区域 -->
            <div class="post-content">
              <h3 class="post-title">{{ item.title }}</h3>
              <p class="post-summary" v-if="item.content">
                {{ item.content.replace(/<[^>]*>/g, '').substring(0, 80) }}{{ item.content.replace(/<[^>]*>/g, '').length > 80 ? '...' : '' }}
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
                <div class="stat-item likes" :class="{ active: item.thumbsupFlag === 1 }">
                  <i :class="item.thumbsupFlag === 1 ? 'el-icon-star-on heart-active' : 'el-icon-star-off'"></i>
                  <span>{{ item.thumbsupnum || 0 }}</span>
                </div>
                <div class="stat-item comments">
                  <i class="el-icon-chat-dot-round"></i>
                  <span>{{ item.commentnum || 0 }}</span>
                </div>
              </div>
              
              <!-- 取消收藏按钮 -->
              <div class="post-actions">
                <el-button size="mini" icon="el-icon-star-on" @click.stop="cancelCollect(item)" class="cancel-collect-btn">
                  取消收藏
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
  </div>
</template>

<script>
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
      layouts: 'total, sizes, prev, pager, next, jumper',
      categoryList: ['增肌', '减脂', '塑形', '营养恢复', '训练心得', '器材使用', '其他'],
    };
  },
  created() {
    this.getDataList();
  },
  watch: {
    '$route'(to, from) {
      this.pageIndex = 1;
      this.getDataList();
    }
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
    
    // 返回社区
    goBack() {
      this.$router.push('/xindefu');
    },
    
    // 搜索
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    
    // 获取收藏列表
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
      
      let username = this.$storage.get('adminName');
      if(username) {
        params['huiyuanzhanghao'] = username;
      }
      
      this.$http({
        url: 'xindefuCollect/page',
        method: "get",
        params: params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          // 收藏列表返回的是xindefuCollect对象，需要提取其中的xindefu信息
          if(data.data.list && data.data.list.length > 0) {
            this.dataList = data.data.list.map(item => {
              // 优先使用关联的xindefu详情
              if(item.xindefu && item.xindefu.id) {
                return {
                  id: item.xindefu.id,
                  title: item.xindefu.title,
                  content: item.xindefu.content,
                  fenlei: item.xindefu.fenlei,
                  fengmian: item.xindefu.fengmian,
                  fabuzhanghao: item.xindefu.fabuzhanghao,
                  fabuxingming: item.xindefu.fabuxingming,
                  fabushijian: item.xindefu.fabushijian,
                  thumbsupnum: item.xindefu.thumbsupnum,
                  clicknum: item.xindefu.clicknum,
                  commentnum: item.xindefu.commentnum,
                  collectId: item.id
                };
              }
              // 如果没有关联的心得详情，直接使用item的属性
              return {
                id: item.xindefuId || item.id,
                title: item.title || item.xindefu_title || '',
                content: item.content || item.xindefu_content || '',
                fenlei: item.fenlei || item.xindefu_fenlei || '',
                fengmian: item.fengmian || item.xindefu_fengmian || '',
                fabuzhanghao: item.fabuzhanghao || item.xindefu_fabuzhanghao || '',
                fabuxingming: item.fabuxingming || item.xindefu_fabuxingming || '',
                fabushijian: item.fabushijian || item.xindefu_fabushijian || '',
                thumbsupnum: item.thumbsupnum || item.xindefu_thumbsupnum || 0,
                clicknum: item.clicknum || item.xindefu_clicknum || 0,
                commentnum: item.commentnum || item.xindefu_commentnum || 0,
                collectId: item.id
              };
            });
          } else {
            this.dataList = [];
          }
          this.totalPage = data.data.total;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },
    
    // 分页
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
    
    // 跳转详情
    goToDetail(item) {
      this.$router.push({ path: '/xindefu/detail', query: { id: item.id } });
    },
    
    // 取消收藏
    cancelCollect(item) {
      this.$confirm('确定取消收藏该心得吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$http({
          url: `xindefu/collect/${item.id}`,
          method: 'get'
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success('已取消收藏');
            this.getDataList();
          } else {
            this.$message.error(data.msg || '操作失败');
          }
        });
      }).catch(() => {});
    }
  }
};
</script>

<style lang="scss" scoped>
$coral: #FF8C69;
$coral-light: #FFB299;
$coral-dark: #E67750;
$cream: #FFF8F0;
$warm-white: #FFFCF8;
$text-primary: #5D4E37;
$text-secondary: #8B7355;
$text-light: #A69580;
$border-color: #F5E6D3;
$shadow-color: rgba(255, 140, 105, 0.15);
$gradient-warm: linear-gradient(135deg, #FF8C69 0%, #FFA07A 50%, #FFD4B8 100%);

.forum-container {
  padding: 24px;
  background: linear-gradient(180deg, #FFF8F0 0%, #FFF5EB 100%);
  min-height: calc(100vh - 84px);
}

.forum-header {
  background: #fff;
  padding: 28px 32px;
  border-radius: 20px;
  margin-bottom: 24px;
  box-shadow: 0 4px 20px $shadow-color;
  border: 1px solid $border-color;
}

.header-top {
  margin-bottom: 20px;
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
    background: linear-gradient(135deg, #FFD700 0%, #FFA500 50%, #FFB347 100%);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 12px rgba(255, 165, 0, 0.3);
    
    i {
      margin: 0;
      color: #fff;
      font-size: 26px;
    }
  }
  
  span {
    background: linear-gradient(135deg, #FF8C69 0%, #FFA500 100%);
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

.back-bar {
  margin-bottom: 20px;
}

.back-btn {
  border-radius: 20px;
  padding: 10px 20px;
  background: #fff;
  border: 1px solid $border-color;
  color: $text-secondary;
  transition: all 0.3s;
  
  &:hover {
    background: $cream;
    border-color: $coral;
    color: $coral;
  }
}

.forum-search {
  margin-bottom: 20px;
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

.post-list {
  min-height: 400px;
}

.post-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 20px;
}

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

.collect-badge {
  position: absolute;
  top: 12px;
  right: 12px;
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(255, 165, 0, 0.4);
  
  i {
    color: #fff;
    font-size: 16px;
  }
}

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
  
  &.likes.active {
    color: #FF6B81;
  }
}

.heart-active {
  color: #FF6B81;
  animation: heartBeat 0.6s ease-in-out;
}

@keyframes heartBeat {
  0% { transform: scale(1); }
  25% { transform: scale(1.4); }
  50% { transform: scale(1); }
  75% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

.post-actions {
  display: flex;
  justify-content: flex-end;
}

.cancel-collect-btn {
  background: linear-gradient(135deg, #FFE4E4 0%, #FFF0F0 100%);
  border: 1px solid #FFCDD2;
  color: #E57373;
  border-radius: 16px;
  font-size: 12px;
  padding: 6px 14px;
  transition: all 0.3s;
  
  &:hover {
    background: linear-gradient(135deg, #FFCDD2 0%, #FFEBEE 100%);
    transform: translateY(-2px);
  }
}

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
