<template>
  <div class="card-type-form-page">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-icon-wrapper">
          <i class="el-icon-postcard header-icon"></i>
        </div>
        <div class="header-text">
          <h2 class="header-title">{{ type === 'info' ? '会员卡类型详情' : (ruleForm.id ? '编辑卡类型' : '新增卡类型') }}</h2>
          <p class="header-desc">{{ type === 'info' ? '查看会员卡类型详细信息' : '填写会员卡类型相关信息' }}</p>
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
            <i class="el-icon-postcard section-icon"></i>
            <span class="section-title">基本信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员卡名称" prop="huiyuankamingcheng">
                <el-input v-model="ruleForm.huiyuankamingcheng" placeholder="请输入会员卡名称" clearable :readonly="ro.huiyuankamingcheng">
                  <i slot="prefix" class="el-input__icon el-icon-postcard"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="会员卡类型" prop="huiyuankaleixing">
                <el-input v-model="ruleForm.huiyuankaleixing" placeholder="请输入会员卡类型" clearable :readonly="ro.huiyuankaleixing">
                  <i slot="prefix" class="el-input__icon el-icon-collection-tag"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员卡价格" prop="huiyuankajiage">
                <el-input v-model="ruleForm.huiyuankajiage" placeholder="请输入会员卡价格" clearable :readonly="ro.huiyuankajiage">
                  <template slot="append">元</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="有效时间" prop="youxiaoshijian">
                <el-input v-model="ruleForm.youxiaoshijian" placeholder="请输入有效时间" clearable :readonly="ro.youxiaoshijian">
                  <i slot="prefix" class="el-input__icon el-icon-time"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 图片上传 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-picture-outline section-icon"></i>
            <span class="section-title">会员卡图片</span>
          </div>
          <el-form-item class="upload" v-if="type!='info' && !ro.huiyuankatupian">
            <file-upload
              tip="点击上传会员卡图片"
              action="file/upload"
              :limit="3"
              :multiple="true"
              :fileUrls="ruleForm.huiyuankatupian ? ruleForm.huiyuankatupian : ''"
              @change="huiyuankatupianUploadChange"
            ></file-upload>
          </el-form-item>
          <div v-if="type === 'info' && ruleForm.huiyuankatupian" class="image-preview">
            <el-image 
              v-for="(item, index) in ruleForm.huiyuankatupian.split(',')" 
              :key="index"
              :src="item" 
              fit="cover"
              class="preview-image"
              :preview-src-list="ruleForm.huiyuankatupian.split(',')"
            ></el-image>
          </div>
        </div>

        <!-- 会员卡功能 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-menu section-icon"></i>
            <span class="section-title">会员卡功能</span>
          </div>
          <el-form-item class="textarea" v-if="type!='info'" label="会员卡功能" prop="huiyuankagongneng">
            <el-input
              type="textarea"
              :rows="6"
              placeholder="请输入会员卡功能"
              v-model="ruleForm.huiyuankagongneng">
            </el-input>
          </el-form-item>
          <div v-else-if="ruleForm.huiyuankagongneng" class="function-display">
            <p>{{ ruleForm.huiyuankagongneng }}</p>
          </div>
        </div>

        <!-- 日期 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-calendar section-icon"></i>
            <span class="section-title">日期信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="date" v-if="type!='info'" label="日期" prop="riqi">
                <el-date-picker
                  format="yyyy 年 MM 月 dd 日"
                  value-format="yyyy-MM-dd"
                  v-model="ruleForm.riqi" 
                  type="date"
                  placeholder="选择日期"
                  class="date-picker"
                ></el-date-picker> 
              </el-form-item>
              <el-form-item v-else label="日期" prop="riqi">
                <el-input v-model="ruleForm.riqi" readonly></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <el-button v-if="type!='info'" type="primary" class="btn-submit" @click="onSubmit">
            <i class="el-icon-check"></i> 提交
          </el-button>
          <el-button v-if="type!='info'" class="btn-cancel" @click="back()">
            <i class="el-icon-close"></i> 取消
          </el-button>
          <el-button v-if="type=='info'" class="btn-cancel" @click="back()">
            <i class="el-icon-back"></i> 返回
          </el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
// 数字，邮件，手机，url，身份证校验
import { isNumber,isIntNumer,isEmail,isPhone, isMobile,isURL,checkIdCard } from "@/utils/validate";
export default {
  data() {
    let self = this
    var validateIdCard = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!checkIdCard(value)) {
        callback(new Error("请输入正确的身份证号码"));
      } else {
        callback();
      }
    };
    var validateUrl = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isURL(value)) {
        callback(new Error("请输入正确的URL地址"));
      } else {
        callback();
      }
    };
    var validateMobile = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isMobile(value)) {
        callback(new Error("请输入正确的手机号码"));
      } else {
        callback();
      }
    };
    var validatePhone = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isPhone(value)) {
        callback(new Error("请输入正确的电话号码"));
      } else {
        callback();
      }
    };
    var validateEmail = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isEmail(value)) {
        callback(new Error("请输入正确的邮箱地址"));
      } else {
        callback();
      }
    };
    var validateNumber = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isNumber(value)) {
        callback(new Error("请输入数字"));
      } else {
        callback();
      }
    };
    var validateIntNumber = (rule, value, callback) => {
      if(!value){
        callback();
      } else if (!isIntNumer(value)) {
        callback(new Error("请输入整数"));
      } else {
        callback();
      }
    };
    return {
      id: '',
      type: '',
      ro:{
        huiyuankamingcheng : false,
        huiyuankatupian : false,
        huiyuankaleixing : false,
        huiyuankagongneng : false,
        huiyuankajiage : false,
        youxiaoshijian : false,
        riqi : false,
      },
      ruleForm: {
        huiyuankamingcheng: '',
        huiyuankatupian: '',
        huiyuankaleixing: '',
        huiyuankagongneng: '',
        huiyuankajiage: '',
        youxiaoshijian: '',
        riqi: '',
      },
      rules: {
        huiyuankamingcheng: [],
        huiyuankatupian: [],
        huiyuankaleixing: [],
        huiyuankagongneng: [],
        huiyuankajiage: [
          { validator: validateIntNumber, trigger: 'blur' },
        ],
        youxiaoshijian: [],
        riqi: [],
      }
    };
  },
  props: ["parent"],
  computed: {
  },
  created() {
  },
  methods: {
    download(file){
      window.open(`${file}`)
    },
    init(id, type) {
      if (id) {
        this.id = id;
        this.type = type;
      }
      if(this.type=='info'||this.type=='else'){
        this.info(id);
      }else if(this.type=='cross'){
        var obj = this.$storage.getObj('crossObj');
        for (var o in obj){
          if(o=='huiyuankamingcheng'){
            this.ruleForm.huiyuankamingcheng = obj[o];
            this.ro.huiyuankamingcheng = true;
            continue;
          }
          if(o=='huiyuankatupian'){
            this.ruleForm.huiyuankatupian = obj[o];
            this.ro.huiyuankatupian = true;
            continue;
          }
          if(o=='huiyuankaleixing'){
            this.ruleForm.huiyuankaleixing = obj[o];
            this.ro.huiyuankaleixing = true;
            continue;
          }
          if(o=='huiyuankagongneng'){
            this.ruleForm.huiyuankagongneng = obj[o];
            this.ro.huiyuankagongneng = true;
            continue;
          }
          if(o=='huiyuankajiage'){
            this.ruleForm.huiyuankajiage = obj[o];
            this.ro.huiyuankajiage = true;
            continue;
          }
          if(o=='youxiaoshijian'){
            this.ruleForm.youxiaoshijian = obj[o];
            this.ro.youxiaoshijian = true;
            continue;
          }
          if(o=='riqi'){
            this.ruleForm.riqi = obj[o];
            this.ro.riqi = true;
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
        url: `huiyuankaleixing/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.ruleForm = data.data;
          let reg=new RegExp('../../../upload','g')
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    onSubmit() {
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          this.$http({
            url: `huiyuankaleixing/${!this.ruleForm.id ? "save" : "update"}`,
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
                  this.parent.huiyuankaleixingCrossAddOrUpdateFlag = false;
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
    getUUID () {
      return new Date().getTime();
    },
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
      this.parent.huiyuankaleixingCrossAddOrUpdateFlag = false;
    },
    huiyuankatupianUploadChange(fileUrls) {
      this.ruleForm.huiyuankatupian = fileUrls;
    },
  }
};
</script>

<style lang="scss" scoped>
.card-type-form-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ed 100%);
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
  width: 70px;
  height: 70px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.header-icon {
  font-size: 36px;
  color: #fff;
}

.header-text {
  color: #fff;
}

.header-title {
  margin: 0;
  font-size: 26px;
  font-weight: 700;
  letter-spacing: 1px;
}

.header-desc {
  margin: 8px 0 0;
  font-size: 14px;
  opacity: 0.9;
}

/* 表单卡片 */
.form-card {
  background: #fff;
  border-radius: 16px;
  padding: 30px 35px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

/* 表单分组 */
.form-section {
  margin-bottom: 30px;
}

.form-section:last-of-type {
  margin-bottom: 0;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 12px;
  padding-bottom: 16px;
  border-bottom: 2px solid #f0f0f0;
  margin-bottom: 24px;
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
::v-deep .el-input__inner {
  border-radius: 10px;
  border: 1px solid #e4e7ed;
  transition: all 0.3s;
}

::v-deep .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

::v-deep .el-input__prefix {
  color: #667eea;
}

::v-deep .el-form-item__label {
  color: #606266;
  font-weight: 500;
}

::v-deep .el-input-group__append {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  border: none;
  border-radius: 0 10px 10px 0;
}

.date-picker {
  width: 100%;
}

.date-picker ::v-deep .el-input__inner {
  padding-left: 30px;
}

/* 文本域 */
::v-deep .el-textarea__inner {
  border-radius: 10px;
  border: 1px solid #e4e7ed;
  transition: all 0.3s;
}

::v-deep .el-textarea__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
}

/* 图片预览 */
.image-preview {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  padding: 16px 0;
}

.preview-image {
  width: 120px;
  height: 120px;
  border-radius: 12px;
  object-fit: cover;
  border: 3px solid rgba(102, 126, 234, 0.2);
  transition: all 0.3s;
  cursor: pointer;
}

.preview-image:hover {
  transform: scale(1.05);
  border-color: #667eea;
}

/* 功能展示 */
.function-display {
  background: #f9fafb;
  border-radius: 10px;
  padding: 16px 20px;
  border-left: 4px solid #667eea;
}

.function-display p {
  margin: 0;
  color: #666;
  line-height: 1.8;
  white-space: pre-wrap;
}

/* 提交按钮 */
.form-actions {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-top: 36px;
  padding-top: 24px;
  border-top: 1px solid #f0f0f0;
}

.btn-submit {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 10px;
  padding: 14px 36px;
  font-size: 15px;
  font-weight: 600;
  transition: all 0.3s;
  color: #fff;
}

.btn-submit:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

.btn-submit i {
  margin-right: 6px;
}

.btn-cancel {
  border-radius: 10px;
  padding: 14px 28px;
  font-size: 15px;
  border: 1px solid #e4e7ed;
  color: #666;
  transition: all 0.3s;
}

.btn-cancel:hover {
  border-color: #667eea;
  color: #667eea;
}

.btn-cancel i {
  margin-right: 6px;
}

/* 响应式 */
@media (max-width: 768px) {
  .card-type-form-page {
    padding: 12px;
  }
  
  .page-header {
    padding: 20px;
  }
  
  .header-icon-wrapper {
    width: 50px;
    height: 50px;
  }
  
  .header-icon {
    font-size: 26px;
  }
  
  .header-title {
    font-size: 20px;
  }
  
  .form-card {
    padding: 20px;
  }
  
  .form-actions {
    flex-direction: column;
  }
  
  .btn-submit,
  .btn-cancel {
    width: 100%;
  }
}
</style>
