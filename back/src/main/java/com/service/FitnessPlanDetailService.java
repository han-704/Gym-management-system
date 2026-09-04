package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.FitnessPlanDetailEntity;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.vo.FitnessPlanDetailVO;
import com.entity.view.FitnessPlanDetailView;

/**
 * 健身计划详情
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface FitnessPlanDetailService extends IService<FitnessPlanDetailEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
    PageUtils queryPage(Map<String, Object> params, Wrapper<FitnessPlanDetailEntity> wrapper);
    
    List<FitnessPlanDetailVO> selectListVO(Wrapper<FitnessPlanDetailEntity> wrapper);
    
    FitnessPlanDetailVO selectVO(Wrapper<FitnessPlanDetailEntity> wrapper);
    
    List<FitnessPlanDetailView> selectListView(Wrapper<FitnessPlanDetailEntity> wrapper);
    
    FitnessPlanDetailView selectView(Wrapper<FitnessPlanDetailEntity> wrapper);

}
