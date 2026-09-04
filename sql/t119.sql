/*
 Navicat Premium Data Transfer

 Source Server         : 1
 Source Server Type    : MySQL
 Source Server Version : 80028 (8.0.28-commercial)
 Source Host           : localhost:3306
 Source Schema         : t119

 Target Server Type    : MySQL
 Target Server Version : 80028 (8.0.28-commercial)
 File Encoding         : 65001

 Date: 26/05/2026 18:08:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aicoach_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `aicoach_knowledge`;
CREATE TABLE `aicoach_knowledge`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `question` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问题',
  `answer` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '答案',
  `category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `keywords` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'AI教练知识库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aicoach_knowledge
-- ----------------------------
INSERT INTO `aicoach_knowledge` VALUES (1, '2026-03-14 15:51:59', '如何开始健身', '初学者建议从以下几个方面开始：\n1. 制定合理的健身计划，每周3-4次为宜\n2. 先从基础动作开始，如深蹲、俯卧撑、平板支撑等\n3. 注意热身和拉伸，避免受伤\n4. 循序渐进，逐步增加强度\n5. 保持充足的睡眠和营养', '入门指南', '健身,开始,初学者,新手', 0);
INSERT INTO `aicoach_knowledge` VALUES (2, '2026-03-14 15:51:59', '增肌饮食建议', '增肌期间饮食建议：\n1. 蛋白质摄入：每公斤体重1.6-2.2克\n2. 碳水化合物：提供训练能量\n3. 健康脂肪：维持激素水平\n4. 多餐少食，每天5-6餐\n5. 训练后30分钟内补充蛋白质和碳水\n推荐食物：鸡胸肉、鱼、鸡蛋、牛奶、燕麦、红薯', '饮食营养', '增肌,饮食,蛋白质,吃什么', 0);
INSERT INTO `aicoach_knowledge` VALUES (3, '2026-03-14 15:51:59', '减脂最有效的运动', '减脂推荐运动：\n1. 有氧运动：跑步、游泳、骑行（每次30分钟以上）\n2. HIIT高强度间歇训练\n3. 力量训练（增加肌肉提高基础代谢）\n4. 复合动作：硬拉、深蹲、卧推\n建议：每周4-5次运动，结合饮食控制效果更佳', '运动健身', '减脂,减肥,跑步,HIIT,有氧', 0);
INSERT INTO `aicoach_knowledge` VALUES (4, '2026-03-14 15:51:59', '健身前如何热身', '热身步骤：\n1. 5-10分钟轻度有氧（快走、原地跑）\n2. 动态拉伸：腿部摆动、手臂环绕、扭腰\n3. 关节活动：肩关节、髋关节、膝关节\n4. 训练动作热身组（轻重量）\n重要：热身可以提高关节灵活性，减少受伤风险', '入门指南', '热身,准备活动,拉伸', 0);
INSERT INTO `aicoach_knowledge` VALUES (5, '2026-03-14 15:51:59', '如何提高深蹲质量', '正确深蹲要点：\n1. 脚与肩同宽，脚尖略微外展\n2. 膝盖沿着脚尖方向弯曲\n3. 核心收紧，背部挺直\n4. 蹲至大腿与地面平行或更低\n5. 起身时脚跟发力\n常见错误：膝盖内扣、腰背弯曲、蹲得太浅', '动作指导', '深蹲,动作,正确姿势', 0);
INSERT INTO `aicoach_knowledge` VALUES (6, '2026-03-14 15:51:59', '健身期间如何补充水分', '补水建议：\n1. 训练前2小时喝500ml水\n2. 训练中每15-20分钟补充200ml\n3. 训练后根据体重流失补充\n4. 避免一次性大量饮水\n5. 可适量补充电解质饮料\n注意：口渴时身体已经轻度脱水', '饮食营养', '喝水,补水,电解质', 0);
INSERT INTO `aicoach_knowledge` VALUES (7, '2026-03-14 15:51:59', '俯卧撑正确姿势', '俯卧撑做法：\n1. 双手与肩同宽或略宽\n2. 身体保持直线，从头到脚\n3. 下降时胸部接近地面\n4. 肘部与身体呈45度角\n5. 上升时手臂伸直\n初学者可以从跪姿俯卧撑开始', '动作指导', '俯卧撑,胸肌,徒手', 0);
INSERT INTO `aicoach_knowledge` VALUES (8, '2026-03-14 15:51:59', '如何安排健身计划', '健身计划建议：\n周一：胸肌+三头肌\n周二：背部+二头肌\n周三：休息或有氧\n周四：腿部+核心\n周五：肩部+有氧\n周六：全身综合训练\n周日：休息\n根据自身情况调整', '入门指南', '计划,安排,训练计划', 0);
INSERT INTO `aicoach_knowledge` VALUES (9, '2026-03-14 15:51:59', '运动后如何放松', '放松步骤：\n1. 训练后进行5-10分钟静态拉伸\n2. 重点拉伸训练部位肌肉\n3. 使用泡沫轴放松肌肉\n4. 适当按摩促进血液循环\n5. 训练后1小时内补充营养\n6. 保证7-8小时睡眠', '入门指南', '放松,拉伸,恢复', 0);
INSERT INTO `aicoach_knowledge` VALUES (10, '2026-03-14 15:51:59', '健身常见错误', '常见健身错误：\n1. 重量过重，动作不标准\n2. 训练强度过大，不注意休息\n3. 只做有氧，忽视力量训练\n4. 饮食不均衡，营养不足\n5. 训练动作单一\n6. 忽视热身和拉伸\n7. 睡眠不足', '入门指南', '错误,误区,注意', 0);
INSERT INTO `aicoach_knowledge` VALUES (11, '2026-03-14 16:41:31', '你好', '你好，我是你的专属AI教练，请问有什么问题？', NULL, '你是谁，hello', 0);

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'picture1', 'http://localhost:8080/springboot97s0t/upload/picture1.jpg');
INSERT INTO `config` VALUES (2, 'picture2', 'http://localhost:8080/springboot97s0t/upload/picture2.jpg');
INSERT INTO `config` VALUES (3, 'picture3', 'http://localhost:8080/springboot97s0t/upload/picture3.jpg');
INSERT INTO `config` VALUES (6, 'homepage', 'https://asoa-1305425069.cos.ap-shanghai.myqcloud.com/1669635627773202432.png');

-- ----------------------------
-- Table structure for fitness_plan
-- ----------------------------
DROP TABLE IF EXISTS `fitness_plan`;
CREATE TABLE `fitness_plan`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `huiyuan_id` bigint NULL DEFAULT NULL COMMENT '会员id',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员账号',
  `plan_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '计划名称',
  `jianshenmubiao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健身目标',
  `jianshendengji` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健身等级',
  `shengao` double NULL DEFAULT NULL COMMENT '身高',
  `tizhong` double NULL DEFAULT NULL COMMENT '体重',
  `bmi` double NULL DEFAULT NULL COMMENT 'BMI',
  `meizhouxunliantian` int NULL DEFAULT NULL COMMENT '每周训练天数',
  `start_date` date NULL DEFAULT NULL COMMENT '开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `zongshichang` int NULL DEFAULT NULL COMMENT '总时长(分钟)',
  `zongtianshu` int NULL DEFAULT NULL COMMENT '训练天数',
  `status` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '进行中' COMMENT '状态(进行中/已完成/已过期)',
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健身计划' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_plan
-- ----------------------------
INSERT INTO `fitness_plan` VALUES (1, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 70, 21.604938271604937, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan` VALUES (2, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 120, 40, 27.77777777777778, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan` VALUES (3, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 120, 40, 27.77777777777778, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan` VALUES (4, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 120, 40, 27.77777777777778, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan` VALUES (5, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 70, 21.604938271604937, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan` VALUES (6, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 70, 21.604938271604937, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan` VALUES (7, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 70, 21.604938271604937, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan` VALUES (8, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 70, 21.604938271604937, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan` VALUES (9, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 190, 60, 16.62049861495845, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan` VALUES (10, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 190, 60, 16.62049861495845, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan` VALUES (11, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 190, 60, 16.62049861495845, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan` VALUES (12, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 190, 60, 16.62049861495845, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:42:00');
INSERT INTO `fitness_plan` VALUES (13, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 190, 60, 16.62049861495845, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan` VALUES (14, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 190, 60, 16.62049861495845, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan` VALUES (15, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 180, 50, 15.432098765432098, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan` VALUES (16, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 70, 21.604938271604937, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan` VALUES (17, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 70, 21.604938271604937, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan` VALUES (18, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 180, 75, 23.148148148148145, 5, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan` VALUES (19, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 180, 75, 23.148148148148145, 5, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan` VALUES (20, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 180, 66, 20.37037037037037, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan` VALUES (21, 11, '会员1', '增肌计划-20260318', '增肌', '中级', 150, 45, 20, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan` VALUES (22, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 181, 50, 15.26204938799182, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan` VALUES (23, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 181, 50, 15.26204938799182, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan` VALUES (24, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 181, 50, 15.26204938799182, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan` VALUES (25, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 180, 75, 23.148148148148145, 3, '2026-03-18', '2026-03-25', NULL, NULL, '进行中', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan` VALUES (26, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 160, 40, 15.624999999999996, 3, '2026-03-18', '2026-03-25', 135, 3, '进行中', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan` VALUES (27, 11, '会员1', '增肌计划-20260318', '增肌', '初级', 165, 50, 18.36547291092746, 3, '2026-03-18', '2026-03-25', 135, 3, '进行中', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan` VALUES (28, 11, '会员1', '塑形计划-20260318', '塑形', '初级', 170, 60, 20.761245674740486, 3, '2026-03-18', '2026-03-25', 135, 3, '进行中', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan` VALUES (29, 11, '会员1', '减脂计划-20260318', '减脂', '初级', 170, 70, 24.221453287197235, 3, '2026-03-18', '2026-03-25', 135, 3, '进行中', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan` VALUES (30, 11, '会员1', '塑形计划-20260318', '塑形', '中级', 180, 60, 18.51851851851852, 6, '2026-03-18', '2026-03-25', 270, 6, '进行中', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan` VALUES (31, 11, '会员1', '增肌计划-20260322', '增肌', '高级', 180, 60, 18.51851851851852, 4, '2026-03-22', '2026-03-29', 180, 4, '进行中', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan` VALUES (32, 11, '会员1', '增肌计划-20260421', '增肌', '高级', 180, 70, 21.604938271604937, 5, '2026-04-21', '2026-04-28', 225, 5, '进行中', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan` VALUES (33, 11, '会员1', '减脂计划-20260422', '减脂', '中级', 180, 70, 21.604938271604937, 5, '2026-04-22', '2026-04-29', 225, 5, '进行中', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan` VALUES (34, 11, '会员1', '增肌计划-20260428', '增肌', '中级', 180, 70, 21.604938271604937, 5, '2026-04-28', '2026-05-05', 225, 5, '进行中', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan` VALUES (35, 11, '会员1', '塑形计划-20260428', '塑形', '中级', 180, 70, 21.604938271604937, 4, '2026-04-28', '2026-05-05', 360, 4, '进行中', '2026-04-28 19:33:36');
INSERT INTO `fitness_plan` VALUES (36, 11, '会员1', '减脂计划-20260428', '减脂', '初级', 180, 90, 27.777777777777775, 5, '2026-04-28', '2026-05-05', 240, 5, '进行中', '2026-04-28 19:40:21');
INSERT INTO `fitness_plan` VALUES (37, 11, '会员1', '增肌计划-20260503', '增肌', '中级', 167, 50, 17.92821542543655, 4, '2026-05-03', '2026-05-10', 270, 4, '进行中', '2026-05-03 23:46:18');
INSERT INTO `fitness_plan` VALUES (38, 11, '会员1', '增肌计划-20260503', '增肌', '中级', 179, 66, 20.598608033457133, 5, '2026-05-03', '2026-05-10', 360, 5, '进行中', '2026-05-03 23:51:19');
INSERT INTO `fitness_plan` VALUES (39, 11, '会员1', '增肌计划-20260518', '增肌', '中级', 180, 66, 20.37037037037037, 5, '2026-05-18', '2026-05-25', 360, 5, '进行中', '2026-05-18 16:46:50');

-- ----------------------------
-- Table structure for fitness_plan_detail
-- ----------------------------
DROP TABLE IF EXISTS `fitness_plan_detail`;
CREATE TABLE `fitness_plan_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `plan_id` bigint NULL DEFAULT NULL COMMENT '计划id',
  `xingqi` int NULL DEFAULT NULL COMMENT '星期几(1-7)',
  `shiduan` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '训练时段(上午/下午/晚上)',
  `xiangmu_id` bigint NULL DEFAULT NULL COMMENT '健身项目id',
  `xiangmumingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目名称',
  `xiangmuleixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目类型',
  `shichang` int NULL DEFAULT NULL COMMENT '训练时长(分钟)',
  `zushu` int NULL DEFAULT NULL COMMENT '组数',
  `cishu` int NULL DEFAULT NULL COMMENT '次数',
  `xiuxishijian` int NULL DEFAULT NULL COMMENT '休息时间(秒)',
  `beizhu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '注意事项',
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 525 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健身计划详情' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fitness_plan_detail
-- ----------------------------
INSERT INTO `fitness_plan_detail` VALUES (1, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (2, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (3, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (4, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (5, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (6, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (7, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (8, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (9, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (10, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (11, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (12, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (13, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:29:27');
INSERT INTO `fitness_plan_detail` VALUES (14, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (15, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (16, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (17, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (18, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (19, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (20, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (21, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (22, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (23, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (24, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (25, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (26, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:09');
INSERT INTO `fitness_plan_detail` VALUES (27, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (28, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (29, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (30, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (31, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (32, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (33, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (34, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (35, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (36, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (37, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (38, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (39, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:11');
INSERT INTO `fitness_plan_detail` VALUES (40, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (41, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (42, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (43, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (44, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (45, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (46, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (47, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (48, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (49, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (50, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (51, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (52, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:35:32');
INSERT INTO `fitness_plan_detail` VALUES (53, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (54, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (55, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (56, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (57, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (58, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (59, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (60, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (61, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (62, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (63, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (64, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (65, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:35');
INSERT INTO `fitness_plan_detail` VALUES (66, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (67, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (68, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (69, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (70, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (71, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (72, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (73, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (74, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (75, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (76, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (77, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (78, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:39:44');
INSERT INTO `fitness_plan_detail` VALUES (79, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (80, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (81, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (82, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (83, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (84, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (85, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (86, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (87, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (88, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (89, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (90, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (91, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:40:05');
INSERT INTO `fitness_plan_detail` VALUES (92, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (93, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (94, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (95, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (96, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (97, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (98, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (99, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (100, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (101, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (102, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (103, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (104, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:24');
INSERT INTO `fitness_plan_detail` VALUES (105, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (106, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (107, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (108, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (109, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (110, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (111, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (112, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (113, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (114, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (115, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (116, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (117, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:36');
INSERT INTO `fitness_plan_detail` VALUES (118, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (119, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (120, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (121, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (122, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (123, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (124, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (125, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (126, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (127, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (128, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (129, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (130, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:43');
INSERT INTO `fitness_plan_detail` VALUES (131, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (132, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (133, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (134, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (135, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (136, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (137, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (138, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (139, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (140, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (141, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (142, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (143, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:41:48');
INSERT INTO `fitness_plan_detail` VALUES (144, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:00');
INSERT INTO `fitness_plan_detail` VALUES (145, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:00');
INSERT INTO `fitness_plan_detail` VALUES (146, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:00');
INSERT INTO `fitness_plan_detail` VALUES (147, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (148, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (149, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (150, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (151, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (152, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (153, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (154, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (155, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (156, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:01');
INSERT INTO `fitness_plan_detail` VALUES (157, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (158, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (159, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (160, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (161, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (162, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (163, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (164, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (165, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (166, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (167, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (168, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (169, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:46');
INSERT INTO `fitness_plan_detail` VALUES (170, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (171, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (172, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (173, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (174, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (175, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (176, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (177, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (178, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (179, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (180, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (181, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (182, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:42:56');
INSERT INTO `fitness_plan_detail` VALUES (183, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (184, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (185, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (186, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (187, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (188, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (189, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (190, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (191, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (192, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (193, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (194, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (195, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:43:53');
INSERT INTO `fitness_plan_detail` VALUES (196, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (197, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (198, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (199, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (200, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (201, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (202, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (203, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (204, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (205, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (206, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (207, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (208, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:30');
INSERT INTO `fitness_plan_detail` VALUES (209, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (210, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (211, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (212, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (213, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (214, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (215, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (216, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (217, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (218, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (219, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (220, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (221, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:45:51');
INSERT INTO `fitness_plan_detail` VALUES (222, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (223, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (224, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (225, NULL, 2, '上午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (226, NULL, 2, '下午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (227, NULL, 2, '晚上', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (228, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (229, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (230, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (231, NULL, 4, '上午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (232, NULL, 4, '下午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (233, NULL, 4, '晚上', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (234, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (235, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (236, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (237, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (238, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:46:19');
INSERT INTO `fitness_plan_detail` VALUES (239, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (240, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (241, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (242, NULL, 2, '上午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (243, NULL, 2, '下午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (244, NULL, 2, '晚上', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (245, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (246, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (247, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (248, NULL, 4, '上午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (249, NULL, 4, '下午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (250, NULL, 4, '晚上', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (251, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (252, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (253, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (254, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (255, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:46:36');
INSERT INTO `fitness_plan_detail` VALUES (256, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (257, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (258, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (259, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (260, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (261, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (262, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (263, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (264, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (265, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (266, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (267, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (268, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:47:00');
INSERT INTO `fitness_plan_detail` VALUES (269, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (270, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (271, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (272, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (273, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (274, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (275, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (276, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (277, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (278, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (279, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (280, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (281, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:49:44');
INSERT INTO `fitness_plan_detail` VALUES (282, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (283, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (284, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (285, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (286, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (287, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (288, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (289, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (290, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (291, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (292, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (293, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (294, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:51:56');
INSERT INTO `fitness_plan_detail` VALUES (295, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (296, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (297, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (298, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (299, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (300, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (301, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (302, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (303, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (304, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (305, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (306, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (307, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:52:45');
INSERT INTO `fitness_plan_detail` VALUES (308, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (309, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (310, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (311, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (312, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (313, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (314, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (315, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (316, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (317, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (318, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (319, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (320, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:53:34');
INSERT INTO `fitness_plan_detail` VALUES (321, NULL, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (322, NULL, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (323, NULL, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (324, NULL, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (325, NULL, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (326, NULL, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (327, NULL, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (328, NULL, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (329, NULL, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (330, NULL, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:29');
INSERT INTO `fitness_plan_detail` VALUES (331, NULL, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:55:30');
INSERT INTO `fitness_plan_detail` VALUES (332, NULL, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:55:30');
INSERT INTO `fitness_plan_detail` VALUES (333, NULL, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:55:30');
INSERT INTO `fitness_plan_detail` VALUES (334, 26, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (335, 26, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (336, 26, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (337, 26, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (338, 26, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (339, 26, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (340, 26, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (341, 26, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (342, 26, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (343, 26, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (344, 26, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (345, 26, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (346, 26, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 18:57:48');
INSERT INTO `fitness_plan_detail` VALUES (347, 27, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (348, 27, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (349, 27, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (350, 27, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (351, 27, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (352, 27, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (353, 27, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (354, 27, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (355, 27, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (356, 27, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (357, 27, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (358, 27, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (359, 27, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:01:11');
INSERT INTO `fitness_plan_detail` VALUES (360, 28, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan_detail` VALUES (361, 28, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan_detail` VALUES (362, 28, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan_detail` VALUES (363, 28, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan_detail` VALUES (364, 28, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan_detail` VALUES (365, 28, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan_detail` VALUES (366, 28, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:08');
INSERT INTO `fitness_plan_detail` VALUES (367, 28, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:04:09');
INSERT INTO `fitness_plan_detail` VALUES (368, 28, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:09');
INSERT INTO `fitness_plan_detail` VALUES (369, 28, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:09');
INSERT INTO `fitness_plan_detail` VALUES (370, 28, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:04:09');
INSERT INTO `fitness_plan_detail` VALUES (371, 28, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:04:09');
INSERT INTO `fitness_plan_detail` VALUES (372, 28, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:04:09');
INSERT INTO `fitness_plan_detail` VALUES (373, 29, 1, '上午', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (374, 29, 1, '下午', 72, '项目名称2', '项目类型2', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (375, 29, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (376, 29, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (377, 29, 3, '上午', 73, '项目名称3', '项目类型3', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (378, 29, 3, '下午', 74, '项目名称4', '项目类型4', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (379, 29, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (380, 29, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (381, 29, 5, '上午', 75, '项目名称5', '项目类型5', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (382, 29, 5, '下午', 76, '项目名称6', '项目类型6', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (383, 29, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 3, 12, 60, '循序渐进，注意安全', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (384, 29, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (385, 29, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:06:32');
INSERT INTO `fitness_plan_detail` VALUES (386, 30, 1, '上午', 71, '项目名称1', '项目类型1', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (387, 30, 1, '下午', 72, '项目名称2', '项目类型2', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (388, 30, 1, '晚上', 73, '项目名称3', '项目类型3', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (389, 30, 2, '上午', 72, '项目名称2', '项目类型2', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (390, 30, 2, '下午', 73, '项目名称3', '项目类型3', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (391, 30, 2, '晚上', 74, '项目名称4', '项目类型4', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (392, 30, 3, '上午', 73, '项目名称3', '项目类型3', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (393, 30, 3, '下午', 74, '项目名称4', '项目类型4', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (394, 30, 3, '晚上', 75, '项目名称5', '项目类型5', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (395, 30, 4, '上午', 74, '项目名称4', '项目类型4', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (396, 30, 4, '下午', 75, '项目名称5', '项目类型5', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (397, 30, 4, '晚上', 76, '项目名称6', '项目类型6', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (398, 30, 5, '上午', 75, '项目名称5', '项目类型5', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (399, 30, 5, '下午', 76, '项目名称6', '项目类型6', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (400, 30, 5, '晚上', 71, '项目名称1', '项目类型1', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (401, 30, 6, '上午', 76, '项目名称6', '项目类型6', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (402, 30, 6, '下午', 71, '项目名称1', '项目类型1', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (403, 30, 6, '晚上', 72, '项目名称2', '项目类型2', 15, 4, 10, 45, '循序渐进，注意安全', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (404, 30, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-18 19:19:27');
INSERT INTO `fitness_plan_detail` VALUES (405, 31, 1, '上午', 71, '俯卧撑', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (406, 31, 1, '下午', 72, '坐姿划船', '增肌', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (407, 31, 1, '晚上', 73, '拉伸', '恢复', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (408, 31, 2, '上午', 72, '坐姿划船', '增肌', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (409, 31, 2, '下午', 73, '拉伸', '恢复', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (410, 31, 2, '晚上', 74, '动感单车', '减脂', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (411, 31, 3, '上午', 73, '拉伸', '恢复', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (412, 31, 3, '下午', 74, '动感单车', '减脂', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (413, 31, 3, '晚上', 75, '瑜伽', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (414, 31, 4, '上午', 74, '动感单车', '减脂', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (415, 31, 4, '下午', 75, '瑜伽', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (416, 31, 4, '晚上', 76, '滑冰', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (417, 31, 5, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (418, 31, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (419, 31, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-03-22 01:14:32');
INSERT INTO `fitness_plan_detail` VALUES (420, 32, 1, '上午', 71, '俯卧撑', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (421, 32, 1, '下午', 72, '坐姿划船', '增肌', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (422, 32, 1, '晚上', 73, '拉伸', '恢复', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (423, 32, 2, '上午', 72, '坐姿划船', '增肌', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (424, 32, 2, '下午', 73, '拉伸', '恢复', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (425, 32, 2, '晚上', 74, '动感单车', '减脂', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (426, 32, 3, '上午', 73, '拉伸', '恢复', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (427, 32, 3, '下午', 74, '动感单车', '减脂', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (428, 32, 3, '晚上', 75, '瑜伽', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (429, 32, 4, '上午', 74, '动感单车', '减脂', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (430, 32, 4, '下午', 75, '瑜伽', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (431, 32, 4, '晚上', 76, '滑冰', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (432, 32, 5, '上午', 75, '瑜伽', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (433, 32, 5, '下午', 76, '滑冰', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (434, 32, 5, '晚上', 71, '俯卧撑', '塑形', 15, 5, 8, 30, '循序渐进，注意安全', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (435, 32, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (436, 32, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-04-21 12:38:16');
INSERT INTO `fitness_plan_detail` VALUES (437, 33, 1, '上午', 71, '俯卧撑', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (438, 33, 1, '下午', 72, '坐姿划船', '增肌', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (439, 33, 1, '晚上', 73, '拉伸', '恢复', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (440, 33, 2, '上午', 72, '坐姿划船', '增肌', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (441, 33, 2, '下午', 73, '拉伸', '恢复', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (442, 33, 2, '晚上', 74, '动感单车', '减脂', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (443, 33, 3, '上午', 73, '拉伸', '恢复', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (444, 33, 3, '下午', 74, '动感单车', '减脂', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (445, 33, 3, '晚上', 75, '瑜伽', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (446, 33, 4, '上午', 74, '动感单车', '减脂', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (447, 33, 4, '下午', 75, '瑜伽', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (448, 33, 4, '晚上', 76, '滑冰', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (449, 33, 5, '上午', 75, '瑜伽', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (450, 33, 5, '下午', 76, '滑冰', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (451, 33, 5, '晚上', 71, '俯卧撑', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (452, 33, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (453, 33, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-04-22 10:20:05');
INSERT INTO `fitness_plan_detail` VALUES (454, 34, 1, '上午', 71, '俯卧撑', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (455, 34, 1, '下午', 72, '坐姿划船', '增肌', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (456, 34, 1, '晚上', 73, '拉伸', '恢复', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (457, 34, 2, '上午', 72, '坐姿划船', '增肌', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (458, 34, 2, '下午', 73, '拉伸', '恢复', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (459, 34, 2, '晚上', 74, '动感单车', '减脂', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (460, 34, 3, '上午', 73, '拉伸', '恢复', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (461, 34, 3, '下午', 74, '动感单车', '减脂', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (462, 34, 3, '晚上', 75, '瑜伽', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (463, 34, 4, '上午', 74, '动感单车', '减脂', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (464, 34, 4, '下午', 75, '瑜伽', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (465, 34, 4, '晚上', 76, '滑冰', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (466, 34, 5, '上午', 75, '瑜伽', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (467, 34, 5, '下午', 76, '滑冰', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (468, 34, 5, '晚上', 71, '俯卧撑', '塑形', 15, 4, 10, 45, '循序渐进，注意安全', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (469, 34, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (470, 34, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '建议：保持充足睡眠，注意饮食', '2026-04-28 15:03:47');
INSERT INTO `fitness_plan_detail` VALUES (471, 35, 1, '上午', NULL, '深蹲', '下肢力量', 45, 4, 15, 90, '保持背部挺直，膝盖不过脚尖', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (472, 35, 1, '下午', NULL, '卧推', '胸肌', 45, 4, 12, 90, '控制速度，避免借力', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (473, 35, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '全身拉伸，适当瑜伽放松', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (474, 35, 3, '上午', NULL, '硬拉', '背部力量', 45, 4, 12, 90, '保持腰背挺直，腿部发力', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (475, 35, 3, '下午', NULL, '引体向上', '背部肌肉', 45, 4, 10, 90, '保持身体稳定，不要摇晃', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (476, 35, 4, '上午', NULL, '哑铃弯举', '二头肌', 45, 4, 12, 90, '控制速度，避免摆动', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (477, 35, 4, '下午', NULL, '仰卧起坐', '腹部', 45, 4, 20, 90, '腹部发力，避免用颈', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (478, 35, 5, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '全身拉伸，适当瑜伽放松', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (479, 35, 6, '上午', NULL, '立式跳跃', '心肺功能', 45, 4, 15, 90, '保持平衡，不要过度用力', '2026-04-28 19:34:02');
INSERT INTO `fitness_plan_detail` VALUES (480, 35, 6, '下午', NULL, '俯卧撑', '胸肌', 45, 4, 15, 90, '保持身体稳定，不要塌腰', '2026-04-28 19:34:03');
INSERT INTO `fitness_plan_detail` VALUES (481, 35, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，保持良好的饮食和睡眠习惯', '2026-04-28 19:34:03');
INSERT INTO `fitness_plan_detail` VALUES (482, 36, 1, '上午', NULL, '深蹲', '力量训练', 30, 3, 12, 60, '保持背部挺直，膝盖不要超过脚尖', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (483, 36, 1, '上午', NULL, '俯卧撑', '力量训练', 30, 3, 12, 60, '保持核心紧绷，避免塌腰', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (484, 36, 2, '上午', NULL, '仰卧起坐', '有氧运动', 30, 3, 12, 60, '保持速度均匀，避免速度过快造成损伤', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (485, 36, 2, '上午', NULL, '跳绳', '有氧运动', 30, 3, 12, 60, '保持节奏，避免跳跃过高', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (486, 36, 3, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '进行轻松的拉伸运动，如瑜伽或散步', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (487, 36, 4, '上午', NULL, '哑铃卧推', '力量训练', 30, 3, 12, 60, '保持肘部靠近身体，避免手腕受伤', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (488, 36, 4, '上午', NULL, '俯身划船', '力量训练', 30, 3, 12, 60, '保持背部挺直，避免腰部用力', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (489, 36, 5, '上午', NULL, '跑步', '有氧运动', 30, 3, 12, 60, '保持均匀呼吸，避免过度劳累', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (490, 36, 5, '上午', NULL, '平板支撑', '核心训练', 30, 3, 12, 60, '保持身体成一条直线，避免塌腰', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (491, 36, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '进行轻松的拉伸运动，如瑜伽或散步', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (492, 36, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '完全休息，保证充足的睡眠', '2026-04-28 19:40:47');
INSERT INTO `fitness_plan_detail` VALUES (493, 37, 1, '上午', NULL, '深蹲', '力量训练', 45, 4, 10, 90, '保持背部挺直，控制下蹲速度', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (494, 37, 1, '上午', NULL, '卧推', '力量训练', 45, 4, 10, 90, '保持肘部靠近身体，控制推举速度', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (495, 37, 2, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，进行轻松的有氧运动如快走或慢跑', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (496, 37, 3, '上午', NULL, '硬拉', '力量训练', 45, 4, 10, 90, '保持背部挺直，控制硬拉速度', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (497, 37, 3, '上午', NULL, '引体向上', '力量训练', 45, 4, 10, 90, '尽量让身体完全悬挂，保持手臂伸直', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (498, 37, 4, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，进行轻松的有氧运动如快走或慢跑', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (499, 37, 5, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，进行轻松的有氧运动如快走或慢跑', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (500, 37, 6, '上午', NULL, '哑铃肩推', '力量训练', 45, 4, 10, 90, '保持背部挺直，控制肩推速度', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (501, 37, 6, '上午', NULL, '卧推三头肌', '力量训练', 45, 4, 10, 90, '保持肘部靠近身体，控制推举速度', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (502, 37, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，进行轻松的有氧运动如快走或慢跑', '2026-05-03 23:46:56');
INSERT INTO `fitness_plan_detail` VALUES (503, 38, 1, '上午', NULL, '深蹲', '力量训练', 45, 4, 10, 90, '保持背部挺直，膝盖不要超过脚尖', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (504, 38, 1, '上午', NULL, '卧推', '力量训练', 45, 4, 10, 90, '保持肘部紧贴身体，控制动作速度', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (505, 38, 2, '上午', NULL, '硬拉', '力量训练', 45, 4, 10, 90, '保持背部挺直，膝盖微弯', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (506, 38, 2, '上午', NULL, '引体向上', '力量训练', 45, 4, 10, 90, '保持身体稳定，控制下降速度', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (507, 38, 3, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，进行适当的有氧运动如快走或慢跑', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (508, 38, 4, '上午', NULL, '卧推', '力量训练', 45, 4, 10, 90, '保持肘部紧贴身体，控制动作速度', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (509, 38, 4, '上午', NULL, '哑铃划船', '力量训练', 45, 4, 10, 90, '保持背部挺直，手臂自然弯曲', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (510, 38, 5, '上午', NULL, '深蹲', '力量训练', 45, 4, 10, 90, '保持背部挺直，膝盖不要超过脚尖', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (511, 38, 5, '上午', NULL, '臂屈伸', '力量训练', 45, 4, 10, 90, '保持肘部紧贴身体，控制动作速度', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (512, 38, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，进行适当的有氧运动如快走或慢跑', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (513, 38, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '休息，进行适当的有氧运动如快走或慢跑', '2026-05-03 23:51:49');
INSERT INTO `fitness_plan_detail` VALUES (514, 39, 1, '上午', NULL, '深蹲', '力量训练', 45, 4, 10, 90, '保持背部挺直，膝盖不要超过脚尖', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (515, 39, 1, '上午', NULL, '卧推', '力量训练', 45, 4, 10, 90, '控制呼吸，避免使用身体其他部位的力量', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (516, 39, 2, '上午', NULL, '硬拉', '力量训练', 45, 4, 10, 90, '保持背部挺直，膝盖微弯', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (517, 39, 2, '上午', NULL, '引体向上', '力量训练', 45, 4, 10, 90, '手臂伸直，避免使用摆动', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (518, 39, 3, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '进行全身拉伸和有氧运动，如快走或慢跑', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (519, 39, 4, '上午', NULL, '哑铃肩推', '力量训练', 45, 4, 10, 90, '保持背部挺直，避免耸肩', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (520, 39, 4, '上午', NULL, '卧推三头肌', '力量训练', 45, 4, 10, 90, '控制手臂运动，避免身体晃动', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (521, 39, 5, '上午', NULL, '俯卧撑', '力量训练', 45, 4, 10, 90, '保持身体成一条直线', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (522, 39, 5, '上午', NULL, '腿举', '力量训练', 45, 4, 10, 90, '保持背部挺直，膝盖微弯', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (523, 39, 6, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '进行全身拉伸和有氧运动，如快走或慢跑', '2026-05-18 16:47:34');
INSERT INTO `fitness_plan_detail` VALUES (524, 39, 7, '全天', NULL, '休息', '休息', 0, 0, 0, NULL, '完全休息，进行轻松的拉伸和呼吸练习', '2026-05-18 16:47:34');

-- ----------------------------
-- Table structure for gym_location
-- ----------------------------
DROP TABLE IF EXISTS `gym_location`;
CREATE TABLE `gym_location`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gym_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '健身房名称',
  `address` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `lng` double NULL DEFAULT NULL COMMENT '经度',
  `lat` double NULL DEFAULT NULL COMMENT '纬度',
  `district` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所在区域',
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态（1-启用，0-禁用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '健身房位置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gym_location
-- ----------------------------
INSERT INTO `gym_location` VALUES (1, '2026-05-07 19:39:50', '健身中心（城关店）', '兰州市城关区东方红广场', 103.838, 36.061, '城关区', '0931-88888888', 1);
INSERT INTO `gym_location` VALUES (2, '2026-05-07 19:39:50', '健身中心（西固店）', '兰州市西固区西固城', 103.622, 36.086, '西固区', '0931-88888889', 1);
INSERT INTO `gym_location` VALUES (3, '2026-05-07 19:39:50', '健身中心（七里河店）', '兰州市七里河区西站', 103.735, 36.062, '七里河区', '0931-88888880', 1);
INSERT INTO `gym_location` VALUES (4, '2026-05-07 19:39:50', '健身中心（安宁店）', '兰州市安宁区培黎广场', 103.718, 36.113, '安宁区', '0931-88888881', 1);
INSERT INTO `gym_location` VALUES (5, '2026-05-07 19:39:50', '健身中心（红古店）', '兰州市红古区海石湾', 102.852, 36.343, '红古区', '0931-88888882', 1);
INSERT INTO `gym_location` VALUES (6, '2026-05-07 19:39:50', '健身中心（永登店）', '兰州市永登县城关镇', 103.255, 36.736, '永登县', '0931-88888883', 1);
INSERT INTO `gym_location` VALUES (7, '2026-05-07 19:39:50', '健身中心（榆中店）', '兰州市榆中县城关镇', 104.138, 35.844, '榆中县', '0931-88888884', 1);
INSERT INTO `gym_location` VALUES (8, '2026-05-07 19:39:50', '健身中心（皋兰店）', '兰州市皋兰县城关镇', 103.952, 36.032, '皋兰县', '0931-88888885', 1);

-- ----------------------------
-- Table structure for huiyuan
-- ----------------------------
DROP TABLE IF EXISTS `huiyuan`;
CREATE TABLE `huiyuan`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '会员账号',
  `mima` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `huiyuanxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `shenfenzheng` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `xingbie` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `touxiang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `shouji` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `huiyuanzhanghao`(`huiyuanzhanghao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1764302061110 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of huiyuan
-- ----------------------------
INSERT INTO `huiyuan` VALUES (11, '2021-05-12 00:06:49', '会员1', '123456', '小涵', '440300199101010001', '男', 'http://localhost:8080/springboot97s0t/upload/1775882236772.jpg', '13823888881');
INSERT INTO `huiyuan` VALUES (12, '2021-05-12 00:06:49', '会员2', '123456', '东东', '440300199202020002', '男', 'http://localhost:8080/springboot97s0t/upload/1776150831080.jpg', '13823888882');
INSERT INTO `huiyuan` VALUES (13, '2021-05-12 00:06:49', '会员3', '123456', '小美', '440300199303030003', '女', 'http://localhost:8080/springboot97s0t/upload/1776150843124.jpg', '13823888883');
INSERT INTO `huiyuan` VALUES (14, '2021-05-12 00:06:49', '会员4', '123456', '乐乐', '440300199404040004', '女', 'http://localhost:8080/springboot97s0t/upload/1776150871434.jpg', '13823888884');
INSERT INTO `huiyuan` VALUES (15, '2021-05-12 00:06:49', '会员5', '123456', '莉莉', '440300199505050005', '女', 'http://localhost:8080/springboot97s0t/upload/huiyuan_touxiang5.jpg', '13823888885');
INSERT INTO `huiyuan` VALUES (16, '2021-05-12 00:06:49', '会员6', '123456', '新唯', '440300199606060006', '男', 'http://localhost:8080/springboot97s0t/upload/huiyuan_touxiang6.jpg', '13823888886');

-- ----------------------------
-- Table structure for huiyuan_body_data
-- ----------------------------
DROP TABLE IF EXISTS `huiyuan_body_data`;
CREATE TABLE `huiyuan_body_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `huiyuan_id` bigint NULL DEFAULT NULL COMMENT '会员id',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员账号',
  `shengao` double NULL DEFAULT NULL COMMENT '身高(cm)',
  `tizhong` double NULL DEFAULT NULL COMMENT '体重(kg)',
  `bmi` double NULL DEFAULT NULL COMMENT 'BMI指数',
  `jianshenmubiao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健身目标(减脂/增肌/塑形/康复)',
  `jianshendengji` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健身等级(初级/中级/高级)',
  `meizhouxunliantian` int NULL DEFAULT NULL COMMENT '每周训练天数',
  `beizhu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '健康备注',
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员身体数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of huiyuan_body_data
-- ----------------------------
INSERT INTO `huiyuan_body_data` VALUES (1, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '初级', 3, NULL, '2026-03-18 18:29:26');
INSERT INTO `huiyuan_body_data` VALUES (2, 11, '会员1', 120, 40, 27.77777777777778, '塑形', '初级', 3, NULL, '2026-03-18 18:35:09');
INSERT INTO `huiyuan_body_data` VALUES (3, 11, '会员1', 120, 40, 27.77777777777778, '塑形', '初级', 3, '1', '2026-03-18 18:35:11');
INSERT INTO `huiyuan_body_data` VALUES (4, 11, '会员1', 120, 40, 27.77777777777778, '塑形', '初级', 3, '1', '2026-03-18 18:35:32');
INSERT INTO `huiyuan_body_data` VALUES (5, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '初级', 3, NULL, '2026-03-18 18:39:35');
INSERT INTO `huiyuan_body_data` VALUES (6, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '初级', 3, NULL, '2026-03-18 18:39:44');
INSERT INTO `huiyuan_body_data` VALUES (7, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '初级', 3, NULL, '2026-03-18 18:40:05');
INSERT INTO `huiyuan_body_data` VALUES (8, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '初级', 3, NULL, '2026-03-18 18:41:24');
INSERT INTO `huiyuan_body_data` VALUES (9, 11, '会员1', 190, 60, 16.62049861495845, '增肌', '初级', 3, NULL, '2026-03-18 18:41:36');
INSERT INTO `huiyuan_body_data` VALUES (10, 11, '会员1', 190, 60, 16.62049861495845, '增肌', '初级', 3, NULL, '2026-03-18 18:41:43');
INSERT INTO `huiyuan_body_data` VALUES (11, 11, '会员1', 190, 60, 16.62049861495845, '增肌', '初级', 3, NULL, '2026-03-18 18:41:48');
INSERT INTO `huiyuan_body_data` VALUES (12, 11, '会员1', 190, 60, 16.62049861495845, '增肌', '初级', 3, NULL, '2026-03-18 18:42:00');
INSERT INTO `huiyuan_body_data` VALUES (13, 11, '会员1', 190, 60, 16.62049861495845, '增肌', '初级', 3, NULL, '2026-03-18 18:42:46');
INSERT INTO `huiyuan_body_data` VALUES (14, 11, '会员1', 190, 60, 16.62049861495845, '增肌', '初级', 3, NULL, '2026-03-18 18:42:56');
INSERT INTO `huiyuan_body_data` VALUES (15, 11, '会员1', 180, 50, 15.432098765432098, '增肌', '初级', 3, NULL, '2026-03-18 18:43:53');
INSERT INTO `huiyuan_body_data` VALUES (16, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '初级', 3, NULL, '2026-03-18 18:45:30');
INSERT INTO `huiyuan_body_data` VALUES (17, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '初级', 3, NULL, '2026-03-18 18:45:51');
INSERT INTO `huiyuan_body_data` VALUES (18, 11, '会员1', 180, 75, 23.148148148148145, '增肌', '初级', 5, NULL, '2026-03-18 18:46:19');
INSERT INTO `huiyuan_body_data` VALUES (19, 11, '会员1', 180, 75, 23.148148148148145, '增肌', '初级', 5, NULL, '2026-03-18 18:46:36');
INSERT INTO `huiyuan_body_data` VALUES (20, 11, '会员1', 180, 66, 20.37037037037037, '增肌', '初级', 3, NULL, '2026-03-18 18:47:00');
INSERT INTO `huiyuan_body_data` VALUES (21, 11, '会员1', 150, 45, 20, '增肌', '中级', 3, NULL, '2026-03-18 18:49:44');
INSERT INTO `huiyuan_body_data` VALUES (22, 11, '会员1', 181, 50, 15.26204938799182, '增肌', '初级', 3, NULL, '2026-03-18 18:51:56');
INSERT INTO `huiyuan_body_data` VALUES (23, 11, '会员1', 181, 50, 15.26204938799182, '增肌', '初级', 3, NULL, '2026-03-18 18:52:45');
INSERT INTO `huiyuan_body_data` VALUES (24, 11, '会员1', 181, 50, 15.26204938799182, '增肌', '初级', 3, NULL, '2026-03-18 18:53:34');
INSERT INTO `huiyuan_body_data` VALUES (25, 11, '会员1', 180, 75, 23.148148148148145, '塑形', '初级', 3, NULL, '2026-03-18 18:55:29');
INSERT INTO `huiyuan_body_data` VALUES (26, 11, '会员1', 160, 40, 15.624999999999996, '增肌', '初级', 3, NULL, '2026-03-18 18:57:48');
INSERT INTO `huiyuan_body_data` VALUES (27, 11, '会员1', 165, 50, 18.36547291092746, '增肌', '初级', 3, NULL, '2026-03-18 19:01:11');
INSERT INTO `huiyuan_body_data` VALUES (28, 11, '会员1', 170, 60, 20.761245674740486, '塑形', '初级', 3, NULL, '2026-03-18 19:04:08');
INSERT INTO `huiyuan_body_data` VALUES (29, 11, '会员1', 170, 70, 24.221453287197235, '减脂', '初级', 3, NULL, '2026-03-18 19:06:32');
INSERT INTO `huiyuan_body_data` VALUES (30, 11, '会员1', 180, 60, 18.51851851851852, '塑形', '中级', 6, NULL, '2026-03-18 19:19:27');
INSERT INTO `huiyuan_body_data` VALUES (31, 11, '会员1', 180, 60, 18.51851851851852, '增肌', '高级', 4, NULL, '2026-03-22 01:14:31');
INSERT INTO `huiyuan_body_data` VALUES (32, 11, '会员1', 180, 70, 21.604938271604937, '增肌', '高级', 5, NULL, '2026-04-21 12:38:16');
INSERT INTO `huiyuan_body_data` VALUES (33, 11, '会员1', 180, 70, 21.604938271604937, '减脂', '中级', 5, NULL, '2026-04-22 10:20:05');
INSERT INTO `huiyuan_body_data` VALUES (34, 11, '会员1', 180, 70, 21.604938271604937, '增肌', '中级', 5, NULL, '2026-04-28 15:03:47');
INSERT INTO `huiyuan_body_data` VALUES (35, 11, '会员1', 180, 70, 21.604938271604937, '塑形', '中级', 4, NULL, '2026-04-28 19:33:36');
INSERT INTO `huiyuan_body_data` VALUES (36, 11, '会员1', 180, 90, 27.777777777777775, '减脂', '初级', 5, NULL, '2026-04-28 19:40:21');
INSERT INTO `huiyuan_body_data` VALUES (37, 11, '会员1', 167, 50, 17.92821542543655, '增肌', '中级', 4, NULL, '2026-05-03 23:46:18');
INSERT INTO `huiyuan_body_data` VALUES (38, 11, '会员1', 179, 66, 20.598608033457133, '增肌', '中级', 5, NULL, '2026-05-03 23:51:19');
INSERT INTO `huiyuan_body_data` VALUES (39, 11, '会员1', 180, 66, 20.37037037037037, '增肌', '中级', 5, NULL, '2026-05-18 16:46:50');

-- ----------------------------
-- Table structure for huiyuanka
-- ----------------------------
DROP TABLE IF EXISTS `huiyuanka`;
CREATE TABLE `huiyuanka`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `huiyuankabianhao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员卡编号',
  `huiyuankamingcheng` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员卡名称',
  `huiyuankaleixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员卡类型',
  `huiyuankajiage` int NOT NULL COMMENT '会员卡价格',
  `youxiaoshijian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有效时间',
  `xiaofeijine` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消费金额',
  `ticeqingkuang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体测情况',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员账号',
  `huiyuanxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `beizhu` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `sfsh` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '审核回复',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `huiyuankabianhao`(`huiyuankabianhao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1777359693882 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员卡' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of huiyuanka
-- ----------------------------
INSERT INTO `huiyuanka` VALUES (1774107065924, '2026-03-21 23:31:05', '1774107051400', '健身终身卡', '终身卡', 20000, '终身', NULL, '优秀', '会员1', '小涵', NULL, '通过', NULL);
INSERT INTO `huiyuanka` VALUES (1774107235302, '2026-03-21 23:33:55', '1774107214937', '游泳终身卡', '终身卡', 30000, '终身', NULL, '优秀', '会员1', '小涵', NULL, '通过', NULL);
INSERT INTO `huiyuanka` VALUES (1774107262256, '2026-03-21 23:34:21', '1774107252802', '游泳年卡', '年卡', 500, '一年', NULL, '优秀', '会员2', '东东', NULL, '通过', NULL);
INSERT INTO `huiyuanka` VALUES (1774107274883, '2026-03-21 23:34:34', '1774107265367', '健身年卡', '年卡', 1000, '一年', NULL, '优秀', '会员2', '东东', NULL, '通过', NULL);
INSERT INTO `huiyuanka` VALUES (1774107305727, '2026-03-21 23:35:05', '1774107287191', '健身年卡', '年卡', 1000, '一年', NULL, '良好', '会员3', '小美', NULL, '通过', NULL);
INSERT INTO `huiyuanka` VALUES (1774107452979, '2026-03-21 23:37:32', '1774107434484', '游泳季卡', '季卡', 600, '三个月', NULL, '较差', '会员4', '乐乐', NULL, '不通过', '体测不合格');
INSERT INTO `huiyuanka` VALUES (1776824158813, '2026-04-22 10:15:58', '1776824151286', '一日体验卡', '体验卡', 10, '一天', NULL, NULL, '会员1', '小涵', NULL, '通过', NULL);
INSERT INTO `huiyuanka` VALUES (1777194166022, '2026-04-26 17:02:45', '1777194163087', '一日体验卡', '体验卡', 10, '一天', NULL, NULL, '会员3', '小美', NULL, '待审核', NULL);
INSERT INTO `huiyuanka` VALUES (1777345116760, '2026-04-28 10:58:36', '1777345111791', '游泳年卡', '年卡', 500, '一年', NULL, NULL, '会员1', '小涵', NULL, '通过', NULL);
INSERT INTO `huiyuanka` VALUES (1777359693881, '2026-04-28 15:01:33', '1777359682290', '健身年卡', '年卡', 1000, '一年', NULL, NULL, '会员1', '小涵', NULL, '通过', NULL);

-- ----------------------------
-- Table structure for huiyuankaleixing
-- ----------------------------
DROP TABLE IF EXISTS `huiyuankaleixing`;
CREATE TABLE `huiyuankaleixing`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `huiyuankamingcheng` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员卡名称',
  `huiyuankatupian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员卡图片',
  `huiyuankaleixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员卡类型',
  `huiyuankagongneng` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '会员卡功能',
  `huiyuankajiage` int NULL DEFAULT NULL COMMENT '会员卡价格',
  `youxiaoshijian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有效时间',
  `riqi` date NULL DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1774106887985 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员卡类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of huiyuankaleixing
-- ----------------------------
INSERT INTO `huiyuankaleixing` VALUES (41, '2021-05-12 00:06:50', '健身终身卡', 'http://localhost:8080/springboot97s0t/upload/1776148851511.png', '终身卡', '可终身健身', 20000, '终身', '2026-03-21');
INSERT INTO `huiyuankaleixing` VALUES (42, '2021-05-12 00:06:50', '游泳年卡', 'http://localhost:8080/springboot97s0t/upload/1776148864357.png', '年卡', '可游泳一年', 500, '一年', '2026-03-21');
INSERT INTO `huiyuankaleixing` VALUES (43, '2021-05-12 00:06:50', '游泳终身卡', 'http://localhost:8080/springboot97s0t/upload/1776148886779.png', '终身卡', '可终身游泳', 30000, '终身', '2026-03-21');
INSERT INTO `huiyuankaleixing` VALUES (44, '2021-05-12 00:06:50', '健身季卡', 'http://localhost:8080/springboot97s0t/upload/1776148897504.png', '季卡', '可健身三个月', 300, '三个月', '2026-03-21');
INSERT INTO `huiyuankaleixing` VALUES (45, '2021-05-12 00:06:50', '健身年卡', 'http://localhost:8080/springboot97s0t/upload/1776148916760.png', '年卡', '可健身一年', 1000, '一年', '2026-03-21');
INSERT INTO `huiyuankaleixing` VALUES (46, '2021-05-12 00:06:50', '游泳季卡', 'http://localhost:8080/springboot97s0t/upload/1776148929217.png', '季卡', '可游泳三个月', 600, '三个月', '2021-05-12');
INSERT INTO `huiyuankaleixing` VALUES (1774106887984, '2026-03-21 23:28:07', '一日体验卡', 'http://localhost:8080/springboot97s0t/upload/1776148941898.png', '体验卡', '一日体验健身房', 10, '一天', '2026-03-21');

-- ----------------------------
-- Table structure for jianshenhuodong
-- ----------------------------
DROP TABLE IF EXISTS `jianshenhuodong`;
CREATE TABLE `jianshenhuodong`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `bianhao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `jianshenshizhang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '健身时长',
  `jianshenxiangmu` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '健身项目',
  `jianshenqicai` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '健身器材',
  `shijian` date NULL DEFAULT NULL COMMENT '时间',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员账号',
  `huiyuanxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员姓名',
  `shouji` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `tizhong` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体重',
  `xinlv` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '心率',
  `beizhu` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `bianhao`(`bianhao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1777359649740 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '健身活动' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jianshenhuodong
-- ----------------------------
INSERT INTO `jianshenhuodong` VALUES (1773804502925, '2026-03-18 11:28:22', 'JS1773804502877', '1小时', '跑步', '跑步机', '2026-03-18', '会员1', '小涵', '13823888881', '70kg', '80次/分', '这次跑步很开心');
INSERT INTO `jianshenhuodong` VALUES (1774276974412, '2026-03-23 22:42:53', 'JS1774276973721', '1h', '拉伸', '瑜伽垫', '2026-03-23', '会员2', '东东', '13823888882', '70', '75', '这次拉伸很舒服');
INSERT INTO `jianshenhuodong` VALUES (1774277022918, '2026-03-23 22:43:42', 'JS1774277022730', '3h', '滑冰', '滑冰鞋', '2026-03-26', '会员3', '小美', '13823888883', '55', '90', '滑冰很开心');
INSERT INTO `jianshenhuodong` VALUES (1774277057311, '2026-03-23 22:44:17', 'JS1774277057270', '1h', '跑步', '跑步机', '2026-03-06', '会员3', '小美', '13823888883', '55', '105', '跑步出了很多汗，很舒服');
INSERT INTO `jianshenhuodong` VALUES (1774277105067, '2026-03-23 22:45:04', 'JS1774277104436', '2h', '瑜伽', '瑜伽垫', '2026-03-28', '会员5', '莉莉', '13823888885', '60', '70', '瑜伽很累但是很开心');
INSERT INTO `jianshenhuodong` VALUES (1776826175312, '2026-04-22 10:49:35', 'JS1776826175249', '3', '跑步', '跑步机', '2026-04-08', '会员1', '小涵', '13823888881', '68', '80', NULL);
INSERT INTO `jianshenhuodong` VALUES (1777355982996, '2026-04-28 13:59:42', 'JS1777355982186', '1', '卧推', '杠铃', '2026-04-28', '会员1', '小涵', '13823888881', '70kg', '80', '这次健身很开心');
INSERT INTO `jianshenhuodong` VALUES (1777359649739, '2026-04-28 15:00:49', 'JS1777359649618', '1', '卧推', '杠铃', '2026-04-28', '会员1', '小涵', '13823888881', '70kg', '80', NULL);

-- ----------------------------
-- Table structure for jianshenhuodong_comment
-- ----------------------------
DROP TABLE IF EXISTS `jianshenhuodong_comment`;
CREATE TABLE `jianshenhuodong_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `jianshenhuodong_id` bigint NULL DEFAULT NULL COMMENT '健身活动',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论人',
  `huiyuanxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论人姓名',
  `pinglunneirong` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '评论内容',
  `pinglunshijian` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1777359667289 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '健身活动评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jianshenhuodong_comment
-- ----------------------------
INSERT INTO `jianshenhuodong_comment` VALUES (1773804730921, 104, '会员1', '会员姓名1', '你好', '2026-03-18 11:32:11', '2026-03-18 11:32:10');
INSERT INTO `jianshenhuodong_comment` VALUES (1773804770335, 104, '会员4', '会员姓名4', '你好，你是会员1吗', '2026-03-18 11:32:50', '2026-03-18 11:32:50');
INSERT INTO `jianshenhuodong_comment` VALUES (1773804788711, 1773804502925, '会员4', '会员姓名4', '下次要不要一起跑步？', '2026-03-18 11:33:09', '2026-03-18 11:33:08');
INSERT INTO `jianshenhuodong_comment` VALUES (1774276864293, 1773804502925, '会员2', '东东', '可以加我一个吗', '2026-03-23 22:41:04', '2026-03-23 22:41:04');
INSERT INTO `jianshenhuodong_comment` VALUES (1774277167923, 1774276974412, '会员1', '小涵', '加油你很棒', '2026-03-23 22:46:07', '2026-03-23 22:46:07');
INSERT INTO `jianshenhuodong_comment` VALUES (1774277191218, 1774277022918, '会员1', '小涵', '我想和你一起滑冰下次', '2026-03-23 22:46:30', '2026-03-23 22:46:30');
INSERT INTO `jianshenhuodong_comment` VALUES (1774277204241, 1774277057311, '会员1', '小涵', '下次可以一起跑步', '2026-03-23 22:46:44', '2026-03-23 22:46:44');
INSERT INTO `jianshenhuodong_comment` VALUES (1774277225404, 1774276974412, '会员2', '东东', '加油！！！', '2026-03-23 22:47:05', '2026-03-23 22:47:04');
INSERT INTO `jianshenhuodong_comment` VALUES (1774277248600, 1774277105067, '会员2', '东东', '我也想学瑜伽，可以加个联系方式一起吗', '2026-03-23 22:47:29', '2026-03-23 22:47:28');
INSERT INTO `jianshenhuodong_comment` VALUES (1777195909162, 1773804502925, '会员1', '小涵', '不错', '2026-04-26 17:31:49', '2026-04-26 17:31:48');
INSERT INTO `jianshenhuodong_comment` VALUES (1777356000559, 1777355982996, '会员1', '小涵', '你好', '2026-04-28 14:00:00', '2026-04-28 14:00:00');
INSERT INTO `jianshenhuodong_comment` VALUES (1777359667288, 1773804502925, '会员1', '小涵', 'nihao', '2026-04-28 15:01:07', '2026-04-28 15:01:06');

-- ----------------------------
-- Table structure for jianshenqicai
-- ----------------------------
DROP TABLE IF EXISTS `jianshenqicai`;
CREATE TABLE `jianshenqicai`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `qicaibianhao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材编号',
  `qicaimingcheng` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材名称',
  `qicaitupian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材图片',
  `qicaileixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '器材类型',
  `pinpai` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品牌',
  `shiyongfangfa` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '使用方法',
  `shoushenxiaoguo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '瘦身效果',
  `qicaijieshao` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '器材介绍',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `qicaibianhao`(`qicaibianhao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '健身器材' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jianshenqicai
-- ----------------------------
INSERT INTO `jianshenqicai` VALUES (91, '2021-05-12 00:06:50', '器材编号1', '哑铃', 'http://localhost:8080/springboot97s0t/upload/1776149002430.png', '哑铃', '力健Life Fitness', '哑铃可练胸肩背臂腿，站姿坐姿平举、弯举，便携通用，居家力量训练首选。', '可增肌', '哑铃是基础力量器材，可练全身肌群，分固定、可调节，适合居家与健身房训练。');
INSERT INTO `jianshenqicai` VALUES (92, '2021-05-12 00:06:50', '器材编号2', '跑步机', 'http://localhost:8080/springboot97s0t/upload/1776149023818.png', '有氧健身器材', '伊力克Eleiko', '先热身，缓慢启动，站稳扶把手，逐步调速，结束慢走再停机，注意安全。', '可瘦身', '跑步机是室内有氧器材，可调节速度坡度，锻炼心肺、燃脂瘦身，居家健身常用。');
INSERT INTO `jianshenqicai` VALUES (93, '2021-05-12 00:06:50', '器材编号3', '蛋白粉', 'http://localhost:8080/springboot97s0t/upload/jianshenqicai_qicaitupian3.jpg', '营养品', '赛霸', '训练后 30 分钟内，取一勺蛋白粉加温水或牛奶摇匀饮用，每日 1–2 次。', '可增肌', '蛋白粉是健身营养补剂，富含优质蛋白，助力肌肉修复增长，适合运动人群补充营养。');
INSERT INTO `jianshenqicai` VALUES (94, '2021-05-12 00:06:50', '器材编号4', '动感单车', 'http://localhost:8080/springboot97s0t/upload/1776149046196.png', '有氧健身器材', '麦瑞克Merach', '调节车座与把手高度，双脚固定，匀速踩踏，配合节奏骑行，锻炼心肺与下肢。', '可瘦身', '动感单车是室内有氧器材，模拟骑行，燃脂塑形，强心肺，适合健身房与家庭训练。');
INSERT INTO `jianshenqicai` VALUES (95, '2021-05-12 00:06:50', '器材编号5', '瑜伽垫', 'http://localhost:8080/springboot97s0t/upload/jianshenqicai_qicaitupian5.jpg', '辅助工具', '迪卡侬', '瑜伽垫铺于平地，防滑减震，用于瑜伽、拉伸，保护关节，运动更舒适安全。', '可瘦身', '瑜伽垫防滑减震、柔软护膝，适合瑜伽、健身拉伸，居家运动必备。');
INSERT INTO `jianshenqicai` VALUES (96, '2021-05-12 00:06:50', '器材编号6', '溜冰鞋', 'http://localhost:8080/springboot97s0t/upload/1776149068648.png', '鞋类', '迪卡侬', '穿好护具，双脚呈外八字站稳，缓慢滑行，弯腰屈膝，保持平衡，避免急停急转弯。', '可瘦身', '溜冰鞋分速滑、花样、冰球款，贴合脚部，滑行顺畅，适合冰上运动与休闲健身。');

-- ----------------------------
-- Table structure for jianshenxiangmu
-- ----------------------------
DROP TABLE IF EXISTS `jianshenxiangmu`;
CREATE TABLE `jianshenxiangmu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xiangmubianhao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目编号',
  `xiangmumingcheng` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `xiangmufengmian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目封面',
  `xiangmuleixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目类型',
  `xiangmujiage` int NULL DEFAULT NULL COMMENT '项目价格',
  `shoufeibiaozhun` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '收费标准',
  `keshishu` int NULL DEFAULT NULL COMMENT '课时数',
  `xiangmushipin` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目视频',
  `xiangqing` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '详情',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `xiangmubianhao`(`xiangmubianhao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '健身项目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jianshenxiangmu
-- ----------------------------
INSERT INTO `jianshenxiangmu` VALUES (71, '2021-05-12 00:06:50', '项目编号1', '俯卧撑', 'http://localhost:8080/springboot97s0t/upload/jianshenxiangmu_xiangmufengmian1.jpg', '塑形', 150, '150元/年', 30, '1.mp4', '<p>详情1</p>');
INSERT INTO `jianshenxiangmu` VALUES (72, '2021-05-12 00:06:50', '项目编号2', '坐姿划船', 'http://localhost:8080/springboot97s0t/upload/jianshenxiangmu_xiangmufengmian2.jpg', '增肌', 200, '收费标准2', 20, '2.mp4', '<p>详情2</p>');
INSERT INTO `jianshenxiangmu` VALUES (73, '2021-05-12 00:06:50', '项目编号3', '拉伸', 'http://localhost:8080/springboot97s0t/upload/jianshenxiangmu_xiangmufengmian3.jpg', '恢复', 30, '收费标准3', 10, '3.mp4', '<p>详情3</p>');
INSERT INTO `jianshenxiangmu` VALUES (74, '2021-05-12 00:06:50', '项目编号4', '动感单车', 'http://localhost:8080/springboot97s0t/upload/jianshenxiangmu_xiangmufengmian4.jpg', '减脂', 400, '收费标准4', 40, '4.mp4', '<p>详情4</p>');
INSERT INTO `jianshenxiangmu` VALUES (75, '2021-05-12 00:06:50', '项目编号5', '瑜伽', 'http://localhost:8080/springboot97s0t/upload/jianshenxiangmu_xiangmufengmian5.jpg', '塑形', 500, '收费标准5', 50, '5.mp4', '<p>详情5</p>');
INSERT INTO `jianshenxiangmu` VALUES (76, '2021-05-12 00:06:50', '项目编号6', '滑冰', 'http://localhost:8080/springboot97s0t/upload/jianshenxiangmu_xiangmufengmian6.jpg', '塑形', 600, '收费标准6', 20, '6.mp4', '<p>详情6</p>');

-- ----------------------------
-- Table structure for jiaolianxinxi
-- ----------------------------
DROP TABLE IF EXISTS `jiaolianxinxi`;
CREATE TABLE `jiaolianxinxi`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gonghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `yuangongxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `xingbie` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `shengao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身高',
  `tizhong` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体重',
  `shoujihao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `jiaolianleixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教练类型',
  `jiaolianjiage` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教练价格',
  `shangkeshijian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上课时间',
  `gongzuolvli` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '工作履历',
  `gerenjianjie` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '个人简介',
  `tupian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1779093064397 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '教练信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jiaolianxinxi
-- ----------------------------
INSERT INTO `jiaolianxinxi` VALUES (1774275784520, '2026-03-23 22:23:04', '员工1', '杰森', '男', '185', '75', '13823888881', '私人教练', '300', '一个月', NULL, NULL, 'http://localhost:8080/springboot97s0t/upload/1776153316420.jpg');
INSERT INTO `jiaolianxinxi` VALUES (1774275858193, '2026-03-23 22:24:17', '员工2', 'melody', '女', '178', '55', '13823888882', '私人教练', '500', '一个月', NULL, NULL, 'http://localhost:8080/springboot97s0t/upload/1776153325722.jpeg');
INSERT INTO `jiaolianxinxi` VALUES (1774275878813, '2026-03-23 22:24:38', '员工3', '航航', '男', '191', '82', '13823888883', '团课教练', '500', '一个月', NULL, NULL, 'http://localhost:8080/springboot97s0t/upload/1776153341829.jpg');
INSERT INTO `jiaolianxinxi` VALUES (1774275890098, '2026-03-23 22:24:49', '员工4', '涵哥', '男', '190', '80', '13823888884', '私人教练', '600', '一个月', NULL, NULL, 'http://localhost:8080/springboot97s0t/upload/1776153357950.jpeg');
INSERT INTO `jiaolianxinxi` VALUES (1774275904596, '2026-03-23 22:25:04', '员工6', '阿伟', '男', '183', '95', '13823888886', '团课教练', '350', '一个月', NULL, NULL, 'http://localhost:8080/springboot97s0t/upload/1776153369214.jpg');
INSERT INTO `jiaolianxinxi` VALUES (1774276638162, '2026-03-23 22:37:17', '员工5', '丽丽', '女', '176', '60', '1382388888', '团课教练', '400', '一个月', NULL, NULL, 'http://localhost:8080/springboot97s0t/upload/1776153391664.jpg');

-- ----------------------------
-- Table structure for jiepin
-- ----------------------------
DROP TABLE IF EXISTS `jiepin`;
CREATE TABLE `jiepin`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `jiepinbianhao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '解聘编号',
  `gonghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `yuangongxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `jiaolianleixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教练类型',
  `jiaolianjiage` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教练价格',
  `jiepinyuanyin` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解聘原因',
  `jiepinshijian` date NULL DEFAULT NULL COMMENT '解聘时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `jiepinbianhao`(`jiepinbianhao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1774276517015 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '解聘' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jiepin
-- ----------------------------
INSERT INTO `jiepin` VALUES (1774276372894, '2026-03-23 22:32:52', '1774276371302', '员工5', '丽丽', '私人教练', '450', NULL, '2026-03-23');
INSERT INTO `jiepin` VALUES (1774276383011, '2026-03-23 22:33:02', '1774276376416', '员工6', '阿伟', '团课教练', '350', '工作不努力', '2026-04-10');
INSERT INTO `jiepin` VALUES (1774276517014, '2026-03-23 22:35:16', '1774276502681', '员工2', 'melody', '私人教练', '500', '与会员起冲突', '2026-03-10');

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `tablename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (1, 1, 'admin', 'users', '管理员', 'thmpx00a0729e3f3brcoatq04dolzzpb', '2024-04-06 16:28:45', '2026-05-18 17:36:34');
INSERT INTO `token` VALUES (2, 11, '会员1', 'huiyuan', '会员', 'mtqyk9ak86e0v8iyja8efkj05dgxemcl', '2024-04-06 16:32:32', '2026-05-18 17:45:18');
INSERT INTO `token` VALUES (3, 21, '员工1', 'yuangong', '员工', 'l1vpxdis6pn8qbyuz30cxq6lcijgpfqj', '2024-04-06 16:32:47', '2026-05-18 17:44:29');
INSERT INTO `token` VALUES (4, 1764302061109, '会员99', 'huiyuan', '会员', 'mao97ged5nzn0rkwatrgf66wfvo8407z', '2025-11-28 11:54:31', '2025-11-28 12:54:31');
INSERT INTO `token` VALUES (5, 14, '会员4', 'huiyuan', '会员', 'b8n59fdguqwomk2ky7ale93pq9umkl2a', '2026-03-18 11:32:24', '2026-03-23 23:14:46');
INSERT INTO `token` VALUES (6, 12, '会员2', 'huiyuan', '会员', '040s41bm9sjugerbzax7845vgayuze99', '2026-03-18 13:16:41', '2026-04-26 18:40:57');
INSERT INTO `token` VALUES (7, 13, '会员3', 'huiyuan', '会员', 'ppz3xcqejlslhmf0i3rgtim1100m0x7v', '2026-03-18 13:45:23', '2026-04-26 18:02:38');
INSERT INTO `token` VALUES (8, 1774108354848, '员工7', 'yuangong', '员工', '9efewv88npjm64p52stdo1s928soghfh', '2026-03-21 23:52:52', '2026-03-22 00:52:52');
INSERT INTO `token` VALUES (9, 15, '会员5', 'huiyuan', '会员', '7229mg2ttes6nsopua9vot848clajzxv', '2026-03-23 22:07:13', '2026-03-23 23:44:25');
INSERT INTO `token` VALUES (10, 22, '员工2', 'yuangong', '员工', '82fp74nz4rlpvvioyek06t2r2f6g0p7i', '2026-03-23 22:08:22', '2026-04-02 17:27:24');
INSERT INTO `token` VALUES (11, 23, '员工3', 'yuangong', '员工', 'z0jq7n8ndsecki8zxv5k7qmqbxt0ebo2', '2026-03-23 22:08:41', '2026-03-23 23:08:41');
INSERT INTO `token` VALUES (12, 24, '员工4', 'yuangong', '员工', 'b0swh4cu67dc5iu1fifzaffbpfjarude', '2026-03-23 22:09:08', '2026-03-23 23:09:08');
INSERT INTO `token` VALUES (13, 25, '员工5', 'yuangong', '员工', '4onct7zcnb6fn6a0o8sjjwscs7xlmibq', '2026-03-23 22:09:30', '2026-03-23 23:09:31');
INSERT INTO `token` VALUES (14, 26, '员工6', 'yuangong', '员工', 'ezd9n4z9nentsi8ksvnrwkc731srgs3a', '2026-03-23 22:09:56', '2026-03-23 23:09:57');
INSERT INTO `token` VALUES (15, 16, '会员6', 'huiyuan', '会员', 'bx0qr5zgk358bd5bnsmryckchyp55b2n', '2026-03-23 22:16:54', '2026-03-23 23:16:54');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', '管理员', '2021-05-12 00:06:50');

-- ----------------------------
-- Table structure for xindefu
-- ----------------------------
DROP TABLE IF EXISTS `xindefu`;
CREATE TABLE `xindefu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `fenlei` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类',
  `fengmian` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片',
  `fabuzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布人账号',
  `fabuxingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布人姓名',
  `fabushijian` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `thumbsupnum` int NULL DEFAULT 0 COMMENT '点赞数',
  `clicknum` int NULL DEFAULT 0 COMMENT '浏览量',
  `collectnum` int NULL DEFAULT 0 COMMENT '收藏数',
  `commentnum` int NULL DEFAULT 0 COMMENT '评论数',
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1777196529136 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健身心得分享' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xindefu
-- ----------------------------
INSERT INTO `xindefu` VALUES (1773810830908, '卧推心得', '卧推要用胸发力', '增肌', 'http://localhost:8080/springboot97s0t/upload/1776151008807.png', NULL, NULL, '2026-03-18 13:13:51', 0, 13, 2, 0, '2026-03-18 13:13:50');
INSERT INTO `xindefu` VALUES (1773811178281, '减脂餐一周计划', '早：鸡蛋 / 玉米 / 无糖豆浆；午：鸡胸肉 + 杂粮饭 + 青菜；晚：鱼虾 / 豆腐 + 蔬菜，少油少盐', '减脂', 'http://localhost:8080/springboot97s0t/upload/1776151163001.png', NULL, NULL, '2026-03-18 13:19:38', 0, 15, 2, 0, '2026-03-18 13:19:37');
INSERT INTO `xindefu` VALUES (1773811824575, '瑜伽心得', '瑜伽让我静心舒展，舒缓压力，感受身心合一，坚持自律，温柔且坚定，遇见更好的自己。', '塑形', 'http://localhost:8080/springboot97s0t/upload/1776151113203.png', '会员1', '会员姓名1', '2026-03-18 13:30:24', 0, 15, 1, 0, '2026-03-18 13:30:23');
INSERT INTO `xindefu` VALUES (1773812360593, '哑铃使用', '哑铃可以练到上身部位', '器材使用', 'http://localhost:8080/springboot97s0t/upload/1776150939058.png', '会员2', '会员姓名2', '2026-03-18 13:39:20', 1, 12, 0, 0, '2026-03-18 13:39:19');
INSERT INTO `xindefu` VALUES (1773812743075, '训练后营养补充', '训练后 30 分钟补蛋白 + 碳水，鸡蛋、牛奶、鸡胸肉搭配粗粮，助力恢复增肌。', '营养恢复', 'http://localhost:8080/springboot97s0t/upload/1776150921642.png', '会员3', '会员姓名3', '2026-03-18 13:45:43', 1, 29, 1, 0, '2026-03-18 13:45:43');
INSERT INTO `xindefu` VALUES (1773817459822, '跳绳训练计划', '每日跳绳 5 组，每组 1 分钟，间歇 30 秒，循序渐进加时长，配合拉伸控饮食。', '减脂', 'http://localhost:8080/springboot97s0t/upload/1776150901776.png', '会员1', '会员姓名1', '2026-03-18 15:04:19', 2, 63, 1, 0, '2026-03-18 15:04:18');
INSERT INTO `xindefu` VALUES (1773822439504, '管理员', '公告：注意维护社区安全', '其他', 'http://localhost:8080/springboot97s0t/upload/1776151909683.png', NULL, NULL, '2026-03-18 16:27:19', 1, 55, 3, 0, '2026-03-18 16:27:19');

-- ----------------------------
-- Table structure for xindefu_collect
-- ----------------------------
DROP TABLE IF EXISTS `xindefu_collect`;
CREATE TABLE `xindefu_collect`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xindefu_id` bigint NOT NULL COMMENT '健身心得ID',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '会员账号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_collect`(`xindefu_id` ASC, `huiyuanzhanghao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '健身心得收藏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xindefu_collect
-- ----------------------------
INSERT INTO `xindefu_collect` VALUES (2, '2026-04-02 15:21:34', 1775114476427, '会员1');
INSERT INTO `xindefu_collect` VALUES (3, '2026-04-21 22:37:52', 1773812743075, 'admin');
INSERT INTO `xindefu_collect` VALUES (27, '2026-04-24 23:41:18', 1773822439504, 'admin');
INSERT INTO `xindefu_collect` VALUES (28, '2026-04-24 23:45:40', 1773817459822, 'admin');
INSERT INTO `xindefu_collect` VALUES (30, '2026-04-26 17:39:34', 1773811824575, '会员1');
INSERT INTO `xindefu_collect` VALUES (31, '2026-04-26 17:39:44', 1773822439504, '会员1');
INSERT INTO `xindefu_collect` VALUES (35, '2026-04-26 17:39:47', 1773810830908, '会员1');
INSERT INTO `xindefu_collect` VALUES (36, '2026-04-26 17:39:48', 1773811178281, '会员1');
INSERT INTO `xindefu_collect` VALUES (37, '2026-04-26 17:40:10', 1773810830908, 'admin');
INSERT INTO `xindefu_collect` VALUES (38, '2026-04-26 17:41:04', 1773822439504, '会员2');
INSERT INTO `xindefu_collect` VALUES (39, '2026-04-26 17:41:05', 1773817459822, '会员2');
INSERT INTO `xindefu_collect` VALUES (40, '2026-04-26 17:41:08', 1773811178281, '会员2');
INSERT INTO `xindefu_collect` VALUES (41, '2026-04-28 14:35:09', 1773812743075, '会员1');

-- ----------------------------
-- Table structure for xindefu_comment
-- ----------------------------
DROP TABLE IF EXISTS `xindefu_comment`;
CREATE TABLE `xindefu_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `xindefu_id` bigint NULL DEFAULT NULL COMMENT '健身心得',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论人账号',
  `huiyuanxingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论人姓名',
  `pinglunneirong` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评论内容',
  `pinglunshijian` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1776782829061 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健身心得评论' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xindefu_comment
-- ----------------------------
INSERT INTO `xindefu_comment` VALUES (1773813915511, 1773810830908, '会员1', '会员姓名1', '你的卧推心得对我很有用，谢谢！\n', '2026-03-18 14:05:15', '2026-03-18 14:05:15');
INSERT INTO `xindefu_comment` VALUES (1774190171902, 1773822439504, '会员1', '会员姓名1', '好的管理员', '2026-03-22 22:36:11', '2026-03-22 22:36:10');
INSERT INTO `xindefu_comment` VALUES (1776782829060, 1773817459822, '会员1', '小涵', '你的跳绳计划不错', '2026-04-21 22:47:09', '2026-04-21 22:47:08');

-- ----------------------------
-- Table structure for xindefu_thumbsup
-- ----------------------------
DROP TABLE IF EXISTS `xindefu_thumbsup`;
CREATE TABLE `xindefu_thumbsup`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `xindefu_id` bigint NULL DEFAULT NULL COMMENT '健身心得',
  `huiyuanzhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户账号',
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_xindefu_huiyuan`(`xindefu_id` ASC, `huiyuanzhanghao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1777356151523 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健身心得点赞' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xindefu_thumbsup
-- ----------------------------
INSERT INTO `xindefu_thumbsup` VALUES (1777045268921, 1773812743075, 'admin', '2026-04-24 23:41:08');
INSERT INTO `xindefu_thumbsup` VALUES (1777348745589, 1773812360593, 'admin', '2026-04-28 11:59:05');
INSERT INTO `xindefu_thumbsup` VALUES (1777348749161, 1773817459822, 'admin', '2026-04-28 11:59:09');
INSERT INTO `xindefu_thumbsup` VALUES (1777348754170, 1773822439504, 'admin', '2026-04-28 11:59:14');
INSERT INTO `xindefu_thumbsup` VALUES (1777356151522, 1773817459822, '会员1', '2026-04-28 14:02:31');

-- ----------------------------
-- Table structure for yuangong
-- ----------------------------
DROP TABLE IF EXISTS `yuangong`;
CREATE TABLE `yuangong`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gonghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工号',
  `mima` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `yuangongxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工姓名',
  `xingbie` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `touxiang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `shouji` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `youxiang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `jiaolianzizhi` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '教练资质文件',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `gonghao`(`gonghao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1774108484229 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of yuangong
-- ----------------------------
INSERT INTO `yuangong` VALUES (21, '2021-05-12 00:06:49', '员工1', '123456', '杰森', '男', 'http://localhost:8080/springboot97s0t/upload/1776149460584.jpg', '13823888881', '773890001@qq.com', 'http://localhost:8080/springboot97s0t/upload/1776746600313.png');
INSERT INTO `yuangong` VALUES (22, '2021-05-12 00:06:49', '员工2', '123456', 'melody', '女', 'http://localhost:8080/springboot97s0t/upload/1776149473065.jpeg', '13823888882', '773890002@qq.com', NULL);
INSERT INTO `yuangong` VALUES (23, '2021-05-12 00:06:50', '员工3', '123456', '航航', '男', 'http://localhost:8080/springboot97s0t/upload/1776149483411.jpg', '13823888883', '773890003@qq.com', NULL);
INSERT INTO `yuangong` VALUES (24, '2021-05-12 00:06:50', '员工4', '123456', '涵哥', '男', 'http://localhost:8080/springboot97s0t/upload/1776149495113.jpeg', '13823888884', '773890004@qq.com', NULL);
INSERT INTO `yuangong` VALUES (25, '2021-05-12 00:06:50', '员工5', '123456', '丽丽', '女', 'http://localhost:8080/springboot97s0t/upload/1776149515691.jpg', '13823888885', '773890005@qq.com', NULL);
INSERT INTO `yuangong` VALUES (26, '2021-05-12 00:06:50', '员工6', '123456', '阿伟', '男', 'http://localhost:8080/springboot97s0t/upload/1776149525581.jpg', '13823888886', '773890006@qq.com', NULL);
INSERT INTO `yuangong` VALUES (1774108354848, '2026-03-21 23:52:34', '员工7', '123456', '保洁阿姨', '女', 'http://localhost:8080/springboot97s0t/upload/1776149307824.png', '12312312312', '1231231231@qq.com', NULL);
INSERT INTO `yuangong` VALUES (1774108484228, '2026-03-21 23:54:44', '员工8', '123456', '前台员工', '女', 'http://localhost:8080/springboot97s0t/upload/1776149391970.png', '19876483957', '19876483957@163.com', NULL);

-- ----------------------------
-- Table structure for zhidaoxiangmu
-- ----------------------------
DROP TABLE IF EXISTS `zhidaoxiangmu`;
CREATE TABLE `zhidaoxiangmu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xiangmubianhao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目编号',
  `xiangmumingcheng` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `xiangmuleixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目类型',
  `xiangmujiage` int NULL DEFAULT NULL COMMENT '项目价格',
  `shoufeibiaozhun` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '收费标准',
  `keshishu` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '课时数',
  `zhidaoxiangmu` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '指导项目',
  `zhidaojiaolian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指导教练',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1777346677747 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '指导项目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of zhidaoxiangmu
-- ----------------------------
INSERT INTO `zhidaoxiangmu` VALUES (1774104968817, '2026-03-21 22:56:08', '项目编号1', '俯卧撑', '塑形', 150, '150元/年', '30', NULL, '杰森');
INSERT INTO `zhidaoxiangmu` VALUES (1774104973859, '2026-03-21 22:56:13', '项目编号2', '坐姿划船', '增肌', 200, '收费标准2', '20', NULL, 'melody');
INSERT INTO `zhidaoxiangmu` VALUES (1774104978541, '2026-03-21 22:56:18', '项目编号3', '拉伸', '恢复', 30, '收费标准3', '10', NULL, '航航');
INSERT INTO `zhidaoxiangmu` VALUES (1774104982710, '2026-03-21 22:56:22', '项目编号4', '动感单车', '减脂', 400, '收费标准4', '40', NULL, '涵哥');
INSERT INTO `zhidaoxiangmu` VALUES (1774104988612, '2026-03-21 22:56:27', '项目编号5', '瑜伽', '塑形', 500, '收费标准5', '50', NULL, '丽丽');
INSERT INTO `zhidaoxiangmu` VALUES (1774104993189, '2026-03-21 22:56:32', '项目编号6', '滑冰', '塑形', 600, '收费标准6', '20', NULL, '阿伟');
INSERT INTO `zhidaoxiangmu` VALUES (1774108592035, '2026-03-21 23:56:31', '项目编号1', '俯卧撑', '塑形', 150, '150元/年', '30', NULL, 'melody');
INSERT INTO `zhidaoxiangmu` VALUES (1777346677746, '2026-04-28 11:24:37', '项目编号5', '瑜伽', '塑形', 500, '收费标准5', '50', NULL, '丽丽');

SET FOREIGN_KEY_CHECKS = 1;
