package com.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.utils.PageUtils;
import com.utils.Query;
import com.dao.XindefuThumbsupDao;
import com.entity.XindefuThumbsupEntity;
import com.service.XindefuThumbsupService;


/**
 * 健身心得点赞
 * 服务实现类
 * @author 
 * @date 2021-05-12 00:06:36
 */
@Service("xindefuThumbsupService")
public class XindefuThumbsupServiceImpl extends ServiceImpl<XindefuThumbsupDao, XindefuThumbsupEntity> implements XindefuThumbsupService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<XindefuThumbsupEntity> page = this.selectPage(
                new Query<XindefuThumbsupEntity>(params).getPage(),
                new EntityWrapper<XindefuThumbsupEntity>()
        );
        return new PageUtils(page);
    }

    @Override
    public List<XindefuThumbsupEntity> selectListView(Wrapper<XindefuThumbsupEntity> wrapper) {
        return baseMapper.selectListView(wrapper);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params, Wrapper<XindefuThumbsupEntity> wrapper) {
        Page<XindefuThumbsupEntity> page = new Query<XindefuThumbsupEntity>(params).getPage();
        page.setRecords(baseMapper.selectListView(page, wrapper));
        PageUtils pageUtil = new PageUtils(page);
        return pageUtil;
    }

}
