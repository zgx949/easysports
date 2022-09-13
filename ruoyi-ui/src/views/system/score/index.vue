<template>
  <div class="app-container">
    <div class="queryterm">
      <div class="selectBox">
        <span>比赛名称:</span>
        <el-select v-model="gameID" filterable placeholder="请选择" size="small" @change="getPlayerByGameId" style="margin-left: 10px">
          <el-option
            v-for="item in finishedGame"
            :key="item.id"
            :label="item.gameName"
            :value="item.id">
          </el-option>
        </el-select>
      </div>
      <el-input v-model="input" placeholder="请输入学号查询" size="small" style="width: 200px;margin-left: 50px" prefix-icon="el-icon-search">
      </el-input>
    </div>
    <div>
      <el-table
        :data="stuData"
        height="530"
        border
        style="width: 100%;">
        <el-table-column
          prop="username"
          label="学号"
          width="150">
        </el-table-column>
        <el-table-column
          prop="nickName"
          label="姓名"
          width="120">
        </el-table-column>
        <el-table-column
          prop="gameName"
          label="比赛项目"
          width="180">
        </el-table-column>
        <el-table-column
          prop="type"
          label="比赛类型">
        </el-table-column>
        <el-table-column
          prop="startTime"
          label="比赛时间"
          width="180">
        </el-table-column>
        <el-table-column
          prop="points"
          label="积分">
        </el-table-column>
        <el-table-column
          prop="score"
          label="成绩">
        </el-table-column>
        <el-table-column
          prop="comment"
          label="备注"
          width="180">
        </el-table-column>
        <el-table-column
          fixed="right"
          prop=""
          label="操作"
          width="180">
          <template>
            <el-button
              size="mini"
              type="text"
              >录入成绩</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
import { getPlayerByGameId, listGames } from '@/api/system/games'
  export default {
    data(){
      return{
        finishedGame: [],
        stuData: [],
        gameID: '',
        input: ''
      }
    },
    created() {
      this.getFinishedList()
    },
    methods:{
      getFinishedList(){
        listGames({status:3}).then(res => {
          const {rows} = res;
          this.finishedGame = rows;
        })
      },
      getPlayerByGameId(val){
        getPlayerByGameId(val).then(res => {
          const {rows} = res;
          this.stuData = rows
          console.log(this.stuData)
        })
      }
    }
  }
</script>

<style>
.queryterm{
  display: flex;
  margin-bottom: 20px;
}

.selectBox span{
  font-size: 14px;
  color: #a8a9b0;
  line-height: 28px;
}
</style>
