package com.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Map;
import java.util.HashMap;
import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.entity.AicoachKnowledgeEntity;
import com.service.AicoachKnowledgeService;
import com.utils.MPUtil;
import com.utils.PageUtils;
import com.utils.R;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


/**
 * AI教练知识库
 * 后端接口
 */
@RestController
@RequestMapping("/aicoach/knowledge")
public class AicoachKnowledgeController {

    @Autowired
    private AicoachKnowledgeService aicoachKnowledgeService;

    /**
     * 分页查询
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params) {
        EntityWrapper<AicoachKnowledgeEntity> ew = new EntityWrapper<AicoachKnowledgeEntity>();
        if(params.get("question") != null && !"".equals(params.get("question"))) {
            ew.like("question", params.get("question").toString());
        }
        if(params.get("category") != null && !"".equals(params.get("category"))) {
            ew.like("category", params.get("category").toString());
        }
        ew.orderBy("id", false);
        PageUtils page = aicoachKnowledgeService.queryPage(params, ew);
        return R.ok().put("data", page);
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        EntityWrapper<AicoachKnowledgeEntity> ew = new EntityWrapper<AicoachKnowledgeEntity>();
        if(params.get("question") != null && !"".equals(params.get("question"))) {
            ew.like("question", params.get("question").toString());
        }
        if(params.get("category") != null && !"".equals(params.get("category"))) {
            ew.like("category", params.get("category").toString());
        }
        ew.orderBy("id", false);
        return R.ok().put("data", aicoachKnowledgeService.selectList(ew));
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id) {
        AicoachKnowledgeEntity aicoachKnowledge = aicoachKnowledgeService.selectById(id);
        return R.ok().put("data", aicoachKnowledge);
    }

    /**
     * 获取详情
     */
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id) {
        AicoachKnowledgeEntity aicoachKnowledge = aicoachKnowledgeService.selectById(id);
        return R.ok().put("data", aicoachKnowledge);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody AicoachKnowledgeEntity aicoachKnowledge) {
        aicoachKnowledgeService.insert(aicoachKnowledge);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody AicoachKnowledgeEntity aicoachKnowledge) {
        aicoachKnowledgeService.updateById(aicoachKnowledge);
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids) {
        aicoachKnowledgeService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    /**
     * AI问答接口
     */
    @RequestMapping("/chat")
    public R chat(@RequestParam("question") String question) {
        String answer = aicoachKnowledgeService.getBestAnswer(question);
        return R.ok().put("answer", answer);
    }

    /**
     * 获取分类列表
     */
    @RequestMapping("/categories")
    public R categories() {
        List<String> categories = new ArrayList<>();
        List<AicoachKnowledgeEntity> list = aicoachKnowledgeService.selectList(null);
        for (AicoachKnowledgeEntity entity : list) {
            if (entity.getCategory() != null && !entity.getCategory().isEmpty() && !categories.contains(entity.getCategory())) {
                categories.add(entity.getCategory());
            }
        }
        return R.ok().put("data", categories);
    }

    /**
     * 推荐问题
     */
    @RequestMapping("/recommend")
    public R recommend() {
        List<AicoachKnowledgeEntity> list = aicoachKnowledgeService.selectList(
            new EntityWrapper<AicoachKnowledgeEntity>().orderBy("sort", true).last("LIMIT 5")
        );
        return R.ok().put("data", list);
    }

}
