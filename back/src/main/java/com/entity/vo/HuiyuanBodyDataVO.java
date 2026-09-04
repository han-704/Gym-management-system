package com.entity.vo;

import com.entity.HuiyuanBodyDataEntity;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;


/**
 * 会员身体数据
 * 手机端接口返回实体辅助类 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public class HuiyuanBodyDataVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private Long huiyuanId;
	private String huiyuanzhanghao;
	private Double shengao;
	private Double tizhong;
	private Double bmi;
	private String jianshenmubiao;
	private String jianshendengji;
	private Integer meizhouxunliantian;
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
	public Integer getMeizhouxunliantian() {
		return meizhouxunliantian;
	}
	public void setMeizhouxunliantian(Integer meizhouxunliantian) {
		this.meizhouxunliantian = meizhouxunliantian;
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
