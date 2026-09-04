<template>
  <div class="fire-form-page">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-icon-wrapper">
          <i class="el-icon-user-solid header-icon"></i>
        </div>
        <div class="header-text">
          <h2 class="header-title">{{ type === 'info' ? '解聘详情' : (ruleForm.id ? '编辑解聘记录' : '新增解聘记录') }}</h2>
          <p class="header-desc">{{ type === 'info' ? '查看解聘详细信息' : '填写解聘相关信息' }}</p>
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
            <i class="el-icon-document section-icon"></i>
            <span class="section-title">基本信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="解聘编号" prop="jiepinbianhao">
                <el-input v-model="ruleForm.jiepinbianhao" placeholder="系统自动生成" readonly>
                  <i slot="prefix" class="el-input__icon el-icon-document"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="工号" prop="gonghao">
                <el-input v-model="ruleForm.gonghao" placeholder="请输入工号" clearable :readonly="ro.gonghao">
                  <i slot="prefix" class="el-input__icon el-icon-key"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="员工姓名" prop="yuangongxingming">
                <el-input v-model="ruleForm.yuangongxingming" placeholder="请输入员工姓名" clearable :readonly="ro.yuangongxingming">
                  <i slot="prefix" class="el-input__icon el-icon-user"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="教练类型" prop="jiaolianleixing">
                <el-input v-model="ruleForm.jiaolianleixing" placeholder="请输入教练类型" clearable :readonly="ro.jiaolianleixing">
                  <i slot="prefix" class="el-input__icon el-icon-s-custom"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 费用信息 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-coin section-icon"></i>
            <span class="section-title">费用信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="教练价格" prop="jiaolianjiage">
                <el-input v-model="ruleForm.jiaolianjiage" placeholder="请输入教练价格" clearable :readonly="ro.jiaolianjiage">
                  <template slot="prepend">¥</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="date" label="解聘时间" prop="jiepinshijian">
                <el-date-picker
                  format="yyyy 年 MM 月 dd 日"
                  value-format="yyyy-MM-dd"
                  v-model="ruleForm.jiepinshijian" 
                  type="date"
                  placeholder="选择解聘时间"
                  class="date-picker"
                  :readonly="ro.jiepinshijian"
                ></el-date-picker> 
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 解聘原因 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-warning section-icon"></i>
            <span class="section-title">解聘原因</span>
          </div>
          <el-form-item class="textarea" v-if="type!='info'" label="解聘原因" prop="jiepinyuanyin">
            <el-input
              type="textarea"
              :rows="6"
              placeholder="请输入解聘原因"
              v-model="ruleForm.jiepinyuanyin">
            </el-input>
          </el-form-item>
          <div v-else-if="ruleForm.jiepinyuanyin" class="reason-display">
            <p>{{ ruleForm.jiepinyuanyin }}</p>
          </div>
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
        jiepinbianhao : false,
        gonghao : false,
        yuangongxingming : false,
        jiaolianleixing : false,
        jiaolianjiage : false,
        jiepinyuanyin : false,
        jiepinshijian : false,
      },
      ruleForm: {
        jiepinbianhao: this.getUUID(),
        gonghao: '',
        yuangongxingming: '',
        jiaolianleixing: '',
        jiaolianjiage: '',
        jiepinyuanyin: '',
        jiepinshijian: '',
      },
      rules: {
        jiepinbianhao: [],
        gonghao: [],
        yuangongxingming: [],
        jiaolianleixing: [],
        jiaolianjiage: [],
        jiepinyuanyin: [],
        jiepinshijian: [],
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
          if(o=='jiepinbianhao'){
            this.ruleForm.jiepinbianhao = obj[o];
            this.ro.jiepinbianhao = true;
            continue;
          }
          if(o=='gonghao'){
            this.ruleForm.gonghao = obj[o];
            this.ro.gonghao = true;
            continue;
          }
          if(o=='yuangongxingming'){
            this.ruleForm.yuangongxingming = obj[o];
            this.ro.yuangongxingming = true;
            continue;
          }
          if(o=='jiaolianleixing'){
            this.ruleForm.jiaolianleixing = obj[o];
            this.ro.jiaolianleixing = true;
            continue;
          }
          if(o=='jiaolianjiage'){
            this.ruleForm.jiaolianjiage = obj[o];
            this.ro.jiaolianjiage = true;
            continue;
          }
          if(o=='jiepinyuanyin'){
            this.ruleForm.jiepinyuanyin = obj[o];
            this.ro.jiepinyuanyin = true;
            continue;
          }
          if(o=='jiepinshijian'){
            this.ruleForm.jiepinshijian = obj[o];
            this.ro.jiepinshijian = true;
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
        url: `jiepin/info/${id}`,
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
            url: `jiepin/${!this.ruleForm.id ? "save" : "update"}`,
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
                  this.parent.jiepinCrossAddOrUpdateFlag = false;
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
      this.parent.jiepinCrossAddOrUpdateFlag = false;
    },
  }
};
</script>

<style lang="scss" scoped>
.fire-form-page {
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
  box-shadow: 0 10px 30px rgba(118, 75, 162, 0.3);
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

::v-deep .el-input-group__prepend {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  border: none;
  border-radius: 10px 0 0 10px;
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

/* 原因展示 */
.reason-display {
  background: #f9fafb;
  border-radius: 10px;
  padding: 16px 20px;
  border-left: 4px solid #764ba2;
}

.reason-display p {
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
  .fire-form-page {
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
