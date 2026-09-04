package com.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.net.ssl.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.cert.X509Certificate;
import java.util.*;

/**
 * 智谱AI GLM-4-Flash 服务类
 * 用于调用智谱AI生成智能健身计划
 */
@Service
public class GLMAIService {

    @Value("${glm.api-key}")
    private String apiKey;

    private static final String API_URL = "https://open.bigmodel.cn/api/paas/v4/chat/completions";
    private static final String MODEL = "glm-4-flash";
    private static final int CONNECT_TIMEOUT = 30000;
    private static final int READ_TIMEOUT = 120000;

    // 禁用SSL证书验证（用于HTTPS请求）
    static {
        try {
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, new TrustManager[]{new X509TrustManager() {
                public X509Certificate[] getAcceptedIssuers() { return null; }
                public void checkClientTrusted(X509Certificate[] certs, String authType) {}
                public void checkServerTrusted(X509Certificate[] certs, String authType) {}
            }}, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sslContext.getSocketFactory());
            HttpsURLConnection.setDefaultHostnameVerifier((hostname, session) -> true);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 调用GLM-4-Flash生成健身计划
     *
     * @param userInfo 用户信息（身高、体重、BMI、健身目标、等级、每周训练天数等）
     * @return AI生成的健身计划JSON
     */
    public String generateFitnessPlan(Map<String, Object> userInfo) {
        HttpURLConnection connection = null;
        try {
            String systemPrompt = buildSystemPrompt();
            String userPrompt = buildUserPrompt(userInfo);

            // 构建请求体
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", MODEL);
            
            List<Map<String, String>> messages = new ArrayList<>();
            messages.add(createMessage("system", systemPrompt));
            messages.add(createMessage("user", userPrompt));
            
            requestBody.put("messages", messages);
            requestBody.put("max_tokens", 4096);
            requestBody.put("temperature", 0.7);

            // 创建连接
            URL url = new URL(API_URL);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setConnectTimeout(CONNECT_TIMEOUT);
            connection.setReadTimeout(READ_TIMEOUT);
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setUseCaches(false);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + apiKey);

            // 发送请求
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = JSON.toJSONString(requestBody).getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // 读取响应
            int responseCode = connection.getResponseCode();
            StringBuilder response = new StringBuilder();
            
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(
                            responseCode >= 400 ? connection.getErrorStream() : connection.getInputStream(),
                            StandardCharsets.UTF_8))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
            }

            if (responseCode == 200) {
                JSONObject jsonResponse = JSON.parseObject(response.toString());
                JSONArray choices = jsonResponse.getJSONArray("choices");
                if (choices != null && !choices.isEmpty()) {
                    JSONObject message = choices.getJSONObject(0).getJSONObject("message");
                    return message.getString("content");
                }
            }
            
            // 返回错误信息
            JSONObject errorJson = JSON.parseObject(response.toString());
            String errorMsg = errorJson.getString("error");
            if (errorMsg == null) {
                errorMsg = "API调用失败，状态码: " + responseCode;
            }
            return "{\"error\": \"" + errorMsg + "\"}";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\": \"调用AI服务异常: " + e.getMessage() + "\"}";
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    /**
     * 创建消息对象（兼容Java 1.8）
     */
    private Map<String, String> createMessage(String role, String content) {
        Map<String, String> message = new HashMap<>();
        message.put("role", role);
        message.put("content", content);
        return message;
    }

    /**
     * 构建系统提示词
     */
    private String buildSystemPrompt() {
        return "你是一位专业的健身教练AI助手，擅长根据用户的个人信息和健身目标，制定科学合理的健身计划。\n\n" +
               "你必须严格按照以下JSON格式输出健身计划，不要包含任何其他内容：\n\n" +
               "{\n" +
               "  \"planName\": \"计划名称\",\n" +
               "  \"weeklyPlan\": [\n" +
               "    {\n" +
               "      \"day\": 1,\n" +
               "      \"isRestDay\": false,\n" +
               "      \"exercises\": [\n" +
               "        {\n" +
               "          \"timePeriod\": \"上午/下午/晚上\",\n" +
               "          \"projectName\": \"项目名称\",\n" +
               "          \"projectType\": \"项目类型\",\n" +
               "          \"duration\": 30,\n" +
               "          \"sets\": 3,\n" +
               "          \"reps\": 12,\n" +
               "          \"restTime\": 60,\n" +
               "          \"notes\": \"注意事项\"\n" +
               "        }\n" +
               "      ]\n" +
               "    },\n" +
               "    {\n" +
               "      \"day\": 2,\n" +
               "      \"isRestDay\": true,\n" +
               "      \"notes\": \"休息建议\"\n" +
               "    }\n" +
               "  ]\n" +
               "}\n\n" +
               "要求：\n" +
               "1. 每周7天的计划，每天都要有安排\n" +
               "2. 根据用户设定的每周训练天数安排训练日，其余为休息日\n" +
               "3. 训练日每天安排2-3个训练项目\n" +
               "4. 根据健身等级调整训练强度（初级：3组、中级：4组、高级：5组）\n" +
               "5. 项目类型应该与健身目标匹配\n" +
               "6. 每次输出必须是可以直接解析的JSON格式，不要输出其他任何文字";
    }

    /**
     * 构建用户提示词
     */
    private String buildUserPrompt(Map<String, Object> userInfo) {
        StringBuilder prompt = new StringBuilder();
        prompt.append("请根据以下用户信息生成健身计划：\n\n");
        
        if (userInfo.get("huiyuanzhanghao") != null) {
            prompt.append("会员账号：").append(userInfo.get("huiyuanzhanghao")).append("\n");
        }
        if (userInfo.get("shengao") != null) {
            prompt.append("身高：").append(userInfo.get("shengao")).append(" cm\n");
        }
        if (userInfo.get("tizhong") != null) {
            prompt.append("体重：").append(userInfo.get("tizhong")).append(" kg\n");
        }
        if (userInfo.get("bmi") != null) {
            prompt.append("BMI：").append(String.format("%.1f", ((Number) userInfo.get("bmi")).doubleValue())).append("\n");
        }
        if (userInfo.get("jianshenmubiao") != null) {
            prompt.append("健身目标：").append(userInfo.get("jianshenmubiao")).append("\n");
        }
        if (userInfo.get("jianshendengji") != null) {
            prompt.append("健身等级：").append(userInfo.get("jianshendengji")).append("\n");
        }
        if (userInfo.get("meizhouxunliantian") != null) {
            prompt.append("每周训练天数：").append(userInfo.get("meizhouxunliantian")).append(" 天\n");
        }
        
        prompt.append("\n请严格按照JSON格式输出健身计划。");
        
        return prompt.toString();
    }

    /**
     * 解析AI返回的健身计划
     *
     * @param aiResponse AI返回的JSON字符串
     * @return 解析后的健身计划列表
     */
    public List<Map<String, Object>> parseFitnessPlan(String aiResponse) {
        List<Map<String, Object>> result = new ArrayList<>();
        
        try {
            // 尝试提取JSON部分（处理可能的markdown代码块）
            String jsonStr = aiResponse.trim();
            if (jsonStr.startsWith("```json")) {
                jsonStr = jsonStr.substring(7);
            } else if (jsonStr.startsWith("```")) {
                jsonStr = jsonStr.substring(3);
            }
            if (jsonStr.endsWith("```")) {
                jsonStr = jsonStr.substring(0, jsonStr.length() - 3);
            }
            jsonStr = jsonStr.trim();
            
            JSONObject planJson = JSON.parseObject(jsonStr);
            JSONArray weeklyPlan = planJson.getJSONArray("weeklyPlan");
            
            if (weeklyPlan != null) {
                for (int i = 0; i < weeklyPlan.size(); i++) {
                    JSONObject dayPlan = weeklyPlan.getJSONObject(i);
                    Map<String, Object> dayInfo = new HashMap<>();
                    dayInfo.put("day", dayPlan.getInteger("day"));
                    dayInfo.put("isRestDay", dayPlan.getBooleanValue("isRestDay"));
                    
                    if (dayPlan.containsKey("notes")) {
                        dayInfo.put("notes", dayPlan.getString("notes"));
                    }
                    
                    if (dayPlan.containsKey("exercises")) {
                        JSONArray exercises = dayPlan.getJSONArray("exercises");
                        List<Map<String, Object>> exerciseList = new ArrayList<>();
                        
                        for (int j = 0; j < exercises.size(); j++) {
                            JSONObject exercise = exercises.getJSONObject(j);
                            Map<String, Object> exerciseInfo = new HashMap<>();
                            exerciseInfo.put("timePeriod", exercise.getString("timePeriod"));
                            exerciseInfo.put("projectName", exercise.getString("projectName"));
                            exerciseInfo.put("projectType", exercise.getString("projectType"));
                            exerciseInfo.put("duration", exercise.getInteger("duration"));
                            exerciseInfo.put("sets", exercise.getInteger("sets"));
                            exerciseInfo.put("reps", exercise.getInteger("reps"));
                            exerciseInfo.put("restTime", exercise.getInteger("restTime"));
                            exerciseInfo.put("notes", exercise.getString("notes"));
                            exerciseList.add(exerciseInfo);
                        }
                        
                        dayInfo.put("exercises", exerciseList);
                    }
                    
                    result.add(dayInfo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 解析失败时返回空列表
            Map<String, Object> errorInfo = new HashMap<>();
            errorInfo.put("error", "解析健身计划失败: " + e.getMessage());
            errorInfo.put("rawResponse", aiResponse);
            result.add(errorInfo);
        }
        
        return result;
    }
}
