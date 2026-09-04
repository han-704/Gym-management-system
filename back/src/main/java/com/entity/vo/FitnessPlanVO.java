package com.entity.vo;

import com.entity.FitnessPlanEntity;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;


/**
 * 健身计划
 * 手机端接口返回实体辅助类 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public class FitnessPlanVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Long huiyuanId;
	private String huiyuanzhanghao;
	private String planName;
	private String jianshenmubiao;
	private String jianshendengji;
	private Double shengao;
	private Double tizhong;
	private Double bmi;
	private Integer meizhouxunliantian;
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat
	private Date startDate;
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat
	private Date endDate;
	private Integer zongshichang;
	private Integer zongtianshu;
	private String status;
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getHuiyuanId() {
		return huiyuanId;
	}
	public void setHuiyuanId(Long huiyuanId) {
		this.huiyuanId = huiyuanId;
	}
	public String getHuiyuanzhanghao() {
		return huiyuanzhanghao;
	}
	public void setHuiyuanzhanghao(String huiyuanzhanghao) {
		this.huiyuanzhanghao = huiyuanzhanghao;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getJianshenmubiao() {
		return jianshenmubiao;
	}
	public void setJianshenmubiao(String jianshenmubiao) {
		this.jianshenmubiao = jianshenmubiao;
	}
	public String getJianshendengji() {
		return jianshendengji;
	}
	public void setJianshendengji(String jianshendengji) {
		this.jianshendengji = jianshendengji;
	}
	public Double getShengao() {
		return shengao;
	}
	public void setShengao(Double shengao) {
		this.shengao = shengao;
	}
	public Double getTizhong() {
		return tizhong;
	}
	public void setTizhong(Double tizhong) {
		this.tizhong = tizhong;
	}
	public Double getBmi() {
		return bmi;
	}
	public void setBmi(Double bmi) {
		this.bmi = bmi;
	}
	public Integer getMeizhouxunliantian() {
		return meizhouxunliantian;
	}
	public void setMeizhouxunliantian(Integer meizhouxunliantian) {
		this.meizhouxunliantian = meizhouxunliantian;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Integer getZongshichang() {
		return zongshichang;
	}
	public void setZongshichang(Integer zongshichang) {
		this.zongshichang = zongshichang;
	}
	public Integer getZongtianshu() {
		return zongtianshu;
	}
	public void setZongtianshu(Integer zongtianshu) {
		this.zongtianshu = zongtianshu;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
}
