package com.dao;

import com.entity.XindefuEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.XindefuView;


/**
 * 健身心得分享
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuDao extends BaseMapper<XindefuEntity> {
	
	List<XindefuEntity> selectListView(@Param("ew") Wrapper<XindefuEntity> wrapper);

	List<XindefuEntity> selectListView(Pagination page,@Param("ew") Wrapper<XindefuEntity> wrapper);
	
	XindefuView selectView(@Param("ew") Wrapper<XindefuEntity> wrapper);
	
}
