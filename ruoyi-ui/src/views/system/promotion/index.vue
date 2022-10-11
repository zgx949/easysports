<template>
  <div class="app-container">
    <div class="transferbox" ref="boxHeight">
      <div class="transferbox-left">
        <div ref="left">
        <div class="head-text">预赛名单</div>
        <div style="border: solid 1px #d3d3d3;border-width: 0px 1px 0px 1px">
          <el-select
            v-model="selectedGame"
            clearable size="mini"
            placeholder="请选择比赛"
            style="margin: 10px 0px 10px 5px;"
            @change="getFinalGameData"
            @focus="backupId">
            <el-option
              v-for="item in finalList"
              :key="item.id"
              :label="item.gameName"
              :value="item.id">
            </el-option>
          </el-select>
        </div>
      </div>
        <div class="transferbox-table">
          <el-table
            :data="LeftData"
            height="400"
            border
            style="width: 100%;"
            @selection-change="handleSelectionChange($event,1)"
            :default-sort="{ prop: 'order', order: 'ascending' }"
            :row-class-name="tableRowClassName"
            :header-row-style="{height:'20px'}"
            :header-cell-style="{'font-size':'6px',padding:'0px'}">
            <el-table-column
              label="选择"
              type="selection"
              min-width="5%"
              align="center">
            </el-table-column>
            <el-table-column
              prop="order"
              label="排名"
              min-width="10%"
              align="center"
              :sortable = "true">
            </el-table-column>
            <el-table-column
              prop="deptName"
              label="学院"
              min-width="13%">
            </el-table-column>
            <el-table-column
              prop="userId"
              label="编号"
              min-width="10%">
            </el-table-column>
            <el-table-column
              prop="nickName"
              label="姓名"
              min-width="12%">
            </el-table-column>
            <el-table-column
            prop="score"
            label="成绩"
            min-width="10%">
              <template slot-scope="scope" v-if="scope.row.score ? true:false">
                <span v-if="scope.row.type != 2">{{scope.row.score}} {{scope.row.unit}}</span>
                <span v-else>{{Math.floor(scope.row.score/60000)}}'{{Math.floor((scope.row.score%60000)/1000)}}''{{Math.floor((scope.row.score%60000)%1000)}}</span>
              </template>
          </el-table-column>
          </el-table>
        </div>
      </div>
      <div class="transferbox-middle">
        <div class="middle-btn">
            <el-button class="btn-style" type="primary" icon="el-icon-arrow-left" plain @click="transferDataToLeft"></el-button>
            <el-button class="btn-style" style="margin-left: 5px" type="primary" plain icon="el-icon-arrow-right" @click="transferDataToRight"></el-button>
        </div>
      </div>
      <div class="transferbox-right">
        <div class="head-text">晋级名单</div>
        <div class="transferbox-table">
          <el-table
            :data="rightData"
            height="410"
            border
            style="width: 100%"
            @selection-change="handleSelectionChange($event,2)"
            :default-sort="{ prop: 'order', order: 'ascending' }"
            :header-row-style="{height:'20px'}"
            :header-cell-style="{'font-size':'6px',padding:'0px'}">
            <el-table-column
              label="选择"
              type="selection"
              min-width="5%"
             align="center">
            </el-table-column>
            <el-table-column
              prop="order"
              label="排名"
              min-width="10%"
              align="center"
              :sortable="true">
            </el-table-column>
            <el-table-column
              prop="deptName"
              label="学院"
              min-width="13%">
            </el-table-column>
            <el-table-column
              prop="userId"
              label="编号"
              min-width="10%">
            </el-table-column>
            <el-table-column
              prop="nickName"
              label="姓名"
              min-width="12%">
            </el-table-column><el-table-column
            prop="score"
            label="成绩"
            min-width="10%">
          </el-table-column>

          </el-table>
        </div>
        <div style="text-align: center;margin: 5px 0px 5px 0px"><el-button type="primary" size="mini" plain>保存</el-button></div>
      </div>
    </div>
  </div>
</template>

<script>
import {getFinalGameDataById, getFinalGameList} from '@/api/system/games'
export default {
  data(){
    return{
      // 需决赛比赛列表
      finalList:[],
      // 被选比赛ID
      selectedGame:null,
      // 被选比赛ID备份
      selectedGameIdBackUp:null,
      LeftData: [{
        rank: '1',
        college: '软件学院',
        id: '001',
        name:'张三',
        score:'2'
      },
        {
          rank: '2',
          college: '软件学院',
          id: '001',
          name:'张三',
          score:'2'
        },
        {
          rank: '3',
          college: '软件学院',
          id: '001',
          name:'张三',
          score:'2'
        }],
      rightData:[],
      // 左边选中的数据
      LeftSelection:[],
      // 右边选中的数据
      RightSelection:[]
    }
  },
  created() {
    this.getGameList()
  },
  methods:{
    backupId(){
      this.selectedGameIdBackUp = this.selectedGame;
    },
    // 获取需决赛比赛列表
    getGameList(){
      getFinalGameList().then(res => {
        console.log(res)
        const {data} = res
        this.finalList = data;
      })
    },
    // 获得决赛项目数据
    getFinalGameData(val){

      if (val){
        if(this.selectedGameIdBackUp !== val){
          this.rightData = [];
        }
        getFinalGameDataById(val).then((res) => {
          console.log(res)
          const {data} = res;
          this.LeftData = data;
          console.log(this.LeftData)
        })
      }

    },
    // 添加索引
    tableRowClassName(row, index){
      // 给每条数据添加一个索引
      row.row.index = row.rowIndex
    },
    handleSelectionChange(val,index) {
      if(index === 1){
        this.LeftSelection = val;
      }
      else {
        this.RightSelection = val;
      }
    },
    transferDataToRight(){

      if(this.LeftSelection.length != 0){
        this.LeftSelection.forEach((v,i) => {
          this.rightData.push(v);
        })
        let val = this.LeftSelection
        //如果选中数据存在
        if(val){
          //将选中数据遍历
          val.forEach((val,index) =>{
            //遍历源数据
            this.LeftData.forEach((v,i)=>{
              //如果选中数据和源数据的某一条唯一标识符相等，删除对应的源数据

              if(val.index === v.index){
                this.LeftData.splice(i,1)
              }
            })
          })
        }
        this.LeftSelection = [];
      }

    },
    transferDataToLeft(){

      if(this.RightSelection.length != 0){
        this.RightSelection.forEach((v,i) => {
          this.LeftData.push(v);
        })
        let val = this.RightSelection
        //如果选中数据存在
        if(val){
          //将选中数据遍历
          val.forEach((val,index) =>{
            //遍历源数据
            this.rightData.forEach((v,i)=>{
              //如果选中数据和源数据的某一条唯一标识符相等，删除对应的源数据

              if(val.index === v.index){
                this.rightData.splice(i,1)
              }
            })
          })
        }
        this.RightSelection = [];
      }

    }
  }
}

</script>

<style>
*{
  padding: 0;
  margin: 0;
}
.transferbox{
  position: absolute;
  margin: 0 auto;
  padding: 0px 10px 0px 10px;
  display: flex;
  width: 100%;
  height: 95%;
  overflow: scroll;
}
.transferbox-left{
  flex: 5;
  height: 100%;
}
.transferbox-middle{
  flex: 1;
  align-self: center;
  margin: 0px 5px 0px 5px;
}
.middle-btn{
  display: flex;
  flex-direction: column;
}
.btn-style{;
  margin: 5px 5px 5px 5px;
}
.transferbox-right{
  flex: 5;
}
.head-text{
  text-align: center;
  padding: 5px;
  background-color: #304156;
  color: #FFFFFF;
}

</style>
