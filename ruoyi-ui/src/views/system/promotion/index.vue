<template>
  <div class="app-container">
    <div class="transferbox" ref="boxHeight">
      <div class="transferbox-left">
        <div ref="left">
        <div class="head-text">预赛名单</div>
        <div style="border: solid 1px #d3d3d3;border-width: 0px 1px 0px 1px">
          <el-select v-model="value" clearable size="mini" placeholder="请选择比赛" style="margin: 10px 0px 10px 5px;">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value">
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
            :default-sort="{ prop: 'rank', order: 'ascending' }"
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
              prop="rank"
              label="排名"
              min-width="10%"
              align="center"
              :sortable = "true">
            </el-table-column>
            <el-table-column
              prop="college"
              label="学院"
              min-width="13%">
            </el-table-column>
            <el-table-column
              prop="id"
              label="编号"
              min-width="10%">
            </el-table-column>
            <el-table-column
              prop="name"
              label="姓名"
              min-width="12%">
            </el-table-column><el-table-column
            prop="score"
            label="成绩"
            min-width="10%">
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
            :default-sort="{ prop: 'rank', order: 'ascending' }"
            :header-row-style="{height:'20px'}"
            :header-cell-style="{'font-size':'6px',padding:'0px'}">
            <el-table-column
              label="选择"
              type="selection"
              min-width="5%"
             align="center">
            </el-table-column>
            <el-table-column
              prop="rank"
              label="排名"
              min-width="10%"
              align="center"
              :sortable="true">
            </el-table-column>
            <el-table-column
              prop="college"
              label="学院"
              min-width="13%">
            </el-table-column>
            <el-table-column
              prop="id"
              label="编号"
              min-width="10%">
            </el-table-column>
            <el-table-column
              prop="name"
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
export default {
  data(){
    return{
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
  },
  methods:{
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
