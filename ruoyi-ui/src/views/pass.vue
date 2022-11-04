<template>
  <div class="main">
    <!-- <div style="display: flex; justify-content:center;"><img :src="logo" width="100" height="100"/></div> -->
    <div class="headline">EasySports补测资格审查</div>
    <el-row :gutter="10">
      <el-col :span="6">
        <button class="menu">错误反馈</button>
      </el-col>
      <el-col :span="6">
        <button class="menu">成绩查询</button>
      </el-col>
      <el-col :span="6">
        <button class="menu">关于我们</button>
      </el-col>
      <el-col :span="6">
        <button class="menu">加入我们</button>
      </el-col>
    </el-row>
    <el-row :gutter="10">
      <el-col :span="12">
        <div class="info">
          <el-descriptions class="margin-top" title="个人信息" :column="1" :size="'large'" border>
            <el-descriptions-item label-class-name="desc-item" content-class-name="desc-item">
              <template slot="label">
                <i class="el-icon-location-outline"></i>
                班级
              </template>
              <!-- {{ userInfo.dept }} -  -->
              {{ userInfo.classNum }}
            </el-descriptions-item>
            <el-descriptions-item  label-class-name="desc-item1" content-class-name="desc-item1">
              <template slot="label">
                <i class="el-icon-question"></i>
                性别
              </template>
              <el-tag size="small">{{ userInfo.sex == 0 ? '男' : userInfo.sex == 1 ? '女' : '未知' }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item  label-class-name="desc-item" content-class-name="desc-item">
              <template slot="label">
                <i class="el-icon-info"></i>
                学号
              </template>
              {{ userInfo.userId }}
            </el-descriptions-item>
            <el-descriptions-item label-class-name="desc-item1" content-class-name="desc-item1">
              <template slot="label">
                <i class="el-icon-user"></i>
                姓名
              </template>
              {{ userInfo.userName }}
            </el-descriptions-item>
          </el-descriptions>
        </div>
      </el-col>
      <el-col :span="12">
        <input type="text" placeholder="七位数学号" style="background-color: #F18962; padding-left: 1rem; margin-left: 1rem; width: 60%; height: 40px; border: 0; border-radius: 20px;">
        <el-button class="menu" icon="el-icon-search" circle></el-button>
        <!-- <button><i class="el-icon-search"></i></button> -->
        <div class="info">
          <img src="https://api.qrserver.com/v1/create-qr-code/?size=500%C3%97500&data=0200932" width="100%" height="100%">
        </div>
      </el-col>
    </el-row>

    <el-dialog title="请先设置学号绑定设备" :visible.sync="dialogVisible" width="90%">

      <el-form :rules="rules" ref="ruleForm">
        <el-form-item label="请输入学号" prop="userId">
          <el-input v-model="userId"></el-input>
        </el-form-item>
      </el-form>
      <!--      <el-input v-model="userId">请输入学号</el-input>-->
      <span slot="footer" class="dialog-footer">
        <!--        <el-button @click="dialogVisible = false">取 消</el-button>-->
        <el-button type="primary" @click="setUserId">确 定</el-button>
      </span>
    </el-dialog>
    <div class="records">
      <el-divider>成绩记录</el-divider>
      <div v-for="(item, index) in scores" :key="index">
        <el-card class="box-card">
          <el-descriptions :title="item.activityName" :column="1" border>
            <el-descriptions-item label="身高CM" label-class-name="my-label" content-class-name="my-content">
              {{ item.height }}
            </el-descriptions-item>
            <el-descriptions-item label="体重KG">{{ item.weight }}</el-descriptions-item>
            <el-descriptions-item label="肺活量">
              <el-tag :type="item.vitalCapacityPass ? 'success' : 'danger'">{{
                  item.vitalCapacityPass ? '合格' : '不合格'
              }}
              </el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="立定跳">
              <el-tag :type="item.longJumpPass ? 'success' : 'danger'">{{ item.longJumpPass ? '合格' : '不合格' }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="坐位体前屈">
              <el-tag :type="item.sittingBodyBendPass ? 'success' : 'danger'">{{
                  item.sittingBodyBendPass ? '合格' : '不合格'
              }}
              </el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="50米">
              <el-tag :type="item.fiftyRunPass ? 'success' : 'danger'">{{ item.fiftyRunPass ? '合格' : '不合格' }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="耐力跑">
              <el-tag :type="item.enduranceRunningPass ? 'success' : 'danger'">
                {{ item.enduranceRunningPass ? '合格' : '不合格' }}
              </el-tag>
            </el-descriptions-item>
          </el-descriptions>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
import logoImg from '@/assets/logo/logo.png'
import { queryPass } from "@/api/system/grade";
import { getData } from "@/api/system/dict/data";
import userInfo from "@/views/system/user/profile/userInfo";

export default {
  name: "pass.vue",
  data() {
    return {
      logo: logoImg,
      userInfo: {},
      scores: [],
      userId: '',
      dialogVisible: false,
      rules: {
        userId: [
          { required: true, message: '请输入7位数学号', trigger: 'blur' },
          { min: 7, max: 7, message: '请输入7位数学号', trigger: 'blur' }
        ],
      }
    }
  },
  mounted() {
    const userId = localStorage.getItem('userId');
    if (!userId) {
      this.dialogVisible = true;
      this.$message.info("请先绑定学号");
    } else {
      this.getData(userId);
    }
  },
  methods: {
    setUserId() {
      if (/[054]\d{6}/.test(this.userId)) {
        this.getData(this.userId);
        this.dialogVisible = false;
      } else {
        this.$message.error("学号位数或格式错误")
      }
    },
    getData(userId) {
      localStorage.setItem('userId', userId);
      queryPass(userId).then(res => {
        if (res.code === 200) {
          this.$message.success(res.msg);
          this.userInfo = res.data.userInfo;
          this.scores = res.data.scores;
          if (this.scores.length === 0) {
            localStorage.removeItem('userId');
          }
        } else {
          this.$message.error(res.msg);
          localStorage.removeItem('userId');
        }
        console.log(res.data);
      })
    },
    handleClose(done) {
      this.$confirm('确认关闭？')
        .then(_ => {
          done();
        })
        .catch(_ => { });
    }
  }
}
</script>

<!-- <style scoped> -->
<style>

.desc-item1 {
  background: #F18962;
}
.desc-item {
  background: #F1B59B;
}
.el-row {
  margin-top: 1rem;
}
.menu {
  font-weight: 800;
  border-radius: 20px;
  /* outline: none; */
  padding: 10px;
  background-color: #F18962;
  border: 0;
  margin: 0.3rem;
}

.records {
  padding: 1rem;
}

.main {
  /*background-image: url("https://img.dowebok.com/9560.jpg");*/
  width: 100%;
  /*opacity:0.4;*/
  height: 100%;
  background-color: #F8EDEB;
}

.info {
  border-radius: 10px;
  padding: 0.5rem;
  border: 5px solid #F18962;
  margin: 0.5rem;
}

el-row {
  margin: 1rem;
}

.menu-item {
  display: flex;
  justify-content: center;
}

/* CDN 服务仅供平台体验和调试使用，平台不承诺服务的稳定性，企业客户需下载字体包自行发布使用并做好备份。 */
.headline {
  margin: 1rem;
  font-family: headLine;
  text-align: center;
  font-size: 20px;

}

@font-face {
  font-family: "headLine";
  font-weight: 400;
  src: url("//at.alicdn.com/wf/webfont/xzgZre3sndSn/wq76e_3J9jZVmxkSFKmjG.woff2") format("woff2"),
    url("//at.alicdn.com/wf/webfont/xzgZre3sndSn/tKI7IpX54pdGDZV_VnuvV.woff") format("woff");
  font-display: swap;
}
</style>
