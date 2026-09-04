-- ----------------------------
-- 健身心得分享论坛表
-- ----------------------------
DROP TABLE IF EXISTS `xindefu`;
CREATE TABLE `xindefu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `fenlei` varchar(200) DEFAULT NULL COMMENT '分类',
  `fengmian` varchar(200) DEFAULT NULL COMMENT '封面图片',
  `fabuzhanghao` varchar(200) DEFAULT NULL COMMENT '发布人账号',
  `fabuxingming` varchar(200) DEFAULT NULL COMMENT '发布人姓名',
  `fabushijian` datetime DEFAULT NULL COMMENT '发布时间',
  `thumbsupnum` int(11) DEFAULT '0' COMMENT '点赞数',
  `clicknum` int(11) DEFAULT '0' COMMENT '浏览量',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健身心得分享';

-- ----------------------------
-- 健身心得评论表
-- ----------------------------
DROP TABLE IF EXISTS `xindefu_comment`;
CREATE TABLE `xindefu_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `xindefu_id` bigint(20) DEFAULT NULL COMMENT '健身心得',
  `huiyuanzhanghao` varchar(200) DEFAULT NULL COMMENT '评论人账号',
  `huiyuanxingming` varchar(200) DEFAULT NULL COMMENT '评论人姓名',
  `pinglunneirong` text COMMENT '评论内容',
  `pinglunshijian` datetime DEFAULT NULL COMMENT '评论时间',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健身心得评论';

-- ----------------------------
-- 健身心得点赞表
-- ----------------------------
DROP TABLE IF EXISTS `xindefu_thumbsup`;
CREATE TABLE `xindefu_thumbsup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `xindefu_id` bigint(20) DEFAULT NULL COMMENT '健身心得',
  `huiyuanzhanghao` varchar(200) DEFAULT NULL COMMENT '用户账号',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_xindefu_huiyuan` (`xindefu_id`,`huiyuanzhanghao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='健身心得点赞';
