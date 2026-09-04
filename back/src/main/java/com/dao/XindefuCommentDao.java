package com.dao;

import com.entity.XindefuCommentEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.XindefuCommentView;


/**
 * 健身心得评论
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuCommentDao extends BaseMapper<XindefuCommentEntity> {
	
	List<XindefuCommentEntity> selectListView(@Param("ew") Wrapper<XindefuCommentEntity> wrapper);

	List<XindefuCommentEntity> selectListView(Pagination page,@Param("ew") Wrapper<XindefuCommentEntity> wrapper);
	
	XindefuCommentView selectView(@Param("ew") Wrapper<XindefuCommentEntity> wrapper);
	
}
