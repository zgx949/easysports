<template>
  <div>
    <h1 style="text-align: center">肺活量成绩录入</h1>
    <el-row :gutter="15">
      <el-form
        ref="elForm"
        :model="formData"
        size="medium"
        label-width="100px"
        label-position="right"
      >
        <el-form-item label="体测活动" prop="actId">
          <el-col :span="22">
            <el-select
              v-model="formData.actId"
              placeholder="请选择活动"
              clearable
              :style="{ width: '100%' }"
            >
              <el-option
                v-for="item in actDict"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-col>
        </el-form-item>
        <el-form-item label="学号" prop="idcard">
          <el-col :span="16">
            <el-input
              v-model="formData.idcard"
              placeholder="请输入学号"
              clearable
              :style="{ width: '100%' }"
            >
            </el-input>
          </el-col>
          <el-col :span="4">
            <el-button
              type="primary"
              size="medium"
              @click="scanf"
            >
              扫码
            </el-button>
          </el-col>
        </el-form-item>
        <!-- <el-form-item label="成绩" prop="score">
          <el-col :span="12">
            <el-input
              v-model="formData.score"
              placeholder="请输入成绩"
              clearable
              :style="{ width: '100%' }"
            >
            </el-input>
          </el-col>
        </el-form-item> -->
        <el-form-item label="" prop="submit">
          <el-col :span="24">
            <el-button
              type="primary"
              icon="el-icon-search"
              size="medium"
              @click="addUser(formData.idcard)"
            >
              添加
            </el-button>
          </el-col>
        </el-form-item>
      </el-form>
    </el-row>
    <div v-for="(data, index) in userDatas" :key="index">
      <el-card class="box-card">
        <template #header>
          <div class="card-header">
            <span>{{ data.name }}</span>
            <el-button class="button" text @click="del(index)">删除</el-button>
          </div>
        </template>
        <div class="text item">学院：{{ data.insName }}</div>
        <div class="text item">学号：{{ data.idcard }}</div>
        <div class="text item">班级：{{ data.className }}</div>
        <div class="text item">
          成绩：
          <el-select v-model="data.score" placeholder="请选择" size="small" style="width: 35%">
            <el-option
              v-for="item in 80"
              :key="item + 10"
              :label="item + 10"
              :value="item + 10">
            </el-option>
          </el-select>00&nbsp; ML
          <!--          <el-input-->
          <!--            v-model="data.score"-->
          <!--            placeholder="请输入成绩"-->
          <!--          ></el-input>-->
        </div>
      </el-card>
    </div>
    <div style="margin-bottom: 5rem">
      <el-row :gutter="20" style="padding-top: 1rem">
        <el-col :offset="4" :span="10">
          <el-button type="primary" @click="submitForm">提交</el-button>
        </el-col>

        <el-col :span="10">
          <el-button @click="resetForm">重置</el-button>
        </el-col>
      </el-row>
    </div>
  </div>
</template>
<script>
import { selectSysUserListByNames, insertGradeList } from "@/api/system/grade";
import { getTesting } from "@/api/system/activity";
export default {
  components: {},
  data() {
    return {
      itemId: 46,
      // 体测活动字典
      actDict: [],
      cards: [],
      userDatas: [],
      formData: {
        idcard: undefined,
        idcards: undefined,
        scanf: undefined,
        score: undefined,
        submit: undefined,
        actId: undefined
      },
    };
  },
  computed: {
    /* 处理提交的表单数据 */
    subData() {
      let data = [];
      for (let i = 0; i < this.userDatas.length; i++) {
        const item = this.userDatas[i];
        data.push({
          userId: item.idcard,
          itemId: this.itemId,
          ftaId: this.formData.actId,
          score: item.score
        })
      }
      return data;
    }
  },
  watch: {
    userDatas() {
      localStorage.setItem("userDatas", JSON.stringify(this.userDatas));
      localStorage.setItem("cards", JSON.stringify(this.cards));
    }
  },
  created() {
    // $.getScript(
    //   "https://res.wx.qq.com/open/js/jweixin-1.2.0.js",
    //   function () {}
    // );
  },
  mounted() {
    getTesting({pageNum: 1, pageSize: 1000}).then(res => {
      let tempList = [];
      for (let i = 0; i < res.data.length; i++) {
        const item = res.data[i];
        tempList.push({
          label: item.name,
          value: item.id
        })
      }
      this.actDict = tempList;
      this.formData.actId = this.actDict[0].value;
    })
    this.cards = JSON.parse(localStorage.getItem("cards"));
    this.userDatas = JSON.parse(localStorage.getItem("userDatas"));
    if (!this.cards) this.cards = [];
    if (!this.userDatas) this.userDatas = [];
    // debugger
    var qr = this.getQueryString("qrresult"); //获取二维码的值
    if (qr) {
      this.formData.idcards = qr.split(',');
      this.addUsers(this.formData.idcards);
      // this.addUser();
    }
  },
  methods: {
    submitForm() {
      this.$refs["elForm"].validate((valid) => {
        if (!valid) return;
        // TODO 提交表单
        console.log(this.userDatas);
        insertGradeList(this.subData).then(res => {
          this.$message({
            message: res.msg,
            type: 'success'
          });
          if (res.msg.indexOf('成功') != -1) {
            this.resetForm();
          }
        });

      });
    },
    getQueryString(name) {
      var reg = new RegExp("\\b" + name + "=([^&]*)");
      var r = location.href.match(reg);
      if (r != null) return unescape(r[1]);
    },
    /** 添加多个用户 */
    addUsers(idcards) {
      let data = [];
      this.resetForm();
      for (let i = 0; i < idcards.length; i++) {
        // this.addUser(idcards[i]);
        data.push(idcards[i])
      }
      selectSysUserListByNames(data).then(res => {
        for (let i = 0; i < res.data.length; i++) {
          const item = res.data[i];
          if (this.cards.indexOf(item.userName) !== -1) {
            alert("用户已经添加过");
            continue;
          }
          this.userDatas.push({
            insName: item.dept.deptName,
            name: item.nickName,
            gender: item.sex,
            idcard: item.userName,
            className: item.dept.deptName,
            score: 0,
          });
          this.cards.push(item.userName);
        }

      })
    },
    /* 添加一个用户 */
    addUser(idcard) {
      if (!idcard) {
        alert("请输入学号");
        return;
      }
      // if (this.cards.indexOf(idcard) !== -1) {
      //   alert("用户已经添加过");
      //   return;
      // }
      selectSysUserListByNames([idcard]).then(res => {
        for (let i = 0; i < res.data.length; i++) {
          const item = res.data[i];
          if (this.cards.indexOf(item.userName) !== -1) {
            alert("用户已经添加过");
            continue;
          }
          this.userDatas.push({
            insName: item.dept.deptName,
            name: item.nickName,
            gender: item.sex,
            idcard: item.userName,
            className: item.dept.deptName,
            score: 0,
          });
          this.cards.push(item.userName);
        }
        localStorage.setItem("userDatas", JSON.stringify(this.userDatas));
        localStorage.setItem("cards", JSON.stringify(this.cards));
      })
      // this.cards.push(idcard);
      // console.log(idcard);

      // this.userDatas.push({
      //   insName: "XX",
      //   name: "",
      //   gender: "",
      //   idcard: idcard,
      //   className: "",
      //   score: 0,
      // });



    },
    del(index) {
      this.userDatas.splice(index, 1);
      this.cards.splice(index, 1);
      localStorage.setItem("userDatas", JSON.stringify(this.userDatas));
      localStorage.setItem("cards", JSON.stringify(this.cards));
    },
    scanf() {
      location.href = `http://sao315.com/w/api/saoyisao/?redirect_uri=${location.href}`;
    },
    resetForm() {
      // this.$refs["elForm"].resetFields();
      this.userDatas = [];
      this.cards = [];
      localStorage.setItem("userDatas", JSON.stringify(this.userDatas));
      localStorage.setItem("cards", JSON.stringify(this.cards));
    },
  },
};
</script>
<style>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.box-card {
  margin: 1rem;
  width: 90%;

}
</style>
