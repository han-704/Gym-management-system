package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.XindefuCollectEntity;
import com.entity.view.XindefuCollectView;
import java.util.Map;
import java.util.List;


/**
 * 健身心得收藏
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuCollectService extends IService<XindefuCollectEntity> {

    PageUtils queryPage(Map<String, Object> params);

    PageUtils queryPage(Map<String, Object> params, Wrapper<XindefuCollectEntity> wrapper);
    
    List<XindefuCollectView> selectListView(Wrapper<XindefuCollectEntity> wrapper);
    
    PageUtils queryPageWithDetail(Map<String, Object> params, Wrapper<XindefuCollectEntity> wrapper);

}
