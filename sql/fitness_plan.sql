-- ----------------------------
-- 智能健身计划生成功能表
-- ----------------------------

-- ----------------------------
-- 会员身体数据表
-- ----------------------------
DROP TABLE IF EXISTS `huiyuan_body_data`;
CREATE TABLE `huiyuan_body_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `huiyuan_id` bigint(20) DEFAULT NULL COMMENT '会员id',
  `huiyuanzhanghao` varchar(200) DEFAULT NULL COMMENT '会员账号',
  `shengao` double DEFAULT NULL COMMENT '身高(cm)',
  `tizhong` double DEFAULT NULL COMMENT '体重(kg)',
  `bmi` double DEFAULT NULL COMMENT 'BMI指数',
  `jianshenmubiao` varchar(200) DEFAULT NULL COMMENT '健身目标(减脂/增肌/塑形/康复)',
  `jianshendengji` varchar(200) DEFAULT NULL COMMENT '健身等级(初级/中级/高级)',
  `meizhouxunliantian` int(11) DEFAULT NULL COMMENT '每周训练天数',
  `beizhu` text COMMENT '健康备注',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员身体数据';

-- ----------------------------
-- 健身计划表
-- ----------------------------
DROP TABLE IF EXISTS `fitness_plan`;
CREATE TABLE `fitness_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `huiyuan_id` bigint(20) DEFAULT NULL COMMENT '会员id',
  `huiyuanzhanghao` varchar(200) DEFAULT NULL COMMENT '会员账号',
  `plan_name` varchar(200) DEFAULT NULL COMMENT '计划名称',
  `jianshenmubiao` varchar(200) DEFAULT NULL COMMENT '健身目标',
  `jianshendengji` varchar(200) DEFAULT NULL COMMENT '健身等级',
  `shengao` double DEFAULT NULL COMMENT '身高',
  `tizhong` double DEFAULT NULL COMMENT '体重',
  `bmi` double DEFAULT NULL COMMENT 'BMI',
  `meizhouxunliantian` int(11) DEFAULT NULL COMMENT '每周训练天数',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `zongshichang` int(11) DEFAULT NULL COMMENT '总时长(分钟)',
  `zongtianshu` int(11) DEFAULT NULL COMMENT '训练天数',
  `status` varchar(200) DEFAULT '进行中' COMMENT '状态(进行中/已完成/已过期)',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健身计划';

-- ----------------------------
-- 健身计划详情表
-- ----------------------------
DROP TABLE IF EXISTS `fitness_plan_detail`;
CREATE TABLE `fitness_plan_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `plan_id` bigint(20) DEFAULT NULL COMMENT '计划id',
  `xingqi` int(11) DEFAULT NULL COMMENT '星期几(1-7)',
  `shiduan` varchar(200) DEFAULT NULL COMMENT '训练时段(上午/下午/晚上)',
  `xiangmu_id` bigint(20) DEFAULT NULL COMMENT '健身项目id',
  `xiangmumingcheng` varchar(200) DEFAULT NULL COMMENT '项目名称',
  `xiangmuleixing` varchar(200) DEFAULT NULL COMMENT '项目类型',
  `shichang` int(11) DEFAULT NULL COMMENT '训练时长(分钟)',
  `zushu` int(11) DEFAULT NULL COMMENT '组数',
  `cishu` int(11) DEFAULT NULL COMMENT '次数',
  `xiuxishijian` int(11) DEFAULT NULL COMMENT '休息时间(秒)',
  `beizhu` text COMMENT '注意事项',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健身计划详情';
