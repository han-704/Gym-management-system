<template>
  <div class="add-or-update">
    <!-- 页面头部 -->
    <div class="form-header">
      <div class="header-icon">
        <i class="el-icon-box"></i>
      </div>
      <div class="header-info">
        <h3>{{ type === 'info' ? '器材详情' : (ruleForm.id ? '编辑器材' : '新增器材') }}</h3>
        <p>{{ type === 'info' ? '查看器材详细信息' : (ruleForm.id ? '修改器材信息' : '创建新的器材记录') }}</p>
      </div>
    </div>

    <el-form class="form-content" ref="ruleForm" :model="ruleForm" :rules="rules" label-width="120px">
      <div class="form-card">
        <div class="form-section-title">
          <i class="el-icon-info"></i>
          <span>基本信息</span>
        </div>
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item class="input" label="器材编号" prop="qicaibianhao">
              <el-input v-model="ruleForm.qicaibianhao" placeholder="系统自动生成" readonly class="readonly-input">
                <template slot="prefix"><i class="el-icon-key"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item class="input" label="器材名称" prop="qicaimingcheng">
              <el-input v-model="ruleForm.qicaimingcheng" placeholder="请输入器材名称" clearable :readonly="ro.qicaimingcheng">
                <template slot="prefix"><i class="el-icon-box"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>
        
        <div class="form-section-title">
          <i class="el-icon-s-management"></i>
          <span>器材信息</span>
        </div>
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item class="input" label="器材类型" prop="qicaileixing">
              <el-input v-model="ruleForm.qicaileixing" placeholder="请输入器材类型" clearable :readonly="ro.qicaileixing">
                <template slot="prefix"><i class="el-icon-menu"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item class="input" label="品牌" prop="pinpai">
              <el-input v-model="ruleForm.pinpai" placeholder="请输入品牌" clearable :readonly="ro.pinpai">
                <template slot="prefix"><i class="el-icon-office-building"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item class="input" label="瘦身效果" prop="shoushenxiaoguo">
              <el-input v-model="ruleForm.shoushenxiaoguo" placeholder="请输入瘦身效果" clearable :readonly="ro.shoushenxiaoguo">
                <template slot="prefix"><i class="el-icon-data-line"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 器材图片 -->
        <div class="form-section-title">
          <i class="el-icon-picture-outline"></i>
          <span>器材图片</span>
        </div>
        <el-row>
          <el-col :span="24">
            <el-form-item class="upload" v-if="type!='info' && !ro.qicaitupian" label="器材图片" prop="qicaitupian">
              <file-upload
                tip="点击上传器材图片"
                action="file/upload"
                :limit="3"
                :multiple="true"
                :fileUrls="ruleForm.qicaitupian?ruleForm.qicaitupian:''"
                @change="qicaitupianUploadChange"
              ></file-upload>
            </el-form-item>
            <div v-else-if="ruleForm.qicaitupian" class="image-preview-container">
              <el-image 
                v-for="(item,index) in ruleForm.qicaitupian.split(',')" 
                :key="index"
                :src="item" 
                fit="cover"
                class="preview-image"
                :preview-src-list="ruleForm.qicaitupian.split(',')"
              >
                <div slot="placeholder" class="image-slot">
                  <i class="el-icon-loading"></i>
                </div>
                <div slot="error" class="image-slot">
                  <i class="el-icon-picture-outline"></i>
                </div>
              </el-image>
            </div>
            <div v-else class="no-image">
              <i class="el-icon-picture-outline"></i>
              <span>暂无图片</span>
            </div>
          </el-col>
        </el-row>

        <div class="form-section-title">
          <i class="el-icon-document"></i>
          <span>详细说明</span>
        </div>
        <el-row>
          <el-col :span="24">
            <el-form-item class="textarea" label="使用方法" prop="shiyongfangfa">
              <el-input
                type="textarea"
                :rows="4"
                placeholder="请输入使用方法"
                v-model="ruleForm.shiyongfangfa"
                :readonly="ro.shiyongfangfa"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item class="textarea" label="器材介绍" prop="qicaijieshao">
              <el-input
                type="textarea"
                :rows="4"
                placeholder="请输入器材介绍"
                v-model="ruleForm.qicaijieshao"
                :readonly="ro.qicaijieshao"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </div>

      <!-- 操作按钮 -->
      <div class="form-actions" v-if="type != 'info'">
        <el-button class="btn-cancel" @click="back()">
          <i class="el-icon-close"></i>
          取消
        </el-button>
        <el-button type="primary" class="btn-submit" @click="onSubmit">
          <i class="el-icon-check"></i>
          提交
        </el-button>
      </div>
      <div class="form-actions" v-else>
        <el-button class="btn-back" @click="back()">
          <i class="el-icon-back"></i>
          返回列表
        </el-button>
      </div>
    </el-form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      id: '',
      type: '',
      ro: {
        qicaibianhao: false,
        qicaimingcheng: false,
        qicaitupian: false,
        qicaileixing: false,
        pinpai: false,
        shiyongfangfa: false,
        shoushenxiaoguo: false,
        qicaijieshao: false,
      },
      ruleForm: {
        qicaibianhao: '',
        qicaimingcheng: '',
        qicaitupian: '',
        qicaileixing: '',
        pinpai: '',
        shiyongfangfa: '',
        shoushenxiaoguo: '',
        qicaijieshao: '',
      },
      rules: {
        qicaimingcheng: [],
        qicaileixing: [],
        pinpai: [],
      }
    };
  },
  props: ["parent"],
  created() {
    this.getUUID = () => new Date().getTime().toString();
  },
  methods: {
    init(id, type) {
      if (id) { this.id = id; this.type = type; }
      if (this.type == 'info' || this.type == 'else') { this.info(id); }
    },
    info(id) {
      this.$http({ url: `jianshenqicai/info/${id}`, method: "get" }).then(({ data }) => {
        if (data && data.code === 0) {
          this.ruleForm = data.data;
        }
      });
    },
    onSubmit() {
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          if (!this.ruleForm.qicaibianhao) {
            this.ruleForm.qicaibianhao = this.getUUID();
          }
          this.$http({ url: `jianshenqicai/${!this.ruleForm.id ? "save" : "update"}`, method: "post", data: this.ruleForm }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({ message: "操作成功", type: "success", duration: 1500, onClose: () => {
                this.parent.showFlag = true;
                this.parent.addOrUpdateFlag = false;
                this.parent.search();
              }});
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
    },
    qicaitupianUploadChange(fileUrls) {
      this.ruleForm.qicaitupian = fileUrls;
    }
  }
};
</script>
<style scoped>
.add-or-update {
  padding: 24px;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ed 100%);
  min-height: calc(100vh - 84px);
}

/* 页面头部 */
.form-header {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 24px 28px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  margin-bottom: 24px;
  box-shadow: 0 8px 24px rgba(102, 126, 234, 0.35);
}

.header-icon {
  width: 60px;
  height: 60px;
  border-radius: 14px;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.header-icon i {
  font-size: 28px;
  color: #fff;
}

.header-info h3 {
  margin: 0 0 6px 0;
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  letter-spacing: 1px;
}

.header-info p {
  margin: 0;
  font-size: 14px;
  color: rgba(255, 255, 255, 0.85);
}

/* 表单卡片 */
.form-content {
  max-width: 900px;
  margin: 0 auto;
}

.form-card {
  background: #fff;
  border-radius: 16px;
  padding: 28px 32px;
  margin-bottom: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  border: 1px solid rgba(0, 0, 0, 0.04);
}

.form-section-title {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 16px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 22px;
  padding-bottom: 12px;
  border-bottom: 2px solid #667eea20;
}

.form-section-title i {
  font-size: 20px;
  color: #667eea;
}

.el-form-item {
  margin-bottom: 22px;
}

.el-input, .el-select {
  width: 100%;
}

/* 输入框样式 */
.el-input >>> .el-input__inner {
  border-radius: 10px;
  border: 1px solid #dcdfe6;
  padding: 0 15px;
  height: 42px;
  line-height: 42px;
  transition: all 0.3s;
}

.el-input >>> .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.el-input >>> .el-input__inner:hover {
  border-color: #667eea;
}

.readonly-input >>> .el-input__inner {
  background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
  color: #909399;
}

/* 文本域 */
.textarea >>> .el-textarea__inner {
  border-radius: 10px;
  border: 1px solid #dcdfe6;
  padding: 12px 15px;
  resize: none;
  transition: all 0.3s;
  font-size: 14px;
  line-height: 1.6;
}

.textarea >>> .el-textarea__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.textarea >>> .el-textarea__inner:hover {
  border-color: #667eea;
}

/* 图片预览 */
.image-preview-container {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
  padding: 16px 0;
}

.preview-image {
  width: 120px;
  height: 120px;
  border-radius: 12px;
  border: 2px solid #ebeef5;
  cursor: pointer;
  transition: all 0.3s;
  overflow: hidden;
}

.preview-image:hover {
  transform: scale(1.05);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.image-slot {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  background: #f5f7fa;
  color: #c0c4cc;
  font-size: 24px;
}

.no-image {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 40px;
  background: #f8f9ff;
  border-radius: 12px;
  color: #c0c4cc;
}

.no-image i {
  font-size: 48px;
}

.no-image span {
  font-size: 14px;
}

/* 上传组件 */
.upload {
  margin-bottom: 16px;
}

.upload >>> .el-upload--picture-card {
  width: 120px;
  height: 120px;
  border-radius: 12px;
  border: 2px dashed #dcdfe6;
  background: #f8f9ff;
  transition: all 0.3s;
}

.upload >>> .el-upload--picture-card:hover {
  border-color: #667eea;
  background: #f0f2ff;
}

/* 操作按钮 */
.form-actions {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-top: 30px;
}

.btn-submit {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 10px;
  padding: 14px 36px;
  font-size: 15px;
  font-weight: 600;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-submit:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
}

.btn-submit i {
  font-size: 16px;
}

.btn-cancel {
  border-radius: 10px;
  padding: 14px 28px;
  font-size: 15px;
  border: 1px solid #dcdfe6;
  color: #606266;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-cancel:hover {
  border-color: #667eea;
  color: #667eea;
}

.btn-back {
  border-radius: 10px;
  padding: 14px 28px;
  font-size: 15px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  color: #fff;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-back:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
}

/* 响应式 */
@media (max-width: 768px) {
  .add-or-update {
    padding: 16px;
  }
  
  .form-header {
    flex-direction: column;
    text-align: center;
    gap: 16px;
  }
  
  .form-card {
    padding: 20px;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .form-actions .el-button {
    width: 100%;
  }
}
</style>
