package com.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;


/**
 * 健身心得评论
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("xindefu_comment")
public class XindefuCommentEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public XindefuCommentEntity() {
		
	}
	
	public XindefuCommentEntity(T t) {
		try {
			BeanUtils.copyProperties(this, t);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 健身心得
	 */
					
	private Long xindefuId;
	
	/**
	 * 评论人账号
	 */
					
	private String huiyuanzhanghao;
	
	/**
	 * 评论人姓名
	 */
					
	private String huiyuanxingming;
	
	/**
	 * 评论内容
	 */
					
	private String pinglunneirong;
	
	/**
	 * 评论时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date pinglunshijian;
	
	/**
	 * 创建时间
	 */
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * 设置：健身心得
	 */
	public void setXindefuId(Long xindefuId) {
		this.xindefuId = xindefuId;
	}
	/**
	 * 获取：健身心得
	 */
	public Long getXindefuId() {
		return xindefuId;
	}
	/**
	 * 设置：评论人账号
	 */
	public void setHuiyuanzhanghao(String huiyuanzhanghao) {
		this.huiyuanzhanghao = huiyuanzhanghao;
	}
	/**
	 * 获取：评论人账号
	 */
	public String getHuiyuanzhanghao() {
		return huiyuanzhanghao;
	}
	/**
	 * 设置：评论人姓名
	 */
	public void setHuiyuanxingming(String huiyuanxingming) {
		this.huiyuanxingming = huiyuanxingming;
	}
	/**
	 * 获取：评论人姓名
	 */
	public String getHuiyuanxingming() {
		return huiyuanxingming;
	}
	/**
	 * 设置：评论内容
	 */
	public void setPinglunneirong(String pinglunneirong) {
		this.pinglunneirong = pinglunneirong;
	}
	/**
	 * 获取：评论内容
	 */
	public String getPinglunneirong() {
		return pinglunneirong;
	}
	/**
	 * 设置：评论时间
	 */
	public void setPinglunshijian(Date pinglunshijian) {
		this.pinglunshijian = pinglunshijian;
	}
	/**
	 * 获取：评论时间
	 */
	public Date getPinglunshijian() {
		return pinglunshijian;
	}

}
