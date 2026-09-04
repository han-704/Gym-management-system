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


import com.dao.FitnessPlanDao;
import com.entity.FitnessPlanEntity;
import com.service.FitnessPlanService;
import com.entity.vo.FitnessPlanVO;
import com.entity.view.FitnessPlanView;

@Service("fitnessPlanService")
public class FitnessPlanServiceImpl extends ServiceImpl<FitnessPlanDao, FitnessPlanEntity> implements FitnessPlanService {
	
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<FitnessPlanEntity> page = this.selectPage(
                new Query<FitnessPlanEntity>(params).getPage(),
                new EntityWrapper<FitnessPlanEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<FitnessPlanEntity> wrapper) {
		  Page<FitnessPlanView> page =new Query<FitnessPlanView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
    @Override
	public List<FitnessPlanVO> selectListVO(Wrapper<FitnessPlanEntity> wrapper) {
		return baseMapper.selectListVO(wrapper);
	}
	
	@Override
	public FitnessPlanVO selectVO(Wrapper<FitnessPlanEntity> wrapper) {
		return baseMapper.selectVO(wrapper);
	}
	
	@Override
	public List<FitnessPlanView> selectListView(Wrapper<FitnessPlanEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public FitnessPlanView selectView(Wrapper<FitnessPlanEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}

}
