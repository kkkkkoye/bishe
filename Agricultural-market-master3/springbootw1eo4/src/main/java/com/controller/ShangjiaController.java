package com.controller;

import java.util.Arrays;
import java.util.Map;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.entity.ShangjiaEntity;
import com.service.ShangjiaService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.service.TokenService;
import com.annotation.IgnoreAuth;

/**
 * 商家管理 - 包含：入驻审核、强制关店、资料维护
 */
@RestController
@RequestMapping("/shangjia")
public class ShangjiaController {
    @Autowired
    private ShangjiaService shangjiaService;

    @Autowired
    private TokenService tokenService;

    /**
     * 商家列表 - 管理员监察所有商家
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, ShangjiaEntity shangjia, HttpServletRequest request){
        EntityWrapper<ShangjiaEntity> ew = new EntityWrapper<ShangjiaEntity>();
        PageUtils page = shangjiaService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shangjia), params), params));
        return R.ok().put("data", page);
    }

    /**
     * 商家登录 - 增加审核状态判断 (对应管理员把关需求)
     */
    @IgnoreAuth
    @RequestMapping(value = "/login")
    public R login(String username, String password, HttpServletRequest request) {
        ShangjiaEntity user = shangjiaService.selectOne(new EntityWrapper<ShangjiaEntity>().eq("shangjiazhango", username));
        if(user==null || !user.getMima().equals(password)) {
            return R.error("账号或密码错误");
        }
        // --- 核心修改：权限把关 ---
        if("否".equals(user.getSfsh())) return R.error("您的入驻申请已被拒绝或店铺已被强行关闭，请联系管理员");
        if("待审核".equals(user.getSfsh())) return R.error("您的申请正在审核中，请耐心等待");
        // -----------------------

        String token = tokenService.generateToken(user.getId(), username, "shangjia", "商家");
        return R.ok().put("token", token);
    }

    /**
     * 管理员审核商家 (对应文档：审核申请、强制关店)
     */
    @RequestMapping("/sh")
    public R shenhe(@RequestBody ShangjiaEntity shangjia){
        // 管理员通过此接口修改 sfsh 为 '是' (通过) 或 '否' (关店/拒绝)
        shangjiaService.updateById(shangjia);
        return R.ok();
    }

    @IgnoreAuth
    @PostMapping(value = "/register")
    public R register(@RequestBody ShangjiaEntity shangjia){
        if(shangjiaService.selectOne(new EntityWrapper<ShangjiaEntity>().eq("shangjiazhango", shangjia.getShangjiazhango())) !=null) {
            return R.error("该商家账号已存在");
        }
        shangjia.setSfsh("待审核"); // 注册默认进入待审核
        shangjia.setAddtime(new Date());
        shangjiaService.insert(shangjia);
        return R.ok();
    }

    @RequestMapping("/session")
    public R getCurrUser(HttpServletRequest request){
        Long id = (Long)request.getSession().getAttribute("userId");
        ShangjiaEntity user = shangjiaService.selectById(id);
        return R.ok().put("data", user);
    }

    /**
     * 管理员后台新增商家（直接入驻，审核状态设为"是"）
     */
    @RequestMapping("/save")
    public R save(@RequestBody ShangjiaEntity shangjia){
        if(shangjiaService.selectOne(new EntityWrapper<ShangjiaEntity>().eq("shangjiazhango", shangjia.getShangjiazhango())) != null) {
            return R.error("该商家账号已存在");
        }
        if(shangjia.getSfsh() == null || shangjia.getSfsh().isEmpty()) {
            shangjia.setSfsh("是"); // 管理员直接新增默认通过
        }
        shangjia.setAddtime(new Date());
        shangjiaService.insert(shangjia);
        return R.ok();
    }

    @RequestMapping("/update")
    public R update(@RequestBody ShangjiaEntity shangjia){
        shangjiaService.updateById(shangjia);
        return R.ok();
    }

    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        return R.ok().put("data", shangjiaService.selectById(id));
    }

    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        shangjiaService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
}