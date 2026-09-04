<template>
  <div class="aicoach-chat">
    <div class="chat-container">
      <!-- 头部 -->
      <div class="chat-header">
        <div class="ai-avatar">
          <i class="el-icon-service"></i>
        </div>
        <div class="header-info">
          <h3>AI健身教练</h3>
          <p>随时为您解答健身问题</p>
        </div>
      </div>

      <!-- 免责提示 -->
      <div class="disclaimer-bar">
        <i class="el-icon-warning-outline"></i>
        <span>AI建议仅供参考，不能替代专业医疗指导</span>
      </div>

      <!-- 聊天内容 -->
      <div class="chat-messages" ref="chatMessages">
        <!-- 欢迎消息 -->
        <div class="message ai-message">
          <div class="message-avatar">
            <i class="el-icon-service"></i>
          </div>
          <div class="message-content">
            <div class="message-text">
              您好！我是您的AI健身教练 🤖<br><br>
              我可以帮您解答以下问题：<br>
              • 如何开始健身<br>
              • 增肌/减脂饮食建议<br>
              • 各种健身动作要领<br>
              • 训练计划安排<br>
              • 健身注意事项<br><br>
              请直接输入您的问题开始咨询！
            </div>
            <div class="message-time">{{ currentTime }}</div>
          </div>
        </div>

        <!-- 推荐问题 -->
        <div class="recommend-questions">
          <p>您可以这样问我：</p>
          <div class="question-tags">
            <el-tag
              v-for="(item, index) in recommendQuestions"
              :key="index"
              type="primary"
              class="question-tag"
              @click="askQuestion(item.question)"
            >
              {{ item.question }}
            </el-tag>
          </div>
        </div>

        <!-- 聊天记录 -->
        <div v-for="(msg, index) in chatHistory" :key="index"
             :class="['message', msg.type === 'user' ? 'user-message' : 'ai-message']">
          <div class="message-avatar">
            <i :class="msg.type === 'user' ? 'el-icon-user' : 'el-icon-service'"></i>
          </div>
          <div class="message-content">
            <div class="message-text" v-html="formatMessage(msg.content)"></div>
            <div class="message-time">{{ msg.time }}</div>
          </div>
        </div>

        <!-- 加载中 -->
        <div v-if="loading" class="message ai-message">
          <div class="message-avatar">
            <i class="el-icon-service"></i>
          </div>
          <div class="message-content">
            <div class="message-text loading">
              <span class="dot">·</span>
              <span class="dot">·</span>
              <span class="dot">·</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 输入区域 -->
      <div class="chat-input">
        <el-input
          v-model="userInput"
          type="text"
          placeholder="请输入您的健身问题..."
          @keyup.enter.native="sendMessage"
          :disabled="loading"
        >
          <el-button slot="append" @click="sendMessage" :loading="loading" type="primary">
            <i class="el-icon-s-promotion"></i> 发送
          </el-button>
        </el-input>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AicoachChat",
  data() {
    return {
      userInput: "",
      chatHistory: [],
      loading: false,
      recommendQuestions: [
        { question: "如何开始健身" },
        { question: "增肌饮食建议" },
        { question: "减脂最有效的运动" },
        { question: "健身前如何热身" },
        { question: "俯卧撑正确姿势" }
      ],
      currentTime: ""
    };
  },
  mounted() {
    this.updateTime();
    this.loadRecommendQuestions();
  },
  methods: {
    updateTime() {
      const now = new Date();
      this.currentTime = `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;
    },

    loadRecommendQuestions() {
      this.$http({
        url: "aicoach/knowledge/recommend",
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0 && data.data.length > 0) {
          this.recommendQuestions = data.data.slice(0, 5);
        }
      });
    },

    sendMessage() {
      if (!this.userInput.trim()) {
        this.$message.warning("请输入您的问题");
        return;
      }

      if (this.loading) return;

      const question = this.userInput.trim();
      this.userInput = "";

      // 添加用户消息
      this.chatHistory.push({
        type: "user",
        content: question,
        time: this.getCurrentTime()
      });

      // 滚动到底部
      this.$nextTick(() => {
        this.scrollToBottom();
      });

      // 发送问题到AI
      this.loading = true;
      this.$http({
        url: "aicoach/knowledge/chat",
        method: "get",
        params: { question: question }
      }).then(({ data }) => {
        this.loading = false;
        if (data && data.code === 0) {
          this.chatHistory.push({
            type: "ai",
            content: data.answer,
            time: this.getCurrentTime()
          });
        } else {
          this.chatHistory.push({
            type: "ai",
            content: "抱歉，我暂时无法回答您的问题，请稍后再试。",
            time: this.getCurrentTime()
          });
        }
        this.$nextTick(() => {
          this.scrollToBottom();
        });
      }).catch(() => {
        this.loading = false;
        this.chatHistory.push({
          type: "ai",
          content: "网络错误，请检查网络后重试。",
          time: this.getCurrentTime()
        });
      });
    },

    askQuestion(question) {
      this.userInput = question;
      this.sendMessage();
    },

    getCurrentTime() {
      const now = new Date();
      return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}`;
    },

    scrollToBottom() {
      const container = this.$refs.chatMessages;
      if (container) {
        container.scrollTop = container.scrollHeight;
      }
    },

    formatMessage(content) {
      // 格式化消息内容，换行显示
      if (!content) return "";
      return content.replace(/\n/g, "<br>");
    }
  }
};
</script>

<style scoped>
.aicoach-chat {
  height: calc(100vh - 84px);
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
}

.chat-container {
  max-width: 800px;
  margin: 0 auto;
  height: 100%;
  background: #fff;
  border-radius: 16px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
}

.chat-header {
  display: flex;
  align-items: center;
  padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
}

.disclaimer-bar {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 10px 20px;
  background: linear-gradient(135deg, #fff8e1 0%, #fff3cd 100%);
  border-bottom: 1px solid #ffe082;
  color: #8d6e00;
  font-size: 13px;
  font-weight: 500;
}

.disclaimer-bar i {
  font-size: 16px;
  color: #ff9800;
}

.ai-avatar {
  width: 60px;
  height: 60px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
}

.ai-avatar i {
  font-size: 30px;
}

.header-info h3 {
  margin: 0 0 5px 0;
  font-size: 20px;
}

.header-info p {
  margin: 0;
  font-size: 14px;
  opacity: 0.9;
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  background: #f5f7fa;
}

.message {
  display: flex;
  margin-bottom: 20px;
}

.message-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 12px;
  flex-shrink: 0;
}

.ai-message .message-avatar {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
}

.user-message .message-avatar {
  background: #409eff;
  color: #fff;
}

.message-avatar i {
  font-size: 20px;
}

.message-content {
  max-width: 70%;
}

.message-text {
  padding: 12px 16px;
  border-radius: 12px;
  line-height: 1.6;
  font-size: 14px;
  white-space: pre-wrap;
  word-break: break-word;
}

.ai-message .message-text {
  background: #fff;
  color: #333;
  border: 1px solid #e4e7ed;
  border-top-left-radius: 0;
}

.user-message .message-text {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  border-top-right-radius: 0;
}

.message-time {
  font-size: 12px;
  color: #999;
  margin-top: 5px;
}

.recommend-questions {
  margin: 10px 0 20px 52px;
}

.recommend-questions p {
  color: #999;
  font-size: 12px;
  margin-bottom: 10px;
}

.question-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.question-tag {
  cursor: pointer;
  transition: all 0.3s;
}

.question-tag:hover {
  transform: scale(1.05);
}

.loading .dot {
  display: inline-block;
  animation: loading 1.4s infinite ease-in-out both;
}

.loading .dot:nth-child(1) {
  animation-delay: -0.32s;
}

.loading .dot:nth-child(2) {
  animation-delay: -0.16s;
}

@keyframes loading {
  0%, 80%, 100% {
    transform: scale(0);
  }
  40% {
    transform: scale(1);
  }
}

.chat-input {
  padding: 15px 20px;
  background: #fff;
  border-top: 1px solid #e4e7ed;
}

.chat-input .el-input-group__append {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  color: #fff;
}
</style>
