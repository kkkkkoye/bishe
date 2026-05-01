package com.dao;

import com.entity.ShangjiaEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.baomidou.mybatisplus.mapper.Wrapper;
import org.apache.ibatis.annotations.Param;

public interface ShangjiaDao extends BaseMapper<ShangjiaEntity> {
    // 基础增删改查由 BaseMapper 提供
}