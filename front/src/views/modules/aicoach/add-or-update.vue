<template>
  <div class="addEdit-block">
    <el-form
      class="detail-form-content"
      ref="ruleForm"
      :model="ruleForm"
      :rules="rules"
      label-width="80px"
    >
      <el-row>
        <el-col :span="24">
          <el-form-item class="input" label="问题" prop="question">
            <el-input v-model="ruleForm.question" placeholder="问题" clearable></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item class="textarea" label="答案" prop="answer">
            <el-input v-model="ruleForm.answer" type="textarea" :rows="8" placeholder="答案" clearable></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item class="input" label="分类" prop="category">
            <el-input v-model="ruleForm.category" placeholder="分类，如：入门指南、饮食营养、运动健身" clearable></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item class="input" label="排序" prop="sort">
            <el-input-number v-model="ruleForm.sort" :min="0" placeholder="排序"></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="24">
          <el-form-item class="textarea" label="关键词" prop="keywords">
            <el-input v-model="ruleForm.keywords" type="textarea" :rows="3" placeholder="关键词，多个用逗号分隔，如：健身,新手,开始" clearable></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item class="btn">
        <el-button v-if="type!='info'" type="primary" @click="onSubmit()">提交</el-button>
        <el-button v-if="type!='info'" @click="resetForm()">重置</el-button>
        <el-button v-if="type=='info'" @click="goBack()">返回</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: "",
      type: "",
      ro: {
        question: false,
        answer: false,
        category: false,
        keywords: false,
        sort: false
      },
      ruleForm: {
        question: "",
        answer: "",
        category: "",
        keywords: "",
        sort: 0
      },
      rules: {
        question: [{ required: true, message: "请输入问题", trigger: "blur" }],
        answer: [{ required: true, message: "请输入答案", trigger: "blur" }]
      }
    };
  },
  mounted() {
    let id = this.$route.query.id;
    this.init(id);
  },
  methods: {
    init(id) {
      if (id) {
        this.id = id;
        this.type = "info";
        this.$http({
          url: `aicoach/knowledge/info/${id}`,
          method: "get"
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.ruleForm = data.data;
          }
        });
      } else {
        this.type = "add";
      }
    },
    onSubmit() {
      this.$refs.ruleForm.validate(valid => {
        if (valid) {
          this.$http({
            url: `aicoach/knowledge/${this.ruleForm.id ? "update" : "save"}`,
            method: "post",
            data: this.ruleForm
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message.success("操作成功");
              this.$router.go(-1);
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    resetForm() {
      this.ruleForm = {
        question: "",
        answer: "",
        category: "",
        keywords: "",
        sort: 0
      };
    },
    goBack() {
      this.$router.go(-1);
    }
  }
};
</script>

<style scoped>
.addEdit-block {
  padding: 20px;
}
.btn {
  text-align: center;
  margin-top: 20px;
}
</style>
