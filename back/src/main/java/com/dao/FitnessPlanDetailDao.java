package com.dao;

import com.entity.FitnessPlanDetailEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.vo.FitnessPlanDetailVO;
import com.entity.view.FitnessPlanDetailView;


/**
 * 健身计划详情
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface FitnessPlanDetailDao extends BaseMapper<FitnessPlanDetailEntity> {
	
	List<FitnessPlanDetailVO> selectListVO(@Param("ew") Wrapper<FitnessPlanDetailEntity> wrapper);
	
	FitnessPlanDetailVO selectVO(@Param("ew") Wrapper<FitnessPlanDetailEntity> wrapper);
	
	List<FitnessPlanDetailView> selectListView(@Param("ew") Wrapper<FitnessPlanDetailEntity> wrapper);

	List<FitnessPlanDetailView> selectListView(Pagination page,@Param("ew") Wrapper<FitnessPlanDetailEntity> wrapper);
	
	FitnessPlanDetailView selectView(@Param("ew") Wrapper<FitnessPlanDetailEntity> wrapper);
	
}
