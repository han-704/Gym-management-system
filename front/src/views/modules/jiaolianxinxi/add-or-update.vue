<template>
  <div class="add-or-update-page">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-icon-wrapper">
          <i class="el-icon-user-solid header-icon"></i>
        </div>
        <div class="header-text">
          <h2 class="header-title">{{ type === 'info' ? '教练详情' : (ruleForm.id ? '编辑教练' : '新增教练') }}</h2>
          <p class="header-desc">{{ type === 'info' ? '查看教练详细信息' : '填写教练相关信息' }}</p>
        </div>
      </div>
    </div>

    <div class="form-card">
      <el-form
        class="detail-form-content"
        ref="ruleForm"
        :model="ruleForm"
        :rules="rules"
        label-width="120px"
      >
        <!-- 基本信息 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-info section-icon"></i>
            <span class="section-title">基本信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="工号" prop="gonghao">
                <el-input v-model="ruleForm.gonghao" placeholder="请输入工号" clearable :readonly="ro.gonghao">
                  <i slot="prefix" class="el-input__icon el-icon-postcard"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="员工姓名" prop="yuangongxingming">
                <el-input v-model="ruleForm.yuangongxingming" placeholder="请输入员工姓名" clearable :readonly="ro.yuangongxingming">
                  <i slot="prefix" class="el-input__icon el-icon-user"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="性别" prop="xingbie">
                <el-input v-model="ruleForm.xingbie" placeholder="请输入性别" clearable :readonly="ro.xingbie">
                  <i slot="prefix" class="el-input__icon el-icon-male" v-if="ruleForm.xingbie === '男'"></i>
                  <i slot="prefix" class="el-input__icon el-icon-female" v-else-if="ruleForm.xingbie === '女'"></i>
                  <i slot="prefix" class="el-input__icon el-icon-user" v-else></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="手机号" prop="shoujihao">
                <el-input v-model="ruleForm.shoujihao" placeholder="请输入手机号" clearable :readonly="ro.shoujihao">
                  <i slot="prefix" class="el-input__icon el-icon-mobile-phone"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 体测信息 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-data-analysis section-icon"></i>
            <span class="section-title">体测信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="身高" prop="shengao">
                <el-input v-model="ruleForm.shengao" placeholder="请输入身高" clearable :readonly="ro.shengao">
                  <template slot="append">cm</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="体重" prop="tizhong">
                <el-input v-model="ruleForm.tizhong" placeholder="请输入体重" clearable :readonly="ro.tizhong">
                  <template slot="append">kg</template>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 教练信息 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-medal section-icon"></i>
            <span class="section-title">教练信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="教练类型" prop="jiaolianleixing">
                <el-input v-model="ruleForm.jiaolianleixing" placeholder="请输入教练类型" clearable :readonly="ro.jiaolianleixing">
                  <i slot="prefix" class="el-input__icon el-icon-collection-tag"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="教练价格" prop="jiaolianjiage">
                <el-input v-model="ruleForm.jiaolianjiage" placeholder="请输入教练价格" clearable :readonly="ro.jiaolianjiage">
                  <template slot="prepend">¥</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item class="input" label="上课时间" prop="shangkeshijian">
                <el-input v-model="ruleForm.shangkeshijian" placeholder="请输入上课时间" clearable :readonly="ro.shangkeshijian">
                  <i slot="prefix" class="el-input__icon el-icon-time"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 图片上传 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-picture section-icon"></i>
            <span class="section-title">教练照片</span>
          </div>
          <el-form-item class="upload" v-if="type!='info' && !ro.tupian">
            <file-upload
              tip="点击上传教练照片（最多3张）"
              action="file/upload"
              :limit="3"
              :multiple="true"
              :fileUrls="ruleForm.tupian ? ruleForm.tupian : ''"
              @change="tupianUploadChange"
            ></file-upload>
          </el-form-item>
          <div v-else-if="ruleForm.tupian" class="image-preview-list">
            <el-image 
              v-for="(item, index) in ruleForm.tupian.split(',')" 
              :key="index"
              :src="item" 
              fit="cover"
              class="preview-image"
              :preview-src-list="ruleForm.tupian.split(',')"
            >
              <div slot="error" class="image-error">
                <i class="el-icon-picture-outline"></i>
              </div>
            </el-image>
          </div>
          <div v-else class="no-image">
            <i class="el-icon-picture-outline"></i>
            <span>暂无图片</span>
          </div>
        </div>

        <!-- 工作履历 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-document section-icon"></i>
            <span class="section-title">工作履历</span>
          </div>
          <el-form-item class="textarea" prop="gongzuolvli">
            <el-input
              type="textarea"
              :rows="4"
              placeholder="请输入工作履历"
              v-model="ruleForm.gongzuolvli"
              :readonly="ro.gongzuolvli"
            ></el-input>
          </el-form-item>
        </div>

        <!-- 个人简介 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-postcard section-icon"></i>
            <span class="section-title">个人简介</span>
          </div>
          <el-form-item class="textarea" prop="gerenjianjie">
            <el-input
              type="textarea"
              :rows="4"
              placeholder="请输入个人简介"
              v-model="ruleForm.gerenjianjie"
              :readonly="ro.gerenjianjie"
            ></el-input>
          </el-form-item>
        </div>

        <!-- 按钮区域 -->
        <div class="form-actions">
          <el-button type="primary" class="submit-btn" @click="onSubmit" v-if="type!='info'">
            <i class="el-icon-check"></i>
            提交保存
          </el-button>
          <el-button class="back-btn" @click="back">
            <i class="el-icon-arrow-left"></i>
            {{ type === 'info' ? '返回列表' : '取消' }}
          </el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      addEditForm: {
        btnSaveFontColor: "#fff",
        selectFontSize: "14px",
        btnCancelBorderColor: "rgba(152, 129, 129, 1)",
        inputBorderRadius: "22px",
        inputFontSize: "14px",
        textareaBgColor: "#fff",
        btnSaveFontSize: "14px",
        textareaBorderRadius: "22px",
        uploadBgColor: "#fff",
        textareaBorderStyle: "solid",
        btnCancelWidth: "88px",
        textareaHeight: "120px",
        dateBgColor: "#fff",
        btnSaveBorderRadius: "22px",
        uploadLableFontSize: "14px",
        textareaBorderWidth: "1px",
        inputLableColor: "#606266",
        addEditBoxColor: "rgba(210, 194, 194, 0.29)",
        dateIconFontSize: "14px",
        btnSaveBgColor: "#409EFF",
        uploadIconFontColor: "#8c939d",
        textareaBorderColor: "rgba(152, 129, 129, 1)",
        btnCancelBgColor: "rgba(143, 222, 143, 1)",
        selectLableColor: "#606266",
        btnSaveBorderStyle: "solid",
        dateBorderWidth: "1px",
        dateLableFontSize: "14px",
        dateBorderRadius: "22px",
        btnCancelBorderStyle: "solid",
        selectLableFontSize: "14px",
        selectBorderStyle: "solid",
        selectIconFontColor: "#C0C4CC",
        btnCancelHeight: "44px",
        inputHeight: "40px",
        btnCancelFontColor: "#606266",
        dateBorderColor: "rgba(152, 129, 129, 1)",
        dateIconFontColor: "#C0C4CC",
        uploadBorderStyle: "solid",
        dateBorderStyle: "solid",
        dateLableColor: "#606266",
        dateFontSize: "14px",
        inputBorderWidth: "1px",
        uploadIconFontSize: "28px",
        selectHeight: "40px",
        inputFontColor: "#606266",
        uploadHeight: "148px",
        textareaLableColor: "#606266",
        textareaLableFontSize: "14px",
        btnCancelFontSize: "14px",
        inputBorderStyle: "solid",
        btnCancelBorderRadius: "22px",
        inputBgColor: "rgba(252, 250, 250, 1)",
        inputLableFontSize: "14px",
        uploadLableColor: "#606266",
        uploadBorderRadius: "22px",
        btnSaveHeight: "44px",
        selectBgColor: "#fff",
        btnSaveWidth: "88px",
        selectIconFontSize: "14px",
        dateHeight: "40px",
        selectBorderColor: "rgba(152, 129, 129, 1)",
        inputBorderColor: "rgba(152, 129, 129, 1)",
        uploadBorderColor: "rgba(152, 129, 129, 1)",
        textareaFontColor: "#606266",
        selectBorderWidth: "1px",
        dateFontColor: "#606266",
        btnCancelBorderWidth: "1px",
        uploadBorderWidth: "1px",
        textareaFontSize: "14px",
        selectBorderRadius: "22px",
        selectFontColor: "#606266",
        btnSaveBorderColor: "#409EFF",
        btnSaveBorderWidth: "1px"
      },
      id: '',
      type: '',
      ro: {
        gonghao: false,
        yuangongxingming: false,
        xingbie: false,
        shengao: false,
        tizhong: false,
        shoujihao: false,
        jiaolianleixing: false,
        jiaolianjiage: false,
        shangkeshijian: false,
        gongzuolvli: false,
        gerenjianjie: false,
        tupian: false,
      },
      ruleForm: {
        gonghao: '',
        yuangongxingming: '',
        xingbie: '',
        shengao: '',
        tizhong: '',
        shoujihao: '',
        jiaolianleixing: '',
        jiaolianjiage: '',
        shangkeshijian: '',
        gongzuolvli: '',
        gerenjianjie: '',
        tupian: '',
      },
      rules: {}
    };
  },
  props: ["parent"],
  computed: {},
  created() {
    this.applyFormThemeConfig();
    this.addEditStyleChange();
    this.addEditUploadStyleChange();
  },
  methods: {
    download(file) {
      window.open(`${file}`);
    },
    init(id, type) {
      if (id) {
        this.id = id;
        this.type = type;
      }
      if (this.type == 'info' || this.type == 'else') {
        this.info(id);
      } else if (this.type == 'cross') {
        var obj = this.$storage.getObj('crossObj');
        for (var o in obj) {
          if (o == 'gonghao') {
            this.ruleForm.gonghao = obj[o];
            this.ro.gonghao = true;
            continue;
          }
          if (o == 'yuangongxingming') {
            this.ruleForm.yuangongxingming = obj[o];
            this.ro.yuangongxingming = true;
            continue;
          }
          if (o == 'xingbie') {
            this.ruleForm.xingbie = obj[o];
            this.ro.xingbie = true;
            continue;
          }
          if (o == 'shengao') {
            this.ruleForm.shengao = obj[o];
            this.ro.shengao = true;
            continue;
          }
          if (o == 'tizhong') {
            this.ruleForm.tizhong = obj[o];
            this.ro.tizhong = true;
            continue;
          }
          if (o == 'shoujihao') {
            this.ruleForm.shoujihao = obj[o];
            this.ro.shoujihao = true;
            continue;
          }
          if (o == 'jiaolianleixing') {
            this.ruleForm.jiaolianleixing = obj[o];
            this.ro.jiaolianleixing = true;
            continue;
          }
          if (o == 'jiaolianjiage') {
            this.ruleForm.jiaolianjiage = obj[o];
            this.ro.jiaolianjiage = true;
            continue;
          }
          if (o == 'shangkeshijian') {
            this.ruleForm.shangkeshijian = obj[o];
            this.ro.shangkeshijian = true;
            continue;
          }
          if (o == 'gongzuolvli') {
            this.ruleForm.gongzuolvli = obj[o];
            this.ro.gongzuolvli = true;
            continue;
          }
          if (o == 'gerenjianjie') {
            this.ruleForm.gerenjianjie = obj[o];
            this.ro.gerenjianjie = true;
            continue;
          }
          if (o == 'tupian') {
            this.ruleForm.tupian = obj[o];
            this.ro.tupian = true;
            continue;
          }
        }
      }
      this.$http({
        url: `${this.$storage.get('sessionTable')}/session`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          var json = data.data;
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    info(id) {
      this.$http({
        url: `jiaolianxinxi/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.ruleForm = data.data;
          let reg = new RegExp('../../../upload', 'g');
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    onSubmit() {
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          this.$http({
            url: `jiaolianxinxi/${!this.ruleForm.id ? "save" : "update"}`,
            method: "post",
            data: this.ruleForm
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "操作成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  this.parent.showFlag = true;
                  this.parent.addOrUpdateFlag = false;
                  this.parent.jiaolianxinxiCrossAddOrUpdateFlag = false;
                  this.parent.search();
                }
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    getUUID() {
      return new Date().getTime();
    },
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
      this.parent.jiaolianxinxiCrossAddOrUpdateFlag = false;
    },
    tupianUploadChange(fileUrls) {
      this.ruleForm.tupian = fileUrls;
      this.addEditUploadStyleChange();
    },
    addEditStyleChange() {
      this.$nextTick(() => {
        document.querySelectorAll('.detail-form-content .input .el-input__inner').forEach(el => {
          el.style.height = this.addEditForm.inputHeight;
          el.style.borderRadius = '8px';
          el.style.border = '1px solid #e4e7ed';
        });
        document.querySelectorAll('.detail-form-content .textarea .el-textarea__inner').forEach(el => {
          el.style.borderRadius = '8px';
          el.style.border = '1px solid #e4e7ed';
        });
      });
    },
    addEditUploadStyleChange() {
      this.$nextTick(() => {
        document.querySelectorAll('.detail-form-content .upload .el-upload--picture-card').forEach(el => {
          el.style.borderRadius = '8px';
        });
      });
    }
  }
};
</script>

<style lang="scss" scoped>
.add-or-update-page {
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
  align-items: center;
  gap: 20px;
}

.header-icon-wrapper {
  width: 64px;
  height: 64px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.header-icon {
  font-size: 32px;
  color: #fff;
}

.header-text {
  color: #fff;
}

.header-title {
  margin: 0;
  font-size: 24px;
  font-weight: 600;
  letter-spacing: 1px;
}

.header-desc {
  margin: 6px 0 0;
  font-size: 14px;
  opacity: 0.85;
}

/* 表单卡片 */
.form-card {
  background: #fff;
  border-radius: 16px;
  padding: 30px 35px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

/* 表单分区 */
.form-section {
  margin-bottom: 30px;
  padding-bottom: 24px;
  border-bottom: 1px dashed #e4e7ed;
}

.form-section:last-of-type {
  border-bottom: none;
  margin-bottom: 20px;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
  padding-bottom: 12px;
  border-bottom: 2px solid #667eea;
}

.section-icon {
  font-size: 20px;
  color: #667eea;
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

/* 输入框样式 */
.input ::v-deep .el-input__inner {
  border-radius: 8px;
  transition: all 0.3s;
}

.input ::v-deep .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

.input ::v-deep .el-input__prefix {
  color: #667eea;
}

/* 文本域样式 */
.textarea ::v-deep .el-textarea__inner {
  border-radius: 8px;
  transition: all 0.3s;
}

.textarea ::v-deep .el-textarea__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

/* 图片预览 */
.image-preview-list {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

.preview-image {
  width: 120px;
  height: 120px;
  border-radius: 12px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s;
  border: 2px solid #f0f0f0;
}

.preview-image:hover {
  transform: scale(1.05);
  border-color: #667eea;
}

.image-error {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f5f5;
  color: #ccc;
  font-size: 30px;
}

.no-image {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 120px;
  height: 120px;
  background: #f5f5f5;
  border-radius: 12px;
  color: #ccc;
  gap: 8px;
}

.no-image i {
  font-size: 30px;
}

/* 按钮区域 */
.form-actions {
  display: flex;
  gap: 16px;
  margin-top: 30px;
  padding-top: 24px;
  border-top: 1px solid #e4e7ed;
}

.submit-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  padding: 14px 36px;
  font-size: 15px;
  font-weight: 500;
  transition: all 0.3s;
}

.submit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

.submit-btn i {
  margin-right: 6px;
}

.back-btn {
  border: 1px solid #e4e7ed;
  border-radius: 8px;
  padding: 14px 28px;
  font-size: 15px;
  color: #666;
  transition: all 0.3s;
}

.back-btn:hover {
  border-color: #667eea;
  color: #667eea;
}

.back-btn i {
  margin-right: 6px;
}

/* 上传组件样式 */
.upload ::v-deep .el-upload--picture-card {
  border-radius: 8px;
  border: 2px dashed #d9d9d9;
  transition: all 0.3s;
}

.upload ::v-deep .el-upload--picture-card:hover {
  border-color: #667eea;
}

/* 响应式 */
@media (max-width: 768px) {
  .add-or-update-page {
    padding: 12px;
  }

  .page-header {
    padding: 20px;
  }

  .header-title {
    font-size: 18px;
  }

  .form-card {
    padding: 20px;
  }

  .form-actions {
    flex-direction: column;
  }

  .submit-btn,
  .back-btn {
    width: 100%;
  }
}
</style>
