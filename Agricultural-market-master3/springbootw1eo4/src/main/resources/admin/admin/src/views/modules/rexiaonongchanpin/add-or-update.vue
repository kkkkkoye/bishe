<template>
  <div class="addEdit-block" :style='{"padding":"0px 3%"}' style="width: 100%;">
    <el-form
        :style='{"borderRadius":"0px","padding":"20px 0 0","margin":"0px"}'
        class="add-update-preview"
        ref="ruleForm"
        :model="ruleForm"
        :rules="rules"
        label-width="140px"
    >
      <template >
        <!-- 基础信息部分 -->
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="input" v-if="type!='info'" label="产品编号" prop="chanpinbianhao">
          <el-input v-model="ruleForm.chanpinbianhao" placeholder="产品编号" readonly></el-input>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="input" v-else-if="ruleForm.chanpinbianhao" label="产品编号" prop="chanpinbianhao">
          <el-input v-model="ruleForm.chanpinbianhao" placeholder="产品编号" readonly></el-input>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="input" v-if="type!='info'"  label="农产品名称" prop="nongchanpinmingcheng">
          <el-input v-model="ruleForm.nongchanpinmingcheng" placeholder="农产品名称" clearable  :readonly="ro.nongchanpinmingcheng"></el-input>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' v-else class="input" label="农产品名称" prop="nongchanpinmingcheng">
          <el-input v-model="ruleForm.nongchanpinmingcheng" placeholder="农产品名称" readonly></el-input>
        </el-form-item>

        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="upload" v-if="type!='info' && !ro.nongchanpintupian" label="农产品图片" prop="nongchanpintupian">
          <file-upload
              tip="点击上传农产品图片"
              action="file/upload"
              :limit="3"
              :multiple="true"
              :fileUrls="ruleForm.nongchanpintupian?ruleForm.nongchanpintupian:''"
              @change="nongchanpintupianUploadChange"
          ></file-upload>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="upload" v-else-if="ruleForm.nongchanpintupian" label="农产品图片" prop="nongchanpintupian">
          <img v-if="ruleForm.nongchanpintupian.substring(0,4)=='http'" class="upload-img" style="margin-right:20px;" v-bind:key="index" :src="ruleForm.nongchanpintupian.split(',')[0]" width="100" height="100">
          <img v-else class="upload-img" style="margin-right:20px;" v-bind:key="index" v-for="(item,index) in ruleForm.nongchanpintupian.split(',')" :src="$base.url+item" width="100" height="100">
        </el-form-item>

        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="select" v-if="type!='info'"  label="产品分类" prop="chanpinfenlei">
          <el-select :disabled="ro.chanpinfenlei" v-model="ruleForm.chanpinfenlei" placeholder="请选择产品分类" >
            <el-option v-for="(item,index) in chanpinfenleiOptions" v-bind:key="index" :label="item" :value="item"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' v-else class="input" label="产品分类" prop="chanpinfenlei">
          <el-input v-model="ruleForm.chanpinfenlei" placeholder="产品分类" readonly></el-input>
        </el-form-item>

        <!-- 价格与库存 -->
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="input" v-if="type!='info'"  label="销售价格" prop="price">
          <el-input v-model="ruleForm.price" placeholder="销售价格" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' v-else class="input" label="价格" prop="price">
          <el-input v-model="ruleForm.price" placeholder="价格" readonly></el-input>
        </el-form-item>

        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="input" v-if="type!='info'"  label="库存" prop="alllimittimes">
          <el-input v-model="ruleForm.alllimittimes" placeholder="库存数量" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' v-else class="input" label="库存" prop="alllimittimes">
          <el-input v-model="ruleForm.alllimittimes" placeholder="库存" readonly></el-input>
        </el-form-item>

        <!-- === 营销模块开始 === -->
        <el-divider content-position="left">营销功能设置</el-divider>

        <!-- 1. 团购功能 -->
        <el-row>
          <el-col :span="12">
            <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none"}' class="select" v-if="type!='info'"  label="开启团购" prop="istuan">
              <el-select v-model="ruleForm.istuan" placeholder="请选择是否开启团购" >
                <el-option label="是" value="是"></el-option>
                <el-option label="否" value="否"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none"}' class="input" v-if="type!='info' && ruleForm.istuan=='是'"  label="团购价格" prop="tuanprice">
              <el-input v-model="ruleForm.tuanprice" placeholder="成团后的单价" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 2. 积分兑换 -->
        <el-row>
          <el-col :span="12">
            <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none"}' class="select" v-if="type!='info'"  label="积分兑换" prop="isjifen">
              <el-select v-model="ruleForm.isjifen" placeholder="是否允许积分兑换" >
                <el-option label="是" value="是"></el-option>
                <el-option label="否" value="否"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none"}' class="input" v-if="type!='info' && ruleForm.isjifen=='是'"  label="所需积分" prop="jifencost">
              <el-input v-model="ruleForm.jifencost" placeholder="兑换所需积分值" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 3. 限时降价活动 -->
        <el-row>
          <el-col :span="8">
            <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none"}' class="input" v-if="type!='info'" label="限时折扣" prop="reducediscount">
              <el-input v-model="ruleForm.reducediscount" placeholder="如0.8代表8折, 1为不打折"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none"}' class="date" v-if="type!='info'" label="活动开始" prop="reducestarttime">
              <el-date-picker v-model="ruleForm.reducestarttime" type="datetime" placeholder="活动开始时间" value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none"}' class="date" v-if="type!='info'" label="活动结束" prop="reduceendtime">
              <el-date-picker v-model="ruleForm.reduceendtime" type="datetime" placeholder="活动结束时间" value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <!-- === 营销模块结束 === -->

        <!-- 产地品牌等次要信息 -->
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="input" v-if="type!='info'"  label="品牌" prop="pinpai">
          <el-input v-model="ruleForm.pinpai" placeholder="品牌" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' class="input" v-if="type!='info'"  label="产地" prop="chandi">
          <el-input v-model="ruleForm.chandi" placeholder="产地" clearable></el-input>
        </el-form-item>
      </template>

      <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' v-if="type!='info'"  label="农产品介绍" prop="nongchanpinjieshao">
        <editor style="min-width: 200px; max-width: 600px;" v-model="ruleForm.nongchanpinjieshao" class="editor" action="file/upload"></editor>
      </el-form-item>
      <el-form-item :style='{"width":"100%","margin":"0 0 20px","background":"none","display":"inline-block"}' v-else-if="ruleForm.nongchanpinjieshao" label="农产品介绍" prop="nongchanpinjieshao">
        <span :style='{"fontSize":"14px","lineHeight":"40px","color":"#333","fontWeight":"500","display":"inline-block"}' v-html="ruleForm.nongchanpinjieshao"></span>
      </el-form-item>

      <el-form-item :style='{"padding":"0","margin":"0"}' class="btn">
        <el-button :style='{"border":"0","cursor":"pointer","padding":"0","margin":"0 20px 0 0","outline":"none","color":"rgba(255, 255, 255, 1)","borderRadius":"40px","background":"rgba(184, 222, 74, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}'  v-if="type!='info'" type="primary" class="btn-success" @click="onSubmit">提交保存</el-button>
        <el-button :style='{"border":"2px solid rgba(184, 222, 74, 1)","cursor":"pointer","padding":"0","margin":"0","outline":"none","color":"rgba(184, 222, 74, 1)","borderRadius":"40px","background":"rgba(255, 255, 255, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-if="type!='info'" class="btn-close" @click="back()">取消</el-button>
        <el-button :style='{"border":"2px solid rgba(184, 222, 74, 1)","cursor":"pointer","padding":"0","margin":"0","outline":"none","color":"rgba(184, 222, 74, 1)","borderRadius":"40px","background":"rgba(255, 255, 255, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-if="type=='info'" class="btn-close" @click="back()">返回</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { isNumber, isIntNumer } from "@/utils/validate";
export default {
  data() {
    return {
      id: '',
      type: '',
      ro:{
        chanpinbianhao : false,
        nongchanpinmingcheng : false,
        nongchanpintupian : false,
        chanpinfenlei : false,
        price : false,
        alllimittimes : false,
        istuan: false,
        tuanprice: false,
        isjifen: false,
        jifencost: false,
        reducediscount: false,
        reducestarttime: false,
        reduceendtime: false
      },
      ruleForm: {
        chanpinbianhao: new Date().getTime(),
        nongchanpinmingcheng: '',
        nongchanpintupian: '',
        chanpinfenlei: '',
        price: '',
        alllimittimes: '-1',
        istuan: '否',
        tuanprice: 0,
        isjifen: '否',
        jifencost: 0,
        reducediscount: 1,
        reducestarttime: '',
        reduceendtime: '',
        nongchanpinjieshao: '',
      },
      chanpinfenleiOptions: [],
      rules: {
        price: [
          { required: true, message: '价格不能为空', trigger: 'blur' },
          { validator: (rule, value, callback) => {
              if(!isNumber(value)) callback(new Error("请输入正确的价格"));
              else callback();
            }, trigger: 'blur' }
        ],
        alllimittimes: [{ validator: (rule, value, callback) => {
            if(!isIntNumer(value)) callback(new Error("请输入整数库存"));
            else callback();
          }, trigger: 'blur' }],
        tuanprice: [{ validator: (rule, value, callback) => {
            if(value && !isNumber(value)) callback(new Error("团购价格需为数字"));
            else callback();
          }, trigger: 'blur' }],
        jifencost: [{ validator: (rule, value, callback) => {
            if(value && !isIntNumer(value)) callback(new Error("积分需为整数"));
            else callback();
          }, trigger: 'blur' }],
        reducediscount: [{ validator: (rule, value, callback) => {
            if(value > 1 || value <= 0) callback(new Error("折扣需在0-1之间"));
            else callback();
          }, trigger: 'blur' }]
      }
    };
  },
  props: ["parent"],
  methods: {
    init(id,type) {
      if (id) {
        this.id = id;
        this.type = type;
        this.info(id);
      }
      // 获取分类
      this.$http({
        url: `option/chanpinfenlei/chanpinfenlei`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.chanpinfenleiOptions = data.data;
        }
      });
    },
    info(id) {
      this.$http({
        url: `rexiaonongchanpin/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.ruleForm = data.data;
        }
      });
    },
    onSubmit() {
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          this.$http({
            url: `rexiaonongchanpin/${!this.ruleForm.id ? "save" : "update"}`,
            method: "post",
            data: this.ruleForm
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message.success("保存成功");
              this.back();
              this.parent.search();
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      });
    },
    getUUID() { return new Date().getTime(); },
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
    },
    nongchanpintupianUploadChange(fileUrls) {
      this.ruleForm.nongchanpintupian = fileUrls;
    },
  }
};
</script>