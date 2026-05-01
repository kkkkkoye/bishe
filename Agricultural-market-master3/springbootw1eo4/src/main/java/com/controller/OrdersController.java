package com.controller;

import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.RexiaonongchanpinEntity;
import com.service.RexiaonongchanpinService;
import com.entity.OrdersEntity;
import com.service.OrdersService;
import com.service.YonghuService;
import com.entity.YonghuEntity;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;

/**
 * 订单监察 - 包含：流转监控、协调纠纷、营销结算
 */
@RestController
@RequestMapping("/orders")
public class OrdersController {
    @Autowired
    private OrdersService ordersService;
    @Autowired
    private YonghuService yonghuService;
    @Autowired
    private RexiaonongchanpinService rexiaonongchanpinService;

    /**
     * 核心：订单监察 (对应文档需求)
     * 管理员：显示全平台订单，监控流转
     * 商家：只显示属于自己商品的订单
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, OrdersEntity orders, HttpServletRequest request){
        String role = request.getSession().getAttribute("role").toString();
        String username = request.getSession().getAttribute("username").toString();
        EntityWrapper<OrdersEntity> ew = new EntityWrapper<OrdersEntity>();

        if(role.equals("商家")) {
            // 先查出该商家名下所有商品的ID列表，再用IN过滤订单
            List<RexiaonongchanpinEntity> goods = rexiaonongchanpinService.selectList(
                new EntityWrapper<RexiaonongchanpinEntity>().eq("shangjiazhango", username)
            );
            List<Long> goodIds = new java.util.ArrayList<>();
            for (RexiaonongchanpinEntity g : goods) {
                goodIds.add(g.getId());
            }
            if (goodIds.isEmpty()) {
                // 该商家没有商品，直接返回空结果
                return R.ok().put("data", new PageUtils(new java.util.ArrayList<>(), 0, 10, 1));
            }
            ew.in("goodid", goodIds);
        } else if(role.equals("用户")) {
            // 用户只能看自己的
            ew.eq("userid", (Long)request.getSession().getAttribute("userId"));
        }
        // 管理员(上帝视角)：不加限制条件，满足“监控全平台订单”

        PageUtils page = ordersService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, orders), params), params));
        return R.ok().put("data", page);
    }

    /**
     * 下单接口 - 整合限时降价 & 团购 7 折
     */
    @RequestMapping("/add")
    @Transactional
    public R add(@RequestBody OrdersEntity orders, HttpServletRequest request){
        String orderId = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + (int)(Math.random()*100);
        orders.setOrderid(orderId);
        Long userId = (Long)request.getSession().getAttribute("userId");
        orders.setUserid(userId);

        RexiaonongchanpinEntity goods = rexiaonongchanpinService.selectById(orders.getGoodid());
        if(goods == null) return R.error("商品不存在");

        float finalPrice = goods.getPrice();
        Date now = new Date();

        // 1. 团购 7 折逻辑
        if("是".equals(goods.getIstuan()) && orders.getGroupId() != null) {
            int count = ordersService.selectCount(new EntityWrapper<OrdersEntity>().eq("group_id", orders.getGroupId()));
            if(count >= 9) { // 满足 10 人要求
                finalPrice = finalPrice * 0.7f;
                orders.setRemark("【团购7折特惠】" + (orders.getRemark()==null?"":orders.getRemark()));
            }
        }
        // 2. 限时降价逻辑 (非团购时触发)
        else if(goods.getReducediscount() != null && goods.getReducediscount() < 1 && goods.getReducestarttime() != null) {
            if(now.after(goods.getReducestarttime()) && now.before(goods.getReduceendtime())) {
                finalPrice = finalPrice * goods.getReducediscount();
                orders.setRemark("【限时打折】" + (orders.getRemark()==null?"":orders.getRemark()));
            }
        }

        orders.setPrice(finalPrice);
        orders.setTotal(finalPrice * orders.getBuynumber());

        // 3. 积分支付处理
        if("积分支付".equals(orders.getPaytype())) {
            YonghuEntity yonghu = yonghuService.selectById(userId);
            int cost = goods.getJifencost() * orders.getBuynumber();
            if(yonghu.getJifen() < cost) return R.error("积分不足");
            yonghu.setJifen(yonghu.getJifen() - cost);
            yonghuService.updateById(yonghu);
            orders.setStatus("已支付");
            orders.setTotal(0f);
        }

        ordersService.insert(orders);
        return R.ok().put("data", orderId);
    }

    /**
     * 更新订单 - 包含返积分逻辑
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody OrdersEntity orders){
        OrdersEntity old = ordersService.selectById(orders.getId());
        // 现金支付成功返积分 (1元=1积分)
        if(old != null && "未支付".equals(old.getStatus()) && "已支付".equals(orders.getStatus())) {
            if(!"积分支付".equals(old.getPaytype())) {
                YonghuEntity user = yonghuService.selectById(old.getUserid());
                user.setJifen(user.getJifen() + old.getTotal().intValue());
                yonghuService.updateById(user);
            }
        }
        ordersService.updateById(orders);
        return R.ok();
    }

    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        ordersService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
}