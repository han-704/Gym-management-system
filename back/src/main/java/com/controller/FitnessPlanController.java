package com.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.utils.PageUtils;
import com.utils.Query;
import com.utils.R;
import com.entity.HuiyuanBodyDataEntity;
import com.entity.FitnessPlanEntity;
import com.entity.FitnessPlanDetailEntity;
import com.entity.JianshenxiangmuEntity;
import com.service.HuiyuanBodyDataService;
import com.service.FitnessPlanService;
import com.service.FitnessPlanDetailService;
import com.service.JianshenxiangmuService;
import com.service.GLMAIService;

/**
 * 智能健身计划生成控制器
 */
@RestController
@RequestMapping("/fitness/plan")
public class FitnessPlanController {

    @Autowired
    private HuiyuanBodyDataService huiyuanBodyDataService;

    @Autowired
    private FitnessPlanService fitnessPlanService;

    @Autowired
    private FitnessPlanDetailService fitnessPlanDetailService;

    @Autowired
    private JianshenxiangmuService jianshenxiangmuService;

    @Autowired
    private GLMAIService glmAIService;

    /**
     * 生成健身计划
     */
    @PostMapping("/generate")
    public R generatePlan(@RequestBody Map<String, Object> params, HttpServletRequest request) {
        try {
            // 获取参数并进行空值校验
            if (params.get("huiyuanId") == null || params.get("shengao") == null || params.get("tizhong") == null) {
                return R.error("缺少必要参数");
            }

            // 获取用户信息
            Long huiyuanId = Long.valueOf(params.get("huiyuanId").toString());
        String huiyuanzhanghao = params.get("huiyuanzhanghao") != null ? params.get("huiyuanzhanghao").toString() : "";
        
        // 获取身体数据
        Double shengao = Double.valueOf(params.get("shengao").toString());
        Double tizhong = Double.valueOf(params.get("tizhong").toString());
        String jianshenmubiao = params.get("jianshenmubiao") != null ? params.get("jianshenmubiao").toString() : "塑形";
        String jianshendengji = params.get("jianshendengji") != null ? params.get("jianshendengji").toString() : "初级";
        Integer meizhouxunliantian = params.get("meizhouxunliantian") != null ? Integer.valueOf(params.get("meizhouxunliantian").toString()) : 3;
        String beizhu = params.get("beizhu") != null ? params.get("beizhu").toString() : "";
        
        // 计算BMI
        double bmi = tizhong / Math.pow(shengao / 100, 2);
        
        // 1. 保存身体数据
        HuiyuanBodyDataEntity bodyData = new HuiyuanBodyDataEntity();
        bodyData.setHuiyuanId(huiyuanId);
        bodyData.setHuiyuanzhanghao(huiyuanzhanghao);
        bodyData.setShengao(shengao);
        bodyData.setTizhong(tizhong);
        bodyData.setBmi(bmi);
        bodyData.setJianshenmubiao(jianshenmubiao);
        bodyData.setJianshendengji(jianshendengji);
        bodyData.setMeizhouxunliantian(meizhouxunliantian);
        bodyData.setBeizhu(beizhu);
        bodyData.setAddtime(new Date());
        huiyuanBodyDataService.insert(bodyData);
        
        // 2. 查询健身项目
        List<JianshenxiangmuEntity> allProjects = jianshenxiangmuService.selectList(null);
        
        // 根据目标筛选项目
        List<JianshenxiangmuEntity> filteredProjects = filterProjectsByGoal(allProjects, jianshenmubiao);
        
        // 构建传递给AI的用户信息
        Map<String, Object> userInfo = new HashMap<>();
        userInfo.put("huiyuanId", huiyuanId);
        userInfo.put("huiyuanzhanghao", huiyuanzhanghao);
        userInfo.put("shengao", shengao);
        userInfo.put("tizhong", tizhong);
        userInfo.put("bmi", bmi);
        userInfo.put("jianshenmubiao", jianshenmubiao);
        userInfo.put("jianshendengji", jianshendengji);
        userInfo.put("meizhouxunliantian", meizhouxunliantian);
        userInfo.put("beizhu", beizhu);
        
        // 3. 生成健身计划
        FitnessPlanEntity plan = new FitnessPlanEntity();
        plan.setHuiyuanId(huiyuanId);
        plan.setHuiyuanzhanghao(huiyuanzhanghao);
        plan.setPlanName(jianshenmubiao + "计划-" + new SimpleDateFormat("yyyyMMdd").format(new Date()));
        plan.setJianshenmubiao(jianshenmubiao);
        plan.setJianshendengji(jianshendengji);
        plan.setShengao(shengao);
        plan.setTizhong(tizhong);
        plan.setBmi(bmi);
        plan.setMeizhouxunliantian(meizhouxunliantian);
        plan.setStartDate(new Date());
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 7);
        plan.setEndDate(cal.getTime());
        plan.setStatus("进行中");
        plan.setAddtime(new Date());
        
        fitnessPlanService.insert(plan);

        // 4. 调用GLM-4-Flash AI生成健身计划
        int totalDuration = generateDailyPlansByAI(plan.getId(), meizhouxunliantian, userInfo);

        // 更新计划总时长
        plan.setZongshichang(totalDuration);
        plan.setZongtianshu(meizhouxunliantian);
        fitnessPlanService.updateById(plan);

        // 重新查询确保返回完整的plan对象
        FitnessPlanEntity savedPlan = fitnessPlanService.selectById(plan.getId());

        Map<String, Object> result = new HashMap<>();
        result.put("plan", savedPlan);
        return R.ok().put("data", result);
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("生成计划失败: " + e.getMessage());
        }
    }

    /**
     * 使用AI生成每日训练计划
     */
    private int generateDailyPlansByAI(Long planId, int weeklyDays, Map<String, Object> userInfo) {
        int totalDuration = 0;
        
        try {
            // 调用GLM-4-Flash AI生成健身计划
            String aiResponse = glmAIService.generateFitnessPlan(userInfo);
            
            // 解析AI返回的计划
            List<Map<String, Object>> parsedPlan = glmAIService.parseFitnessPlan(aiResponse);
            
            for (Map<String, Object> dayPlan : parsedPlan) {
                // 检查是否有解析错误
                if (dayPlan.containsKey("error")) {
                    System.err.println("AI计划解析错误: " + dayPlan.get("error"));
                    // 使用备用规则生成
                    return generateDailyPlansFallback(planId, weeklyDays, userInfo);
                }
                
                Integer day = (Integer) dayPlan.get("day");
                Boolean isRestDay = (Boolean) dayPlan.get("isRestDay");
                
                if (isRestDay) {
                    // 休息日
                    FitnessPlanDetailEntity restDay = new FitnessPlanDetailEntity();
                    restDay.setPlanId(planId);
                    restDay.setXingqi(day);
                    restDay.setShiduan("全天");
                    restDay.setXiangmumingcheng("休息");
                    restDay.setXiangmuleixing("休息");
                    restDay.setShichang(0);
                    restDay.setZushu(0);
                    restDay.setCishu(0);
                    restDay.setBeizhu(dayPlan.containsKey("notes") ? dayPlan.get("notes").toString() : "建议：保持充足睡眠，注意饮食");
                    restDay.setAddtime(new Date());
                    fitnessPlanDetailService.insert(restDay);
                } else {
                    // 训练日
                    List<Map<String, Object>> exercises = (List<Map<String, Object>>) dayPlan.get("exercises");
                    if (exercises != null) {
                        for (Map<String, Object> exercise : exercises) {
                            FitnessPlanDetailEntity detail = new FitnessPlanDetailEntity();
                            detail.setPlanId(planId);
                            detail.setXingqi(day);
                            detail.setShiduan(exercise.get("timePeriod").toString());
                            detail.setXiangmumingcheng(exercise.get("projectName").toString());
                            detail.setXiangmuleixing(exercise.get("projectType").toString());
                            detail.setShichang((Integer) exercise.get("duration"));
                            detail.setZushu((Integer) exercise.get("sets"));
                            detail.setCishu((Integer) exercise.get("reps"));
                            detail.setXiuxishijian((Integer) exercise.get("restTime"));
                            detail.setBeizhu(exercise.get("notes").toString());
                            detail.setAddtime(new Date());
                            fitnessPlanDetailService.insert(detail);
                            totalDuration += (Integer) exercise.get("duration");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // AI生成失败时使用备用规则生成
            return generateDailyPlansFallback(planId, weeklyDays, userInfo);
        }
        
        return totalDuration;
    }
    
    /**
     * 备用规则生成（AI调用失败时使用）
     */
    private int generateDailyPlansFallback(Long planId, int weeklyDays, Map<String, Object> userInfo) {
        List<JianshenxiangmuEntity> allProjects = jianshenxiangmuService.selectList(null);
        String goal = userInfo.get("jianshenmubiao") != null ? userInfo.get("jianshenmubiao").toString() : "塑形";
        String level = userInfo.get("jianshendengji") != null ? userInfo.get("jianshendengji").toString() : "初级";
        List<JianshenxiangmuEntity> filteredProjects = filterProjectsByGoal(allProjects, goal);
        return generateDailyPlans(planId, weeklyDays, filteredProjects, goal, level);
    }
    
    /**
     * 根据目标筛选健身项目
     */
    private List<JianshenxiangmuEntity> filterProjectsByGoal(List<JianshenxiangmuEntity> projects, String goal) {
        List<JianshenxiangmuEntity> result = new ArrayList<>();
        
        // 目标类型映射到项目类型
        Map<String, String[]> goalTypeMap = new HashMap<>();
        goalTypeMap.put("减脂", new String[]{"有氧运动", "动感单车", "跑步", "游泳"});
        goalTypeMap.put("增肌", new String[]{"力量训练", "哑铃", "杠铃", "器械"});
        goalTypeMap.put("塑形", new String[]{"瑜伽", "普拉提", "力量训练", "拉伸"});
        goalTypeMap.put("康复", new String[]{"拉伸", "瑜伽", "理疗"});
        
        String[] targetTypes = goalTypeMap.getOrDefault(goal, new String[]{});
        
        for (JianshenxiangmuEntity project : projects) {
            String xiangmuleixing = project.getXiangmuleixing();
            if (xiangmuleixing != null) {
                for (String type : targetTypes) {
                    if (xiangmuleixing.contains(type) || type.contains(xiangmuleixing)) {
                        result.add(project);
                        break;
                    }
                }
            }
        }
        
        // 如果筛选结果为空，返回所有项目
        if (result.isEmpty()) {
            return projects;
        }
        
        return result;
    }
    
    /**
     * 生成每日训练计划
     */
    private int generateDailyPlans(Long planId, int weeklyDays, List<JianshenxiangmuEntity> projects, 
                                    String goal, String level) {
        int totalDuration = 0;
        
        // 训练日安排（均匀分布）
        List<Integer> trainingDays = new ArrayList<>();
        int interval = 7 / weeklyDays;
        for (int i = 0; i < weeklyDays; i++) {
            trainingDays.add((i * interval) + 1);
        }
        
        // 身体部位轮换
        String[] bodyParts = {"胸部", "背部", "腿部", "肩部", "手臂", "核心"};
        
        // 生成每天的训练计划
        for (int day = 1; day <= 7; day++) {
            // 判断是否为训练日
            boolean isTrainingDay = trainingDays.contains(day);
            
            if (!isTrainingDay) {
                // 休息日
                FitnessPlanDetailEntity restDay = new FitnessPlanDetailEntity();
                restDay.setPlanId(planId);
                restDay.setXingqi(day);
                restDay.setShiduan("全天");
                restDay.setXiangmumingcheng("休息");
                restDay.setXiangmuleixing("休息");
                restDay.setShichang(0);
                restDay.setZushu(0);
                restDay.setCishu(0);
                restDay.setBeizhu("建议：保持充足睡眠，注意饮食");
                restDay.setAddtime(new Date());
                fitnessPlanDetailService.insert(restDay);
                continue;
            }
            
            // 根据等级设置训练参数
            int sets = "初级".equals(level) ? 3 : ("中级".equals(level) ? 4 : 5);
            int reps = "初级".equals(level) ? 12 : ("中级".equals(level) ? 10 : 8);
            int restTime = "初级".equals(level) ? 60 : ("中级".equals(level) ? 45 : 30);
            int duration = 45;
            
            // 每天安排2-3个项目
            int projectCount = Math.min(3, projects.size());
            for (int p = 0; p < projectCount; p++) {
                int projectIndex = (day - 1 + p) % Math.max(projects.size(), 1);
                JianshenxiangmuEntity project = projects.get(projectIndex % projects.size());
                
                FitnessPlanDetailEntity detail = new FitnessPlanDetailEntity();
                detail.setPlanId(planId);
                detail.setXingqi(day);
                detail.setShiduan(p == 0 ? "上午" : (p == 1 ? "下午" : "晚上"));
                detail.setXiangmuId(project.getId());
                detail.setXiangmumingcheng(project.getXiangmumingcheng());
                detail.setXiangmuleixing(project.getXiangmuleixing());
                detail.setShichang(duration / projectCount);
                detail.setZushu(sets);
                detail.setCishu(reps);
                detail.setXiuxishijian(restTime);
                
                // 添加目标相关的注意事项
                String notes = getNotesByGoal(goal, project.getXiangmuleixing());
                detail.setBeizhu(notes);
                detail.setAddtime(new Date());
                
                fitnessPlanDetailService.insert(detail);
                totalDuration += duration / projectCount;
            }
        }
        
        return totalDuration;
    }
    
    /**
     * 根据目标获取注意事项
     */
    private String getNotesByGoal(String goal, String projectType) {
        Map<String, String> notesMap = new HashMap<>();
        notesMap.put("减脂有氧", "保持中高速心率，注意补充水分");
        notesMap.put("增肌力量", "用力时呼气，还原时吸气，注意保护关节");
        notesMap.put("塑形", "动作标准为主，感受肌肉发力");
        notesMap.put("default", "循序渐进，注意安全");
        
        String key = goal + projectType;
        return notesMap.getOrDefault(key, notesMap.get("default"));
    }
    
    /**
     * 获取计划详情
     */
    @GetMapping("/detail/{id}")
    public R getPlanDetail(@PathVariable("id") Long id) {
        FitnessPlanEntity plan = fitnessPlanService.selectById(id);
        if (plan == null) {
            return R.error("计划不存在");
        }
        
        // 查询计划详情
        List<FitnessPlanDetailEntity> details = fitnessPlanDetailService.selectList(
            new EntityWrapper<FitnessPlanDetailEntity>().eq("plan_id", id).orderBy("xingqi")
        );
        
        // 按星期分组
        Map<Integer, List<FitnessPlanDetailEntity>> weeklyPlan = new LinkedHashMap<>();
        for (FitnessPlanDetailEntity detail : details) {
            weeklyPlan.computeIfAbsent(detail.getXingqi(), k -> new ArrayList<>()).add(detail);
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("plan", plan);
        result.put("weeklyPlan", weeklyPlan);

        return R.ok().put("data", result);
    }
    
    /**
     * 导出Excel
     */
    @CrossOrigin
    @GetMapping("/export/excel/{id}")
    public void exportExcel(@PathVariable("id") Long id, HttpServletResponse response) throws Exception {
        try {
            FitnessPlanEntity plan = fitnessPlanService.selectById(id);
            if (plan == null) {
                response.getWriter().write("计划不存在");
                return;
            }
            List<FitnessPlanDetailEntity> details = fitnessPlanDetailService.selectList(
                new EntityWrapper<FitnessPlanDetailEntity>().eq("plan_id", id).orderBy("xingqi")
            );

            // 使用CSV格式导出（更稳定）
            StringBuilder csv = new StringBuilder();
            csv.append("智能健身计划\n");
            csv.append("会员账号:,").append(plan.getHuiyuanzhanghao()).append(",健身目标:,").append(plan.getJianshenmubiao()).append("\n");
            csv.append("身高:,").append(plan.getShengao()).append("cm,体重:,").append(plan.getTizhong()).append("kg,BMI:,").append(String.format("%.1f", plan.getBmi())).append("\n\n");
            csv.append("星期,时段,项目名称,项目类型,时长(分钟),组数,次数,休息时间(秒),注意事项\n");

            String[] weekDays = {"", "周一", "周二", "周三", "周四", "周五", "周六", "周日"};
            for (FitnessPlanDetailEntity detail : details) {
                csv.append(weekDays[detail.getXingqi()]).append(",");
                csv.append(detail.getShiduan()).append(",");
                csv.append(detail.getXiangmumingcheng()).append(",");
                csv.append(detail.getXiangmuleixing()).append(",");
                csv.append(detail.getShichang()).append(",");
                csv.append(detail.getZushu()).append(",");
                csv.append(detail.getCishu()).append(",");
                csv.append(detail.getXiuxishijian()).append(",");
                csv.append(detail.getBeizhu()).append("\n");
            }

            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename=fitness_plan_" + id + ".csv");

            response.getWriter().write(new String(csv.toString().getBytes("UTF-8"), "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain;charset=utf-8");
            response.getWriter().write("导出失败: " + e.getMessage());
        }
    }

    /**
     * 导出文本格式（简单实现）
     */
    @CrossOrigin
    @GetMapping("/export/txt/{id}")
    public void exportTxt(@PathVariable("id") Long id, HttpServletResponse response) throws Exception {
        FitnessPlanEntity plan = fitnessPlanService.selectById(id);
        List<FitnessPlanDetailEntity> details = fitnessPlanDetailService.selectList(
            new EntityWrapper<FitnessPlanDetailEntity>().eq("plan_id", id).orderBy("xingqi")
        );
        
        StringBuilder sb = new StringBuilder();
        sb.append("========================================\n");
        sb.append("           智能健身计划\n");
        sb.append("========================================\n\n");
        sb.append("会员账号: ").append(plan.getHuiyuanzhanghao()).append("\n");
        sb.append("健身目标: ").append(plan.getJianshenmubiao()).append("\n");
        sb.append("健身等级: ").append(plan.getJianshendengji()).append("\n");
        sb.append("身高: ").append(plan.getShengao()).append("cm\n");
        sb.append("体重: ").append(plan.getTizhong()).append("kg\n");
        sb.append("BMI: ").append(String.format("%.1f", plan.getBmi())).append("\n");
        sb.append("每周训练: ").append(plan.getMeizhouxunliantian()).append("天\n");
        sb.append("计划周期: ").append(new SimpleDateFormat("yyyy-MM-dd").format(plan.getStartDate()))
          .append(" 至 ").append(new SimpleDateFormat("yyyy-MM-dd").format(plan.getEndDate())).append("\n\n");
        
        String[] weekDays = {"", "周一", "周二", "周三", "周四", "周五", "周六", "周日"};
        
        sb.append("========================================\n");
        sb.append("           每周训练安排\n");
        sb.append("========================================\n\n");
        
        int currentDay = 0;
        for (FitnessPlanDetailEntity detail : details) {
            if (detail.getXingqi() != currentDay) {
                currentDay = detail.getXingqi();
                sb.append("\n【").append(weekDays[currentDay]).append("】\n");
            }
            
            if ("休息".equals(detail.getXiangmumingcheng())) {
                sb.append("  ").append("休息 - ").append(detail.getBeizhu()).append("\n");
            } else {
                sb.append("  ").append(detail.getShiduan()).append(" ")
                  .append(detail.getXiangmumingcheng())
                  .append(" - ").append(detail.getShichang()).append("分钟")
                  .append(" ").append(detail.getZushu()).append("组×")
                  .append(detail.getCishu()).append("次\n");
                if (detail.getBeizhu() != null && !detail.getBeizhu().isEmpty()) {
                    sb.append("    注意事项: ").append(detail.getBeizhu()).append("\n");
                }
            }
        }
        
        sb.append("\n========================================\n");
        sb.append("           计划说明\n");
        sb.append("========================================\n");
        sb.append("1. 训练前请做好热身准备\n");
        sb.append("2. 训练过程中注意补充水分\n");
        sb.append("3. 训练后做好拉伸放松\n");
        sb.append("4. 如有不适请停止训练并咨询教练\n");
        
        response.setContentType("text/plain;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=fitness_plan_" + id + ".txt");
        response.getWriter().write(sb.toString());
    }
}
