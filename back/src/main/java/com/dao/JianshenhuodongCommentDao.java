package com.dao;

import com.entity.JianshenhuodongCommentEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.JianshenhuodongCommentView;


/**
 * 健身活动评论
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface JianshenhuodongCommentDao extends BaseMapper<JianshenhuodongCommentEntity> {
	
	List<JianshenhuodongCommentEntity> selectListView(@Param("ew") Wrapper<JianshenhuodongCommentEntity> wrapper);

	List<JianshenhuodongCommentEntity> selectListView(Pagination page,@Param("ew") Wrapper<JianshenhuodongCommentEntity> wrapper);
	
	JianshenhuodongCommentView selectView(@Param("ew") Wrapper<JianshenhuodongCommentEntity> wrapper);
	
}
