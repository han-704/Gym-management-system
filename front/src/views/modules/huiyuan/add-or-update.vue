<template>
  <div class="add-or-update-page">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-icon-wrapper">
          <i class="el-icon-user-solid header-icon"></i>
        </div>
        <div class="header-text">
          <h2 class="header-title">{{ type === 'info' ? '会员详情' : (ruleForm.id ? '编辑会员' : '新增会员') }}</h2>
          <p class="header-desc">{{ type === 'info' ? '查看会员详细信息' : '填写会员相关信息' }}</p>
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
        <!-- 账号信息 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-user section-icon"></i>
            <span class="section-title">账号信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员账号" prop="huiyuanzhanghao">
                <el-input v-model="ruleForm.huiyuanzhanghao" placeholder="请输入会员账号" clearable :readonly="ro.huiyuanzhanghao">
                  <i slot="prefix" class="el-input__icon el-icon-user"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="密码" prop="mima">
                <el-input v-model="ruleForm.mima" placeholder="请输入密码" clearable :readonly="ro.mima" type="password" show-password>
                  <i slot="prefix" class="el-input__icon el-icon-lock"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 基本信息 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-postcard section-icon"></i>
            <span class="section-title">基本信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员姓名" prop="huiyuanxingming">
                <el-input v-model="ruleForm.huiyuanxingming" placeholder="请输入会员姓名" clearable :readonly="ro.huiyuanxingming">
                  <i slot="prefix" class="el-input__icon el-icon-edit"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="身份证" prop="shenfenzheng">
                <el-input v-model="ruleForm.shenfenzheng" placeholder="请输入身份证号" clearable :readonly="ro.shenfenzheng">
                  <i slot="prefix" class="el-input__icon el-icon-postcard"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="select" label="性别" prop="xingbie">
                <el-select v-model="ruleForm.xingbie" placeholder="请选择性别" :disabled="ro.xingbie" class="gender-select">
                  <el-option
                    v-for="(item, index) in xingbieOptions"
                    :key="index"
                    :label="item"
                    :value="item"
                  >
                    <span><i :class="item === '男' ? 'el-icon-male' : 'el-icon-female'"></i> {{ item }}</span>
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="手机" prop="shouji">
                <el-input v-model="ruleForm.shouji" placeholder="请输入手机号" clearable :readonly="ro.shouji">
                  <i slot="prefix" class="el-input__icon el-icon-mobile-phone"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 头像上传 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-picture section-icon"></i>
            <span class="section-title">会员头像</span>
          </div>
          <el-form-item class="upload" v-if="type!='info' && !ro.touxiang">
            <file-upload
              tip="点击上传会员头像（最多3张）"
              action="file/upload"
              :limit="3"
              :multiple="true"
              :fileUrls="ruleForm.touxiang ? ruleForm.touxiang : ''"
              @change="touxiangUploadChange"
            ></file-upload>
          </el-form-item>
          <div v-else-if="ruleForm.touxiang" class="avatar-preview">
            <div class="avatar-wrapper" v-for="(item, index) in ruleForm.touxiang.split(',')" :key="index">
              <el-image 
                :src="item" 
                fit="cover"
                class="preview-avatar"
                :preview-src-list="ruleForm.touxiang.split(',')"
              >
                <div slot="error" class="image-error">
                  <i class="el-icon-picture-outline"></i>
                </div>
              </el-image>
            </div>
          </div>
          <div v-else class="no-avatar">
            <i class="el-icon-picture-outline"></i>
            <span>暂无头像</span>
          </div>
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
import { isNumber, isIntNumer, isEmail, isPhone, isMobile, isURL, checkIdCard } from "@/utils/validate";

export default {
  data() {
    let self = this;
    var validateIdCard = (rule, value, callback) => {
      if (!value) {
        callback();
      } else if (!checkIdCard(value)) {
        callback(new Error("请输入正确的身份证号码"));
      } else {
        callback();
      }
    };
    var validateMobile = (rule, value, callback) => {
      if (!value) {
        callback();
      } else if (!isMobile(value)) {
        callback(new Error("请输入正确的手机号码"));
      } else {
        callback();
      }
    };
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
        huiyuanzhanghao: false,
        mima: false,
        huiyuanxingming: false,
        shenfenzheng: false,
        xingbie: false,
        touxiang: false,
        shouji: false,
      },
      ruleForm: {
        huiyuanzhanghao: '',
        mima: '',
        huiyuanxingming: '',
        shenfenzheng: '',
        xingbie: '',
        touxiang: '',
        shouji: '',
      },
      xingbieOptions: [],
      rules: {
        huiyuanzhanghao: [
          { required: true, message: '会员账号不能为空', trigger: 'blur' },
        ],
        mima: [
          { required: true, message: '密码不能为空', trigger: 'blur' },
        ],
        huiyuanxingming: [],
        shenfenzheng: [
          { validator: validateIdCard, trigger: 'blur' },
        ],
        xingbie: [],
        touxiang: [],
        shouji: [
          { validator: validateMobile, trigger: 'blur' },
        ],
      }
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
          if (o == 'huiyuanzhanghao') {
            this.ruleForm.huiyuanzhanghao = obj[o];
            this.ro.huiyuanzhanghao = true;
            continue;
          }
          if (o == 'mima') {
            this.ruleForm.mima = obj[o];
            this.ro.mima = true;
            continue;
          }
          if (o == 'huiyuanxingming') {
            this.ruleForm.huiyuanxingming = obj[o];
            this.ro.huiyuanxingming = true;
            continue;
          }
          if (o == 'shenfenzheng') {
            this.ruleForm.shenfenzheng = obj[o];
            this.ro.shenfenzheng = true;
            continue;
          }
          if (o == 'xingbie') {
            this.ruleForm.xingbie = obj[o];
            this.ro.xingbie = true;
            continue;
          }
          if (o == 'touxiang') {
            this.ruleForm.touxiang = obj[o];
            this.ro.touxiang = true;
            continue;
          }
          if (o == 'shouji') {
            this.ruleForm.shouji = obj[o];
            this.ro.shouji = true;
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
      this.xingbieOptions = "男,女".split(',');
    },
    info(id) {
      this.$http({
        url: `huiyuan/info/${id}`,
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
            url: `huiyuan/${!this.ruleForm.id ? "save" : "update"}`,
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
                  this.parent.huiyuanCrossAddOrUpdateFlag = false;
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
      this.parent.huiyuanCrossAddOrUpdateFlag = false;
    },
    touxiangUploadChange(fileUrls) {
      this.ruleForm.touxiang = fileUrls;
      this.addEditUploadStyleChange();
    },
    addEditStyleChange() {
      this.$nextTick(() => {
        document.querySelectorAll('.detail-form-content .input .el-input__inner').forEach(el => {
          el.style.height = this.addEditForm.inputHeight;
          el.style.borderRadius = '8px';
          el.style.border = '1px solid #e4e7ed';
        });
        document.querySelectorAll('.detail-form-content .select .el-input__inner').forEach(el => {
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

/* 下拉框样式 */
.select ::v-deep .el-input__inner {
  border-radius: 8px;
  transition: all 0.3s;
}

.select ::v-deep .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

.gender-select ::v-deep .el-select__caret {
  color: #667eea;
}

/* 头像预览 */
.avatar-preview {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
}

.avatar-wrapper {
  position: relative;
}

.preview-avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s;
  border: 4px solid #f0f0f0;
}

.preview-avatar:hover {
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

.no-avatar {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 120px;
  height: 120px;
  background: #f5f5f5;
  border-radius: 50%;
  color: #ccc;
  gap: 8px;
}

.no-avatar i {
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
