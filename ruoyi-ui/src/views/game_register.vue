<template>
  <div>
    <div class="header">
      <img class="logo" src="https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi-1.lanrentuku.com%2F2020%2F10%2F28%2Fc58fe77c-7c1e-49a0-b029-b7ce7e84cc89.png%3FimageView2%2F2%2Fw%2F500&refer=http%3A%2F%2Fi-1.lanrentuku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1659881091&t=c34a3263ddd1dd8835180363f83ae38b">
    </div>
    <div class="title">项目报名系统</div>
    <el-form ref="elForm" :model="formData" :rules="rules" size="medium" label-width="100px">
      <el-form-item label="用户名" prop="user_id">
        <el-input v-model="formData.user_id" placeholder="请输入用户名用户名" clearable :style="{width: '95%'}">
        </el-input>
      </el-form-item>
      <el-form-item label="密码" prop="field105">
        <el-input v-model="formData.password" placeholder="请输入密码" clearable show-password
          :style="{width: '95%'}"></el-input>
      </el-form-item>
      <el-form-item label="学号" prop="field106">
        <el-input v-model="formData.idcard" placeholder="请选择学号" clearable :style="{width: '95%'}">
        </el-input>
      </el-form-item>
      <el-form-item label="姓名" prop="name">
        <el-input v-model="formData.name" placeholder="请输入单行文本姓名" clearable :style="{width: '95%'}">
        </el-input>
      </el-form-item>
      <el-form-item label="学院" prop="field105">
        <el-select v-model="formData.institution" placeholder="请选择学院" clearable :style="{width: '95%'}">
          <el-option v-for="(item, index) in institutionOptions" :key="index" :label="item.label"
            :value="item.value" :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="比赛项目" prop="game">
        <el-select v-model="formData.game" placeholder="请选择比赛项目" clearable :style="{width: '95%'}">
          <el-option v-for="(item, index) in gameOptions" :key="index" :label="item.label" :value="item.value"
            :disabled="item.disabled"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item size="large">
        <el-button type="primary" @click="submitForm">提交</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
export default {
  components: {},
  props: [],
  data() {
    return {
      formData: {
        user_id: 'admin',
        password: 'admin123',
        idcard: undefined,
        name: undefined,
        institution: undefined,
        game: 1,
      },
      rules: {
        user_id: [{
          required: true,
          message: '请输入用户名用户名',
          trigger: 'blur'
        }],
        password: [{
          required: true,
          message: '请输入密码',
          trigger: 'blur'
        }],
        idcard: [{
          required: true,
          message: '请选择学号',
          trigger: 'blur'
        }],
        name: [{
          required: true,
          message: '请输入单行文本姓名',
          trigger: 'blur'
        }],
        institution: [{
          required: true,
          message: '请选择学院',
          trigger: 'change'
        }],
        game: [{
          required: true,
          message: '请选择比赛项目',
          trigger: 'change'
        }],
      },
      institutionOptions: [{
        "label": "选项一",
        "value": 1
      }, {
        "label": "选项二",
        "value": 2
      }],
      gameOptions: [{
        "label": "选项一",
        "value": 1
      }, {
        "label": "选项二",
        "value": 2
      }],
    }
  },
  computed: {},
  watch: {},
  created() {},
  mounted() {},
  methods: {
    submitForm() {
      this.$refs['elForm'].validate(valid => {
        if (!valid) return
        // TODO 提交表单
      })
    },
    resetForm() {
      this.$refs['elForm'].resetFields()
    },
  }
}

</script>
<style scoped>
/*TODO: 编译后出现flex不生效问题*/
.header {
  padding: 1rem;
  display: flex;
  justify-content: center;
}

.logo {
  width: 10rem;
  height: 10rem;
}

.title {
  display: flex;
  font-size: 3rem;
  padding: 1rem;
  justify-content: center;
  font-weight: 500;
}
</style>
