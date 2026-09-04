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
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;


/**
 * 健身计划详情
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("fitness_plan_detail")
public class FitnessPlanDetailEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public FitnessPlanDetailEntity() {
		
	}
	
	public FitnessPlanDetailEntity(T t) {
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
	@TableId(type = IdType.AUTO)
	private Long id;
	
	/**
	 * 计划id
	 */
						
	private Long planId;
	
	/**
	 * 星期几(1-7)
	 */
						
	private Integer xingqi;
	
	/**
	 * 训练时段
	 */
						
	private String shiduan;
	
	/**
	 * 健身项目id
	 */
						
	private Long xiangmuId;
	
	/**
	 * 项目名称
	 */
						
	private String xiangmumingcheng;
	
	/**
	 * 项目类型
	 */
						
	private String xiangmuleixing;
	
	/**
	 * 训练时长(分钟)
	 */
						
	private Integer shichang;
	
	/**
	 * 组数
	 */
						
	private Integer zushu;
	
	/**
	 * 次数
	 */
						
	private Integer cishu;
	
	/**
	 * 休息时间(秒)
	 */
						
	private Integer xiuxishijian;
	
	/**
	 * 注意事项
	 */
						
	private String beizhu;
	
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
	 * 设置：计划id
	 */
	public void setPlanId(Long planId) {
		this.planId = planId;
	}
	/**
	 * 获取：计划id
	 */
	public Long getPlanId() {
		return planId;
	}
	/**
	 * 设置：星期几(1-7)
	 */
	public void setXingqi(Integer xingqi) {
		this.xingqi = xingqi;
	}
	/**
	 * 获取：星期几(1-7)
	 */
	public Integer getXingqi() {
		return xingqi;
	}
	/**
	 * 设置：训练时段
	 */
	public void setShiduan(String shiduan) {
		this.shiduan = shiduan;
	}
	/**
	 * 获取：训练时段
	 */
	public String getShiduan() {
		return shiduan;
	}
	/**
	 * 设置：健身项目id
	 */
	public void setXiangmuId(Long xiangmuId) {
		this.xiangmuId = xiangmuId;
	}
	/**
	 * 获取：健身项目id
	 */
	public Long getXiangmuId() {
		return xiangmuId;
	}
	/**
	 * 设置：项目名称
	 */
	public void setXiangmumingcheng(String xiangmumingcheng) {
		this.xiangmumingcheng = xiangmumingcheng;
	}
	/**
	 * 获取：项目名称
	 */
	public String getXiangmumingcheng() {
		return xiangmumingcheng;
	}
	/**
	 * 设置：项目类型
	 */
	public void setXiangmuleixing(String xiangmuleixing) {
		this.xiangmuleixing = xiangmuleixing;
	}
	/**
	 * 获取：项目类型
	 */
	public String getXiangmuleixing() {
		return xiangmuleixing;
	}
	/**
	 * 设置：训练时长(分钟)
	 */
	public void setShichang(Integer shichang) {
		this.shichang = shichang;
	}
	/**
	 * 获取：训练时长(分钟)
	 */
	public Integer getShichang() {
		return shichang;
	}
	/**
	 * 设置：组数
	 */
	public void setZushu(Integer zushu) {
		this.zushu = zushu;
	}
	/**
	 * 获取：组数
	 */
	public Integer getZushu() {
		return zushu;
	}
	/**
	 * 设置：次数
	 */
	public void setCishu(Integer cishu) {
		this.cishu = cishu;
	}
	/**
	 * 获取：次数
	 */
	public Integer getCishu() {
		return cishu;
	}
	/**
	 * 设置：休息时间(秒)
	 */
	public void setXiuxishijian(Integer xiuxishijian) {
		this.xiuxishijian = xiuxishijian;
	}
	/**
	 * 获取：休息时间(秒)
	 */
	public Integer getXiuxishijian() {
		return xiuxishijian;
	}
	/**
	 * 设置：注意事项
	 */
	public void setBeizhu(String beizhu) {
		this.beizhu = beizhu;
	}
	/**
	 * 获取：注意事项
	 */
	public String getBeizhu() {
		return beizhu;
	}

}
