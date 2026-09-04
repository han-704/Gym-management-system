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
 * 健身计划
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@TableName("fitness_plan")
public class FitnessPlanEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public FitnessPlanEntity() {
		
	}
	
	public FitnessPlanEntity(T t) {
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
	 * 会员id
	 */
						
	private Long huiyuanId;
	
	/**
	 * 会员账号
	 */
						
	private String huiyuanzhanghao;
	
	/**
	 * 计划名称
	 */
						
	private String planName;
	
	/**
	 * 健身目标
	 */
						
	private String jianshenmubiao;
	
	/**
	 * 健身等级
	 */
						
	private String jianshendengji;
	
	/**
	 * 身高
	 */
						
	private Double shengao;
	
	/**
	 * 体重
	 */
						
	private Double tizhong;
	
	/**
	 * BMI
	 */
						
	private Double bmi;
	
	/**
	 * 每周训练天数
	 */
						
	private Integer meizhouxunliantian;
	
	/**
	 * 开始日期
	 */
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat
	private Date startDate;
	
	/**
	 * 结束日期
	 */
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat
	private Date endDate;
	
	/**
	 * 总时长(分钟)
	 */
						
	private Integer zongshichang;
	
	/**
	 * 训练天数
	 */
						
	private Integer zongtianshu;
	
	/**
	 * 状态
	 */
						
	private String status;
	
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
	 * 设置：会员id
	 */
	public void setHuiyuanId(Long huiyuanId) {
		this.huiyuanId = huiyuanId;
	}
	/**
	 * 获取：会员id
	 */
	public Long getHuiyuanId() {
		return huiyuanId;
	}
	/**
	 * 设置：会员账号
	 */
	public void setHuiyuanzhanghao(String huiyuanzhanghao) {
		this.huiyuanzhanghao = huiyuanzhanghao;
	}
	/**
	 * 获取：会员账号
	 */
	public String getHuiyuanzhanghao() {
		return huiyuanzhanghao;
	}
	/**
	 * 设置：计划名称
	 */
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	/**
	 * 获取：计划名称
	 */
	public String getPlanName() {
		return planName;
	}
	/**
	 * 设置：健身目标
	 */
	public void setJianshenmubiao(String jianshenmubiao) {
		this.jianshenmubiao = jianshenmubiao;
	}
	/**
	 * 获取：健身目标
	 */
	public String getJianshenmubiao() {
		return jianshenmubiao;
	}
	/**
	 * 设置：健身等级
	 */
	public void setJianshendengji(String jianshendengji) {
		this.jianshendengji = jianshendengji;
	}
	/**
	 * 获取：健身等级
	 */
	public String getJianshendengji() {
		return jianshendengji;
	}
	/**
	 * 设置：身高
	 */
	public void setShengao(Double shengao) {
		this.shengao = shengao;
	}
	/**
	 * 获取：身高
	 */
	public Double getShengao() {
		return shengao;
	}
	/**
	 * 设置：体重
	 */
	public void setTizhong(Double tizhong) {
		this.tizhong = tizhong;
	}
	/**
	 * 获取：体重
	 */
	public Double getTizhong() {
		return tizhong;
	}
	/**
	 * 设置：BMI
	 */
	public void setBmi(Double bmi) {
		this.bmi = bmi;
	}
	/**
	 * 获取：BMI
	 */
	public Double getBmi() {
		return bmi;
	}
	/**
	 * 设置：每周训练天数
	 */
	public void setMeizhouxunliantian(Integer meizhouxunliantian) {
		this.meizhouxunliantian = meizhouxunliantian;
	}
	/**
	 * 获取：每周训练天数
	 */
	public Integer getMeizhouxunliantian() {
		return meizhouxunliantian;
	}
	/**
	 * 设置：开始日期
	 */
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	/**
	 * 获取：开始日期
	 */
	public Date getStartDate() {
		return startDate;
	}
	/**
	 * 设置：结束日期
	 */
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	/**
	 * 获取：结束日期
	 */
	public Date getEndDate() {
		return endDate;
	}
	/**
	 * 设置：总时长(分钟)
	 */
	public void setZongshichang(Integer zongshichang) {
		this.zongshichang = zongshichang;
	}
	/**
	 * 获取：总时长(分钟)
	 */
	public Integer getZongshichang() {
		return zongshichang;
	}
	/**
	 * 设置：训练天数
	 */
	public void setZongtianshu(Integer zongtianshu) {
		this.zongtianshu = zongtianshu;
	}
	/**
	 * 获取：训练天数
	 */
	public Integer getZongtianshu() {
		return zongtianshu;
	}
	/**
	 * 设置：状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * 获取：状态
	 */
	public String getStatus() {
		return status;
	}

}
