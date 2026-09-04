package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.XindefuEntity;
import java.util.List;
import java.util.Map;
import com.entity.view.XindefuView;
import org.apache.ibatis.annotations.Param;


/**
 * 健身心得分享
 *
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface XindefuService extends IService<XindefuEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<XindefuEntity> selectListView(Wrapper<XindefuEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<XindefuEntity> wrapper);
    
   	XindefuView selectView(@Param("ew") Wrapper<XindefuEntity> wrapper);
    
}
