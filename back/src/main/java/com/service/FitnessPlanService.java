package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.FitnessPlanEntity;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.vo.FitnessPlanVO;
import com.entity.view.FitnessPlanView;

/**
 * 健身计划
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface FitnessPlanService extends IService<FitnessPlanEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
    PageUtils queryPage(Map<String, Object> params, Wrapper<FitnessPlanEntity> wrapper);
    
    List<FitnessPlanVO> selectListVO(Wrapper<FitnessPlanEntity> wrapper);
    
    FitnessPlanVO selectVO(Wrapper<FitnessPlanEntity> wrapper);
    
    List<FitnessPlanView> selectListView(Wrapper<FitnessPlanEntity> wrapper);
    
    FitnessPlanView selectView(Wrapper<FitnessPlanEntity> wrapper);

}
