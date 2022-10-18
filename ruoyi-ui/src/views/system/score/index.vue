<template>
  <div class="app-container">
    <div class="queryterm">
      <div class="selectBox">
        <span>比赛名称:</span>
        <el-select v-model="pageObj.gameId" filterable clearable placeholder="请选择" @change="getPlayerListByGameId" style="margin-left: 10px">
          <el-option
            v-for="item in finishedGame"
            :key="item.id"
            :label="item.gameName"
            :value="item.id">
          </el-option>
        </el-select>
      </div>
      <el-input v-model="input" placeholder="请输入编码查询" style="width: 220px;margin-left: 50px" clearable>
        <el-button slot="append" icon="el-icon-search" @click="searchPerson"></el-button>
      </el-input>
      <div style="margin-left: auto">
        <el-button type="primary" @click="turnTo(`http://sport.lefthand.top/tab.html?gid=${pageObj.gameId}`)" :disabled="typeof(this.pageObj.gameId)=='undefined'">决赛通知单</el-button>
        <el-button type="success" @click="getGameResult()" :disabled="typeof(this.pageObj.gameId)=='undefined'">成绩单</el-button>
        <el-button type="info" @click="turnTo(`http://sport.lefthand.top/print.html?gid=${pageObj.gameId}`)" :disabled="typeof(this.pageObj.gameId)=='undefined'">最终个人成绩</el-button>
      </div>
    </div>
    <div>
      <el-table
        :data="stuData"
        height="530"
        border
        style="width: 100%;">
        <el-table-column
          prop="username"
          label="编码"
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
            <span v-if="scope.row.type != 2">{{scope.row.score}} {{scope.row.unit}}</span>
            <span v-else>{{Math.floor(scope.row.score/60000)}}分{{Math.floor((scope.row.score%60000)/1000)}}秒{{Math.floor((scope.row.score%60000)%1000)}}毫秒</span>
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
        <div><label>编码：</label><span>{{this.scoreForm.username}}</span></div>
        <div><label>学院：</label> <span>{{this.scoreForm.deptName}}</span></div>
        <div><label>项目：</label><span>{{this.scoreForm.gameName}}</span></div>
      </div>

      <el-row :gutter="15">
        <el-form ref="dataForm" :model="scoreForm" :rules="rules" size="medium" label-width="60px">
          <el-col>
            <el-form-item label="成绩" prop="score">
              <el-input v-model="scoreForm.score" placeholder="请输入成绩" clearable :style="{width: '100%'}" v-if="scoreForm.type != 2">
                <template slot="append">{{scoreForm.unit}}</template>
              </el-input>
              <el-row v-else type="flex" justify="start">
                <el-col >
                  <el-input v-model="trackScore.minute" placeholder="分" clearable :style="{width: '100%'}">
                  <template slot="append">分</template>
                  </el-input>
                </el-col>
                <el-col >
                <el-input v-model="trackScore.second" placeholder="秒" clearable :style="{width: '100%'}">
                  <template slot="append">秒</template>
                </el-input>
                </el-col>
                <el-col >
                <el-input v-model="trackScore.millisecond" placeholder="毫秒" clearable :style="{width: '100%'}">
                  <template slot="append">毫秒</template>
                </el-input>
                </el-col>
              </el-row>
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

    <!--  比赛项目成绩  -->
    <el-dialog :title=this.gName :visible.sync="dialogTableVisibleSearch" v-if="this.dialogTableVisibleSearch" width="60%" style="height: 100%">
      <div>
      <el-table
        :data="searchGameData"
        height="400"
        @selection-change="handleSelectionChange">
        <el-table-column
          type="selection"
          width="55">
        </el-table-column>
        <el-table-column property="username" label="编码" width="120"></el-table-column>
        <el-table-column property="deptName" label="学院"></el-table-column>
        <el-table-column property="nickName" label="姓名"></el-table-column>
        <el-table-column property="order" label="名次"></el-table-column>
        <el-table-column property="score" :label="searchGameData[0].type === 2 ?(`成绩`):(`成绩(${searchGameData[0].unit})`)">
          <template slot-scope="scope">
            <span v-if="scope.row.type != 2">{{ scope.row.score }}</span>
            <span v-else>{{Math.floor(scope.row.score/60000)}}'{{Math.floor((scope.row.score%60000)/1000)}}''{{Math.floor((scope.row.score%60000)%1000)}}</span>
          </template>
        </el-table-column>
        <el-table-column property="points" label="积分"></el-table-column>
        <el-table-column property="startTime" label="日期" width="150"></el-table-column>
      </el-table>
      </div>
      <el-button type="primary" style="margin-top: 10px;right: 0px" size="mini" @click="printSelectedList">打印</el-button>
    </el-dialog>

    <!--  需打印的页面  -->

    <el-dialog :title=this.gName :visible.sync="dialogSelectedListVisible" v-if="this.dialogSelectedListVisible" width="60%" style="height: 100%">
      <div id="print">
        <span style="margin: 0 auto;">{{this.gName}}成绩</span>
        <el-table :data="selectPrintInf" height="400">
          <el-table-column property="username" label="编码" width="120"></el-table-column>
          <el-table-column property="deptName" label="学院"></el-table-column>
          <el-table-column property="nickName" label="姓名"></el-table-column>
          <el-table-column property="order" label="名次"></el-table-column>
          <el-table-column property="score" :label="selectPrintInf[0].type === 2 ?(`成绩`):(`成绩(${selectPrintInf[0].unit})`)">
            <template slot-scope="scope">
              <span v-if="scope.row.type != 2">{{ scope.row.score }}</span>
              <span v-else>{{ Math.floor(scope.row.score/60000) != 0 ? `${Math.floor(scope.row.score/60000)}\'`: '' }} {{Math.floor((scope.row.score%60000)/1000)}}''{{Math.floor((scope.row.score%60000)%1000)}}</span>
            </template>
          </el-table-column>
          <el-table-column property="points" label="积分"></el-table-column>
          <el-table-column property="startTime" label="日期" width="150"></el-table-column>
        </el-table>
      </div>
      <el-button type="primary" plain style="margin-top: 10px;right: 0px" size="mini" @click="confirmPrint">确定</el-button>
      <el-button type="info" plain style="margin-top: 10px;right: 0px" size="mini" @click="cancelPrint">取消</el-button>
    </el-dialog>
  </div>
</template>

<script>
import {getGameWinList, getPlayerByGameId, listGames, registerScore, searchGameListByUserId} from '@/api/system/games';
import { getToken } from '../../../utils/auth'
export default {
  data(){
    return{
      // 所查询比赛名称
      gName:'',
      // 所查询比赛数据
      searchGameData:[],
      // 下拉框已结束比赛数据列表
      finishedGame: [],
      // 运动员数据列表
      stuData: [],
      // 运动员数据备份
      dataBackup:[],
      // 被选打印信息列表
      selectPrintInf:[],
      // 比赛id及分页数据
      pageObj:{
        gameId:undefined,
        // 每页数量
        pageSize:10,
        // 页码
        pageNum:1,
        userId:undefined
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
        points:0,
        comment:""
      },
      // 径赛成绩
      trackScore:{
        minute:0,
        second:0,
        millisecond:0
      },
      // 表单展示条件
      dialogTableVisible: false,
      // 成绩单展示
      dialogTableVisibleSearch:false,
      // 被选列表打印效果窗口
      dialogSelectedListVisible: false,

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
    turnTo(url) {
      window.open(url + '&token=' + getToken());
    },
    // 获取已完成比赛列表
    getFinishedList(){
      listGames({status:3, pageNum: 1, pageSize: 1000}).then(res => {
        const {rows} = res;
        this.finishedGame = rows;
      })
    },
    // 根据比赛ID获取运动员数据
    getPlayerListByGameId(val){
      if (!val) return
      this.pageObj.gameId = val;
      getPlayerByGameId(this.pageObj).then(res => {
        this.dataTotal = res.total;
        const {rows} = res;
        this.stuData = rows;
        this.gName = this.stuData[0].gameName
      })
    },
    getGameResult(){
      getGameWinList(this.stuData[0].gameId).then(response => {
        const {data} = response
        this.searchGameData = data
        this.dialogTableVisibleSearch = true;
      })
    },

    // 多选框选中数据
    handleSelectionChange(selection) {
      if ("username" in selection[0]){
        this.selectPrintInf = selection.map(item => item)
      }
      else {
        return
      }
    },

    searchPlayerListByUserId(val){
      this.pageObj.userId = val;
      console.log(this.pageObj)
      searchGameListByUserId(this.pageObj).then(res => {
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
      this.scoreForm['type'] = data.type
      console.log(this.scoreForm)
      this.dialogTableVisible = true
    },

    // 搜索指定学号人员的所有比赛
    searchPerson(){
        this.searchPlayerListByUserId(parseInt(this.input))
    },
    onClose() {
      this.$refs['scoreForm'].resetFields()
    },
    close() {
      this.dialogTableVisible = false
    },

    // 提交成绩
    handleConfirm() {
      if (this.scoreForm.type === 2){
        const trackGradeResult = Math.ceil(this.trackScore.minute*60*1000)+Math.ceil(this.trackScore.second*1000)+Math.ceil(this.trackScore.millisecond)
        this.scoreForm.score = trackGradeResult
      }
       this.$refs['dataForm'].validate(async valid => {
        if (!valid) return
        // 径赛单位换算
        const result = await registerScore(this.scoreForm)
        if(result.code === 200){
          this.stuData.forEach((value) => {
            if(value.userId === this.scoreForm.userId && value.gameId === this.scoreForm.gameId){
              value.score = this.scoreForm.score
              value.points = this.scoreForm.points
              value.comment = this.scoreForm.comment
            }
          })
        }
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
    },

    /** 打印处理 */
    printSelectedList(){
      for (let i = 0; i < this.selectPrintInf.length; i++) {
        this.selectPrintInf[i].startTime = this.selectPrintInf[i].startTime.split(' ')[0];
      }
      this.dialogSelectedListVisible = true;
    },
    confirmPrint(){
      let print= document.getElementById('print');
      let newContent = print.innerHTML;
      let oldContent = document.body.innerHTML;
      document.body.innerHTML = newContent;
      document.getElementsByTagName('body')[0].style.zoom=0.92;
      window.print();
      window.location.reload();
      //将原有页面还原到页面
      document.body.innerHTML = oldContent;
      return false;
    },
    cancelPrint(){
      this.dialogSelectedListVisible = false;
    },
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
