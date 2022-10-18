<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学号" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入学号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="身高" prop="height">
        <el-input
          v-model="queryParams.height"
          placeholder="请输入身高"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="体重" prop="weight">
        <el-input
          v-model="queryParams.weight"
          placeholder="请输入体重"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="左眼" prop="leftEye">
        <el-input
          v-model="queryParams.leftEye"
          placeholder="请输入左眼"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="右眼" prop="rightEye">
        <el-input
          v-model="queryParams.rightEye"
          placeholder="请输入右眼"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="肺活量" prop="vitalCapacity">
        <el-input
          v-model="queryParams.vitalCapacity"
          placeholder="请输入肺活量"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="50米" prop="fiftyRun">
        <el-input
          v-model="queryParams.fiftyRun"
          placeholder="请输入50米"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="跳远" prop="longJump">
        <el-input
          v-model="queryParams.longJump"
          placeholder="请输入跳远"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="坐位体前驱" prop="sittingBodyBend">
        <el-input
          v-model="queryParams.sittingBodyBend"
          placeholder="请输入坐位体前驱"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="耐力跑" prop="enduranceRunning">
        <el-input
          v-model="queryParams.enduranceRunning"
          placeholder="请输入耐力跑"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="活动id" prop="ftaId">
        <el-input
          v-model="queryParams.ftaId"
          placeholder="请输入活动id"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="附加项目" prop="otherItem">
        <el-input
          v-model="queryParams.otherItem"
          placeholder="请输入附加项目"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否免测" prop="isFree">
        <el-select v-model="queryParams.isFree" placeholder="请选择是否免测" clearable>
          <el-option
            v-for="dict in dict.type.sys_yes_no"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="创建人" prop="createUid">
        <el-input
          v-model="queryParams.createUid"
          placeholder="请输入创建人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="最后修改的人" prop="updateUid">
        <el-input
          v-model="queryParams.updateUid"
          placeholder="请输入最后修改的人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="年级" prop="grade">
        <el-select v-model="queryParams.grade" placeholder="请选择年级" clearable>
          <el-option
            v-for="dict in dict.type.stu_grade"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
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
          v-hasPermi="['system:score:add']"
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
          v-hasPermi="['system:score:edit']"
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
          v-hasPermi="['system:score:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:score:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="scoreList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键id" align="center" prop="id" />
      <el-table-column label="学号" align="center" prop="userId" />
      <el-table-column label="身高" align="center" prop="height" />
      <el-table-column label="体重" align="center" prop="weight" />
      <el-table-column label="左眼" align="center" prop="leftEye" />
      <el-table-column label="右眼" align="center" prop="rightEye" />
      <el-table-column label="肺活量" align="center" prop="vitalCapacity" />
      <el-table-column label="50米" align="center" prop="fiftyRun" />
      <el-table-column label="跳远" align="center" prop="longJump" />
      <el-table-column label="坐位体前驱" align="center" prop="sittingBodyBend" />
      <el-table-column label="耐力跑" align="center" prop="enduranceRunning" />
      <el-table-column label="活动id" align="center" prop="ftaId" />
      <el-table-column label="附加项目" align="center" prop="otherItem" />
      <el-table-column label="是否免测" align="center" prop="isFree">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_yes_no" :value="scope.row.isFree"/>
        </template>
      </el-table-column>
      <el-table-column label="备注信息" align="center" prop="remark" />
      <el-table-column label="创建人" align="center" prop="createUid" />
      <el-table-column label="最后修改的人" align="center" prop="updateUid" />
      <el-table-column label="年级" align="center" prop="grade">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.stu_grade" :value="scope.row.grade"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:score:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:score:remove']"
          >删除</el-button>
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

    <!-- 添加或修改体测成绩对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学号" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入学号" />
        </el-form-item>
        <el-form-item label="身高" prop="height">
          <el-input v-model="form.height" placeholder="请输入身高" />
        </el-form-item>
        <el-form-item label="体重" prop="weight">
          <el-input v-model="form.weight" placeholder="请输入体重" />
        </el-form-item>
        <el-form-item label="左眼" prop="leftEye">
          <el-input v-model="form.leftEye" placeholder="请输入左眼" />
        </el-form-item>
        <el-form-item label="右眼" prop="rightEye">
          <el-input v-model="form.rightEye" placeholder="请输入右眼" />
        </el-form-item>
        <el-form-item label="肺活量" prop="vitalCapacity">
          <el-input v-model="form.vitalCapacity" placeholder="请输入肺活量" />
        </el-form-item>
        <el-form-item label="50米" prop="fiftyRun">
          <el-input v-model="form.fiftyRun" placeholder="请输入50米" />
        </el-form-item>
        <el-form-item label="跳远" prop="longJump">
          <el-input v-model="form.longJump" placeholder="请输入跳远" />
        </el-form-item>
        <el-form-item label="坐位体前驱" prop="sittingBodyBend">
          <el-input v-model="form.sittingBodyBend" placeholder="请输入坐位体前驱" />
        </el-form-item>
        <el-form-item label="耐力跑" prop="enduranceRunning">
          <el-input v-model="form.enduranceRunning" placeholder="请输入耐力跑" />
        </el-form-item>
        <el-form-item label="活动id" prop="ftaId">
          <el-input v-model="form.ftaId" placeholder="请输入活动id" />
        </el-form-item>
        <el-form-item label="附加项目" prop="otherItem">
          <el-input v-model="form.otherItem" placeholder="请输入附加项目" />
        </el-form-item>
        <el-form-item label="是否免测" prop="isFree">
          <el-select v-model="form.isFree" placeholder="请选择是否免测">
            <el-option
              v-for="dict in dict.type.sys_yes_no"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注信息" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="创建人" prop="createUid">
          <el-input v-model="form.createUid" placeholder="请输入创建人" />
        </el-form-item>
        <el-form-item label="最后修改的人" prop="updateUid">
          <el-input v-model="form.updateUid" placeholder="请输入最后修改的人" />
        </el-form-item>
        <el-form-item label="年级" prop="grade">
          <el-select v-model="form.grade" placeholder="请选择年级">
            <el-option
              v-for="dict in dict.type.stu_grade"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listFitness_score, getFitness_score, delFitness_score, addFitness_score, updateFitness_score } from "@/api/system/fitness_score";

export default {
  name: "Score",
  dicts: ['sys_yes_no', 'stu_grade'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 体测成绩表格数据
      scoreList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        height: null,
        weight: null,
        leftEye: null,
        rightEye: null,
        vitalCapacity: null,
        fiftyRun: null,
        longJump: null,
        sittingBodyBend: null,
        enduranceRunning: null,
        ftaId: null,
        otherItem: null,
        isFree: null,
        createUid: null,
        updateUid: null,
        grade: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询体测成绩列表 */
    getList() {
      this.loading = true;
      listFitness_score(this.queryParams).then(response => {
        this.scoreList = response.rows;
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
        userId: null,
        height: null,
        weight: null,
        leftEye: null,
        rightEye: null,
        vitalCapacity: null,
        fiftyRun: null,
        longJump: null,
        sittingBodyBend: null,
        enduranceRunning: null,
        ftaId: null,
        otherItem: null,
        isFree: null,
        remark: null,
        createUid: null,
        createTime: null,
        updateUid: null,
        updateTime: null,
        grade: null
      };
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加体测成绩";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getFitness_score(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改体测成绩";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateFitness_score(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addFitness_score(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除体测成绩编号为"' + ids + '"的数据项？').then(function() {
        return delFitness_score(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/score/export', {
        ...this.queryParams
      }, `score_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
