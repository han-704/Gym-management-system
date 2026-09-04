package com.entity.vo;

import com.entity.FitnessPlanDetailEntity;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;


/**
 * 健身计划详情
 * 手机端接口返回实体辅助类 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public class FitnessPlanDetailVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Long planId;
	private Integer xingqi;
	private String shiduan;
	private Long xiangmuId;
	private String xiangmumingcheng;
	private String xiangmuleixing;
	private Integer shichang;
	private Integer zushu;
	private Integer cishu;
	private Integer xiuxishijian;
	private String beizhu;
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getPlanId() {
		return planId;
	}
	public void setPlanId(Long planId) {
		this.planId = planId;
	}
	public Integer getXingqi() {
		return xingqi;
	}
	public void setXingqi(Integer xingqi) {
		this.xingqi = xingqi;
	}
	public String getShiduan() {
		return shiduan;
	}
	public void setShiduan(String shiduan) {
		this.shiduan = shiduan;
	}
	public Long getXiangmuId() {
		return xiangmuId;
	}
	public void setXiangmuId(Long xiangmuId) {
		this.xiangmuId = xiangmuId;
	}
	public String getXiangmumingcheng() {
		return xiangmumingcheng;
	}
	public void setXiangmumingcheng(String xiangmumingcheng) {
		this.xiangmumingcheng = xiangmumingcheng;
	}
	public String getXiangmuleixing() {
		return xiangmuleixing;
	}
	public void setXiangmuleixing(String xiangmuleixing) {
		this.xiangmuleixing = xiangmuleixing;
	}
	public Integer getShichang() {
		return shichang;
	}
	public void setShichang(Integer shichang) {
		this.shichang = shichang;
	}
	public Integer getZushu() {
		return zushu;
	}
	public void setZushu(Integer zushu) {
		this.zushu = zushu;
	}
	public Integer getCishu() {
		return cishu;
	}
	public void setCishu(Integer cishu) {
		this.cishu = cishu;
	}
	public Integer getXiuxishijian() {
		return xiuxishijian;
	}
	public void setXiuxishijian(Integer xiuxishijian) {
		this.xiuxishijian = xiuxishijian;
	}
	public String getBeizhu() {
		return beizhu;
	}
	public void setBeizhu(String beizhu) {
		this.beizhu = beizhu;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
}
