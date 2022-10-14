<template>
  <div class="gameList">
    <div class="header">
    <!--   赛事时间   -->
      <div class="gameTime">
          <el-row class="timeStyle">
            <el-col :span="24"><span>上午起始时间：</span>
              <el-input-number size="small" v-model="startAMHour" :min="0" :max="23" @change="handleChange" />点
              <el-input-number size="small" v-model="startAMMin" :min="0" :max="23" @change="handleChange" />分
            </el-col>
            <el-col :span="24"><span>上午结束时间：</span>
              <el-input-number size="small" v-model="endAMHour" :min="0" :max="23" @change="handleChange" />点
              <el-input-number size="small" v-model="endAMMin" :min="0" :max="23" @change="handleChange" />分
            </el-col>
          </el-row>
          <el-row class="timeStyle">
            <el-col :span="24"><span>下午起始时间：</span>
              <el-input-number size="small" v-model="startPMHour" :min="0" :max="23" @change="handleChange" />点
              <el-input-number size="small" v-model="startPMMin" :min="0" :max="23" @change="handleChange" />分
            </el-col>
            <el-col :span="24"><span>下午结束时间：</span>
              <el-input-number size="small" v-model="endPMHour" :min="0" :max="23" @change="handleChange" />点
              <el-input-number size="small" v-model="endPMMin" :min="0" :max="23" @change="handleChange" />分
            </el-col>
          </el-row>
      </div>
      <div>
        <el-button>一键编排</el-button>
      </div>
    </div>
    <!--  赛程内容  -->
    <div>
      <h1 style="text-align: center;font-weight: bold">径赛赛程</h1>
      <div style="margin: 10px 0 10px 10px"><span>两场比赛间隔时间（分钟）：</span><el-input-number size="small" v-model="midTime" :min="0" :max="999" @change="handleChange" />分</div>
      <div>
        <el-table
          :data="tableData"
          style="width: 100%;font-size: 18px"
        :header-cell-style="{background:'white',border:'0px','font-size':'18px'}"
        :cell-style="{border:'0px'}">
          <el-table-column
            prop="gameID"
            label="比赛编码"
            width="150">
          </el-table-column>
          <el-table-column
            prop="gameName"
            label="比赛名"
            width="240">
          </el-table-column>
          <el-table-column
            prop="number"
            label="单组人数限制"
          width="200">
          </el-table-column>
          <el-table-column
            prop="interval"
            label="平均每人间隔时间">
          </el-table-column>
        </el-table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      startAMHour: 8,
      startAMMin: 0,
      endAMHour: 12,
      endAMMin: 0,
      startPMHour: 14,
      startPMMin: 0,
      endPMHour: 17,
      endPMMin: 0,
      // 比赛间隔分钟
      midTime: 10,
      tableData:[{
        gameID:'1',
        gameName:'【男子】100米（预赛）',
        number:'6',
        interval:'1'
      },{
        gameID:'2',
        gameName:'【女子】100米（预赛）',
        number:'6',
        interval:'1'
      },{
        gameID:'3',
        gameName:'【男子】200米（预赛）',
        number:'6',
        interval:'1'
      }]
    }
  },
  methods:{
    handleChange(value) {
      console.log(value)
    }
  }
}
</script>

<style scoped>
.gameList{
  width: 80%;
  margin: 0 auto;
}
.header{
  display: flex;
  align-items: center;
  margin-top: 20px;
}
.gameTime{
  width: 60%;
}

.timeStyle{
  margin: 10px 0px 0px 10px;
}


</style>
