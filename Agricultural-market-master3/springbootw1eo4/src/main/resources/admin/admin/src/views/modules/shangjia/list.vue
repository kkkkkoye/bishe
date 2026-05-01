<template>
  <div class="main-content" :style='{"padding":"0px 3%"}'>
    <!-- 列表页 -->
    <template v-if="showFlag">
      <el-form class="center-form-pv" :style='{"margin":"20px 0 20px 0","position":"relative"}' :inline="true" :model="searchForm">
        <el-row :style='{"width":"150px","position":"absolute","top":"20px","left":"0","display":"block","zIndex":"1003"}' >
          <div :style='{"margin":"0 0 5px","display":"inline-block"}'>
            <label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"left","display":"inline-block","width":"100px","lineHeight":"40px","fontSize":"14px","fontWeight":"600","height":"40px"}' class="item-label">商家账号</label>
            <el-input v-model="searchForm.shangjiazhango" placeholder="商家账号" clearable></el-input>
          </div>
          <div :style='{"margin":"0 0 5px","display":"inline-block"}'>
            <label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"left","display":"inline-block","width":"100px","lineHeight":"40px","fontSize":"14px","fontWeight":"600","height":"40px"}' class="item-label">商家名称</label>
            <el-input v-model="searchForm.shangjianame" placeholder="商家名称" clearable></el-input>
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
          <el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 10px 0 0","outline":"none","color":"#333","borderRadius":"40px","background":"rgba(184, 222, 74, 1)","width":"auto","fontSize":"14px","height":"40px"}' v-if="isAuth('shangjia','新增')" type="success" @click="addOrUpdateHandler()">新增</el-button>
          <el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 10px 0 0","outline":"none","color":"#333","borderRadius":"40px","background":"rgba(184, 222, 74, 1)","width":"auto","fontSize":"14px","height":"40px"}' v-if="isAuth('shangjia','删除')" :disabled="dataListSelections.length <= 0" type="danger" @click="deleteHandler()">删除</el-button>
        </el-row>
      </el-form>

      <el-table class="tables"
                :stripe='false'
                :style='{"padding":"0","borderColor":"#eee","margin":"0 0 0 180px","borderWidth":"1px","background":"#fff","flex":"1","width":"auto","borderStyle":"solid"}'
                v-if="isAuth('shangjia','查看')"
                :data="dataList"
                v-loading="dataListLoading"
                @selection-change="selectionChangeHandler">

        <el-table-column type="selection" align="center" width="50"></el-table-column>
        <el-table-column label="索引" type="index" width="50" />
        <el-table-column prop="shangjiazhango" label="商家账号" width="120"></el-table-column>
        <el-table-column prop="shangjianame" label="商家名称" width="120"></el-table-column>

        <el-table-column prop="touxiang" width="100" label="头像">
          <template slot-scope="scope">
            <div v-if="scope.row.touxiang">
              <img :src="$base.url+scope.row.touxiang.split(',')[0]" width="80" height="80" style="border-radius:4px">
            </div>
            <div v-else>无图片</div>
          </template>
        </el-table-column>

        <!-- 修复：性别显示 -->
        <el-table-column prop="xingbie" label="性别" width="80"></el-table-column>

        <el-table-column prop="lianxifangshi" label="联系方式" width="120"></el-table-column>

        <!-- 修复：审核状态逻辑（处理空值情况） -->
        <el-table-column prop="sfsh" label="审核状态" width="100">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.sfsh=='是'" type="success">已入驻</el-tag>
            <el-tag v-else-if="scope.row.sfsh=='否'" type="danger">拒绝</el-tag>
            <el-tag v-else type="warning">待审核</el-tag>
          </template>
        </el-table-column>

        <el-table-column prop="shhf" label="审核回复" show-overflow-tooltip></el-table-column>

        <!-- 修复：操作列宽度调大到 350，解决按钮挤在一起的问题 -->
        <el-table-column width="350" label="操作" fixed="right">
          <template slot-scope="scope">
            <el-button size="mini" type="text" icon="el-icon-view" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
            <el-button size="mini" type="text" icon="el-icon-edit" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>

            <!-- 审核按钮独立出来，增加颜色标识 -->
            <el-button size="mini" type="text" style="color:#B8DE4A;font-weight:bold" icon="el-icon-s-check" @click="shDialog(scope.row)">审核</el-button>

            <el-button size="mini" type="text" style="color:red" icon="el-icon-delete" @click="deleteHandler(scope.row.id)">删除</el-button>
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
          :style='{"padding":"0","margin":"20px 0 0 180px","textAlign":"center"}'
      ></el-pagination>
    </template>

    <!-- 添加/修改页面 -->
    <add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>

    <!-- 审核弹窗 -->
    <el-dialog title="商家资质审核" :visible.sync="sfshVisiable" width="400px">
      <el-form ref="form" :model="shForm" label-width="80px" style="padding: 20px;">
        <el-form-item label="结果">
          <el-select v-model="shForm.sfsh" placeholder="请选择" style="width: 100%">
            <el-option label="通过" value="是"></el-option>
            <el-option label="拒绝" value="否"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="回复">
          <el-input type="textarea" :rows="4" v-model="shForm.shhf" placeholder="请输入审核意见"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="sfshVisiable = false">取 消</el-button>
        <el-button type="primary" @click="shHandler">确 定</el-button>
      </div>
    </el-dialog>
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
      sfshVisiable: false, // 弹窗控制
      shForm: {},          // 弹窗表单
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
      if(this.searchForm.shangjiazhango) params['shangjiazhango'] = '%' + this.searchForm.shangjiazhango + '%'
      if(this.searchForm.shangjianame) params['shangjianame'] = '%' + this.searchForm.shangjianame + '%'
      if(this.searchForm.xingbie) params['xingbie'] = this.searchForm.xingbie

      this.$http({
        url: "shangjia/page",
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

    // --- 核心修改 1：打开审核弹窗 ---
    shDialog(row) {
      this.sfshVisiable = true;
      // 使用 JSON 转换进行深拷贝，防止直接修改表格行数据
      this.shForm = JSON.parse(JSON.stringify(row));
    },

    // --- 核心修改 2：提交审核结果 ---
    shHandler() {
      // 同样为了防止 500 错误，删除可能导致解析失败的时间字段
      delete this.shForm.addtime;

      this.$http({
        url: "shangjia/update", // 通常标准项目用 update 接口即可修改审核状态
        method: "post",
        data: this.shForm
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message.success("审核操作已完成");
          this.sfshVisiable = false;
          this.getDataList(); // 刷新列表
        } else {
          this.$message.error(data.msg);
        }
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
      this.$confirm(`确定进行删除操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "shangjia/delete",
          method: "post",
          data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success("操作成功");
            this.getDataList();
          }
        });
      });
    }
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
