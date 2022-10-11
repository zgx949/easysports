<template>
  <div>
    <h1 style="text-align: center">XX成绩录入</h1>
    <el-row :gutter="15">
      <el-form
        ref="elForm"
        :model="formData"
        size="medium"
        label-width="100px"
        label-position="right"
      >
        <el-form-item label="学号" prop="idcard">
          <el-col :span="16">
            <el-input
              v-model="formData.idcard"
              placeholder="请输入学号学号"
              clearable
              :style="{ width: '100%' }"
            >
            </el-input>
          </el-col>
          <el-col :span="4">
            <el-button type="primary" icon="el-icon-search" size="medium" @click="scanf">
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
            <el-button type="primary" icon="el-icon-search" size="medium" @click="addUser">
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
            <span>data.name</span>
            <el-button class="button" text @click="del(index)">删除</el-button>
          </div>
        </template>
        <div class="text item">
            学院：{{ data.insName }}
        </div>
        <div class="text item">
            学号：{{ data.idcard }}
        </div>
        <div class="text item">
            班级：{{ data.className }}
        </div>
        <div class="text item">
            成绩：<el-input v-model="data.score" placeholder="请输入成绩"></el-input>
        </div>
      </el-card>
    </div>
    <div>
    <el-row :gutter="20" style="padding-top: 1rem;">
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
export default {
  components: {},
  props: [],
  data() {
    return {
      cards: [],
      userDatas: [],
      formData: {
        idcard: undefined,
        scanf: undefined,
        score: undefined,
        submit: undefined,
      },
      
    };
  },
  computed: {},
  watch: {},
  created() {},
  mounted() {},
  methods: {
    submitForm() {
      this.$refs["elForm"].validate((valid) => {
        if (!valid) return;
        // TODO 提交表单
      });
    },
    addUser() {
        const idcard = this.formData.idcard;
        if (!idcard) {
            alert('请输入学号')
            return;
        }
        if (this.cards.indexOf(idcard) !== -1) {
            alert('用户已经添加过');
            return;
        }
        this.cards.push(idcard);
        console.log(idcard);
        this.userDatas.push({
            insName: 'XX',
            name: '',
            gender: '',
            idcard: idcard,
            className: '',
            score: 0
        });
    },
    del(index) {
        this.userDatas.splice(index, 1);
        this.cards.splice(index, 1);
    },
    scanf() {
        alert('暂不支持');
    },
    resetForm() {
      this.$refs["elForm"].resetFields();
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
  width: 100%;
}
</style>
  