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
 * 健身心得点赞
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("xindefu_thumbsup")
public class XindefuThumbsupEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public XindefuThumbsupEntity() {
		
	}
	
	public XindefuThumbsupEntity(T t) {
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
	 * 用户账号
	 */
					
	private String huiyuanzhanghao;
	
	/**
	 * 点赞时间
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
	 * 设置：用户账号
	 */
	public void setHuiyuanzhanghao(String huiyuanzhanghao) {
		this.huiyuanzhanghao = huiyuanzhanghao;
	}
	/**
	 * 获取：用户账号
	 */
	public String getHuiyuanzhanghao() {
		return huiyuanzhanghao;
	}

}
