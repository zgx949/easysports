<template>
  <div>
    <title>花名册</title>
    <div class="printBtn"><el-button @click="getPdf('秩序册')" type="primary">打印</el-button></div>
    <div id="pdfDom">
    <div>
      <h1 style="text-align: center;margin: 30px 0 50px 0">代表队名单</h1>
    </div>
    <div class="list-content" v-for="(item,index) in this.tableData" :key="index">
      <div class="head-content" style="margin-left: 5px">
        <h2 style="text-align: center">{{ item.deptName }}</h2>
        <el-row>
          <el-col :span="10"><span>领队：{{item.leader}}</span></el-col>
          <el-col :span="10"><span>联系电话：{{item.phoneNumber}}</span></el-col>
        </el-row>
        <el-row style="margin: 10px 0 10px 0">
          <el-col :span="10"><span>教练员：{{item.coach}}</span></el-col>
        </el-row>
      </div>
      <div class="content-list">
        <el-table
          :data="item.gameSequenceItem"
          style="width: 100%;"
          :show-header="false"
          :cell-style="cellStyle">
          <el-table-column
            prop="username"
            label="运动员ID"
            width="150">
          </el-table-column>
          <el-table-column
            prop="nickName"
            label="姓名"
            width="120">
          </el-table-column>
          <el-table-column
            prop="postName"
            label="身份"
          width="100">
          </el-table-column>
          <el-table-column
            prop="sex"
            label="性别"
          width="80">
            <template slot-scope="scope">
              <span v-if="scope.row.sex === 0 ">男</span>
              <span v-if="scope.row.sex === 1 ">女</span>
            </template>
          </el-table-column>
          <el-table-column
            prop=""
            label="赛事">
            <template slot-scope="scope">
              <pre><span v-for="(item2, index2) in scope.row.joinGames">{{item2}} </span></pre>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </div>
    </div>
  </div>
</template>

<script>
import { getRosterInfo } from '@/api/system/games'
export default {
  data(){
    return{
      tableData: [],
      htmlTitle: '秩序册'
    }
  },
  created() {
    this.getRosterTableData()
  },
  methods: {
    // 设置表头样式
    tableHeaderColor({row, column, rowIndex, columnIndex}) {
      return 'background-color:white;text-align:center'
    },
    // 设置单元格样式
    cellStyle({row, column, rowIndex, columnIndex}){
      return 'font-size:19px;border:0px'
    },

    // 获取表格信息
    getRosterTableData() {
      getRosterInfo().then(res => {
        const {data} = res;
        this.tableData = data;
      })
    },

  }
}
</script>

<style>
.list-content{
  width: 80%;
  margin: 0 auto;
}
.printBtn{
  display: flex;
  justify-content: flex-end;
  margin: 20px 20px 0 0;
}
</style>
