<template>
  <div class="center-container">
    <!-- 顶部用户信息卡片 -->
    <div class="user-header" v-if="flag=='huiyuan' || flag=='yuangong'">
      <div class="user-avatar">
        <img v-if="ruleForm.touxiang && !avatarLoadError" :src="ruleForm.touxiang" alt="头像" @error="handleAvatarError">
        <div v-if="!ruleForm.touxiang || avatarLoadError" class="avatar-placeholder">
          <i class="el-icon-user-solid"></i>
        </div>
      </div>
      <div class="user-info">
        <h2 class="user-name">{{ flag=='huiyuan' ? ruleForm.huiyuanxingming : ruleForm.yuangongxingming }}</h2>
        <p class="user-account">{{ flag=='huiyuan' ? ruleForm.huiyuanzhanghao : ruleForm.gonghao }}</p>
        <div class="user-tags">
          <el-tag type="success" size="mini">{{ flag=='huiyuan' ? '会员' : '员工' }}</el-tag>
          <el-tag type="info" size="mini" v-if="ruleForm.xingbie">{{ ruleForm.xingbie }}</el-tag>
        </div>
      </div>
    </div>

    <!-- 快捷入口 -->
    <div class="quick-entry" v-if="flag=='huiyuan'">
      <div class="section-title">
        <i class="el-icon-star-on"></i> 快捷入口
      </div>
      <el-row :gutter="20" class="entry-cards">
        <el-col :span="6">
          <div class="entry-card" @click="goToXindefu">
            <div class="entry-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
              <i class="el-icon-edit-outline"></i>
            </div>
            <div class="entry-text">发布心得</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="entry-card" @click="goToXindefuList">
            <div class="entry-icon" style="background: linear-gradient(135deg, #67c23a 0%, #85ce61 100%);">
              <i class="el-icon-reading"></i>
            </div>
            <div class="entry-text">浏览心得</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="entry-card" @click="goToMyXindefu">
            <div class="entry-icon" style="background: linear-gradient(135deg, #e6a23c 0%, #ebb563 100%);">
              <i class="el-icon-user"></i>
            </div>
            <div class="entry-text">我的心得</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="entry-card" @click="$router.push('/gymmap')">
            <div class="entry-icon" style="background: linear-gradient(135deg, #409eff 0%, #66b1ff 100%);">
              <i class="el-icon-location"></i>
            </div>
            <div class="entry-text">附近健身房</div>
          </div>
        </el-col>
      </el-row>
    </div>

    <!-- 健身记录上传 -->
    <div class="record-section" v-if="flag=='huiyuan'">
      <div class="section-title">
        <i class="el-icon-data-analysis"></i> 健身记录上传
      </div>
      <el-card class="record-card">
        <el-form ref="jianshenForm" :model="jianshenForm" label-width="100px">
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="健身时长">
                <el-input v-model="jianshenForm.jianshenshizhang" placeholder="如：1小时">
                  <template slot="append"><i class="el-icon-time"></i></template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="健身项目">
                <el-input v-model="jianshenForm.jianshenxiangmu" placeholder="如：跑步、游泳">
                  <template slot="append"><i class="el-icon-sport"></i></template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="健身器材">
                <el-input v-model="jianshenForm.jianshenqicai" placeholder="如：跑步机、哑铃">
                  <template slot="append"><i class="el-icon-box"></i></template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="体重">
                <el-input v-model="jianshenForm.tizhong" placeholder="如：70kg">
                  <template slot="append">kg</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="心率">
                <el-input v-model="jianshenForm.xinlv" placeholder="如：80次/分">
                  <template slot="append">次/分</template>
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="时间">
                <el-date-picker v-model="jianshenForm.shijian" type="date" placeholder="选择日期" value-format="yyyy-MM-dd" style="width: 100%;"></el-date-picker>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="备注">
                <el-input type="textarea" v-model="jianshenForm.beizhu" placeholder="备注内容" :rows="3"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item>
                <el-button type="primary" icon="el-icon-upload2" @click="submitJianshenRecord" class="submit-btn">上传健身记录</el-button>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </el-card>
    </div>

    <!-- 个人信息编辑 -->
    <div class="profile-section">
      <div class="section-title">
        <i class="el-icon-user"></i> 个人信息
      </div>
      <el-card class="profile-card">
        <el-form ref="ruleForm" :model="ruleForm" label-width="100px">
          <!-- 会员信息 -->
          <template v-if="flag=='huiyuan'">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="会员账号">
                  <el-input v-model="ruleForm.huiyuanzhanghao" readonly>
                    <i slot="prefix" class="el-icon-user"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="会员姓名">
                  <el-input v-model="ruleForm.huiyuanxingming" placeholder="请输入姓名">
                    <i slot="prefix" class="el-icon-edit"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="身份证">
                  <el-input v-model="ruleForm.shenfenzheng" placeholder="请输入身份证">
                    <i slot="prefix" class="el-icon-postcard"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="性别">
                  <el-select v-model="ruleForm.xingbie" placeholder="请选择性别" style="width: 100%;">
                    <el-option label="男" value="男"></el-option>
                    <el-option label="女" value="女"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="手机">
                  <el-input v-model="ruleForm.shouji" placeholder="请输入手机号">
                    <i slot="prefix" class="el-icon-phone"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="头像">
                  <file-upload tip="点击上传头像" action="file/upload" :limit="3" :multiple="true" :fileUrls="ruleForm.touxiang?ruleForm.touxiang:''" @change="huiyuantouxiangUploadChange"></file-upload>
                </el-form-item>
              </el-col>
            </el-row>
          </template>

          <!-- 员工信息 -->
          <template v-if="flag=='yuangong'">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="工号">
                  <el-input v-model="ruleForm.gonghao" readonly>
                    <i slot="prefix" class="el-icon-tickets"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="员工姓名">
                  <el-input v-model="ruleForm.yuangongxingming" placeholder="请输入姓名">
                    <i slot="prefix" class="el-icon-edit"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="性别">
                  <el-select v-model="ruleForm.xingbie" placeholder="请选择性别" style="width: 100%;">
                    <el-option label="男" value="男"></el-option>
                    <el-option label="女" value="女"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="手机">
                  <el-input v-model="ruleForm.shouji" placeholder="请输入手机号">
                    <i slot="prefix" class="el-icon-phone"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="邮箱">
                  <el-input v-model="ruleForm.youxiang" placeholder="请输入邮箱">
                    <i slot="prefix" class="el-icon-message"></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="头像">
                  <file-upload tip="点击上传头像" action="file/upload" :limit="3" :multiple="true" :fileUrls="ruleForm.touxiang?ruleForm.touxiang:''" @change="yuangongtouxiangUploadChange"></file-upload>
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="教练资质">
                  <div class="cert-upload-area">
                    <el-upload
                      ref="certUpload"
                      action
                      :http-request="uploadCertFile"
                      :before-upload="beforeCertUpload"
                      :file-list="certFileList"
                      :on-remove="handleCertRemove"
                      :limit="3"
                      :on-exceed="handleCertExceed"
                      accept=".pdf,.jpg,.jpeg,.png"
                    >
                      <el-button size="small" type="primary" icon="el-icon-upload2">选择文件</el-button>
                      <div slot="tip" class="el-upload__tip">
                        支持 PDF、JPG、PNG 格式，单文件不超过 5MB，最多上传 3 个文件
                      </div>
                    </el-upload>
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
          </template>

          <!-- 管理员信息 -->
          <template v-if="flag=='users'">
            <el-form-item label="用户名">
              <el-input v-model="ruleForm.username" placeholder="用户名">
                <i slot="prefix" class="el-icon-user"></i>
              </el-input>
            </el-form-item>
          </template>

          <el-row>
            <el-col :span="24">
              <el-form-item>
                <el-button type="primary" icon="el-icon-check" @click="onUpdateHandler" class="save-btn">保存修改</el-button>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </el-card>
    </div>
  </div>
</template>

<script>
import { isNumber,isIntNumer,isEmail,isMobile,isPhone,isURL,checkIdCard } from "@/utils/validate";

export default {
  data() {
    return {
      ruleForm: {},
      flag: '',
      usersFlag: false,
      huiyuanxingbieOptions: [],
      yuangongxingbieOptions: [],
      certFileList: [],
      avatarLoadError: false,
      jianshenForm: {
        jianshenshizhang: '',
        jianshenxiangmu: '',
        jianshenqicai: '',
        tizhong: '',
        xinlv: '',
        beizhu: '',
        shijian: ''
      }
    };
  },
  mounted() {
    var table = this.$storage.get("sessionTable");
    this.flag = table;
    this.$http({
      url: `${this.$storage.get("sessionTable")}/session`,
      method: "get"
    }).then(({ data }) => {
      if (data && data.code === 0) {
        this.ruleForm = data.data;
        if (this.flag === 'yuangong' && this.ruleForm.jiaolianzizhi) {
          this.initCertFileList(this.ruleForm.jiaolianzizhi);
        }
      } else {
        this.$message.error(data.msg);
      }
    });
    this.huiyuanxingbieOptions = "男,女".split(',')
    this.yuangongxingbieOptions = "男,女".split(',')
  },
  methods: {
    huiyuantouxiangUploadChange(fileUrls) {
        this.ruleForm.touxiang = fileUrls;
    },
    yuangongtouxiangUploadChange(fileUrls) {
        this.ruleForm.touxiang = fileUrls;
    },
    handleAvatarError() {
      this.avatarLoadError = true;
    },
    beforeCertUpload(file) {
      const allowedExtensions = ['.pdf', '.jpg', '.jpeg', '.png'];
      const fileName = file.name.toLowerCase();
      const ext = fileName.substring(fileName.lastIndexOf('.'));
      const maxSize = 5 * 1024 * 1024;

      if (!allowedExtensions.includes(ext)) {
        this.$message.error('仅支持 PDF、JPG、PNG 格式的文件');
        return false;
      }
      if (file.size > maxSize) {
        this.$message.error('文件大小不能超过 5MB');
        return false;
      }
      return true;
    },
    uploadCertFile(param) {
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
          let fileUrl = this.$base.url + "upload/" + data.file;
          this.certFileList.push({ name: file.name, url: fileUrl });
          this.syncCertUrls();
          this.$message.success('资质文件上传成功');
        } else {
          this.$message.error(data.msg || '上传失败');
        }
      });
    },
    handleCertRemove(file, fileList) {
      this.certFileList = fileList;
      this.syncCertUrls();
    },
    handleCertExceed() {
      this.$message.warning('最多上传 3 个资质文件');
    },
    syncCertUrls() {
      this.ruleForm.jiaolianzizhi = this.certFileList.map(f => f.url).join(',');
    },
    initCertFileList(urls) {
      if (!urls) return;
      this.certFileList = urls.split(',').filter(url => url.trim()).map((url, index) => ({
        name: '资质文件' + (index + 1),
        url: url.trim()
      }));
    },
    onUpdateHandler() {
      if((!this.ruleForm.huiyuanzhanghao)&& 'huiyuan'==this.flag){
        this.$message.error('会员账号不能为空');
        return
      }
      if((!this.ruleForm.mima)&& 'huiyuan'==this.flag){
        this.$message.error('密码不能为空');
        return
      }
      if( 'huiyuan' ==this.flag && this.ruleForm.shenfenzheng&&(!checkIdCard(this.ruleForm.shenfenzheng))){
        this.$message.error(`身份证应输入身份证格式`);
        return
      }
      if( 'huiyuan' ==this.flag && this.ruleForm.shouji&&(!isMobile(this.ruleForm.shouji))){
        this.$message.error(`手机应输入手机格式`);
        return
      }
      if((!this.ruleForm.gonghao)&& 'yuangong'==this.flag){
        this.$message.error('工号不能为空');
        return
      }
      if((!this.ruleForm.mima)&& 'yuangong'==this.flag){
        this.$message.error('密码不能为空');
        return
      }
      if((!this.ruleForm.yuangongxingming)&& 'yuangong'==this.flag){
        this.$message.error('员工姓名不能为空');
        return
      }
      if( 'yuangong' ==this.flag && this.ruleForm.shouji&&(!isMobile(this.ruleForm.shouji))){
        this.$message.error(`手机应输入手机格式`);
        return
      }
      if( 'yuangong' ==this.flag && this.ruleForm.youxiang&&(!isEmail(this.ruleForm.youxiang))){
        this.$message.error(`邮箱应输入邮箱格式`);
        return
      }
      if('users'==this.flag && this.ruleForm.username.trim().length<1) {
        this.$message.error(`用户名不能为空`);
        return 
      }
      this.$http({
        url: `${this.$storage.get("sessionTable")}/update`,
        method: "post",
        data: this.ruleForm
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: "修改信息成功",
            type: "success",
            duration: 1500,
          });
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    submitJianshenRecord() {
      if(!this.jianshenForm.jianshenshizhang) {
        this.$message.error('健身时长不能为空');
        return;
      }
      if(!this.jianshenForm.jianshenxiangmu) {
        this.$message.error('健身项目不能为空');
        return;
      }
      if(!this.jianshenForm.shijian) {
        this.$message.error('时间不能为空');
        return;
      }
      this.$http({
        url: 'huiyuan/session',
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          const huiyuan = data.data;
          this.jianshenForm.huiyuanzhanghao = huiyuan.huiyuanzhanghao;
          this.jianshenForm.huiyuanxingming = huiyuan.huiyuanxingming;
          this.jianshenForm.shouji = huiyuan.shouji;
          
          this.$http({
            url: 'jianshenhuodong/save',
            method: "post",
            data: this.jianshenForm
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "健身记录上传成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  this.jianshenForm = {
                    jianshenshizhang: '',
                    jianshenxiangmu: '',
                    jianshenqicai: '',
                    tizhong: '',
                    xinlv: '',
                    beizhu: '',
                    shijian: ''
                  };
                }
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    goToXindefu() {
      this.$router.push('/xindefu/add-or-update');
    },
    goToXindefuList() {
      this.$router.push('/xindefu/list');
    },
    goToMyXindefu() {
      this.$router.push('/xindefu/myList');
    }
  }
};
</script>

<style lang="scss" scoped>
.center-container {
  padding: 20px;
  min-height: calc(100vh - 100px);
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ec 100%);
}

.user-header {
  display: flex;
  align-items: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16px;
  padding: 30px;
  margin-bottom: 24px;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
  
  .user-avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    overflow: hidden;
    border: 4px solid rgba(255, 255, 255, 0.5);
    flex-shrink: 0;
    
    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    .avatar-placeholder {
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.2);
      display: flex;
      align-items: center;
      justify-content: center;
      
      i {
        font-size: 50px;
        color: rgba(255, 255, 255, 0.8);
      }
    }
  }
  
  .user-info {
    margin-left: 24px;
    color: #fff;
    
    .user-name {
      font-size: 28px;
      font-weight: 600;
      margin: 0 0 8px 0;
    }
    
    .user-account {
      font-size: 14px;
      opacity: 0.9;
      margin: 0 0 12px 0;
    }
    
    .user-tags {
      .el-tag {
        margin-right: 8px;
      }
    }
  }
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
  margin-bottom: 16px;
  padding-left: 12px;
  border-left: 4px solid #667eea;
  display: flex;
  align-items: center;
  
  i {
    margin-right: 8px;
    color: #667eea;
  }
}

.quick-entry {
  margin-bottom: 24px;
  
  .entry-cards {
    .entry-card {
      background: #fff;
      border-radius: 12px;
      padding: 24px 16px;
      text-align: center;
      cursor: pointer;
      transition: all 0.3s ease;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
      
      &:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 24px rgba(102, 126, 234, 0.2);
      }
      
      .entry-icon {
        width: 56px;
        height: 56px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 12px;
        
        i {
          font-size: 24px;
          color: #fff;
        }
      }
      
      .entry-text {
        font-size: 14px;
        color: #666;
        font-weight: 500;
      }
    }
  }
}

.record-section, .profile-section {
  margin-bottom: 24px;
  
  .el-card {
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    border: none;
  }
}

.submit-btn, .save-btn {
  width: 200px;
  height: 44px;
  border-radius: 22px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  font-size: 16px;
  
  &:hover {
    opacity: 0.9;
  }
}

.submit-btn {
  width: 160px;
}
.cert-upload-area {
  width: 100%;
}

::v-deep .el-input__inner {
  border-radius: 8px;
}

::v-deep .el-textarea__inner {
  border-radius: 8px;
}

::v-deep .el-select {
  width: 100%;
}
</style>
