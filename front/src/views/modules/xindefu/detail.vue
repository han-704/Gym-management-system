<template>
  <div class="page">
    <div class="detail-content">
      <!-- 博客头部 -->
      <div class="blog-header">
        <h1 class="blog-title">{{ form.title }}</h1>
        <div class="blog-meta">
          <span class="meta-item">
            <i class="el-icon-user"></i>
            {{ form.fabuxingming || form.fabuzhanghao || '匿名用户' }}
          </span>
          <span class="meta-item">
            <i class="el-icon-time"></i>
            {{ form.fabushijian }}
          </span>
          <span class="meta-item category-tag" :class="'tag-' + form.fenlei">
            <i class="el-icon-collection-tag"></i>
            {{ form.fenlei }}
          </span>
        </div>
      </div>

      <!-- 封面图 -->
      <div class="blog-cover" v-if="form.fengmian">
        <img :src="form.fengmian" alt="封面图片">
      </div>

      <!-- 内容区域 -->
      <div class="blog-content" v-html="form.content"></div>

      <!-- 底部操作栏 -->
      <div class="blog-footer">
        <div class="footer-left">
          <span class="stat-item">
            <i class="el-icon-view"></i>
            {{ form.clicknum || 0 }} 阅读
          </span>
          <span class="stat-item" :class="{ active: hasThumbsup }" @click="handleThumbsup">
            <i :class="hasThumbsup ? 'el-icon-star-on' : 'el-icon-star-off'"></i>
            {{ form.thumbsupnum || 0 }} 点赞
          </span>
        </div>
        <div class="footer-right">
          <el-button class="back-btn" @click="goBack">
            <i class="el-icon-arrow-left"></i>
            返回列表
          </el-button>
        </div>
      </div>

      <!-- 评论区 -->
      <div class="comment-section" v-if="infoFlag">
        <div class="comment-header">
          <i class="el-icon-chat-dot-round"></i>
          <span>评论</span>
          <span class="comment-count">({{ commentList.length }})</span>
        </div>

        <!-- 评论列表 -->
        <div class="comment-list" v-if="commentList.length > 0">
          <div v-for="(comment, index) in commentList" :key="comment.id" class="comment-item">
            <div class="comment-avatar">
              {{ (comment.huiyuanxingming || '游').charAt(0) }}
            </div>
            <div class="comment-body">
              <div class="comment-meta">
                <span class="comment-author">{{ comment.huiyuanxingming || '游客' }}</span>
                <span class="comment-time">{{ comment.pinglunshijian }}</span>
              </div>
              <div class="comment-text">{{ comment.pinglunneirong }}</div>
            </div>
          </div>
        </div>
        <div v-else class="no-comment">
          <i class="el-icon-chat-line-square"></i>
          <span>暂无评论，快来抢沙发吧~</span>
        </div>

        <!-- 发表评论 -->
        <div class="comment-form">
          <el-input
            type="textarea"
            v-model="commentForm.pinglunneirong"
            placeholder="发表一下你的看法..."
            :rows="3"
          ></el-input>
          <div class="form-actions">
            <el-button type="primary" @click="submitComment">发表评论</el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        id: null,
        title: '',
        fenlei: '',
        fengmian: '',
        content: '',
        fabuzhanghao: '',
        fabuxingming: '',
        fabushijian: '',
        thumbsupnum: 0,
        clicknum: 0
      },
      infoFlag: false,
      hasThumbsup: false,
      commentList: [],
      commentCount: 0,
      commentForm: {
        pinglunneirong: '',
        xindefuId: null
      }
    };
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      let id = this.$route.query.id;
      if(id) {
        this.$http({
          url: `xindefu/detail/${id}`,
          method: "get"
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.form = Object.assign({}, this.form, data.data);
            this.hasThumbsup = data.data.hasThumbsup || false;
            this.commentCount = data.data.commentnum || 0;
            this.infoFlag = true;
            this.commentForm.xindefuId = id;
            this.getCommentList(id);
          }
        });
      }
    },
    getCommentList(xindefuId) {
      this.$http({
        url: 'xindefuComment/listByXindefuId',
        method: "get",
        params: { xindefuId }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.commentList = data.data;
          this.commentCount = data.data.length;
        }
      });
    },
    handleThumbsup() {
      this.$http({
        url: `xindefu/thumbsup/${this.form.id}`,
        method: "post"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: data.data,
            type: 'success',
            duration: 1500
          });
          this.hasThumbsup = !this.hasThumbsup;
          this.form.thumbsupnum = (this.form.thumbsupnum || 0) + (this.hasThumbsup ? 1 : -1);
        } else {
          this.$message.error(data.msg);
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
    },
    goBack() {
      this.$router.replace('/xindefu');
    }
  }
};
</script>

<style lang="scss" scoped>
.page {
  min-height: 100%;
  background: #f5f7fa;
  padding: 20px;
}

.detail-content {
  max-width: 900px;
  margin: 0 auto;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.blog-header {
  padding: 30px 40px 20px;
  border-bottom: 1px solid #eee;
}

.blog-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  line-height: 1.4;
  margin: 0 0 16px 0;
}

.blog-meta {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
  color: #999;
  font-size: 14px;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 6px;
  
  i {
    font-size: 16px;
  }
}

.category-tag {
  padding: 4px 12px;
  border-radius: 16px;
  font-size: 12px;
  color: #fff;
  background: #409EFF;
  
  &.tag-增肌 { background: linear-gradient(135deg, #FF6B6B, #EE5A5A); }
  &.tag-减脂 { background: linear-gradient(135deg, #4ECDC4, #3DBDB5); }
  &.tag-塑形 { background: linear-gradient(135deg, #9B59B6, #8E44AD); }
  &.tag-营养恢复 { background: linear-gradient(135deg, #F39C12, #E67E22); }
  &.tag-训练心得 { background: linear-gradient(135deg, #3498DB, #2980B9); }
  &.tag-器材使用 { background: linear-gradient(135deg, #E74C3C, #C0392B); }
  &.tag-其他 { background: linear-gradient(135deg, #95A5A6, #7F8C8D); }
}

.blog-cover {
  width: 100%;
  max-height: 450px;
  overflow: hidden;
  
  img {
    width: 100%;
    height: auto;
    display: block;
    object-fit: cover;
  }
}

.blog-content {
  padding: 30px 40px;
  font-size: 16px;
  line-height: 1.8;
  color: #333;
  
  ::v-deep p {
    margin: 16px 0;
  }
  
  ::v-deep img {
    max-width: 100%;
    border-radius: 8px;
    margin: 16px 0;
  }
  
  ::v-deep h1, ::v-deep h2, ::v-deep h3 {
    margin: 24px 0 16px;
    font-weight: 600;
  }
  
  ::v-deep ul, ::v-deep ol {
    padding-left: 24px;
    margin: 16px 0;
  }
  
  ::v-deep li {
    margin: 8px 0;
  }
  
  ::v-deep blockquote {
    border-left: 4px solid #409EFF;
    padding: 10px 16px;
    margin: 16px 0;
    background: #f5f7fa;
    border-radius: 0 8px 8px 0;
  }
}

.blog-footer {
  padding: 20px 40px;
  border-top: 1px solid #eee;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #fafafa;
}

.footer-left {
  display: flex;
  gap: 24px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #666;
  font-size: 14px;
  
  i {
    font-size: 18px;
    color: #999;
  }
  
  &.active {
    color: #f56c6c;
    
    i {
      color: #f56c6c;
    }
  }
}

.footer-right {
  display: flex;
  gap: 12px;
}

.back-btn {
  padding: 8px 20px;
  border-radius: 20px;
}

.comment-section {
  padding: 30px 40px;
  border-top: 1px solid #eee;
}

.comment-header {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 18px;
  font-weight: 600;
  color: #333;
  margin-bottom: 20px;
  
  i {
    color: #409EFF;
    font-size: 22px;
  }
  
  .comment-count {
    font-weight: 400;
    color: #999;
    font-size: 14px;
  }
}

.comment-list {
  margin-bottom: 30px;
}

.comment-item {
  display: flex;
  gap: 12px;
  padding: 16px 0;
  border-bottom: 1px solid #f0f2f5;
  
  &:last-child {
    border-bottom: none;
  }
}

.comment-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea, #764ba2);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  flex-shrink: 0;
}

.comment-body {
  flex: 1;
}

.comment-meta {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  
  .comment-author {
    font-size: 14px;
    font-weight: 600;
    color: #333;
  }
  
  .comment-time {
    font-size: 12px;
    color: #999;
  }
}

.comment-text {
  font-size: 14px;
  color: #666;
  line-height: 1.6;
  background: #f5f7fa;
  padding: 12px;
  border-radius: 8px;
}

.no-comment {
  text-align: center;
  padding: 30px;
  color: #999;
  
  i {
    font-size: 48px;
    margin-bottom: 10px;
    display: block;
  }
  
  span {
    font-size: 14px;
  }
}

.comment-form {
  padding-top: 20px;
  border-top: 1px solid #eee;
  
  .form-actions {
    margin-top: 12px;
    display: flex;
    justify-content: flex-end;
  }
}
</style>
