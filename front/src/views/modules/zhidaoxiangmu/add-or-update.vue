<template>
  <div class="add-or-update">
    <!-- 页面头部 -->
    <div class="form-header">
      <div class="header-icon">
        <i class="el-icon-guide"></i>
      </div>
      <div class="header-info">
        <h3>{{ type === 'info' ? '指导详情' : (ruleForm.id ? '编辑指导' : '新增指导') }}</h3>
        <p>{{ type === 'info' ? '查看指导详细信息' : (ruleForm.id ? '修改指导信息' : '创建新的项目指导') }}</p>
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
            <el-form-item class="input" label="项目编号" prop="xiangmubianhao">
              <el-input v-model="ruleForm.xiangmubianhao" placeholder="系统自动生成" readonly class="readonly-input">
                <template slot="prefix"><i class="el-icon-key"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item class="input" label="项目名称" prop="xiangmumingcheng">
              <el-input v-model="ruleForm.xiangmumingcheng" placeholder="请输入项目名称" clearable :readonly="ro.xiangmumingcheng">
                <template slot="prefix"><i class="el-icon-sport"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>
        
        <div class="form-section-title">
          <i class="el-icon-s-grid"></i>
          <span>项目信息</span>
        </div>
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item class="input" label="项目类型" prop="xiangmuleixing">
              <el-input v-model="ruleForm.xiangmuleixing" placeholder="请输入项目类型" clearable :readonly="ro.xiangmuleixing">
                <template slot="prefix"><i class="el-icon-menu"></i></template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item class="input" label="项目价格" prop="xiangmujiage">
              <el-input v-model="ruleForm.xiangmujiage" placeholder="请输入项目价格" clearable :readonly="ro.xiangmujiage">
                <template slot="prefix"><i class="el-icon-money"></i></template>
                <template slot="append">元</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item class="input" label="课时数" prop="keshishu">
              <el-input v-model="ruleForm.keshishu" placeholder="请输入课时数" clearable :readonly="ro.keshishu">
                <template slot="prefix"><i class="el-icon-collection-tag"></i></template>
                <template slot="append">节</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item class="select" label="指导教练" prop="zhidaojiaolian">
              <el-select v-model="ruleForm.zhidaojiaolian" placeholder="请选择指导教练" clearable>
                <el-option
                  v-for="(item,index) in zhidaojiaolianOptions"
                  :key="index"
                  :label="item"
                  :value="item">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <div class="form-section-title">
          <i class="el-icon-document"></i>
          <span>详细说明</span>
        </div>
        <el-row>
          <el-col :span="24">
            <el-form-item class="textarea" label="收费标准" prop="shoufeibiaozhun">
              <el-input
                type="textarea"
                :rows="4"
                placeholder="请输入收费标准"
                v-model="ruleForm.shoufeibiaozhun"
                :readonly="ro.shoufeibiaozhun"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item class="textarea" label="指导项目" prop="zhidaoxiangmu">
              <el-input
                type="textarea"
                :rows="4"
                placeholder="请输入指导项目内容"
                v-model="ruleForm.zhidaoxiangmu"
                :readonly="ro.zhidaoxiangmu"
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
        xiangmubianhao: true,
        xiangmumingcheng: true,
        xiangmuleixing: true,
        xiangmujiage: true,
        shoufeibiaozhun: true,
        keshishu: true,
        zhidaoxiangmu: false,
        zhidaojiaolian: false,
      },
      ruleForm: {
        xiangmubianhao: '',
        xiangmumingcheng: '',
        xiangmuleixing: '',
        xiangmujiage: '',
        shoufeibiaozhun: '',
        keshishu: '',
        zhidaoxiangmu: '',
        zhidaojiaolian: '',
      },
      zhidaojiaolianOptions: [],
      rules: {
        xiangmujiage: [
          { validator: (rule, value, callback) => {
            if(!value) { callback(); }
            else if (!/^\d+$/.test(value)) { callback(new Error("请输入整数")); }
            else { callback(); }
          }, trigger: 'blur' },
        ],
        keshishu: [
          { validator: (rule, value, callback) => {
            if(!value) { callback(); }
            else if (!/^\d+$/.test(value)) { callback(new Error("请输入整数")); }
            else { callback(); }
          }, trigger: 'blur' },
        ],
      }
    };
  },
  props: ["parent"],
  created() {
    this.getUUID = () => new Date().getTime().toString();
    // 获取当前登录员工姓名并自动填充
    this.$http({
      url: "yuangong/session",
      method: "get"
    }).then(({ data }) => {
      if (data && data.code === 0) {
        this.ruleForm.zhidaojiaolian = data.data.yuangongxingming || data.data.name || '';
      }
    });
  },
  methods: {
    init(id, type) {
      // 先设置 type，确保后续逻辑可以正确判断
      if (id) { this.id = id; }
      if (type) { this.type = type; }

      if (this.type == 'info' || this.type == 'else') { this.info(id); return; }

      // 从 localStorage 读取项目信息并自动填充
      const crossObj = this.$storage.getObj('crossObj');
      const crossTable = this.$storage.get('crossTable');
      if (crossObj && crossTable === 'jianshenxiangmu') {
        this.ruleForm.xiangmubianhao = crossObj.xiangmubianhao || '';
        this.ruleForm.xiangmumingcheng = crossObj.xiangmumingcheng || '';
        this.ruleForm.xiangmuleixing = crossObj.xiangmuleixing || '';
        this.ruleForm.xiangmujiage = crossObj.xiangmujiage || '';
        this.ruleForm.keshishu = crossObj.keshishu || '';
        this.ruleForm.shoufeibiaozhun = crossObj.shoufeibiaozhun || '';
        // 清除 localStorage
        this.$storage.remove('crossObj');
        this.$storage.remove('crossTable');
      }
    },
    info(id) {
      this.$http({ url: `zhidaoxiangmu/info/${id}`, method: "get" }).then(({ data }) => {
        if (data && data.code === 0) {
          this.ruleForm = data.data;
        }
      });
    },
    onSubmit() {
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          if (!this.ruleForm.xiangmubianhao) {
            this.ruleForm.xiangmubianhao = this.getUUID();
          }
          this.$http({ url: `zhidaoxiangmu/${!this.ruleForm.id ? "save" : "update"}`, method: "post", data: this.ruleForm }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({ message: "操作成功", type: "success", duration: 1500, onClose: () => {
                this.parent.showFlag = true;
                this.parent.addOrUpdateFlag = false;
                this.parent.zhidaoxiangmuCrossAddOrUpdateFlag = false;
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
      this.parent.zhidaoxiangmuCrossAddOrUpdateFlag = false;
    }
  },
  mounted() {
    this.$http({ url: `option/yuangong/yuangongxingming`, method: "get" }).then(({ data }) => {
      if (data && data.code === 0) {
        this.zhidaojiaolianOptions = data.data;
      }
    });
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

.el-input >>> .el-input-group__append {
  border-radius: 0 10px 10px 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  border-color: #667eea;
}

.readonly-input >>> .el-input__inner {
  background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
  color: #909399;
}

/* 下拉框样式 */
.el-select >>> .el-input__inner:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.el-select >>> .el-select-dropdown__item.selected {
  color: #667eea;
  font-weight: 600;
}

.el-select-dropdown__item.hover,
.el-select-dropdown__item:hover {
  background-color: #f8f9ff;
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
