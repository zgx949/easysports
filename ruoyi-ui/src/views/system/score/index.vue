<template>
  <div class="app-container">
    <div class="queryterm">
      <div class="selectBox">
        <span>比赛名称:</span>
        <el-select v-model="pageObj.gameId" filterable placeholder="请选择" size="small" @change="getPlayerListByGameId" style="margin-left: 10px">
          <el-option
            v-for="item in finishedGame"
            :key="item.id"
            :label="item.gameName"
            :value="item.id">
          </el-option>
        </el-select>
      </div>
      <el-input v-model="input" placeholder="请输入学号查询" size="small" style="width: 200px;margin-left: 50px" clearable>
        <el-button slot="append" icon="el-icon-search" @click="searchPerson"></el-button>
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
          width="130">
        </el-table-column>
        <el-table-column
          prop="nickName"
          label="姓名"
          width="100">
        </el-table-column>
        <el-table-column
          prop="gameName"
          label="比赛项目"
          width="180">
        </el-table-column>
        <el-table-column
          prop="type"
          label="比赛类型">
          <template slot-scope="scope">
            <span v-if="scope.row.type === 1">田赛</span>
            <span v-if="scope.row.type === 2">径赛</span>
            <span v-if="scope.row.type === 3">团体赛</span>
          </template>
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
          prop="score,unit"
          label="成绩"
        width="150">
          <template slot-scope="scope" v-if="scope.row.score ? true:false">
            {{scope.row.score}} {{scope.row.unit}}
          </template>
        </el-table-column>
        <el-table-column
          prop="comment"
          label="备注"
          width="180">
        </el-table-column>
        <el-table-column
          fixed="right"
          label="操作"
          width="180">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              @click="showScoreForm(scope.row)"
              >录入成绩</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!--   分页   -->
      <div class="block">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page.sync="pageObj.pageNum"
          :page-size="pageObj.pageSize"
          layout="total, prev, pager, next"
          :total="dataTotal">
        </el-pagination>
      </div>
    </div>
<!--  成绩录入表单  -->
    <el-dialog v-bind="$attrs" v-on="$listeners" @close="onClose"  :visible.sync="dialogTableVisible">
      <div class="stuInfo">
        <div><label>姓名：</label><span>{{this.scoreForm.nickName}}</span></div>
        <div><label>学号：</label><span>{{this.scoreForm.username}}</span></div>
        <div><label>学院：</label> <span>{{this.scoreForm.deptName}}</span></div>
        <div><label>项目：</label><span>{{this.scoreForm.gameName}}</span></div>
      </div>

      <el-row :gutter="15">
        <el-form ref="dataForm" :model="scoreForm" :rules="rules" size="medium" label-width="60px">
          <el-col :span="12">
            <el-form-item label="成绩" prop="score">
              <el-input v-model="scoreForm.score" placeholder="请输入成绩" clearable :style="{width: '100%'}">
                <template slot="append">{{scoreForm.unit}}</template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="积分" prop="points">
              <el-input v-model="scoreForm.points" placeholder="请输入积分" clearable :style="{width: '100%'}">
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="comment">
              <el-input v-model="scoreForm.comment" placeholder="请输入备注" clearable :style="{width: '100%'}">
              </el-input>
            </el-form-item>
          </el-col>
        </el-form>
      </el-row>
      <div slot="footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="handleConfirm">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getPlayerByGameId, listGames, registerScore} from '@/api/system/games'
  export default {
    data(){
      return{

        // 下拉框已结束比赛数据列表
        finishedGame: [],
        // 运动员数据列表
        stuData: [],
        // 运动员数据备份
        dataBackup:[],
        // 比赛id及分页数据
        pageObj:{
          gameId:undefined,
          // 每页数量
          pageSize:10,
          // 页码
          pageNum:1,
        },
        // 数据总数
        dataTotal:undefined,
        // 根据学号查询的学号
        input: '',
        // 搜索结果
        searchResult:[],
        // 成绩录入表单数据
        scoreForm: {
          score:undefined,
          points:undefined,
          comment:""
        },
        // 表单展示条件
        dialogTableVisible: false,

        rules: {
          score: [{
            required: true,
            message: '请输入成绩',
            trigger: 'blur'
          }],
          points: [{
            required: true,
            message: '请输入积分',
            trigger: 'blur'
          }],
          comment: [],
        }
      }
    },
    created() {
      this.getFinishedList()
    },
    methods:{
      // 获取已完成比赛列表
      getFinishedList(){
        listGames({status:3, pageSize: 1000}).then(res => {
          const {rows} = res;
          this.finishedGame = rows;
        })
      },
      // 根据比赛ID获取运动员数据
      getPlayerListByGameId(val){
        this.pageObj.gameId = val;
        getPlayerByGameId(this.pageObj).then(res => {
          this.dataTotal = res.total;
          const {rows} = res;
          this.stuData = rows;
        })
      },

      // 运动员信息获取
      showScoreForm(data){
        console.log(data)
        this.scoreForm['userId'] = data.userId
        this.scoreForm['username'] = data.username
        this.scoreForm['gameId'] = data.gameId
        this.scoreForm['score'] = data.score
        this.scoreForm['points'] = data.points
        this.scoreForm['comment'] = data.comment
        this.scoreForm['unit'] = data.unit
        this.scoreForm['deptName'] = data.deptName
        this.scoreForm['nickName'] = data.nickName
        this.scoreForm['gameName'] = data.gameName
        console.log(this.scoreForm)
        this.dialogTableVisible = true
      },

      searchPerson(){
        if(this.input){
          if(JSON.stringify(this.dataBackup)==='[]'){
            this.dataBackup = this.stuData
          }
          this.stuData = this.dataBackup.filter( (value) => {
            if (value.username === this.input)
              return true
            else
              return false
          })
          if (JSON.stringify(this.stuData)==='[]'){
            this.stuData = this.dataBackup
            this.$message({
              message:'查无此人',
              type:'error'
            });
            this.input=""
            return
          }
        }
        else {
          this.getPlayerByGameId(this.stuData[0].gameId)
        }
        console.log(this.stuData)
      },
      onClose() {
        this.$refs['scoreForm'].resetFields()
      },
      close() {
        this.dialogTableVisible = false
      },
      handleConfirm() {
        this.$refs['dataForm'].validate(async valid => {
          if (!valid) return
          const result = await registerScore(this.scoreForm)
          if (result.code === 200){
            this.stuData.forEach((value) => {
              if(value.userId === this.scoreForm.userId && value.gameId === this.scoreForm.gameId){
                value.score = this.scoreForm.score
                value.points = this.scoreForm.points
                value.comment = this.scoreForm.comment
              }
            })
          }
          //this.getPlayerByGameId(this.scoreForm.gameId)
          this.close()
        })
      },

      /** 分页处理 */
      handleSizeChange(val) {
        console.log(`每页 ${val} 条`);
      },
      handleCurrentChange(val) {
        this.pageObj.pageNum = val;
        console.log(this.pageObj)
        this.getPlayerListByGameId(this.pageObj.gameId)
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

.stuInfo{
  display: flex;
  flex-flow: column;
  margin-left: 20px;
}

.stuInfo div{
  margin-bottom: 20px;
}
</style>
