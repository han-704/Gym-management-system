package com.entity.view;

import com.entity.FitnessPlanDetailEntity;
import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.io.Serializable;


/**
 * 健身计划详情
 * 后端返回视图实体辅助类   
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("fitness_plan_detail")
public class FitnessPlanDetailView extends FitnessPlanDetailEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public FitnessPlanDetailView(){
	}
	
	public FitnessPlanDetailView(FitnessPlanDetailEntity fitnessPlanDetailEntity){
		try {
			BeanUtils.copyProperties(this, fitnessPlanDetailEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
	}
}
