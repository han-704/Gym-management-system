package com.entity.view;

import com.entity.JianshenhuodongCommentEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;


/**
 * 健身活动评论
 * 后端返回视图实体辅助类
 * @author
 * @email
 * @date 2021-05-12 00:06:36
 */
@TableName("jianshenhuodong_comment")
public class JianshenhuodongCommentView extends JianshenhuodongCommentEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public JianshenhuodongCommentView(){
	}

	public JianshenhuodongCommentView(JianshenhuodongCommentEntity jianshenhuodongCommentEntity){
		try {
			BeanUtils.copyProperties(this, jianshenhuodongCommentEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
