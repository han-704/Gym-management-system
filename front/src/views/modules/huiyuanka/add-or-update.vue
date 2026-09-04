<template>
  <div class="card-page">
    <!-- 页面头部 -->
    <div class="page-header">
      <div class="header-content">
        <div class="header-icon-wrapper">
          <i class="el-icon-postcard header-icon"></i>
        </div>
        <div class="header-text">
          <h2 class="header-title">{{ type === 'info' ? '会员卡详情' : '申请会员卡' }}</h2>
          <p class="header-desc">{{ type === 'info' ? '查看会员卡详细信息' : '为会员办理健身会员卡' }}</p>
        </div>
      </div>
    </div>

    <!-- 表单卡片 -->
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
            <span class="section-title">会员卡信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员卡编号" prop="huiyuankabianhao">
                <el-input v-model="ruleForm.huiyuankabianhao" placeholder="系统自动生成" readonly>
                  <i slot="prefix" class="el-input__icon el-icon-key"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="select" label="会员卡名称" prop="huiyuankamingcheng">
                <el-select @change="huiyuankamingchengChange" v-model="ruleForm.huiyuankamingcheng" placeholder="请选择会员卡名称" class="custom-select">
                  <el-option
                    v-for="(item,index) in huiyuankamingchengOptions"
                    :key="index"
                    :label="item"
                    :value="item"
                  >
                    <span><i class="el-icon-tickets"></i> {{ item }}</span>
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员卡类型" prop="huiyuankaleixing">
                <el-input v-model="ruleForm.huiyuankaleixing" placeholder="根据卡名自动填充" clearable :readonly="ro.huiyuankaleixing">
                  <i slot="prefix" class="el-input__icon el-icon-collection-tag"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="会员卡价格" prop="huiyuankajiage">
                <el-input v-model="ruleForm.huiyuankajiage" placeholder="根据卡名自动填充" clearable :readonly="ro.huiyuankajiage">
                  <i slot="prefix" class="el-input__icon el-icon-wallet"></i>
                  <template slot="append">元</template>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="有效时间" prop="youxiaoshijian">
                <el-input v-model="ruleForm.youxiaoshijian" placeholder="根据卡名自动填充" clearable :readonly="ro.youxiaoshijian">
                  <i slot="prefix" class="el-input__icon el-icon-time"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="消费金额" prop="xiaofeijine">
                <el-input v-model="ruleForm.xiaofeijine" placeholder="请输入消费金额" clearable :readonly="ro.xiaofeijine">
                  <i slot="prefix" class="el-input__icon el-icon-shopping-cart-2"></i>
                  <template slot="append">元</template>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 会员信息 -->
        <div class="form-section">
          <div class="section-header">
            <i class="el-icon-user section-icon"></i>
            <span class="section-title">会员信息</span>
          </div>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="会员账号" prop="huiyuanzhanghao">
                <el-input v-model="ruleForm.huiyuanzhanghao" placeholder="系统自动填充" clearable :readonly="ro.huiyuanzhanghao">
                  <i slot="prefix" class="el-input__icon el-icon-user"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="会员姓名" prop="huiyuanxingming">
                <el-input v-model="ruleForm.huiyuanxingming" placeholder="系统自动填充" clearable :readonly="ro.huiyuanxingming">
                  <i slot="prefix" class="el-input__icon el-icon-s-custom"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="24">
            <el-col :span="12">
              <el-form-item class="input" label="体测情况" prop="ticeqingkuang">
                <el-input v-model="ruleForm.ticeqingkuang" placeholder="请输入体测情况" clearable :readonly="ro.ticeqingkuang">
                  <i slot="prefix" class="el-input__icon el-icon-data-analysis"></i>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item class="input" label="备注" prop="beizhu">
                <el-input v-model="ruleForm.beizhu" placeholder="请输入备注信息" clearable :readonly="ro.beizhu">
                  <i slot="prefix" class="el-input__icon el-icon-document"></i>
                </el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <el-button v-if="type!='info'" type="primary" class="btn-submit" @click="onSubmit">
            <i class="el-icon-check"></i> 提交申请
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
        huiyuankabianhao : false,
        huiyuankamingcheng : false,
        huiyuankaleixing : false,
        huiyuankajiage : false,
        youxiaoshijian : false,
        xiaofeijine : false,
        ticeqingkuang : false,
        huiyuanzhanghao : false,
        huiyuanxingming : false,
        beizhu : false,
        sfsh : false,
        shhf : false,
      },
      ruleForm: {
        huiyuankabianhao: this.getUUID(),
        huiyuankamingcheng: '',
        huiyuankaleixing: '',
        huiyuankajiage: '',
        youxiaoshijian: '',
        xiaofeijine: '',
        ticeqingkuang: '',
        huiyuanzhanghao: '',
        huiyuanxingming: '',
        beizhu: '',
        sfsh: '待审核',
        shhf: '',
      },
      huiyuankamingchengOptions: [],
      rules: {
        huiyuankabianhao: [],
        huiyuankamingcheng: [
          { required: true, message: '请选择会员卡名称', trigger: 'change' },
        ],
        huiyuankaleixing: [],
        huiyuankajiage: [
          { required: true, message: '会员卡价格不能为空', trigger: 'blur' },
          { validator: validateIntNumber, trigger: 'blur' },
        ],
        youxiaoshijian: [],
        xiaofeijine: [],
        ticeqingkuang: [],
        huiyuanzhanghao: [],
        huiyuanxingming: [],
        beizhu: [],
        sfsh: [],
        shhf: [],
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
    init(id,type) {
      if (id) {
        this.id = id;
        this.type = type;
      }
      if(this.type=='info'||this.type=='else'){
        this.info(id);
      }else if(this.type=='cross'){
        var obj = this.$storage.getObj('crossObj');
        for (var o in obj){
          if(o=='huiyuankabianhao'){
            this.ruleForm.huiyuankabianhao = obj[o];
            this.ro.huiyuankabianhao = true;
            continue;
          }
          if(o=='huiyuankamingcheng'){
            this.ruleForm.huiyuankamingcheng = obj[o];
            this.ro.huiyuankamingcheng = true;
            continue;
          }
          if(o=='huiyuankaleixing'){
            this.ruleForm.huiyuankaleixing = obj[o];
            this.ro.huiyuankaleixing = true;
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
          if(o=='xiaofeijine'){
            this.ruleForm.xiaofeijine = obj[o];
            this.ro.xiaofeijine = true;
            continue;
          }
          if(o=='ticeqingkuang'){
            this.ruleForm.ticeqingkuang = obj[o];
            this.ro.ticeqingkuang = true;
            continue;
          }
          if(o=='huiyuanzhanghao'){
            this.ruleForm.huiyuanzhanghao = obj[o];
            this.ro.huiyuanzhanghao = true;
            continue;
          }
          if(o=='huiyuanxingming'){
            this.ruleForm.huiyuanxingming = obj[o];
            this.ro.huiyuanxingming = true;
            continue;
          }
          if(o=='beizhu'){
            this.ruleForm.beizhu = obj[o];
            this.ro.beizhu = true;
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
          if(json.huiyuanzhanghao!=''&&json.huiyuanzhanghao){
            this.ruleForm.huiyuanzhanghao = json.huiyuanzhanghao
          }
          if(json.huiyuanxingming!=''&&json.huiyuanxingming){
            this.ruleForm.huiyuanxingming = json.huiyuanxingming
          }
        } else {
          this.$message.error(data.msg);
        }
      });
      this.$http({
        url: `option/huiyuankaleixing/huiyuankamingcheng`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.huiyuankamingchengOptions = data.data;
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    huiyuankamingchengChange () {
      this.$http({
        url: `follow/huiyuankaleixing/huiyuankamingcheng?columnValue=`+ this.ruleForm.huiyuankamingcheng,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          if(data.data.huiyuankaleixing){
            this.ruleForm.huiyuankaleixing = data.data.huiyuankaleixing
          }
          if(data.data.huiyuankajiage){
            this.ruleForm.huiyuankajiage = data.data.huiyuankajiage
          }
          if(data.data.youxiaoshijian){
            this.ruleForm.youxiaoshijian = data.data.youxiaoshijian
          }
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    info(id) {
      this.$http({
        url: `huiyuanka/info/${id}`,
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
            url: `huiyuanka/${!this.ruleForm.id ? "save" : "update"}`,
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
                  this.parent.huiyuankaCrossAddOrUpdateFlag = false;
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
      this.parent.huiyuankaCrossAddOrUpdateFlag = false;
    },
  }
};
</script>

<style lang="scss" scoped>
.card-page {
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

::v-deep .el-select .el-input__inner {
  border-radius: 10px;
}

::v-deep .el-input-group__append {
  border-radius: 0 10px 10px 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  border: none;
  font-weight: 500;
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
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
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
  box-shadow: 0 8px 25px rgba(17, 153, 142, 0.4);
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
  .card-page {
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
