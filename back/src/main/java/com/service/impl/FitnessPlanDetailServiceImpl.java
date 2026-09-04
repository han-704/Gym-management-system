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


import com.dao.FitnessPlanDetailDao;
import com.entity.FitnessPlanDetailEntity;
import com.service.FitnessPlanDetailService;
import com.entity.vo.FitnessPlanDetailVO;
import com.entity.view.FitnessPlanDetailView;

@Service("fitnessPlanDetailService")
public class FitnessPlanDetailServiceImpl extends ServiceImpl<FitnessPlanDetailDao, FitnessPlanDetailEntity> implements FitnessPlanDetailService {
	
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<FitnessPlanDetailEntity> page = this.selectPage(
                new Query<FitnessPlanDetailEntity>(params).getPage(),
                new EntityWrapper<FitnessPlanDetailEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<FitnessPlanDetailEntity> wrapper) {
		  Page<FitnessPlanDetailView> page =new Query<FitnessPlanDetailView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
    @Override
	public List<FitnessPlanDetailVO> selectListVO(Wrapper<FitnessPlanDetailEntity> wrapper) {
		return baseMapper.selectListVO(wrapper);
	}
	
	@Override
	public FitnessPlanDetailVO selectVO(Wrapper<FitnessPlanDetailEntity> wrapper) {
		return baseMapper.selectVO(wrapper);
	}
	
	@Override
	public List<FitnessPlanDetailView> selectListView(Wrapper<FitnessPlanDetailEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public FitnessPlanDetailView selectView(Wrapper<FitnessPlanDetailEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}

}
