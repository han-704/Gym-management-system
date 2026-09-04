package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.HuiyuanBodyDataEntity;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.vo.HuiyuanBodyDataVO;
import com.entity.view.HuiyuanBodyDataView;

/**
 * 会员身体数据
 * 
 * @author 
 * @email 
 * @date 2021-05-12 00:06:36
 */
public interface HuiyuanBodyDataService extends IService<HuiyuanBodyDataEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
    PageUtils queryPage(Map<String, Object> params, Wrapper<HuiyuanBodyDataEntity> wrapper);
    
    List<HuiyuanBodyDataVO> selectListVO(Wrapper<HuiyuanBodyDataEntity> wrapper);
    
    HuiyuanBodyDataVO selectVO(Wrapper<HuiyuanBodyDataEntity> wrapper);
    
    List<HuiyuanBodyDataView> selectListView(Wrapper<HuiyuanBodyDataEntity> wrapper);
    
    HuiyuanBodyDataView selectView(Wrapper<HuiyuanBodyDataEntity> wrapper);

}
