package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.AicoachKnowledgeEntity;
import com.utils.PageUtils;

import java.util.List;
import java.util.Map;

/**
 * AI教练知识库Service接口
 */
public interface AicoachKnowledgeService extends IService<AicoachKnowledgeEntity> {

    PageUtils queryPage(Map<String, Object> params);

    PageUtils queryPage(Map<String, Object> params, Wrapper<AicoachKnowledgeEntity> wrapper);

    /**
     * 根据问题获取最佳匹配的答案
     * @param question 用户问题
     * @return 匹配的答案
     */
    String getBestAnswer(String question);

    /**
     * 获取列表数据（带排序）
     */
    List<AicoachKnowledgeEntity> selectListView(Map<String, Object> params);

}
