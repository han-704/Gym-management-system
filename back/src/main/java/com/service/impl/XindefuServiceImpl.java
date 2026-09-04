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
import com.dao.XindefuDao;
import com.entity.XindefuEntity;
import com.entity.view.XindefuView;
import com.service.XindefuService;


/**
 * 健身心得分享
 * 服务实现类
 * @author 
 * @date 2021-05-12 00:06:36
 */
@Service("xindefuService")
public class XindefuServiceImpl extends ServiceImpl<XindefuDao, XindefuEntity> implements XindefuService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<XindefuEntity> page = this.selectPage(
                new Query<XindefuEntity>(params).getPage(),
                new EntityWrapper<XindefuEntity>()
        );
        String key = (String) params.get("key");
        if(key != null && !key.equals("")) {
            page = this.selectPage(
                new Query<XindefuEntity>(params).getPage(),
                new EntityWrapper<XindefuEntity>().like("title", key).or().like("content", key)
            );
        }
        String fenlei = (String) params.get("fenlei");
        if(fenlei != null && !fenlei.equals("")) {
            page = this.selectPage(
                new Query<XindefuEntity>(params).getPage(),
                new EntityWrapper<XindefuEntity>().eq("fenlei", fenlei)
            );
        }
        return new PageUtils(page);
    }

    @Override
    public List<XindefuEntity> selectListView(Wrapper<XindefuEntity> wrapper) {
        return baseMapper.selectListView(wrapper);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params, Wrapper<XindefuEntity> wrapper) {
        Page<XindefuEntity> page = new Query<XindefuEntity>(params).getPage();
        page.setRecords(baseMapper.selectListView(page, wrapper));
        PageUtils pageUtil = new PageUtils(page);
        return pageUtil;
    }

    @Override
    public XindefuView selectView(Wrapper<XindefuEntity> wrapper) {
        return baseMapper.selectView(wrapper);
    }

}
