package com.entity.view;

import com.entity.HuiyuanBodyDataEntity;
import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.io.Serializable;


/**
 * 会员身体数据
 * 后端返回视图实体辅助类   
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("huiyuan_body_data")
public class HuiyuanBodyDataView extends HuiyuanBodyDataEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public HuiyuanBodyDataView(){
	}
	
	public HuiyuanBodyDataView(HuiyuanBodyDataEntity huiyuanBodyDataEntity){
		try {
			BeanUtils.copyProperties(this, huiyuanBodyDataEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
	}
}
