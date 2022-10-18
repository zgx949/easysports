<template>
<div class="app-container">
  <div class="container">
    <div>
      <el-input
        type="textarea"
        rows="20"
        placeholder="请输入内容"
        v-model="text">
      </el-input>
      <el-button @click="generate" style="margin: 10px auto;display: block;" :disabled="text !=='' ? false:true">生成二维码</el-button>
    </div>
    <div  v-if="imgsrc != '' ? true:false" style="margin: 10px auto;">
      <div>
        <img :src="imgsrc" style="border: #1ab394 solid 6px">
      </div>
<!--      <el-button @click="loadQR" style="margin: 10px auto;display: block;">下载二维码</el-button>-->
    </div>


  </div>
</div>
</template>

<script>
import {generateQRcode} from "@/api/system/code";

export default {
  name: "index",
  data(){
    return{
      imgsrc:'',
      text:"",
      errorData:[],
      stuIds:{
        size:"500×500",
        data:''
      }
    }
  },
  methods:{
    generate(){
      let rex = /^[0-9]+.?[0-9]*$/;
      let errorList = []
      if(this.text){
        let result = this.text.split("\n")
        let newStr = []
        // 去除非数字字符串
        result.forEach((v,i) => {
          // v = v.replace(/[^0-9]/ig,"")
          if(rex.test(v)){
            newStr.push(v)
          }else {
            errorList.push(v)
          }
        })
       this.stuIds.data = newStr.join(',')
      }
      if(this.stuIds.data != ''){
        generateQRcode(this.stuIds).then(res => {
          let {request} = res;
          this.imgsrc = request.responseURL
        })
      }
      if(errorList.length>0){
        this.errorData = errorList
        this.$message({
          message:'学号有误'+this.errorData,
          type:"error",
          duration:0,
          showClose:true
        })
        console.log(this.errorData)
      }
    },
    // loadQR(){
    //   if(this.imgsrc !== ""){
    //     var a = document.createElement('a')
    //          var event = new MouseEvent('click')
    //          // 自定义下载后图片的名称
    //          a.download = '二维码'
    //          a.href = this.imgsrc
    //          a.dispatchEvent(event)
    //   }
    //
    // }
  }
}
</script>

<style scoped>
.container{
  display: flex;
  flex-direction:row;
  align-items: center;
}
</style>
