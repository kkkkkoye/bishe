package com.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.validation.constraints.NotBlank;
import java.lang.reflect.InvocationTargetException;
import java.io.Serializable;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;

/**
 * 商家
 * 数据库通用操作实体类
 */
@TableName("shangjia")
public class ShangjiaEntity<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    public ShangjiaEntity() {
    }

    public ShangjiaEntity(T t) {
        try {
            BeanUtils.copyProperties(this, t);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    /**
     * 主键id
     */
    @TableId
    private Long id;

    /**
     * 商家账号
     */
    private String shangjiazhango;

    /**
     * 密码
     */
    private String mima;
    // --- 新增：性别字段 ---
    private String xingbie;

    /**
     * 商家姓名
     */
    private String shangjianame;

    /**
     * 店铺名称
     */
    private String dianpumingcheng;

    /**
     * 店铺头像
     */
    private String touxiang;

    /**
     * 联系方式
     */
    private String lianxifangshi;

    /**
     * 地址
     */
    private String dizhi;

    /**
     * 余额
     */
    private Float money;

    /**
     * 是否审核
     * 待审核 / 是 / 否
     */
    private String sfsh;

    /**
     * 审核回复
     * 管理员填写的审核反馈意见
     */
    private String shhf;

    @JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat
    private Date addtime;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getShangjiazhango() { return shangjiazhango; }
    public void setShangjiazhango(String shangjiazhango) { this.shangjiazhango = shangjiazhango; }

    public String getMima() { return mima; }
    public void setMima(String mima) { this.mima = mima; }

    public String getShangjianame() { return shangjianame; }
    public void setShangjianame(String shangjianame) { this.shangjianame = shangjianame; }

    public String getDianpumingcheng() { return dianpumingcheng; }
    public void setDianpumingcheng(String dianpumingcheng) { this.dianpumingcheng = dianpumingcheng; }

    public String getTouxiang() { return touxiang; }
    public void setTouxiang(String touxiang) { this.touxiang = touxiang; }

    public String getLianxifangshi() { return lianxifangshi; }
    public void setLianxifangshi(String lianxifangshi) { this.lianxifangshi = lianxifangshi; }

    public String getDizhi() { return dizhi; }
    public void setDizhi(String dizhi) { this.dizhi = dizhi; }

    public Float getMoney() { return money; }
    public void setMoney(Float money) { this.money = money; }

    public String getSfsh() { return sfsh; }
    public void setSfsh(String sfsh) { this.sfsh = sfsh; }

    public String getShhf() { return shhf; }
    public void setShhf(String shhf) { this.shhf = shhf; }

    public Date getAddtime() { return addtime; }
    public void setAddtime(Date addtime) { this.addtime = addtime; }

    public String getXingbie() { return xingbie; }
    public void setXingbie(String xingbie) { this.xingbie = xingbie; }
}