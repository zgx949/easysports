<template>
  <div class="main">
    <div class="headline">EasySports补测审查</div>
    <el-row :gutter="10">
      <el-col :span="6">

        <el-button class="menu" @click="turnTo(feedbackUrl)">
          <svg class="icon" aria-hidden="true">
            <use xlink:href="#icon-fankui"></use>
          </svg>
          <div>错误反馈</div>
        </el-button>
      </el-col>
      <el-col :span="6">
        <el-button class="menu" @click="toQyeryScore">
          <svg class="icon" aria-hidden="true">
            <use xlink:href="#icon-chengji"></use>
          </svg>
          <div>成绩查询</div>
        </el-button>
      </el-col>
      <el-col :span="6">
        <el-button class="menu" @click="about">
          <svg class="icon" aria-hidden="true">
            <use xlink:href="#icon-guanyu1"></use>
          </svg>
          <div>关于我们</div>
        </el-button>
      </el-col>
      <el-col :span="6" @click="about">
        <el-button class="menu">
          <svg class="icon" aria-hidden="true">
            <use xlink:href="#icon-yaoqingjiaru"></use>
          </svg>
          <div>加入我们</div>
        </el-button>
      </el-col>
    </el-row>
    <el-row :gutter="10">
      <el-col :span="12">
        <div class="info">
          <el-descriptions class="margin-top" title="个人信息" :column="1" :size="'large'" border>
            <el-descriptions-item label-class-name="desc-item" content-class-name="desc-item">
              <template slot="label">
                <!-- <i class="el-icon-location-outline"></i> -->
                班级
              </template>
              <!-- {{ userInfo.dept }} -  -->
              {{ userInfo.classNum }}
            </el-descriptions-item>
            <el-descriptions-item label-class-name="desc-item1" content-class-name="desc-item1">
              <template slot="label">
                <!-- <i class="el-icon-question"></i> -->
                性别
              </template>
              <el-tag size="small">{{ userInfo.sex == 0 ? '男' : userInfo.sex == 1 ? '女' : '未知' }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label-class-name="desc-item" content-class-name="desc-item">
              <template slot="label">
                <!-- <i class="el-icon-info"></i> -->
                学号
              </template>
              {{ userInfo.userId }}
            </el-descriptions-item>
            <el-descriptions-item label-class-name="desc-item1" content-class-name="desc-item1">
              <template slot="label">
                <!-- <i class="el-icon-user"></i> -->
                姓名
              </template>
              {{ userInfo.userName }}
            </el-descriptions-item>
          </el-descriptions>
        </div>
      </el-col>
      <el-col :span="12">
        <input type="text" 
          placeholder="七位数学号"
          v-model="userId"
          style="background-color: #F18962; padding-left: 1rem; margin-left: 1rem; width: 60%; height: 40px; border: 0; border-radius: 20px;" />
        <el-button class="menu" icon="el-icon-search" circle @click="getData(userId)"></el-button>
        <div class="info">
          <div style="text-align: center; margin: 3px; font-family: headLine;font-size: 20px;">补测码: </div>
          <div style="text-align: center; margin: 3px; font-family: headLine;font-size: 20px;">{{ userInfo.userName }}</div>
          <img :src="`https://api.qrserver.com/v1/create-qr-code/?size=500%C3%97500&data=${userId.length == 7 ? userId : '无权补测' }`" width="100%"
            height="100%">
        </div>
      </el-col>
    </el-row>

    <el-dialog title="关于" :visible.sync="dialogVisible" width="90%">
      <el-card>
        系统介绍:<p>EasySports是由江西财经大学体育学院自主研发的高校体育综合服务平台，具体应用服务范围包括：</p>
        <ul><el-tag type="success">运动会</el-tag>：移动端报名、自动编排系统、成绩管理、晋级及成绩单打印等</ul>
        <ul><el-tag type="success">体测</el-tag>：移动端实时成绩录入、成绩异常检测、数据健康检测等</ul>
        <ul><el-tag type="success">AI运动</el-tag>：体育网课、跑步记录、锻炼记录、AI纠正、AI动作计数等</ul>
        <ul><el-tag type="success">场馆比赛</el-tag>：场馆预约、场馆管理、比赛发布、比赛报名、精彩锦集自动采集</ul>
      </el-card>
      <el-card>
        团队成员：
        <ul><el-tag class="tag">郑国相(体育学院)</el-tag></ul>
        <ul><el-tag class="tag">金林涛(软件学院)</el-tag></ul>
        <ul><el-tag class="tag">胡友(软件学院)</el-tag></ul>
        <ul><el-tag class="tag">罗世权(软件学院)</el-tag></ul>
        <ul><el-tag class="tag">王亦萱(艺术学院)</el-tag></ul>
        <ul><el-tag class="tag">张成涛(体育学院)</el-tag></ul>
        <p>架构设计：</p>
          <el-tag class="tag">郑国相</el-tag>
        <p>前端开发：</p>
          <el-tag class="tag">胡友</el-tag>
          <el-tag class="tag">郑国相</el-tag>
        <p>后端开发：</p>
          <el-tag class="tag">金林涛</el-tag>
          <el-tag class="tag">罗世权</el-tag>
          <el-tag class="tag">郑国相</el-tag>
        <p>UI设计：</p>
          <el-tag class="tag">王亦萱</el-tag>
        <p>软件测试：</p>
          <el-tag class="tag">张成涛</el-tag>
          <el-tag class="tag">金林涛</el-tag>
          <el-tag class="tag">罗世权</el-tag>
          <el-tag class="tag">胡友</el-tag>
          <el-tag class="tag">郑国相</el-tag>
      </el-card>
      
      
      <span slot="footer" class="dialog-footer">
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
            <el-descriptions-item label="附加项目">
              <el-tag :type="item.otherItemPass ? 'success' : 'danger'">
                {{ item.otherItemPass ? '合格' : '不合格' }}
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
      feedbackUrl: 'https://docs.qq.com/form/page/DT2xwS2FwQVZPa3hl?create_type=2&from_page=doc_list_new_form&templateId=25000&u=e23e78ac4a024268b3923b192ad87037#/fill-detail',
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
    turnTo(url) {
      window.open(url);
    },
    toQyeryScore() {
      this.$message.error("成绩查询暂未开放")
    },
    about() {
      this.dialogVisible = true;
    },
    setUserId() {
      // if (/[054]\d{6}/.test(this.userId)) {
      //   this.getData(this.userId);
      this.dialogVisible = false;
      // } else {
      //   this.$message.error("学号位数或格式错误")
      // }
    },
    getData(userId) {
      localStorage.setItem('userId', userId);
      queryPass(userId).then(res => {
        if (res.code === 200) {
          this.$message.success(res.msg);
          this.userInfo = res.data.userInfo;
          this.scores = res.data.scores;
          this.userId = userId;
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
.tag {
  margin: 3px;
}
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
  color: #000;
  font-weight: 800;
  border-radius: 20px;
  /* outline: none; */
  padding: 10px;
  background-color: #ecc5b7;
  border: 0;
  margin: 0.3rem;
}

.menu svg {
  font-size: 30px;
  width: 1em;
  height: 1em;
  vertical-align: -0.15em;
  fill: currentColor;
  overflow: hidden;
  margin: 0.5rem;
}

.records {
  padding: 1rem;
  background: #F8EDEB;
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
  margin: 0 1rem;
  font-family: headLine;
  text-align: center;
  font-size: 30px;
  font-weight: 800;

}

@font-face {
  font-family: "headLine";
  font-weight: 400;
  src: url("//at.alicdn.com/wf/webfont/xzgZre3sndSn/wq76e_3J9jZVmxkSFKmjG.woff2") format("woff2"),
    url("//at.alicdn.com/wf/webfont/xzgZre3sndSn/tKI7IpX54pdGDZV_VnuvV.woff") format("woff");
  font-display: swap;
}
</style>
