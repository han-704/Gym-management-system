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
 * 健身心得分享
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("xindefu")
public class XindefuEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public XindefuEntity() {
		
	}
	
	public XindefuEntity(T t) {
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
	 * 标题
	 */
					
	private String title;
	
	/**
	 * 内容
	 */
					
	private String content;
	
	/**
	 * 分类
	 */
					
	private String fenlei;
	
	/**
	 * 封面图片
	 */
					
	private String fengmian;
	
	/**
	 * 发布人账号
	 */
					
	private String fabuzhanghao;
	
	/**
	 * 发布人姓名
	 */
					
	private String fabuxingming;
	
	/**
	 * 发布时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date fabushijian;
	
	/**
	 * 点赞数
	 */
					
	private Integer thumbsupnum;
	
	/**
	 * 浏览量
	 */
				
	private Integer clicknum;
	
	/**
	 * 收藏数
	 */
				
	private Integer collectnum;
	
	/**
	 * 评论数
	 */
				
	private Integer commentnum;
	
	/**
	 * 创建时间
	 */
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	/**
	 * 是否已点赞（前端使用）
	 */
	@TableField(exist = false)
	private Boolean hasThumbsup;

	public Boolean getHasThumbsup() {
		return hasThumbsup;
	}

	public void setHasThumbsup(Boolean hasThumbsup) {
		this.hasThumbsup = hasThumbsup;
	}

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
	 * 设置：标题
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * 获取：标题
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * 设置：内容
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * 获取：内容
	 */
	public String getContent() {
		return content;
	}
	/**
	 * 设置：分类
	 */
	public void setFenlei(String fenlei) {
		this.fenlei = fenlei;
	}
	/**
	 * 获取：分类
	 */
	public String getFenlei() {
		return fenlei;
	}
	/**
	 * 设置：封面图片
	 */
	public void setFengmian(String fengmian) {
		this.fengmian = fengmian;
	}
	/**
	 * 获取：封面图片
	 */
	public String getFengmian() {
		return fengmian;
	}
	/**
	 * 设置：发布人账号
	 */
	public void setFabuzhanghao(String fabuzhanghao) {
		this.fabuzhanghao = fabuzhanghao;
	}
	/**
	 * 获取：发布人账号
	 */
	public String getFabuzhanghao() {
		return fabuzhanghao;
	}
	/**
	 * 设置：发布人姓名
	 */
	public void setFabuxingming(String fabuxingming) {
		this.fabuxingming = fabuxingming;
	}
	/**
	 * 获取：发布人姓名
	 */
	public String getFabuxingming() {
		return fabuxingming;
	}
	/**
	 * 设置：发布时间
	 */
	public void setFabushijian(Date fabushijian) {
		this.fabushijian = fabushijian;
	}
	/**
	 * 获取：发布时间
	 */
	public Date getFabushijian() {
		return fabushijian;
	}
	/**
	 * 设置：点赞数
	 */
	public void setThumbsupnum(Integer thumbsupnum) {
		this.thumbsupnum = thumbsupnum;
	}
	/**
	 * 获取：点赞数
	 */
	public Integer getThumbsupnum() {
		return thumbsupnum;
	}
	/**
	 * 设置：浏览量
	 */
	public void setClicknum(Integer clicknum) {
		this.clicknum = clicknum;
	}
	/**
	 * 获取：浏览量
	 */
	public Integer getClicknum() {
		return clicknum;
	}
	/**
	 * 设置：收藏数
	 */
	public void setCollectnum(Integer collectnum) {
		this.collectnum = collectnum;
	}
	/**
	 * 获取：收藏数
	 */
	public Integer getCollectnum() {
		return collectnum;
	}
	/**
	 * 设置：评论数
	 */
	public void setCommentnum(Integer commentnum) {
		this.commentnum = commentnum;
	}
	/**
	 * 获取：评论数
	 */
	public Integer getCommentnum() {
		return commentnum;
	}

}
