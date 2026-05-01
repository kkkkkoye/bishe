package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.ShangjiaEntity;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import org.apache.ibatis.annotations.Param;

/**
 * 商家
 */
public interface ShangjiaService extends IService<ShangjiaEntity> {

    // 增加下面这两个方法声明
    PageUtils queryPage(Map<String, Object> params);

    PageUtils queryPage(Map<String, Object> params, Wrapper<ShangjiaEntity> wrapper);
}