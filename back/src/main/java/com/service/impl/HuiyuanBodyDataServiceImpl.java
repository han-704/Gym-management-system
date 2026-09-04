package com.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.utils.PageUtils;
import com.utils.Query;


import com.dao.HuiyuanBodyDataDao;
import com.entity.HuiyuanBodyDataEntity;
import com.service.HuiyuanBodyDataService;
import com.entity.vo.HuiyuanBodyDataVO;
import com.entity.view.HuiyuanBodyDataView;

@Service("huiyuanBodyDataService")
public class HuiyuanBodyDataServiceImpl extends ServiceImpl<HuiyuanBodyDataDao, HuiyuanBodyDataEntity> implements HuiyuanBodyDataService {
	
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<HuiyuanBodyDataEntity> page = this.selectPage(
                new Query<HuiyuanBodyDataEntity>(params).getPage(),
                new EntityWrapper<HuiyuanBodyDataEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<HuiyuanBodyDataEntity> wrapper) {
		  Page<HuiyuanBodyDataView> page =new Query<HuiyuanBodyDataView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
    @Override
	public List<HuiyuanBodyDataVO> selectListVO(Wrapper<HuiyuanBodyDataEntity> wrapper) {
		return baseMapper.selectListVO(wrapper);
	}
	
	@Override
	public HuiyuanBodyDataVO selectVO(Wrapper<HuiyuanBodyDataEntity> wrapper) {
		return baseMapper.selectVO(wrapper);
	}
	
	@Override
	public List<HuiyuanBodyDataView> selectListView(Wrapper<HuiyuanBodyDataEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public HuiyuanBodyDataView selectView(Wrapper<HuiyuanBodyDataEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}

}
