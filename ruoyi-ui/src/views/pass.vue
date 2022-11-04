<template>
  <div class="main">
    <div style="display: flex; justify-content:center;"><img :src="logo" width="100" height="100"/></div>
    <div class="headline">补测资格审查</div>
    <el-row :gutter="10">
      <el-col :span="6">
        <button>错误反馈</button>
      </el-col>
      <el-col :span="6">
        <button>成绩查询</button>
      </el-col>
      <el-col :span="6">
        <button>关于我们</button>
      </el-col>
      <el-col :span="6">
        <button>加入我们</button>
      </el-col>
    </el-row>
    <div class="info">
      <el-descriptions class="margin-top" title="个人信息" :column="2" :size="'large'" border>
        <template slot="extra">
          <el-button type="primary" size="small">补测码</el-button>
        </template>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-location-outline"></i>
            班级
          </template>
          {{ userInfo.dept }} - {{ userInfo.classNum }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-question"></i>
            性别
          </template>
          <el-tag size="small">{{ userInfo.sex == 0 ? '男' : userInfo.sex == 1 ? '女' : '未知'}}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-info"></i>
            学号
          </template>
          {{ userInfo.userId }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            姓名
          </template>
          {{ userInfo.userName }}
        </el-descriptions-item>


      </el-descriptions>
    </div>

    <div class="records">
      <el-divider>成绩记录</el-divider>
      <div v-for="(item, index) in scores" :key="index">
        <el-card class="box-card">
          <el-descriptions :title="item.activityName" :column="1" border>
            <el-descriptions-item label="身高CM" label-class-name="my-label" content-class-name="my-content">{{ item.height }}</el-descriptions-item>
            <el-descriptions-item label="体重KG">{{ item.weight }}</el-descriptions-item>
            <el-descriptions-item label="肺活量"><el-tag :type="item.vitalCapacityPass? 'success' : 'danger'">{{ item.vitalCapacityPass? '合格' : '不合格' }}</el-tag></el-descriptions-item>
            <el-descriptions-item label="立定跳"><el-tag :type="item.longJumpPass? 'success' : 'danger'">{{ item.longJumpPass? '合格' : '不合格' }}</el-tag></el-descriptions-item>
            <el-descriptions-item label="坐位体前屈"><el-tag :type="item.sittingBodyBendPass? 'success' : 'danger'">{{ item.sittingBodyBendPass? '合格' : '不合格' }}</el-tag></el-descriptions-item>
            <el-descriptions-item label="50米"><el-tag :type="item.fiftyRunPass? 'success' : 'danger'">{{ item.fiftyRunPass? '合格' : '不合格' }}</el-tag></el-descriptions-item>
            <el-descriptions-item label="耐力跑"><el-tag :type="item.enduranceRunningPass? 'success' : 'danger'">{{ item.enduranceRunningPass? '合格' : '不合格' }}</el-tag></el-descriptions-item>
          </el-descriptions>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
import logoImg from '@/assets/logo/logo.png'
import { queryPass } from "@/api/system/grade";

export default {
  name: "pass.vue",
  data() {
    return {
      logo: logoImg,
      userInfo: {},
      scores: [],
    }
  },
  mounted() {
    queryPass("0220465").then(res => {
      if (res.code === 200) {
        this.$message.success(res.msg);
        this.userInfo = res.data.userInfo;
        this.scores = res.data.scores
      } else {
        this.$message.error(res.msg);
      }
      console.log(res.data);
    })
  }
}
</script>

<style scoped>
.records {
  padding: 1rem;
}
.main {
  /*background-image: url("https://img.dowebok.com/9560.jpg");*/
  width: 100%;
  /*opacity:0.4;*/
  height: 100%;
}

.info {
  padding: 1rem;
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
  font-size: 30px;

}

@font-face {
  font-family: "headLine";
  font-weight: 400;
  src: url("//at.alicdn.com/wf/webfont/xzgZre3sndSn/wq76e_3J9jZVmxkSFKmjG.woff2") format("woff2"),
  url("//at.alicdn.com/wf/webfont/xzgZre3sndSn/tKI7IpX54pdGDZV_VnuvV.woff") format("woff");
  font-display: swap;
}
</style>
