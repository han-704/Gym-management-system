package com.entity.view;

import com.entity.XindefuCommentEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;


/**
 * 健身心得评论
 * 后端返回视图实体辅助类
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("xindefu_comment")
public class XindefuCommentView extends XindefuCommentEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public XindefuCommentView(){
	}
	
	public XindefuCommentView(XindefuCommentEntity xindefuCommentEntity){
		try {
			BeanUtils.copyProperties(this, xindefuCommentEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
