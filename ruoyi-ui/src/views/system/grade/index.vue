<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户名" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="体测活动" prop="ftaId">
        <el-select v-model="queryParams.ftaId" placeholder="请输入体测活动" clearable>
          <el-option
            v-for="dict in dictAct"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
<!--        <el-input-->
<!--          v-model="queryParams.ftaId"-->
<!--          placeholder="请输入体测活动"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
      </el-form-item>
      <el-form-item label="项目id" prop="itemId">
        <el-select v-model="queryParams.itemId" placeholder="请选择项目" clearable>
          <el-option
            v-for="dict in dictItem"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
<!--        <el-input-->
<!--          v-model="queryParams.itemId"-->
<!--          placeholder="请输入项目id"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
      </el-form-item>
<!--      <el-form-item label="成绩" prop="score">-->
<!--        <el-input-->
<!--          v-model="queryParams.score"-->
<!--          placeholder="请输入成绩"-->
<!--          clearable-->
<!--          @keyup.enter.native="handleQuery"-->
<!--        />-->
<!--      </el-form-item>-->

      <el-form-item label="创建人" prop="createUid">
        <el-input
          v-model="queryParams.createUid"
          placeholder="请输入创建人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="修改人" prop="updateUid">
        <el-input
          v-model="queryParams.updateUid"
          placeholder="请输入最后修改的人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建时间" prop="createTime">
        <el-date-picker clearable
                        v-model="queryParams.createTime"
                        type="datetime"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-date-picker clearable
                        v-model="queryParams.updateTime"
                        type="datetime"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择最后更新时间">
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
          v-hasPermi="['system:grade:add']"
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
          v-hasPermi="['system:grade:edit']"
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
          v-hasPermi="['system:grade:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:grade:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="gradeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="成绩编码" align="center" prop="id" />
      <el-table-column label="用户名" align="center" prop="userId" />
      <el-table-column label="体测活动" align="center" prop="fta.name" />
      <el-table-column label="项目id" align="center" prop="item.itemName" />
      <el-table-column label="成绩" align="center" prop="score">
        <template slot-scope="scope">
          <span>{{ scope.row.score }}{{ scope.row.item.unit }}</span>
        </template>
      </el-table-column>
      <el-table-column label="备注信息" align="center" prop="remark" />
      <el-table-column label="创建人" align="center" prop="createUid" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="最后修改的人" align="center" prop="updateUid" />
      <el-table-column label="最后更新时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:grade:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:grade:remove']"
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
        <el-form-item label="用户名" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="体测活动" prop="ftaId">
          <el-select v-model="form.ftaId" placeholder="请选择项目" clearable>
            <el-option
              v-for="dict in dictAct"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
<!--          <el-input v-model="form.ftaId" placeholder="请输入体测活动" />-->
        </el-form-item>
        <el-form-item label="项目id" prop="itemId">
          <el-select v-model="form.itemId" placeholder="请选择项目" clearable>
            <el-option
              v-for="dict in dictItem"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
<!--          <el-input v-model="form.itemId" placeholder="请输入项目id" />-->
        </el-form-item>
        <el-form-item label="成绩" prop="score">
          <el-input-number v-model="form.score" placeholder="请输入成绩" />
        </el-form-item>
        <el-form-item label="备注信息" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
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
import { listGrade, getGrade, delGrade, addGrade, updateGrade } from "@/api/system/grade";
import { activityDict } from "@/api/system/activity";
import { dictItem } from "@/api/system/item";
export default {
  name: "Grade",
  data() {
    return {
      // 项目字典
      dictItem: [],
      // 活动字典
      dictAct: [],
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
      gradeList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        ftaId: null,
        itemId: null,
        score: null,
        createUid: null,
        createTime: null,
        updateUid: null,
        updateTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "用户名不能为空", trigger: "blur" }
        ],
        ftaId: [
          { required: true, message: "体测活动不能为空", trigger: "blur" }
        ],
        itemId: [
          { required: true, message: "项目id不能为空", trigger: "blur" }
        ],
        score: [
          { required: true, message: "成绩不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
    // 获取活动字典
    activityDict().then(res => {
      this.dictAct = res.data;
    })
    // 获取项目字典
    dictItem().then(res => {
      this.dictItem = res.data;
    })

  },
  methods: {
    /** 查询体测成绩列表 */
    getList() {
      this.loading = true;
      listGrade(this.queryParams).then(response => {
        this.gradeList = response.rows;
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
        ftaId: null,
        itemId: null,
        score: null,
        remark: null,
        createUid: null,
        createTime: null,
        updateUid: null,
        updateTime: null
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
      getGrade(id).then(response => {
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
            updateGrade(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addGrade(this.form).then(response => {
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
        return delGrade(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/grade/export', {
        ...this.queryParams
      }, `grade_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
