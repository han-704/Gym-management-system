package com.dao;

import com.entity.HuiyuanBodyDataEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.vo.HuiyuanBodyDataVO;
import com.entity.view.HuiyuanBodyDataView;


/**
 * 会员身体数据
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface HuiyuanBodyDataDao extends BaseMapper<HuiyuanBodyDataEntity> {
	
	List<HuiyuanBodyDataVO> selectListVO(@Param("ew") Wrapper<HuiyuanBodyDataEntity> wrapper);
	
	HuiyuanBodyDataVO selectVO(@Param("ew") Wrapper<HuiyuanBodyDataEntity> wrapper);
	
	List<HuiyuanBodyDataView> selectListView(@Param("ew") Wrapper<HuiyuanBodyDataEntity> wrapper);

	List<HuiyuanBodyDataView> selectListView(Pagination page,@Param("ew") Wrapper<HuiyuanBodyDataEntity> wrapper);
	
	HuiyuanBodyDataView selectView(@Param("ew") Wrapper<HuiyuanBodyDataEntity> wrapper);
	
}
