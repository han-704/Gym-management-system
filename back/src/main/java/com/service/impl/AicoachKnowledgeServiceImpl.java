package com.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.dao.AicoachKnowledgeDao;
import com.entity.AicoachKnowledgeEntity;
import com.service.AicoachKnowledgeService;
import com.baomidou.mybatisplus.plugins.Page;
import com.utils.PageUtils;
import com.utils.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("aicoachKnowledgeService")
@Transactional
public class AicoachKnowledgeServiceImpl extends ServiceImpl<AicoachKnowledgeDao, AicoachKnowledgeEntity> implements AicoachKnowledgeService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<AicoachKnowledgeEntity> page = this.selectPage(
                new Query<AicoachKnowledgeEntity>(params).getPage(),
                new EntityWrapper<AicoachKnowledgeEntity>()
        );
        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params, Wrapper<AicoachKnowledgeEntity> wrapper) {
        Page<AicoachKnowledgeEntity> page = this.selectPage(
                new Query<AicoachKnowledgeEntity>(params).getPage(),
                wrapper
        );
        return new PageUtils(page);
    }

    @Override
    public List<AicoachKnowledgeEntity> selectListView(Map<String, Object> params) {
        EntityWrapper<AicoachKnowledgeEntity> wrapper = new EntityWrapper<>();
        if (params.containsKey("question") && params.get("question") != null) {
            wrapper.like("question", params.get("question").toString());
        }
        if (params.containsKey("category") && params.get("category") != null) {
            wrapper.like("category", params.get("category").toString());
        }
        wrapper.orderBy("sort", true);
        return this.selectList(wrapper);
    }

    /**
     * 关键词匹配算法 - 获取最佳答案
     * 匹配策略：
     * 1. 精确匹配问题
     * 2. 模糊匹配问题
     * 3. 关键词匹配
     */
    @Override
    public String getBestAnswer(String question) {
        if (question == null || question.trim().isEmpty()) {
            return "您好，请告诉我您想了解的健身问题，我会尽力为您解答。";
        }

        String lowerQuestion = question.toLowerCase().trim();

        // 获取所有知识库数据
        List<AicoachKnowledgeEntity> allKnowledge = this.selectList(null);

        if (allKnowledge == null || allKnowledge.isEmpty()) {
            return "知识库暂未完善，请联系管理员添加健身知识。";
        }

        // 评分列表
        List<MatchResult> results = new ArrayList<>();

        for (AicoachKnowledgeEntity knowledge : allKnowledge) {
            int score = calculateMatchScore(lowerQuestion, knowledge);

            if (score > 0) {
                results.add(new MatchResult(knowledge, score));
            }
        }

        // 按评分排序
        results.sort((a, b) -> b.score - a.score);

        if (!results.isEmpty()) {
            return results.get(0).entity.getAnswer();
        }

        // 没有匹配到，返回默认回复
        return getDefaultAnswer();
    }

    /**
     * 计算匹配分数
     */
    private int calculateMatchScore(String question, AicoachKnowledgeEntity entity) {
        int score = 0;

        // 1. 精确匹配问题（最高优先级）
        if (entity.getQuestion() != null && entity.getQuestion().toLowerCase().contains(question)) {
            score += 100;
        }

        // 2. 精确包含问题
        if (entity.getQuestion() != null && question.contains(entity.getQuestion().toLowerCase())) {
            score += 80;
        }

        // 3. 关键词匹配
        if (entity.getKeywords() != null && !entity.getKeywords().isEmpty()) {
            String[] keywords = entity.getKeywords().split(",");
            for (String keyword : keywords) {
                keyword = keyword.trim().toLowerCase();
                if (!keyword.isEmpty() && question.contains(keyword)) {
                    score += 20;
                }
            }
        }

        // 4. 分类关键词匹配
        if (entity.getCategory() != null && !entity.getCategory().isEmpty()) {
            String category = entity.getCategory().toLowerCase();
            if (question.contains(category)) {
                score += 10;
            }
        }

        // 5. 常见健身问题模式匹配
        score += patternMatch(question, entity);

        return score;
    }

    /**
     * 模式匹配 - 处理常见问法
     */
    private int patternMatch(String question, AicoachKnowledgeEntity entity) {
        int score = 0;

        // 什么是... / 如何... / 怎样...
        String[] patterns = {"如何", "怎么", "怎样", "什么", "哪些", "怎么样", "how", "what", "怎么"};
        for (String pattern : patterns) {
            if (question.contains(pattern.toLowerCase()) && entity.getQuestion().contains(pattern)) {
                score += 15;
                break;
            }
        }

        // 动作类问题
        if (question.contains("做") || question.contains("练") || question.contains("锻炼")) {
            if (entity.getQuestion().contains("运动") || entity.getQuestion().contains("健身") || entity.getQuestion().contains("训练")) {
                score += 10;
            }
        }

        // 饮食类问题
        if (question.contains("吃") || question.contains("饮食") || question.contains("食物") || question.contains("饭")) {
            if (entity.getCategory() != null && entity.getCategory().contains("饮食")) {
                score += 15;
            }
        }

        return score;
    }

    /**
     * 获取默认回复
     */
    private String getDefaultAnswer() {
        String[] defaultAnswers = {
            "抱歉，我不太理解您的问题。您可以尝试询问：\n1. 如何开始健身\n2. 增肌饮食建议\n3. 减脂最有效的运动\n4. 健身前如何热身\n5. 俯卧撑正确姿势",
            "这个问题我暂时无法回答，不过我可以为您解答以下常见问题：\n- 如何开始健身\n- 增肌饮食建议\n- 减脂运动推荐\n- 正确的健身动作\n- 健身计划安排",
            "不如换个方式问我？例如：\n「如何增肌」\n「减脂做什么运动」\n「健身前后怎么吃」"
        };
        return defaultAnswers[(int) (Math.random() * defaultAnswers.length)];
    }

    /**
     * 匹配结果内部类
     */
    private static class MatchResult {
        AicoachKnowledgeEntity entity;
        int score;

        MatchResult(AicoachKnowledgeEntity entity, int score) {
            this.entity = entity;
            this.score = score;
        }
    }

}
