package com.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import com.entity.XindefuCollectEntity;
import com.entity.view.XindefuCollectView;
import com.dao.XindefuCollectDao;
import com.service.XindefuCollectService;
import com.utils.PageUtils;
import com.utils.Query;

/**
 * 健身心得收藏
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
@Service("xindefuCollectService")
public class XindefuCollectServiceImpl extends ServiceImpl<XindefuCollectDao, XindefuCollectEntity> implements XindefuCollectService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<XindefuCollectEntity> page = this.selectPage(
                new Query<XindefuCollectEntity>(params).getPage(),
                new EntityWrapper<XindefuCollectEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params, Wrapper<XindefuCollectEntity> wrapper) {
        Page<XindefuCollectEntity> page = this.selectPage(
                new Query<XindefuCollectEntity>(params).getPage(),
                wrapper
        );
        return new PageUtils(page);
    }
    
    @Override
    public List<XindefuCollectView> selectListView(Wrapper<XindefuCollectEntity> wrapper) {
        Map<String, Object> params = new java.util.HashMap<>();
        params.put("ew", wrapper);
        return baseMapper.selectListView(params);
    }
    
    /**
     * 分页查询收藏列表（包含心得详情）
     */
    public PageUtils queryPageWithDetail(Map<String, Object> params, Wrapper<XindefuCollectEntity> wrapper) {
        Page<XindefuCollectView> page = new Query<XindefuCollectView>(params).getPage();
        params.put("ew", wrapper);
        List<XindefuCollectView> list = baseMapper.selectListView(params);
        page.setRecords(list);
        return new PageUtils(page);
    }

}
