package com.dao;

import com.entity.XindefuThumbsupEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;


/**
 * 健身心得点赞
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuThumbsupDao extends BaseMapper<XindefuThumbsupEntity> {
	
	List<XindefuThumbsupEntity> selectListView(@Param("ew") Wrapper<XindefuThumbsupEntity> wrapper);

	List<XindefuThumbsupEntity> selectListView(Pagination page,@Param("ew") Wrapper<XindefuThumbsupEntity> wrapper);
	
}
