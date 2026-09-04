<template>
  <div class="main-content">
    <div class="add-update-content">
      <el-form
        class="add-update-form"
        :model="form"
        :rules="rules"
        ref="form"
        label-width="110px"
      >
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入标题" :disabled="isReadonly" />
        </el-form-item>
        <el-form-item label="分类" prop="fenlei">
          <el-select v-model="form.fenlei" placeholder="请选择分类" :disabled="isReadonly">
            <el-option label="增肌" value="增肌"></el-option>
            <el-option label="减脂" value="减脂"></el-option>
            <el-option label="塑形" value="塑形"></el-option>
            <el-option label="营养恢复" value="营养恢复"></el-option>
            <el-option label="训练心得" value="训练心得"></el-option>
            <el-option label="器材使用" value="器材使用"></el-option>
            <el-option label="其他" value="其他"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="封面图片" prop="fengmian">
          <el-upload
            v-if="!isReadonly"
            class="avatar-uploader"
            action="#"
            :show-file-list="false"
            :http-request="uploadPicture"
            accept="image/*"
          >
            <img v-if="form.fengmian" :src="form.fengmian" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
          <img v-else-if="form.fengmian" :src="form.fengmian" class="avatar">
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input
            type="textarea"
            v-model="form.content"
            placeholder="请输入内容"
            :rows="10"
            :disabled="isReadonly"
          ></el-input>
        </el-form-item>
        <el-form-item class="form-btn">
          <el-button class="close-btn" @click="close">{{ isReadonly ? '返回' : '取消' }}</el-button>
          <el-button v-if="!isReadonly" class="confirm-btn" type="primary" @click="submitForm">确定</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  props: ["parent"],
  data() {
    return {
      isReadonly: false,
      form: {
        id: null,
        title: '',
        fenlei: '',
        fengmian: '',
        content: ''
      },
      rules: {
        title: [
          { required: true, message: '请输入标题', trigger: 'blur' }
        ],
        fenlei: [
          { required: true, message: '请选择分类', trigger: 'change' }
        ],
        content: [
          { required: true, message: '请输入内容', trigger: 'blur' }
        ]
      }
    };
  },
  methods: {
    init(id, type) {
      // 如果没有传入id，尝试从路由获取
      if (!id) {
        id = this.$route.query.id;
        type = this.$route.query.type || '';
      }
      if (id) {
        this.$http({
          url: `xindefu/info/${id}`,
          method: "get"
        }).then(({ data }) => {
          if (data && data.code === 0) {
            // 浅拷贝可能导致响应式问题，使用 Object.assign 确保响应式
            this.form = Object.assign({}, this.form, data.data);

            let tableName = this.$storage.get('sessionTable') || '';
            let username = this.$storage.get('adminName') || '';

            if (type === 'info') {
              // 查看模式：只读
              this.isReadonly = true;
            } else {
              // 编辑模式：会员需要校验是否为本人发布
              if (tableName === 'huiyuan' && username && this.form.fabuzhanghao !== username) {
                this.$message.error('无权编辑他人发布的心得');
                this.$router.go(-1);
              }
            }
          } else {
            this.$message.error(data.msg || '获取数据失败');
          }
        }).catch(err => {
          console.error('获取心得详情失败:', err);
          this.$message.error('网络错误，请稍后重试');
        });
      }
    },
    uploadPicture(param) {
      let file = param.file;
      let formData = new FormData();
      formData.append('file', file);
      this.$http({
        url: 'file/upload',
        method: "post",
        data: formData,
        headers: { 'Content-Type': 'multipart/form-data' }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.form.fengmian = this.$base.url + "upload/" + data.file;
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.$http({
            url: `xindefu/${!this.form.id ? 'add' : 'update'}`,
            method: "post",
            data: this.form
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "操作成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  // 通过父组件关闭详情页，返回列表
                  if (this.parent) {
                    this.parent.showFlag = true;
                    this.parent.addOrUpdateFlag = false;
                  } else {
                    this.$router.go(-1);
                  }
                }
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    close() {
      // 通过父组件关闭详情页，返回列表
      if (this.parent) {
        this.parent.showFlag = true;
        this.parent.addOrUpdateFlag = false;
      } else {
        this.$router.go(-1);
      }
    }
  },
  mounted() {
    let id = this.$route.query.id;
    let type = this.$route.query.type || '';
    if (id) {
      this.init(id, type);
    }
  }
};
</script>

<style lang="scss" scoped>
.add-update-content {
  padding: 20px;
}
.add-update-form {
  max-width: 800px;
  margin: 0 auto;
}
.avatar-uploader {
  width: 120px;
  height: 120px;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}
.avatar {
  width: 120px;
  height: 120px;
  display: block;
}
.form-btn {
  margin-top: 30px;
  text-align: center;
}
.close-btn {
  margin-right: 20px;
}
.confirm-btn {
  
}
</style>
