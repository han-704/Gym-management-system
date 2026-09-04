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
import com.dao.XindefuCommentDao;
import com.entity.XindefuCommentEntity;
import com.entity.view.XindefuCommentView;
import com.service.XindefuCommentService;


/**
 * 健身心得评论
 * 服务实现类
 * @author 
 * @date 2021-05-12 00:06:36
 */
@Service("xindefuCommentService")
public class XindefuCommentServiceImpl extends ServiceImpl<XindefuCommentDao, XindefuCommentEntity> implements XindefuCommentService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<XindefuCommentEntity> page = this.selectPage(
                new Query<XindefuCommentEntity>(params).getPage(),
                new EntityWrapper<XindefuCommentEntity>()
        );
        return new PageUtils(page);
    }

    @Override
    public List<XindefuCommentEntity> selectListView(Wrapper<XindefuCommentEntity> wrapper) {
        return baseMapper.selectListView(wrapper);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params, Wrapper<XindefuCommentEntity> wrapper) {
        Page<XindefuCommentEntity> page = new Query<XindefuCommentEntity>(params).getPage();
        page.setRecords(baseMapper.selectListView(page, wrapper));
        PageUtils pageUtil = new PageUtils(page);
        return pageUtil;
    }

    @Override
    public XindefuCommentView selectView(Wrapper<XindefuCommentEntity> wrapper) {
        return baseMapper.selectView(wrapper);
    }

}
