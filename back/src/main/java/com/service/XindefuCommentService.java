package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.XindefuCommentEntity;
import java.util.List;
import java.util.Map;
import com.entity.view.XindefuCommentView;
import org.apache.ibatis.annotations.Param;


/**
 * 健身心得评论
 *
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuCommentService extends IService<XindefuCommentEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<XindefuCommentEntity> selectListView(Wrapper<XindefuCommentEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<XindefuCommentEntity> wrapper);
    
   	XindefuCommentView selectView(@Param("ew") Wrapper<XindefuCommentEntity> wrapper);
    
}
