package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.XindefuThumbsupEntity;
import java.util.List;
import java.util.Map;


/**
 * 健身心得点赞
 *
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuThumbsupService extends IService<XindefuThumbsupEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<XindefuThumbsupEntity> selectListView(Wrapper<XindefuThumbsupEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<XindefuThumbsupEntity> wrapper);
    
}
