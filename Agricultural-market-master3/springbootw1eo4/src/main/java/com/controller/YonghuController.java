package com.controller;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.annotation.IgnoreAuth;
import com.entity.YonghuEntity;
import com.service.YonghuService;
import com.service.TokenService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;

/**
 * 用户管理 - 包含：警告、禁言、封号处理
 */
@RestController
@RequestMapping("/yonghu")
public class YonghuController {
	@Autowired
	private YonghuService yonghuService;
	@Autowired
	private TokenService tokenService;

	/**
	 * 用户登录 - 增加封号判断 (对应文档：封号处理)
	 */
	@IgnoreAuth
	@RequestMapping(value = "/login")
	public R login(String username, String password, HttpServletRequest request) {
		YonghuEntity u = yonghuService.selectOne(new EntityWrapper<YonghuEntity>().eq("yonghuzhanghao", username));
		if(u==null || !u.getMima().equals(password)) {
			return R.error("账号或密码不正确");
		}
		// --- 核心修改：管理员监察权力体现 ---
		if("封号".equals(u.getStatus())) return R.error("您的账号因违规已被封禁，请联系管理员");
		// --------------------------------

		String token = tokenService.generateToken(u.getId(), username,"yonghu",  "用户" );
		return R.ok().put("token", token);
	}

	/**
	 * 修改用户状态 (对应管理员：警告、禁言、封号操作)
	 */
	@RequestMapping("/update")
	@Transactional
	public R update(@RequestBody YonghuEntity yonghu){
		// 管理员可以直接通过此接口修改 status(封号) 或 jinyan(禁言) 字段
		System.out.println("DEBUG >>> 收到更新请求，ID: " + yonghu.getId() + "，状态: " + yonghu.getStatus());
		yonghuService.updateById(yonghu);
		return R.ok();
	}

	@IgnoreAuth
	@RequestMapping("/register")
	public R register(@RequestBody YonghuEntity yonghu){
		YonghuEntity u = yonghuService.selectOne(new EntityWrapper<YonghuEntity>().eq("yonghuzhanghao", yonghu.getYonghuzhanghao()));
		if(u!=null) return R.error("注册用户已存在");
		yonghu.setId(new Date().getTime());
		yonghu.setStatus("正常");
		yonghu.setJinyan("否");
		yonghuService.insert(yonghu);
		return R.ok();
	}

	@RequestMapping("/session")
	public R getCurrUser(HttpServletRequest request){
		Long id = (Long)request.getSession().getAttribute("userId");
		return R.ok().put("data", yonghuService.selectById(id));
	}

	@RequestMapping("/page")
	public R page(@RequestParam Map<String, Object> params, YonghuEntity yonghu){
		EntityWrapper<YonghuEntity> ew = new EntityWrapper<YonghuEntity>();
		PageUtils page = yonghuService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, yonghu), params), params));
		return R.ok().put("data", page);
	}

	@RequestMapping("/delete")
	public R delete(@RequestBody Long[] ids){
		yonghuService.deleteBatchIds(Arrays.asList(ids));
		return R.ok();
	}
}