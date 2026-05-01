<template>
  <div class="main-content" :style='{"padding":"0px 3%"}'>
    <!-- 列表页 -->
    <template v-if="showFlag">
      <el-form class="center-form-pv" :style='{"margin":"20px 0 20px 0","position":"relative"}' :inline="true" :model="searchForm">
        <el-row :style='{"width":"150px","position":"absolute","top":"20px","left":"0","display":"block","zIndex":"1003"}' >
          <div :style='{"margin":"0 0 5px","display":"inline-block"}'>
            <label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"left","display":"inline-block","width":"100px","lineHeight":"40px","fontSize":"14px","fontWeight":"600","height":"40px"}' class="item-label">用户账号</label>
            <el-input v-model="searchForm.yonghuzhanghao" placeholder="用户账号" clearable></el-input>
          </div>
          <div :style='{"margin":"0 0 5px","display":"inline-block"}'>
            <label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"left","display":"inline-block","width":"100px","lineHeight":"40px","fontSize":"14px","fontWeight":"600","height":"40px"}' class="item-label">用户姓名</label>
            <el-input v-model="searchForm.yonghuxingming" placeholder="用户姓名" clearable></el-input>
          </div>
          <div :style='{"margin":"0 0 5px","display":"inline-block"}' class="select" label="性别" prop="xingbie">
            <label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"left","display":"inline-block","width":"100px","lineHeight":"40px","fontSize":"14px","fontWeight":"600","height":"40px"}' class="item-label">性别</label>
            <el-select  @change="xingbieChange" clearable v-model="searchForm.xingbie" placeholder="请选择性别">
              <el-option v-for="(item,index) in xingbieOptions" v-bind:key="index" :label="item" :value="item"></el-option>
            </el-select>
          </div>
          <el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","outline":"none","margin":"10px 0 0 0","color":"#fff","borderRadius":"4px","background":"rgba(184, 222, 74, 1)","width":"150px","fontSize":"14px","height":"40px"}' type="success" @click="search()">查询</el-button>
        </el-row>

        <el-row :style='{"margin":"0","justifyContent":"flex-end","display":"flex"}'>
          <el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 10px 0 0","outline":"none","color":"#333","borderRadius":"40px","background":"rgba(184, 222, 74, 1)","width":"auto","fontSize":"14px","height":"40px"}' v-if="isAuth('yonghu','新增')" type="success" @click="addOrUpdateHandler()">新增</el-button>
          <el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 10px 0 0","outline":"none","color":"#333","borderRadius":"40px","background":"rgba(184, 222, 74, 1)","width":"auto","fontSize":"14px","height":"40px"}' v-if="isAuth('yonghu','删除')" :disabled="dataListSelections.length <= 0" type="danger" @click="deleteHandler()">删除</el-button>
        </el-row>
      </el-form>

      <el-table class="tables"
                :stripe='false'
                :style='{"padding":"0","borderColor":"#eee","margin":"0 0 0 180px","borderWidth":"1px","background":"#fff","flex":"1","width":"auto","borderStyle":"solid"}'
                v-if="isAuth('yonghu','查看')"
                :data="dataList"
                v-loading="dataListLoading"
                @selection-change="selectionChangeHandler">
        <el-table-column :resizable='true' type="selection" align="center" width="50"></el-table-column>
        <el-table-column :resizable='true' :sortable='false' label="索引" type="index" width="50" />
        <el-table-column prop="yonghuzhanghao" label="用户账号"></el-table-column>
        <el-table-column prop="yonghuxingming" label="用户姓名"></el-table-column>
        <el-table-column prop="touxiang" width="130" label="头像">
          <template slot-scope="scope">
            <div v-if="scope.row.touxiang">
              <img v-if="scope.row.touxiang.substring(0,4)=='http'" :src="scope.row.touxiang.split(',')[0]" width="100" height="100">
              <img v-else :src="$base.url+scope.row.touxiang.split(',')[0]" width="100" height="100">
            </div>
            <div v-else>无图片</div>
          </template>
        </el-table-column>
        <el-table-column prop="xingbie" label="性别"></el-table-column>
        <el-table-column prop="lianxifangshi" label="联系方式"></el-table-column>

        <!-- 账号状态显示 -->
        <el-table-column prop="status" label="账号状态" sortable>
          <template slot-scope="scope">
            <el-tag v-if="scope.row.status=='正常' || !scope.row.status" type="success">正常</el-tag>
            <el-tag v-else type="danger">已封号</el-tag>
          </template>
        </el-table-column>

        <!-- 禁言显示 -->
        <el-table-column prop="jinyan" label="是否禁言" sortable>
          <template slot-scope="scope">
            <el-tag v-if="scope.row.jinyan=='是'" type="warning">禁言中</el-tag>
            <el-tag v-else type="info">活跃</el-tag>
          </template>
        </el-table-column>

        <el-table-column width="350" label="操作">
          <template slot-scope="scope">
            <el-button :style='{"border":"1px solid #AAAAAA","cursor":"pointer","padding":"0 12px","margin":"0 6px 5px 0","color":"#AAAAAA","borderRadius":"20px","background":"#fff","fontSize":"12px","height":"32px"}' v-if="isAuth('yonghu','查看')" type="success" size="mini" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
            <el-button :style='{"border":"1px solid #AAAAAA","cursor":"pointer","padding":"0 12px","margin":"0 6px 5px 0","color":"#AAAAAA","borderRadius":"20px","background":"#fff","fontSize":"12px","height":"32px"}' v-if="isAuth('yonghu','修改')" type="primary" size="mini" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>

            <!-- 状态管理按钮 -->
            <el-button v-if="scope.row.status=='正常' || !scope.row.status"
                       type="text" size="mini" style="color: #F56C6C" @click="statusChange(scope.row, '封号')">封号</el-button>
            <el-button v-else
                       type="text" size="mini" style="color: #67C23A" @click="statusChange(scope.row, '正常')">解封</el-button>

            <!-- 禁言管理按钮 -->
            <el-button v-if="scope.row.jinyan=='是'"
                       type="text" size="mini" style="color: #409EFF" @click="jinyanChange(scope.row, '否')">取消禁言</el-button>
            <el-button v-else
                       type="text" size="mini" style="color: #E6A23C" @click="jinyanChange(scope.row, '是')">禁言</el-button>

            <el-button :style='{"border":"1px solid #AAAAAA","cursor":"pointer","padding":"0 12px","margin":"0 6px 5px 0","color":"#AAAAAA","borderRadius":"20px","background":"#fff","fontSize":"12px","height":"32px"}' v-if="isAuth('yonghu','删除')" type="danger" size="mini" @click="deleteHandler(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="pageIndex"
          background
          :page-sizes="[10, 20, 30, 50]"
          :page-size="pageSize"
          :layout="layouts.join()"
          :total="totalPage"
          prev-text="<"
          next-text=">"
          :style='{"padding":"0","margin":"20px 0 0 180px","textAlign":"center"}'
      ></el-pagination>
    </template>

    <!-- 添加/修改页面 -->
    <add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>
  </div>
</template>

<script>
import AddOrUpdate from "./add-or-update";
export default {
  data() {
    return {
      searchForm: { key: "" },
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      showFlag: true,
      addOrUpdateFlag: false,
      xingbieOptions: [],
      layouts: ["total","prev","pager","next","sizes","jumper"],
    };
  },
  created() {
    this.init();
    this.getDataList();
  },
  components: { AddOrUpdate },
  methods: {
    init() {
      this.xingbieOptions = "男,女".split(',');
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    getDataList() {
      this.dataListLoading = true;
      let params = {
        page: this.pageIndex,
        limit: this.pageSize,
        sort: 'id',
        order: 'desc',
      }
      if(this.searchForm.yonghuzhanghao) params['yonghuzhanghao'] = '%' + this.searchForm.yonghuzhanghao + '%'
      if(this.searchForm.yonghuxingming) params['yonghuxingming'] = '%' + this.searchForm.yonghuxingming + '%'
      if(this.searchForm.xingbie) params['xingbie'] = this.searchForm.xingbie

      this.$http({
        url: "yonghu/page",
        method: "get",
        params: params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.data.list;
          this.totalPage = data.data.total;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
    selectionChangeHandler(val) {
      this.dataListSelections = val;
    },
    addOrUpdateHandler(id, type) {
      this.showFlag = false;
      this.addOrUpdateFlag = true;
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(id, type === 'info' ? 'info' : 'else');
      });
    },
    deleteHandler(id) {
      var ids = id ? [Number(id)] : this.dataListSelections.map(item => Number(item.id));
      this.$confirm(`确定进行操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "yonghu/delete",
          method: "post",
          data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success("操作成功");
            this.getDataList();
          }
        });
      });
    },

    // --- 核心逻辑修改：封号 ---
    statusChange(row, status) {
      this.$confirm(`确定改为【${status}】状态吗?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        let updateData = JSON.parse(JSON.stringify(row));
        updateData.status = status;
        // 关键：删除时间字段，防止 500 报错
        delete updateData.addtime;

        this.$http({
          url: `yonghu/update`,
          method: "post",
          data: updateData
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success("操作成功");
            this.getDataList();
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },

    // --- 核心逻辑修改：禁言 ---
    jinyanChange(row, jinyan) {
      const msg = jinyan === '是' ? '禁言' : '取消禁言';
      this.$confirm(`确定进行【${msg}】操作吗?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        let updateData = JSON.parse(JSON.stringify(row));
        updateData.jinyan = jinyan;
        // 关键：删除时间字段，防止 500 报错
        delete updateData.addtime;

        this.$http({
          url: `yonghu/update`,
          method: "post",
          data: updateData
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success("操作成功");
            this.getDataList();
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
  }
};
</script>
<style lang="scss" scoped>

	.center-form-pv {
	  .el-date-editor.el-input {
	    width: auto;
	  }
	}

	.el-input {
	  width: auto;
	}

	// form
	.center-form-pv .el-input ::v-deep .el-input__inner {
				border: 2px solid #B8DE4A;
				border-radius: 4px;
				padding: 0 12px;
				outline: none;
				color: rgba(0, 0, 0, 1);
				width: 150px;
				font-size: 14px;
				height: 40px;
			}

	.center-form-pv .el-select ::v-deep .el-input__inner {
				border: 2px solid #B8DE4A;
				border-radius: 4px;
				padding: 0 10px;
				outline: none;
				color: rgba(0, 0, 0, 1);
				width: 150px;
				font-size: 14px;
				height: 40px;
			}

	.center-form-pv .el-date-editor ::v-deep .el-input__inner {
				border: 2px solid #B8DE4A;
				border-radius: 4px;
				padding: 0 10px 0 30px;
				outline: none;
				color: rgba(0, 0, 0, 1);
				width: 150px;
				font-size: 14px;
				height: 40px;
			}

	// table
	.el-table ::v-deep .el-table__header-wrapper thead {
				color: #333;
				font-weight: 500;
				width: 100%;
			}

	.el-table ::v-deep .el-table__header-wrapper thead tr {
				background: #fff;
			}

	.el-table ::v-deep .el-table__header-wrapper thead tr th {
				padding: 12px 0;
				background: rgba(226, 226, 226, 1);
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}

	.el-table ::v-deep .el-table__header-wrapper thead tr th .cell {
				padding: 0 10px;
				word-wrap: normal;
				word-break: break-all;
				white-space: normal;
				font-weight: bold;
				display: inline-block;
				vertical-align: middle;
				width: 100%;
				line-height: 24px;
				position: relative;
				text-overflow: ellipsis;
			}


	.el-table ::v-deep .el-table__body-wrapper tbody {
				width: 100%;
			}

	.el-table ::v-deep .el-table__body-wrapper tbody tr {
				background: #fff;
			}

	.el-table ::v-deep .el-table__body-wrapper tbody tr td {
				padding: 6px 0;
				color: #999;
				background: #fff;
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}


	.el-table ::v-deep .el-table__body-wrapper tbody tr:hover td {
				padding: 6px 0;
				color: #333;
				background: rgba(226, 226, 226, .2);
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}

	.el-table ::v-deep .el-table__body-wrapper tbody tr td {
				padding: 6px 0;
				color: #999;
				background: #fff;
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}

	.el-table ::v-deep .el-table__body-wrapper tbody tr td .cell {
				padding: 0 10px;
				overflow: hidden;
				word-break: break-all;
				white-space: normal;
				line-height: 24px;
				text-overflow: ellipsis;
			}

	// pagination
	.main-content .el-pagination ::v-deep .el-pagination__total {
				margin: 0 10px 0 0;
				color: #666;
				font-weight: 400;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .btn-prev {
				border: none;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #666;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				min-width: 35px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .btn-next {
				border: none;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #666;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				min-width: 35px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .btn-prev:disabled {
				border: none;
				cursor: not-allowed;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #C0C4CC;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .btn-next:disabled {
				border: none;
				cursor: not-allowed;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #C0C4CC;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pager {
				padding: 0;
				margin: 0;
				display: inline-block;
				vertical-align: top;
			}

	.main-content .el-pagination ::v-deep .el-pager .number {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #666;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #f4f4f5;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pager .number:hover {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #b8de4a;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #f4f4f5;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pager .number.active {
				cursor: default;
				padding: 0 4px;
				margin: 0 5px;
				color: #FFF;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #b8de4a;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pagination__sizes {
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input {
				margin: 0 5px;
				width: 100px;
				position: relative;
			}

	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input .el-input__inner {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0 25px 0 8px;
				color: #606266;
				display: inline-block;
				font-size: 13px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input span.el-input__suffix {
				top: 0;
				position: absolute;
				right: 0;
				height: 100%;
			}

	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input .el-input__suffix .el-select__caret {
				cursor: pointer;
				color: #C0C4CC;
				width: 25px;
				font-size: 14px;
				line-height: 28px;
				text-align: center;
			}

	.main-content .el-pagination ::v-deep .el-pagination__jump {
				margin: 0 0 0 24px;
				color: #606266;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pagination__jump .el-input {
				border-radius: 3px;
				padding: 0 2px;
				margin: 0 2px;
				display: inline-block;
				width: 50px;
				font-size: 14px;
				line-height: 18px;
				position: relative;
				text-align: center;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pagination__jump .el-input .el-input__inner {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0 3px;
				color: #606266;
				display: inline-block;
				font-size: 14px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
			}
</style>
