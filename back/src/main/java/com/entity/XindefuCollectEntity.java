package com.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import lombok.Data;

/**
 * 健身心得收藏
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@Data
@TableName("xindefu_collect")
public class XindefuCollectEntity {

	@TableId(type = IdType.AUTO)
	private Long id;
	/**
	 * 创建时间
	 */
	private Date addtime;
	/**
	 * 健身心得ID
	 */
	private Long xindefuId;
	/**
	 * 会员账号
	 */
	private String huiyuanzhanghao;

}
