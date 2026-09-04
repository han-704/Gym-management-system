package com.entity.view;

import com.entity.XindefuEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;


/**
 * 健身心得分享
 * 后端返回视图实体辅助类
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("xindefu")
public class XindefuView extends XindefuEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public XindefuView(){
	}
	
	public XindefuView(XindefuEntity xindefuEntity){
		try {
			BeanUtils.copyProperties(this, xindefuEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
