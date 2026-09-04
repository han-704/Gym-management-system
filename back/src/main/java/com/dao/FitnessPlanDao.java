package com.dao;

import com.entity.FitnessPlanEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.vo.FitnessPlanVO;
import com.entity.view.FitnessPlanView;


/**
 * 健身计划
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface FitnessPlanDao extends BaseMapper<FitnessPlanEntity> {
	
	List<FitnessPlanVO> selectListVO(@Param("ew") Wrapper<FitnessPlanEntity> wrapper);
	
	FitnessPlanVO selectVO(@Param("ew") Wrapper<FitnessPlanEntity> wrapper);
	
	List<FitnessPlanView> selectListView(@Param("ew") Wrapper<FitnessPlanEntity> wrapper);

	List<FitnessPlanView> selectListView(Pagination page,@Param("ew") Wrapper<FitnessPlanEntity> wrapper);
	
	FitnessPlanView selectView(@Param("ew") Wrapper<FitnessPlanEntity> wrapper);
	
}
