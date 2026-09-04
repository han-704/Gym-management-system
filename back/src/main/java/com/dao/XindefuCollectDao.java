package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.XindefuCollectEntity;
import com.entity.view.XindefuCollectView;
import java.util.List;
import java.util.Map;

/**
 * 健身心得收藏
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuCollectDao extends BaseMapper<XindefuCollectEntity> {
    
    List<XindefuCollectView> selectListView(Map<String, Object> params);
    
}
