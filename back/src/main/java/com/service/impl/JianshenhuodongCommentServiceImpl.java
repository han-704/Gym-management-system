package com.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.utils.PageUtils;
import com.utils.Query;


import com.dao.JianshenhuodongCommentDao;
import com.entity.JianshenhuodongCommentEntity;
import com.service.JianshenhuodongCommentService;
import com.entity.view.JianshenhuodongCommentView;


@Service("jianshenhuodongCommentService")
public class JianshenhuodongCommentServiceImpl extends ServiceImpl<JianshenhuodongCommentDao, JianshenhuodongCommentEntity> implements JianshenhuodongCommentService {
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<JianshenhuodongCommentEntity> page = this.selectPage(
                new Query<JianshenhuodongCommentEntity>(params).getPage(),
                new EntityWrapper<JianshenhuodongCommentEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<JianshenhuodongCommentEntity> wrapper) {
		  Page<JianshenhuodongCommentEntity> page =new Query<JianshenhuodongCommentEntity>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
    @Override
	public List<JianshenhuodongCommentEntity> selectListView(Wrapper<JianshenhuodongCommentEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public JianshenhuodongCommentView selectView(Wrapper<JianshenhuodongCommentEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
