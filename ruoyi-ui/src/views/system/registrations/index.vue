<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="比赛" prop="gameId">
        <el-input
          v-model="queryParams.gameId"
          placeholder="请输入比赛"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="场地" prop="fieldId">
        <el-input
          v-model="queryParams.fieldId"
          placeholder="请输入场地"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="审核状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择审核状态" clearable>
          <el-option
            v-for="dict in dict.type.sport_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="比赛成绩" prop="score">
        <el-input
          v-model="queryParams.score"
          placeholder="请输入比赛成绩"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="比赛积分" prop="points">
        <el-input
          v-model="queryParams.points"
          placeholder="请输入比赛积分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="备注信息(是否破纪录等)" prop="comment">
        <el-input
          v-model="queryParams.comment"
          placeholder="请输入备注信息(是否破纪录等)"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['system:registrations:add']"
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
          v-hasPermi="['system:registrations:edit']"
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
          v-hasPermi="['system:registrations:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:registrations:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="registrationsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="id" align="center" prop="id" />
      <el-table-column label="比赛" align="center" prop="gameId" />
      <el-table-column label="用户" align="center" prop="userId" />
      <el-table-column label="场地" align="center" prop="fieldId" />
      <el-table-column label="审核状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sport_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="比赛成绩" align="center" prop="score" />
      <el-table-column label="比赛积分" align="center" prop="points" />
      <el-table-column label="备注信息(是否破纪录等)" align="center" prop="comment" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:registrations:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:registrations:remove']"
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

    <!-- 添加或修改报名管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="比赛" prop="gameId">
          <el-input v-model="form.gameId" placeholder="请输入比赛" />
        </el-form-item>
        <el-form-item label="用户" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户" />
        </el-form-item>
        <el-form-item label="场地" prop="fieldId">
          <el-input v-model="form.fieldId" placeholder="请输入场地" />
        </el-form-item>
        <el-form-item label="审核状态">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in dict.type.sport_status"
              :key="dict.value"
:label="dict.value"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="比赛成绩" prop="score">
          <el-input v-model="form.score" placeholder="请输入比赛成绩" />
        </el-form-item>
        <el-form-item label="比赛积分" prop="points">
          <el-input v-model="form.points" placeholder="请输入比赛积分" />
        </el-form-item>
        <el-form-item label="备注信息(是否破纪录等)" prop="comment">
          <el-input v-model="form.comment" placeholder="请输入备注信息(是否破纪录等)" />
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
import { listRegistrations, getRegistrations, delRegistrations, addRegistrations, updateRegistrations } from "@/api/system/registrations";

export default {
  name: "Registrations",
  dicts: ['sport_status'],
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
      // 报名管理表格数据
      registrationsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        gameId: null,
        userId: null,
        fieldId: null,
        status: null,
        score: null,
        points: null,
        comment: null,
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
    /** 查询报名管理列表 */
    getList() {
      this.loading = true;
      listRegistrations(this.queryParams).then(response => {
        this.registrationsList = response.rows;
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
        gameId: null,
        userId: null,
        fieldId: null,
        status: "0",
        score: null,
        points: null,
        comment: null,
        createTime: null,
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
      this.title = "添加报名管理";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getRegistrations(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改报名管理";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateRegistrations(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addRegistrations(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除报名管理编号为"' + ids + '"的数据项？').then(function() {
        return delRegistrations(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/registrations/export', {
        ...this.queryParams
      }, `registrations_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
