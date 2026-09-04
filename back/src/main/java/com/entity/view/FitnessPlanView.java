package com.entity.view;

import com.entity.FitnessPlanEntity;
import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.io.Serializable;


/**
 * 健身计划
 * 后端返回视图实体辅助类   
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("fitness_plan")
public class FitnessPlanView extends FitnessPlanEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public FitnessPlanView(){
	}
	
	public FitnessPlanView(FitnessPlanEntity fitnessPlanEntity){
		try {
			BeanUtils.copyProperties(this, fitnessPlanEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
	}
}
