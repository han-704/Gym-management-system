package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.JianshenhuodongCommentEntity;
import java.util.List;
import java.util.Map;
import com.entity.view.JianshenhuodongCommentView;
import org.apache.ibatis.annotations.Param;


/**
 * 健身活动评论
 *
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface JianshenhuodongCommentService extends IService<JianshenhuodongCommentEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<JianshenhuodongCommentEntity> selectListView(Wrapper<JianshenhuodongCommentEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<JianshenhuodongCommentEntity> wrapper);
    
   	JianshenhuodongCommentView selectView(@Param("ew") Wrapper<JianshenhuodongCommentEntity> wrapper);
    
}
