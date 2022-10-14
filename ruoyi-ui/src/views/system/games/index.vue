<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="项目" prop="itemId">
        <el-select v-model="queryParams.itemId" placeholder="请选择项目" clearable>
          <el-option
            v-for="dict in itemDict"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="比赛" prop="gameName">
        <el-input
          v-model="queryParams.gameName"
          placeholder="请输入比赛名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="性别" prop="gender">
        <el-select v-model="queryParams.gender" placeholder="请选择性别" clearable>
          <el-option
            v-for="dict in dict.type.sys_user_sex"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="场地" prop="fieldId">
        <el-select v-model="queryParams.fieldId" placeholder="请选择场地" clearable>
          <el-option
            v-for="dict in fieldDict"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option
            v-for="dict in dict.type.sport_game_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="开始时间" prop="startTime">
        <el-date-picker clearable
                        v-model="queryParams.startTime"
                        type="datetime"
                        value-format="yyyy-MM-dd h:m:s"
                        placeholder="请选择开始时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="结束时间" prop="endTime">
        <el-date-picker clearable
                        v-model="queryParams.endTime"
                        type="datetime"
                        value-format="yyyy-MM-dd h:m:s"
                        placeholder="请选择结束时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:games:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:games:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:games:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:games:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="gamesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="id" align="center" prop="id" />
      <el-table-column label="项目" align="center" prop="itemId" :formatter="itemFormatter" />
      <el-table-column label="比赛名" align="center" prop="gameName" />
      <el-table-column label="决赛编码" align="center" prop="nextGame" :formatter="(row)=>{return row.nextGame === 0 || row.nextGame === 0? '无': row.nextGame}"/>
      <el-table-column label="性别" align="center" prop="gender">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_user_sex" :value="scope.row.gender"/>
        </template>
      </el-table-column>
      <el-table-column label="场地" align="center" prop="fieldId" :formatter="fieldFormatter" />
      <el-table-column label="限制人数" align="center" prop="maxPerson" />
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sport_game_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="开始时间" align="center" prop="startTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结束时间" align="center" prop="endTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.endTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:games:edit']"
          >修改</el-button>

          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:games:remove']"
          >删除</el-button>

          <el-button
            size="mini"
            type="text"
            icon="el-icon-search"
            @click="getGameResult(scope.row.id,scope.row.gameName)"
            v-hasPermi="['system:games:list']"
            v-if="scope.row.status == 3"
          >查询</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改比赛管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="项目" prop="itemId">
          <el-select v-model="form.itemId" placeholder="请选择项目">
            <el-option
              v-for="dict in itemDict"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="比赛名" prop="gameName">
          <el-input v-model="form.gameName" placeholder="请输入比赛名" />
        </el-form-item>
        <el-form-item label="决赛" prop="nextGame">
<!--          TODO: 下拉选择-->
          <el-select v-model="form.nextGame" placeholder="请选择项目">

          <el-option
            v-for="dict in gameDict"
            :key="dict.value"
            :label="dict.label"
            :value="parseInt(dict.value)"
          ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="性别" prop="gender">
          <el-select v-model="form.gender" placeholder="请选择性别">
            <el-option
              v-for="dict in dict.type.sys_user_sex"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="场地" prop="fieldId">
          <el-select v-model="form.fieldId" placeholder="请选择场地">
            <el-option
              v-for="dict in fieldDict"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="限制人数" prop="maxPerson">
          <el-input-number v-model="form.maxPerson" placeholder="请输入限制人数" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in dict.type.sport_game_status"
              :key="dict.value"
              :label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="开始时间" prop="startTime">
          <el-date-picker clearable
                          v-model="form.startTime"
                          type="datetime"
                          value-format="yyyy-MM-dd HH:mm:ss"
                          placeholder="请选择开始时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="结束时间" prop="endTime">
          <el-date-picker clearable
                          v-model="form.endTime"
                          type="datetime"
                          value-format="yyyy-MM-dd HH:mm:ss"
                          placeholder="请选择结束时间">
          </el-date-picker>
        </el-form-item>
        <el-divider content-position="center">项目管理信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="el-icon-plus" size="mini" @click="handleAddSportItem">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="handleDeleteSportItem">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="sportItemList" :row-class-name="rowSportItemIndex" @selection-change="handleSportItemSelectionChange" ref="sportItem">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="限制最多人数" prop="maxPerson" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.maxPerson" placeholder="请输入限制最多人数" />
            </template>
          </el-table-column>
          <el-table-column label="项目类型" prop="type" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.type" placeholder="请选择项目类型">
                <el-option
                  v-for="dict in dict.type.sport_item_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="成绩单位" prop="unit" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.unit" placeholder="请输入成绩单位" />
            </template>
          </el-table-column>
          <el-table-column label="是否降序排序" prop="isDesc" width="150">
            <template slot-scope="scope">
              <el-select v-model="scope.row.isDesc" placeholder="请选择是否降序排序">
                <el-option
                  v-for="dict in dict.type.sport_sort_type"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

<!--  比赛项目成绩  -->
    <el-dialog :title=this.gName :visible.sync="dialogTableVisible" v-if="this.dialogTableVisible" width="60%">
      <el-table
        :data="gameData"
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
        <el-table-column property="score" :label="this.gameData[0].type === 2?(`成绩`):(`成绩(${gameData[0].unit})`)">
          <template slot-scope="scope">
            <span v-if="scope.row.type != 2">{{ scope.row.score }}</span>
            <span v-else>{{Math.floor(scope.row.score/60000)}}'{{Math.floor((scope.row.score%60000)/1000)}}''{{Math.floor((scope.row.score%60000)%1000)}}</span>
          </template>
        </el-table-column>
        <el-table-column property="points" label="积分"></el-table-column>
        <el-table-column property="startTime" label="日期" width="150"></el-table-column>
      </el-table>
      <el-button type="primary" style="margin-top: 10px;right: 0px" size="mini" @click="printSelectedList">打印</el-button>
    </el-dialog>
<!--  需打印的页面  -->

    <el-dialog :title=this.gName :visible.sync="dialogSelectedListVisible" v-if="this.dialogSelectedListVisible" width="60%">
      <div id="print">
        <span style="margin: 0 auto;">{{this.gName}}成绩名单</span>
      <el-table :data="selectPrintInf">
        <el-table-column property="username" label="编码" width="120"></el-table-column>
        <el-table-column property="deptName" label="学院"></el-table-column>
        <el-table-column property="nickName" label="姓名"></el-table-column>
        <el-table-column property="order" label="名次"></el-table-column>
        <el-table-column property="score" :label="selectPrintInf[0].type === 2 ?(`成绩`):(`成绩(${selectPrintInf[0].unit})`)">
          <template slot-scope="scope">
            <span v-if="scope.row.type != 2">{{ scope.row.score }}</span>
            <span v-else>{{Math.floor(scope.row.score/60000)}}'{{Math.floor((scope.row.score%60000)/1000)}}''{{Math.floor((scope.row.score%60000)%1000)}}</span>
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
import { listGames, getGames, delGames, addGames, updateGames } from "@/api/system/games";
import { dictItem } from "@/api/system/item";
import { dictFields } from "@/api/system/fields";
import { dictGames, getGameWinList } from "@/api/system/games";
import moment from 'moment'

export default {
  name: "Games",
  dicts: ['sport_game_status', 'sys_user_sex', 'sport_item_type', 'sport_sort_type'],
  data() {
    return {
      // 比赛成绩弹窗判断
      dialogTableVisible : false,
      // 被选列表打印效果窗口
      dialogSelectedListVisible: false,
      // 被查询比赛名称
      gName:"",
      // 比赛成绩数据
      gameData:[],
      // 赛事单位
      unit:'',
      // 被选打印信息列表
      selectPrintInf:[],
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedSportItem: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 比赛管理表格数据
      gamesList: [],
      // 项目管理表格数据
      sportItemList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        itemId: null,
        gameName: null,
        nextGame: null,
        gender: null,
        fieldId: null,
        maxPerson: null,
        status: null,
        startTime: null,
        endTime: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      },
      // 项目字典
      itemDict: [],
      // 场地字典
      fieldDict: [],
      // 比赛字典
      gameDict: [],
    };
  },
  created() {
    this.getList();
    /** 查询比赛字典 */
    dictGames().then(res => {
      this.gameDict = res.data;
    })
  },
  methods: {
    /** 打印被选列表 */
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
    /** 获取比赛获奖数据 */
    getGameResult(id,name){
      getGameWinList(id).then(response => {
        this.gName = name
        const {data} = response
        this.gameData = data
        console.log(this.gameData)
        this.dialogTableVisible = true;
      })
    },
    /** 查询项目字典 */
    getItemDict() {
      dictItem().then(response => {
        this.itemDict = response.data;
      })
    },
    /** 项目字典格式化 */
    itemFormatter(row, column) {
      for (const item of this.itemDict) {
        if (item.value === row.itemId) {
          return item.label;
        }
      }
    },
    /** 查询场地字典 */
    getFieldDict() {
      dictFields().then(response => {
        this.fieldDict = response.data;
      })
    },
    /** 场地字典格式化 */
    fieldFormatter(row, column) {
      for (const item of this.fieldDict) {
        if (item.value === row.fieldId) {
          return item.label;
        }
      }
    },
    /** 处理比赛状态 */
    handleGameStatus(res){
      let currentTime = moment(new Date().getTime()).format('YYYY-MM-DD HH:mm:ss')
      let statusResult = [];

      for (let i = 0; i < res.length; i++) {
        let item = res[i]
        if(currentTime<item.startTime){
          res[i].status = 0;
          if(this.queryParams.status && this.queryParams.status == 0){
            statusResult.push(res[i]);
          }
        }
        else if(currentTime>item.endTime){
          res[i].status = 3;
          if(this.queryParams.status && this.queryParams.status == 3){
            statusResult.push(res[i]);
          }
        }
        else {
          res[i].status = 2;
          if(this.queryParams.status && this.queryParams.status == 2){
            statusResult.push(res[i]);
          }
        }
      }
      if (this.queryParams.status){
        return statusResult;
      }
      return res
    },
    /** 查询比赛管理列表 */
    getList() {
      this.loading = true;
      this.getItemDict();
      this.getFieldDict();
      listGames(this.queryParams).then(response => {
        this.gamesList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        itemId: null,
        gameName: null,
        nextGame: null,
        gender: null,
        fieldId: null,
        maxPerson: null,
        status: 0,
        startTime: null,
        endTime: null,
        createTime: null
      };
      this.sportItemList = [];
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      if ("id" in selection[0]){
        this.ids = selection.map(item => item.id)
        this.single = selection.length!==1
        this.multiple = !selection.length
      }
      else if ("username" in selection[0]){
        this.selectPrintInf = selection.map(item => item)
      }
      else {
        return
      }
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加比赛管理";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getGames(id).then(response => {
        this.form = response.data;
        this.sportItemList = response.data.sportItemList;
        this.open = true;
        this.title = "修改比赛管理";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.sportItemList = this.sportItemList;
          if (this.form.id != null) {
            updateGames(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addGames(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除比赛管理编号为"' + ids + '"的数据项？').then(function() {
        return delGames(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 项目管理序号 */
    rowSportItemIndex({ row, rowIndex }) {
      row.index = rowIndex + 1;
    },
    /** 项目管理添加按钮操作 */
    handleAddSportItem() {
      let obj = {};
      obj.maxPerson = "";
      obj.type = "";
      obj.unit = "";
      obj.isDesc = "";
      this.sportItemList.push(obj);
    },
    /** 项目管理删除按钮操作 */
    handleDeleteSportItem() {
      if (this.checkedSportItem.length == 0) {
        this.$modal.msgError("请先选择要删除的项目管理数据");
      } else {
        const sportItemList = this.sportItemList;
        const checkedSportItem = this.checkedSportItem;
        this.sportItemList = sportItemList.filter(function(item) {
          return checkedSportItem.indexOf(item.index) == -1
        });
      }
    },
    /** 复选框选中数据 */
    handleSportItemSelectionChange(selection) {
      this.checkedSportItem = selection.map(item => item.index)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/games/export', {
        ...this.queryParams
      }, `games_${new Date().getTime()}.xlsx`)
    },
  }
};
</script>

<style>

@media print{
  table,
  tbody,
  thead {
    width: 100% !important;
  }

  colgroup {
    position: absolute;
    width: 90% !important;
  }
}
</style>
