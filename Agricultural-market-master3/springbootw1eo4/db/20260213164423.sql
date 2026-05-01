/*
MySQL Backup
Database: springbootw1eo4
Backup Time: 2026-02-13 16:44:23
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `springbootw1eo4`.`aboutus`;
DROP TABLE IF EXISTS `springbootw1eo4`.`address`;
DROP TABLE IF EXISTS `springbootw1eo4`.`cart`;
DROP TABLE IF EXISTS `springbootw1eo4`.`chanpinfenlei`;
DROP TABLE IF EXISTS `springbootw1eo4`.`chat`;
DROP TABLE IF EXISTS `springbootw1eo4`.`config`;
DROP TABLE IF EXISTS `springbootw1eo4`.`discussrexiaonongchanpin`;
DROP TABLE IF EXISTS `springbootw1eo4`.`news`;
DROP TABLE IF EXISTS `springbootw1eo4`.`orders`;
DROP TABLE IF EXISTS `springbootw1eo4`.`rexiaonongchanpin`;
DROP TABLE IF EXISTS `springbootw1eo4`.`shangjia`;
DROP TABLE IF EXISTS `springbootw1eo4`.`storeup`;
DROP TABLE IF EXISTS `springbootw1eo4`.`token`;
DROP TABLE IF EXISTS `springbootw1eo4`.`users`;
DROP TABLE IF EXISTS `springbootw1eo4`.`yonghu`;
CREATE TABLE `aboutus` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `subtitle` varchar(200) DEFAULT NULL COMMENT '副标题',
  `content` longtext NOT NULL COMMENT '内容',
  `picture1` longtext COMMENT '图片1',
  `picture2` longtext COMMENT '图片2',
  `picture3` longtext COMMENT '图片3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='关于我们';
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '用户id',
  `address` varchar(200) NOT NULL COMMENT '地址',
  `name` varchar(200) NOT NULL COMMENT '收货人',
  `phone` varchar(200) NOT NULL COMMENT '电话',
  `isdefault` varchar(200) NOT NULL COMMENT '是否默认地址[是/否]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COMMENT='地址';
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tablename` varchar(200) DEFAULT 'rexiaonongchanpin' COMMENT '商品表名',
  `userid` bigint NOT NULL COMMENT '用户id',
  `goodid` bigint NOT NULL COMMENT '商品id',
  `goodname` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `picture` longtext COMMENT '图片',
  `buynumber` int NOT NULL COMMENT '购买数量',
  `price` float DEFAULT NULL COMMENT '单价',
  `discountprice` float DEFAULT NULL COMMENT '会员价',
  `goodtype` varchar(200) DEFAULT NULL COMMENT '商品类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='购物车表';
CREATE TABLE `chanpinfenlei` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `chanpinfenlei` varchar(200) DEFAULT NULL COMMENT '产品分类',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COMMENT='产品分类';
CREATE TABLE `chat` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '用户id',
  `adminid` bigint DEFAULT NULL COMMENT '管理员id',
  `ask` longtext COMMENT '提问',
  `reply` longtext COMMENT '回复',
  `isreply` int DEFAULT NULL COMMENT '是否回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3 COMMENT='在线客服';
CREATE TABLE `config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='配置文件';
CREATE TABLE `discussrexiaonongchanpin` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint NOT NULL COMMENT '关联表id',
  `userid` bigint NOT NULL COMMENT '用户id',
  `avatarurl` longtext COMMENT '头像',
  `nickname` varchar(200) DEFAULT NULL COMMENT '用户名',
  `content` longtext NOT NULL COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='热销农产品评论表';
CREATE TABLE `news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `introduction` longtext COMMENT '简介',
  `picture` longtext NOT NULL COMMENT '图片',
  `content` longtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb3 COMMENT='网站公告';
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `orderid` varchar(200) NOT NULL COMMENT '订单编号',
  `tablename` varchar(200) DEFAULT 'rexiaonongchanpin' COMMENT '商品表名',
  `userid` bigint NOT NULL COMMENT '用户id',
  `goodid` bigint NOT NULL COMMENT '商品id',
  `goodname` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `picture` longtext COMMENT '商品图片',
  `buynumber` int NOT NULL COMMENT '购买数量',
  `price` float NOT NULL DEFAULT '0' COMMENT '价格',
  `discountprice` float DEFAULT '0' COMMENT '折扣价格',
  `total` float NOT NULL DEFAULT '0' COMMENT '总价格',
  `discounttotal` float DEFAULT '0' COMMENT '折扣总价格',
  `type` int DEFAULT '1' COMMENT '支付类型',
  `status` varchar(200) DEFAULT NULL COMMENT '状态',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `tel` varchar(200) DEFAULT NULL COMMENT '电话',
  `consignee` varchar(200) DEFAULT NULL COMMENT '收货人',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `logistics` longtext COMMENT '物流',
  `goodtype` varchar(200) DEFAULT NULL COMMENT '商品类型',
  `paytype` varchar(200) DEFAULT '现金' COMMENT '支付类型（现金/积分）',
  `group_id` bigint DEFAULT NULL COMMENT '团号（如果不为null则代表是团购单）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderid` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=1770971551183 DEFAULT CHARSET=utf8mb3 COMMENT='订单';
CREATE TABLE `rexiaonongchanpin` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `chanpinbianhao` varchar(200) DEFAULT NULL COMMENT '产品编号',
  `nongchanpinmingcheng` varchar(200) DEFAULT NULL COMMENT '农产品名称',
  `nongchanpintupian` longtext COMMENT '农产品图片',
  `chanpinfenlei` varchar(200) DEFAULT NULL COMMENT '产品分类',
  `shifouyouji` varchar(200) DEFAULT NULL COMMENT '是否有机',
  `pinpai` varchar(200) DEFAULT NULL COMMENT '品牌',
  `guigebaozhuang` varchar(200) DEFAULT NULL COMMENT '规格包装',
  `chandi` varchar(200) DEFAULT NULL COMMENT '产地',
  `nongchanpinjieshao` longtext COMMENT '农产品介绍',
  `onelimittimes` int DEFAULT NULL COMMENT '单限',
  `alllimittimes` int DEFAULT NULL COMMENT '库存',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  `clicknum` int DEFAULT '0' COMMENT '点击次数',
  `price` float NOT NULL COMMENT '价格',
  `shangjiazhango` varchar(200) DEFAULT NULL COMMENT '商家账号',
  `istuan` varchar(200) DEFAULT '否' COMMENT '是否团购',
  `tuanprice` decimal(10,2) DEFAULT '0.00' COMMENT '团购价',
  `isjifen` varchar(200) DEFAULT '否' COMMENT '是否积分兑换',
  `jifencost` int DEFAULT '0' COMMENT '所需积分',
  `reducestarttime` datetime DEFAULT NULL COMMENT '降价开始时间',
  `reduceendtime` datetime DEFAULT NULL COMMENT '降价结束时间',
  `reducediscount` float DEFAULT '1' COMMENT '降价折扣（如0.8代表8折，1代表不打折）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chanpinbianhao` (`chanpinbianhao`)
) ENGINE=InnoDB AUTO_INCREMENT=1770951130917 DEFAULT CHARSET=utf8mb3 COMMENT='热销农产品';
CREATE TABLE `shangjia` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `shangjiazhango` varchar(200) NOT NULL COMMENT '商家账号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `shangjianame` varchar(200) DEFAULT NULL COMMENT '商家姓名',
  `dianpumingcheng` varchar(200) DEFAULT NULL COMMENT '店铺名称',
  `touxiang` longtext COMMENT '店铺头像',
  `lianxifangshi` varchar(200) DEFAULT NULL COMMENT '联系方式',
  `dizhi` varchar(200) DEFAULT NULL COMMENT '地址',
  `money` float DEFAULT '0' COMMENT '余额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shangjiazhango` (`shangjiazhango`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='商家';
CREATE TABLE `storeup` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '用户id',
  `refid` bigint DEFAULT NULL COMMENT '商品id',
  `tablename` varchar(200) DEFAULT NULL COMMENT '表名',
  `name` varchar(200) NOT NULL COMMENT '名称',
  `picture` longtext NOT NULL COMMENT '图片',
  `type` varchar(200) DEFAULT '1' COMMENT '类型(1:收藏,21:赞,22:踩,31:竞拍参与,41:关注)',
  `inteltype` varchar(200) DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='收藏表';
CREATE TABLE `token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='token表';
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='用户表';
CREATE TABLE `yonghu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yonghuzhanghao` varchar(200) DEFAULT NULL COMMENT '用户账号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `yonghuxingming` varchar(200) DEFAULT NULL COMMENT '用户姓名',
  `touxiang` longtext COMMENT '头像',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `lianxifangshi` varchar(200) DEFAULT NULL COMMENT '联系方式',
  `money` float DEFAULT '0' COMMENT '余额',
  `jifen` int DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`id`),
  UNIQUE KEY `yonghuzhanghao` (`yonghuzhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COMMENT='用户';
BEGIN;
LOCK TABLES `springbootw1eo4`.`aboutus` WRITE;
DELETE FROM `springbootw1eo4`.`aboutus`;
INSERT INTO `springbootw1eo4`.`aboutus` (`id`,`addtime`,`title`,`subtitle`,`content`,`picture1`,`picture2`,`picture3`) VALUES (1, '2023-03-19 17:44:35', '关于我们', 'ABOUT US', '不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?\n你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。其实，我已经厌倦了你这样说说而已的把戏，我觉得就算我告诉你如何去做，你也不会照做，因为你根本什么都不做。', 'upload/aboutus_picture1.jpg', 'upload/aboutus_picture2.jpg', 'upload/aboutus_picture3.jpg')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`address` WRITE;
DELETE FROM `springbootw1eo4`.`address`;
INSERT INTO `springbootw1eo4`.`address` (`id`,`addtime`,`userid`,`address`,`name`,`phone`,`isdefault`) VALUES (1, '2023-03-19 17:44:35', 11, '宇宙银河系金星1号', '金某', '13823888881', '是'),(2, '2023-03-19 17:44:35', 12, '宇宙银河系木星1号', '木某', '13823888882', '是'),(3, '2023-03-19 17:44:35', 13, '宇宙银河系水星1号', '水某', '13823888883', '是'),(4, '2023-03-19 17:44:35', 14, '宇宙银河系火星1号', '火某', '13823888884', '是'),(5, '2023-03-19 17:44:35', 15, '宇宙银河系土星1号', '土某', '13823888885', '是'),(6, '2023-03-19 17:44:35', 16, '宇宙银河系月球1号', '月某', '13823888886', '是'),(7, '2023-03-19 17:44:35', 17, '宇宙银河系黑洞1号', '黑某', '13823888887', '是'),(8, '2023-03-19 17:44:35', 18, '宇宙银河系地球1号', '地某', '13823888888', '是')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`cart` WRITE;
DELETE FROM `springbootw1eo4`.`cart`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`chanpinfenlei` WRITE;
DELETE FROM `springbootw1eo4`.`chanpinfenlei`;
INSERT INTO `springbootw1eo4`.`chanpinfenlei` (`id`,`addtime`,`chanpinfenlei`) VALUES (21, '2023-03-19 17:44:35', '产品分类1'),(22, '2023-03-19 17:44:35', '产品分类2'),(23, '2023-03-19 17:44:35', '产品分类3'),(24, '2023-03-19 17:44:35', '产品分类4'),(25, '2023-03-19 17:44:35', '产品分类5'),(26, '2023-03-19 17:44:35', '产品分类6'),(27, '2023-03-19 17:44:35', '产品分类7'),(28, '2023-03-19 17:44:35', '产品分类8')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`chat` WRITE;
DELETE FROM `springbootw1eo4`.`chat`;
INSERT INTO `springbootw1eo4`.`chat` (`id`,`addtime`,`userid`,`adminid`,`ask`,`reply`,`isreply`) VALUES (41, '2023-03-19 17:44:35', 1, 1, '提问1', '回复1', 1),(42, '2023-03-19 17:44:35', 2, 2, '提问2', '回复2', 2),(43, '2023-03-19 17:44:35', 3, 3, '提问3', '回复3', 3),(44, '2023-03-19 17:44:35', 4, 4, '提问4', '回复4', 4),(45, '2023-03-19 17:44:35', 5, 5, '提问5', '回复5', 5),(46, '2023-03-19 17:44:35', 6, 6, '提问6', '回复6', 6),(47, '2023-03-19 17:44:35', 7, 7, '提问7', '回复7', 7),(48, '2023-03-19 17:44:35', 8, 8, '提问8', '回复8', 8)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`config` WRITE;
DELETE FROM `springbootw1eo4`.`config`;
INSERT INTO `springbootw1eo4`.`config` (`id`,`name`,`value`) VALUES (1, 'picture1', 'upload/picture1.jpg'),(2, 'picture2', 'upload/picture2.jpg'),(3, 'picture3', 'upload/picture3.jpg')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`discussrexiaonongchanpin` WRITE;
DELETE FROM `springbootw1eo4`.`discussrexiaonongchanpin`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`news` WRITE;
DELETE FROM `springbootw1eo4`.`news`;
INSERT INTO `springbootw1eo4`.`news` (`id`,`addtime`,`title`,`introduction`,`picture`,`content`) VALUES (91, '2023-03-19 17:44:35', '有梦想，就要努力去实现', '不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。', 'upload/news_picture1.jpg', '<p>不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?</p><p>你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。其实，我已经厌倦了你这样说说而已的把戏，我觉得就算我告诉你如何去做，你也不会照做，因为你根本什么都不做。</p><p>真正有行动力的人不需要别人告诉他如何做，因为他已经在做了。就算碰到问题，他也会自己想办法，自己动手去解决或者主动寻求可以帮助他的人，而不是等着别人为自己解决问题。</p><p>首先要学习独立思考。花一点时间想一下自己喜欢什么，梦想是什么，不要别人说想环游世界，你就说你的梦想是环游世界。</p><p>很多人说现实束缚了自己，其实在这个世界上，我们一直都可以有很多选择，生活的决定权也—直都在自己手上，只是我们缺乏行动力而已。</p><p>如果你觉得安于现状是你想要的，那选择安于现状就会让你幸福和满足;如果你不甘平庸，选择一条改变、进取和奋斗的道路，在这个追求的过程中，你也一样会感到快乐。所谓的成功，即是按照自己想要的生活方式生活。最糟糕的状态，莫过于当你想要选择一条不甘平庸、改变、进取和奋斗的道路时，却以一种安于现状的方式生活，最后抱怨自己没有得到想要的人生。</p><p>因为喜欢，你不是在苦苦坚持，也因为喜欢，你愿意投入时间、精力，长久以往，获得成功就是自然而然的事情。</p>'),(92, '2023-03-19 17:44:35', '又是一年毕业季', '又是一年毕业季，感慨万千，还记的自己刚进学校那时候的情景，我拖着沉重的行李箱站在偌大的教学楼前面，感叹自己未来的日子即将在这个陌生的校园里度过，而如今斗转星移，浮光掠影，弹指之间，那些青葱岁月如同白驹过隙般悄然从指缝溜走。过去的种种在胸口交集纠结，像打翻的五味瓶，甜蜜，酸楚，苦涩，一并涌上心头。', 'upload/news_picture2.jpg', '<p>又是一年毕业季，感慨万千，还记的自己刚进学校那时候的情景，我拖着沉重的行李箱站在偌大的教学楼前面，感叹自己未来的日子即将在这个陌生的校园里度过，而如今斗转星移，浮光掠影，弹指之间，那些青葱岁月如同白驹过隙般悄然从指缝溜走。</p><p>过去的种种在胸口交集纠结，像打翻的五味瓶，甜蜜，酸楚，苦涩，一并涌上心头。一直都是晚会的忠实参与者，无论是台前还是幕后，忽然间，角色转变，那种感觉确实难以用语言表达。</p><p>	过去的三年，总是默默地期盼着这个好雨时节，因为这时候，会有灿烂的阳光，会有满目的百花争艳，会有香甜的冰激凌，这是个毕业的季节，当时不经世事的我们会殷切地期待学校那一大堆的活动，期待穿上绚丽的演出服或者礼仪服，站在大礼堂镁光灯下尽情挥洒我们的澎拜的激情。</p><p>百感交集，隔岸观火与身临其境的感觉竟是如此不同。从来没想过一场晚会送走的是我们自己的时候会是怎样的感情，毕业就真的意味着结束吗?倔强的我们不愿意承认，谢谢学弟学妹们慷慨的将这次的主题定为“我们在这里”。我知道，这可能是他们对我们这些过来人的尊敬和施舍。</p><p>没有为这场晚会排练、奔波，没有为班级、学生会、文学院出点力，还真有点不习惯，百般无奈中，用“工作忙”个万能的借口来搪塞自己，欺骗别人。其实自己心里明白，那只是在逃避，只是不愿面对繁华落幕后的萧条和落寞。大四了，大家各奔东西，想凑齐班上的人真的是难上加难，敏燕从越南回来，刚落地就匆匆回了学校，那么恋家的人也启程回来了，睿睿学姐也是从家赶来跟我们团圆。大家—如既往的寒暄、打趣、调侃对方，似乎一切又回到了当初的单纯美好。</p><p>看着舞台上活泼可爱的学弟学妹们，如同一群机灵的小精灵，清澈的眼神，稚嫩的肢体，轻快地步伐，用他们那热情洋溢的舞姿渲染着在场的每一个人，我知道，我不应该羡慕嫉妒他们，不应该顾自怜惜逝去的青春，不应该感叹夕阳无限好，曾经，我们也拥有过，曾经，我们也年轻过，曾经，我们也灿烂过。我深深地告诉自己，人生的每个阶段都是美的，年轻有年轻的活力，成熟也有成熟的魅力。多—份稳重、淡然、优雅，也是漫漫时光掠影遗留下的.珍贵赏赐。</p>'),(93, '2023-03-19 17:44:35', '挫折路上，坚持常在心间', '回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。', 'upload/news_picture3.jpg', '<p>回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?</p><p>清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。</p><p>是的，面对道途上那无情的嘲讽，面对步伐中那重复的摔跤，面对激流与硬石之间猛烈的碰撞，我们必须选择那富于阴雨，却最终见到彩虹的荆棘路。也许，经历了那暴风雨的洗礼，我们便会变得自信，幸福也随之而来。</p><p>司马迁屡遭羞辱，却依然在狱中撰写《史记》，作为一名史学家，不因王权而极度赞赏，也不因卑微而极度批判，然而他在坚持自己操守的同时，却依然要受统治阶级的阻碍，他似乎无权选择自己的本职。但是，他不顾于此，只是在面对道途的阻隔之时，他依然选择了走下去的信念。终于一部开山巨作《史记》诞生，为后人留下一份馈赠，也许在他完成毕生的杰作之时，他微微地笑了，没有什么比梦想实现更快乐的了......</p><p>	或许正如“长风破浪会有时，直挂云帆济沧海”一般，欣欣然地走向看似深渊的崎岖路，而在一番耕耘之后，便会发现这里另有一番天地。也许这就是困难与快乐的交融。</p><p>也许在形形色色的社会中，我们常能看到一份坚持，一份自信，但这里却还有一类人。这类人在暴风雨来临之际，只会闪躲，从未懂得这也是一种历炼，这何尝不是一份快乐。在阴暗的角落里，总是独自在哭，带着伤愁，看不到一点希望。</p><p>我们不能堕落于此，而要像海燕那般，在苍茫的大海上，高傲地飞翔，任何事物都无法阻挡，任何事都是幸福快乐的。</p>'),(94, '2023-03-19 17:44:35', '挫折是另一个生命的开端', '当遇到挫折或失败，你是看见失败还是看见机会?挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。', 'upload/news_picture4.jpg', '<p>当遇到挫折或失败，你是看见失败还是看见机会?</p><p>挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。</p><p>人生在世，从古到今，不分天子平民，机遇虽有不同，但总不免有身陷困境或遭遇难题之处，这时候唯有通权达变，才能使人转危为安，甚至反败为胜。</p><p>大部分的人，一生当中，最痛苦的经验是失去所爱的人，其次是丢掉一份工作。其实，经得起考验的人，就算是被开除也不会惊慌，要学会面对。</p><p>	“塞翁失马，焉知非福。”人生的道路，并不是每一步都迈向成功，这就是追求的意义。我们还要认识到一点，挫折作为一种情绪状态和一种个人体验，各人的耐受性是大不相同的，有的人经历了一次次挫折，就能够坚忍不拔，百折不挠;有的人稍遇挫折便意志消沉，一蹶不振。所以，挫折感是一种主观感受，因为人的目的和需要不同，成功标准不同，所以同一种活动对于不同的人可能会造成不同的挫折感受。</p><p>凡事皆以平常心来看待，对于生命顺逆不要太执著。能够“破我执”是很高层的人生境界。</p><p>人事的艰难就是一种考验。就像—支剑要有磨刀来磨，剑才会利:一块璞玉要有粗石来磨，才会发出耀眼的光芒。我们能够做到的，只是如何减少、避免那些由于自身的原因所造成的挫折，而在遇到痛苦和挫折之后，则力求化解痛苦，争取幸福。我们要知道，痛苦和挫折是双重性的，它既是我们人生中难以完全避免的，也是我们在争取成功时，不可缺少的一种动力。因为我认为，推动我们奋斗的力量，不仅仅是对成功的渴望，还有为摆脱痛苦和挫折而进行的奋斗。</p>'),(95, '2023-03-19 17:44:35', '你要去相信，没有到不了的明天', '有梦想就去努力，因为在这一辈子里面，现在不去勇敢的努力，也许就再也没有机会了。你要去相信，一定要相信，没有到不了的明天。不要被命运打败，让自己变得更强大。不管你现在是一个人走在异乡的街道上始终没有找到一丝归属感，还是你在跟朋友们一起吃饭开心址笑着的时候闪过一丝落寞。', 'upload/news_picture5.jpg', '<p>有梦想就去努力，因为在这一辈子里面，现在不去勇敢的努力，也许就再也没有机会了。你要去相信，一定要相信，没有到不了的明天。不要被命运打败，让自己变得更强大。</p><p>不管你现在是一个人走在异乡的街道上始终没有找到一丝归属感，还是你在跟朋友们一起吃饭开心址笑着的时候闪过一丝落寞。</p><p>	不管你现在是在图书馆里背着怎么也看不进去的英语单词，还是你现在迷茫地看不清未来的方向不知道要往哪走。</p><p>不管你现在是在努力着去实现梦想却没能拉近与梦想的距离，还是你已经慢慢地找不到自己的梦想了。</p><p>你都要去相信，没有到不了的明天。</p><p>	有的时候你的梦想太大，别人说你的梦想根本不可能实现;有的时候你的梦想又太小，又有人说你胸无大志;有的时候你对死党说着将来要去环游世界的梦想，却换来他的不屑一顾，于是你再也不提自己的梦想;有的时候你突然说起将来要开个小店的愿望，却发现你讲述的那个人，并没有听到你在说什么。</p><p>不过又能怎么样呢，未来始终是自己的，梦想始终是自己的，没有人会来帮你实现它。</p><p>也许很多时候我们只是需要朋友的一句鼓励，一句安慰，却也得不到。但是相信我，世界上还有很多人，只是想要和你说说话。</p><p>因为我们都一样。一样的被人说成固执，一样的在追逐他们眼里根本不在意的东西。</p><p>所以，又有什么关系呢，别人始终不是你、不能懂你的心情，你又何必多去解释呢。这个世界会来阻止你，困难也会接踵而至，其实真正关键的只有自己，有没有那个倔强。</p><p>这个世界上没有不带伤的人，真正能治愈自己的，只有自己。</p>'),(96, '2023-03-19 17:44:35', '离开是一种痛苦，是一种勇气，但同样也是一个考验，是一个新的开端', '无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。', 'upload/news_picture6.jpg', '<p>无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。离别的确是一种痛苦，但同样也是我们走入社会，走向新环境、新领域的一个开端，希望大家在以后新的工作岗位上能够确定自己的新起点，坚持不懈，向着更新、更高的目标前进，因为人生最美好的东西永远都在最前方!</p><p>忆往昔峥嵘岁月，看今朝潮起潮落，望未来任重而道远。作为新时代的我们，就应在失败时，能拼搏奋起，去谱写人生的辉煌。在成功时，亦能居安思危，不沉湎于一时的荣耀、鲜花和掌声中，时时刻刻怀着一颗积极寻找自己新的奶酪的心，处变不惊、成败不渝，始终踏着自己坚实的步伐，从零开始，不断向前迈进，这样才能在这风起云涌、变幻莫测的社会大潮中成为真正的弄潮儿!</p>'),(97, '2023-03-19 17:44:35', 'Leave未必是一种痛苦', '无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。', 'upload/news_picture7.jpg', '<p>无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。离别的确是一种痛苦，但同样也是我们走入社会，走向新环境、新领域的一个开端，希望大家在以后新的工作岗位上能够确定自己的新起点，坚持不懈，向着更新、更高的目标前进，因为人生最美好的东西永远都在最前方!</p><p>忆往昔峥嵘岁月，看今朝潮起潮落，望未来任重而道远。作为新时代的我们，就应在失败时，能拼搏奋起，去谱写人生的辉煌。在成功时，亦能居安思危，不沉湎于一时的荣耀、鲜花和掌声中，时时刻刻怀着一颗积极寻找自己新的奶酪的心，处变不惊、成败不渝，始终踏着自己坚实的步伐，从零开始，不断向前迈进，这样才能在这风起云涌、变幻莫测的社会大潮中成为真正的弄潮儿!</p>'),(98, '2023-03-19 17:44:35', '坚持才会成功', '回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。', 'upload/news_picture8.jpg', '<p>回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?</p><p>清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。</p><p>是的，面对道途上那无情的嘲讽，面对步伐中那重复的摔跤，面对激流与硬石之间猛烈的碰撞，我们必须选择那富于阴雨，却最终见到彩虹的荆棘路。也许，经历了那暴风雨的洗礼，我们便会变得自信，幸福也随之而来。</p><p>司马迁屡遭羞辱，却依然在狱中撰写《史记》，作为一名史学家，不因王权而极度赞赏，也不因卑微而极度批判，然而他在坚持自己操守的同时，却依然要受统治阶级的阻碍，他似乎无权选择自己的本职。但是，他不顾于此，只是在面对道途的阻隔之时，他依然选择了走下去的信念。终于一部开山巨作《史记》诞生，为后人留下一份馈赠，也许在他完成毕生的杰作之时，他微微地笑了，没有什么比梦想实现更快乐的了......</p><p>	或许正如“长风破浪会有时，直挂云帆济沧海”一般，欣欣然地走向看似深渊的崎岖路，而在一番耕耘之后，便会发现这里另有一番天地。也许这就是困难与快乐的交融。</p><p>也许在形形色色的社会中，我们常能看到一份坚持，一份自信，但这里却还有一类人。这类人在暴风雨来临之际，只会闪躲，从未懂得这也是一种历炼，这何尝不是一份快乐。在阴暗的角落里，总是独自在哭，带着伤愁，看不到一点希望。</p><p>我们不能堕落于此，而要像海燕那般，在苍茫的大海上，高傲地飞翔，任何事物都无法阻挡，任何事都是幸福快乐的。</p>')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`orders` WRITE;
DELETE FROM `springbootw1eo4`.`orders`;
INSERT INTO `springbootw1eo4`.`orders` (`id`,`addtime`,`orderid`,`tablename`,`userid`,`goodid`,`goodname`,`picture`,`buynumber`,`price`,`discountprice`,`total`,`discounttotal`,`type`,`status`,`address`,`tel`,`consignee`,`remark`,`logistics`,`goodtype`,`paytype`,`group_id`) VALUES (1770965787422, '2026-02-13 15:18:28', '318965c308ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787423, '2026-02-13 15:18:28', '3189889508ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787424, '2026-02-13 15:18:28', '31898a0308ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787425, '2026-02-13 15:18:28', '31898aa308ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787426, '2026-02-13 15:18:28', '31898b0508ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787427, '2026-02-13 15:18:28', '318992f208ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787428, '2026-02-13 15:18:28', '3189938808ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787429, '2026-02-13 15:18:28', '318993ec08ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770965787430, '2026-02-13 15:18:28', '3189944d08ac11f1ac436c1ff70ae632', 'rexiaonongchanpin', 8, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 1, '已支付', NULL, NULL, NULL, NULL, NULL, '产品分类1', '现金支付', 1001),(1770967488296, '2026-02-13 15:24:47', '202621315244728640505', 'rexiaonongchanpin', 18, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 99.9, 99.9, 99.9, 1, '已取消', '宇宙银河系地球1号', '13823888888', '地某', '', NULL, '产品分类1', '现金支付', NULL),(1770967909811, '2026-02-13 15:31:49', '202621315314975239143', 'rexiaonongchanpin', 18, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 99.9, 0, 2, '已支付', '宇宙银河系地球1号', '13823888888', '地某', '', NULL, '产品分类1', '积分支付', NULL),(1770968246248, '2026-02-13 15:37:25', '202621315372547148332', 'rexiaonongchanpin', 18, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 69.93, 69.93, 1, '已支付', '宇宙银河系地球1号', '13823888888', '地某', '【团购满员优惠】', NULL, '产品分类1', '现金支付', 1001),(1770969690675, '2026-02-13 16:01:30', '202621316130111176', 'rexiaonongchanpin', 18, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 49.95, 0, 1, '已取消', '宇宙银河系地球1号', '13823888888', '地某', '【限时降价优惠】', NULL, '产品分类1', '现金支付', NULL),(1770969721840, '2026-02-13 16:02:00', '2026213162083462947', 'rexiaonongchanpin', 18, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 49.95, 0, 1, '已支付', '宇宙银河系地球1号', '13823888888', '地某', '【限时降价优惠】', NULL, '产品分类1', '现金支付', NULL),(1770969997548, '2026-02-13 16:06:37', '202621316637818435', 'rexiaonongchanpin', 18, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 49.95, 0, 1, '未支付', '宇宙银河系地球1号', '13823888888', '地某', '【限时降价优惠】', NULL, '产品分类1', '现金支付', NULL),(1770971551182, '2026-02-13 16:32:31', '20262131632316662808', 'rexiaonongchanpin', 18, 31, '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg', 1, 99.9, 0, 49.95, 0, 1, '未支付', '宇宙银河系地球1号', '13823888888', '地某', '【限时降价优惠】', NULL, '产品分类1', '现金支付', NULL)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`rexiaonongchanpin` WRITE;
DELETE FROM `springbootw1eo4`.`rexiaonongchanpin`;
INSERT INTO `springbootw1eo4`.`rexiaonongchanpin` (`id`,`addtime`,`chanpinbianhao`,`nongchanpinmingcheng`,`nongchanpintupian`,`chanpinfenlei`,`shifouyouji`,`pinpai`,`guigebaozhuang`,`chandi`,`nongchanpinjieshao`,`onelimittimes`,`alllimittimes`,`clicktime`,`clicknum`,`price`,`shangjiazhango`,`istuan`,`tuanprice`,`isjifen`,`jifencost`,`reducestarttime`,`reduceendtime`,`reducediscount`) VALUES (31, '2023-03-19 17:44:35', '1111111111', '农产品名称1', 'upload/rexiaonongchanpin_nongchanpintupian1.jpg,upload/rexiaonongchanpin_nongchanpintupian2.jpg,upload/rexiaonongchanpin_nongchanpintupian3.jpg', '产品分类1', '有机', '品牌1', '规格包装1', '产地1', '农产品介绍1', 1, 103, '2026-02-13 16:43:19', 58, 99.9, NULL, '否', 0.00, '否', 0, '2026-02-12 00:00:00', '2026-02-14 23:59:59', 0.5),(32, '2023-03-19 17:44:35', '2222222222', '农产品名称2', 'upload/rexiaonongchanpin_nongchanpintupian2.jpg,upload/rexiaonongchanpin_nongchanpintupian3.jpg,upload/rexiaonongchanpin_nongchanpintupian4.jpg', '产品分类2', '有机', '品牌2', '规格包装2', '产地2', '农产品介绍2', 2, 99, '2023-03-19 17:44:35', 2, 99.9, NULL, '否', 0.00, '否', 0, NULL, NULL, 1),(33, '2023-03-19 17:44:35', '3333333333', '农产品名称3', 'upload/rexiaonongchanpin_nongchanpintupian3.jpg,upload/rexiaonongchanpin_nongchanpintupian4.jpg,upload/rexiaonongchanpin_nongchanpintupian5.jpg', '产品分类3', '有机', '品牌3', '规格包装3', '产地3', '农产品介绍3', 3, 99, '2023-03-19 17:44:35', 3, 99.9, NULL, '否', 0.00, '否', 0, NULL, NULL, 1),(34, '2023-03-19 17:44:35', '4444444444', '农产品名称4', 'upload/rexiaonongchanpin_nongchanpintupian4.jpg,upload/rexiaonongchanpin_nongchanpintupian5.jpg,upload/rexiaonongchanpin_nongchanpintupian6.jpg', '产品分类4', '有机', '品牌4', '规格包装4', '产地4', '农产品介绍4', 4, 99, '2023-03-19 17:44:35', 4, 99.9, NULL, '否', 0.00, '否', 0, NULL, NULL, 1),(35, '2023-03-19 17:44:35', '5555555555', '农产品名称5', 'upload/rexiaonongchanpin_nongchanpintupian5.jpg,upload/rexiaonongchanpin_nongchanpintupian6.jpg,upload/rexiaonongchanpin_nongchanpintupian7.jpg', '产品分类5', '有机', '品牌5', '规格包装5', '产地5', '农产品介绍5', 5, 99, '2023-03-19 17:44:35', 5, 99.9, NULL, '否', 0.00, '否', 0, NULL, NULL, 1),(36, '2023-03-19 17:44:35', '6666666666', '农产品名称6', 'upload/rexiaonongchanpin_nongchanpintupian6.jpg,upload/rexiaonongchanpin_nongchanpintupian7.jpg,upload/rexiaonongchanpin_nongchanpintupian8.jpg', '产品分类6', '有机', '品牌6', '规格包装6', '产地6', '农产品介绍6', 6, 99, '2023-03-19 17:44:35', 6, 99.9, NULL, '否', 0.00, '否', 0, NULL, NULL, 1),(37, '2023-03-19 17:44:35', '7777777777', '农产品名称7', 'upload/rexiaonongchanpin_nongchanpintupian7.jpg,upload/rexiaonongchanpin_nongchanpintupian8.jpg,upload/rexiaonongchanpin_nongchanpintupian9.jpg', '产品分类7', '有机', '品牌7', '规格包装7', '产地7', '农产品介绍7', 7, 99, '2023-03-19 17:44:35', 7, 99.9, NULL, '否', 0.00, '否', 0, NULL, NULL, 1),(38, '2023-03-19 17:44:35', '8888888888', '农产品名称8', 'upload/rexiaonongchanpin_nongchanpintupian8.jpg,upload/rexiaonongchanpin_nongchanpintupian9.jpg,upload/rexiaonongchanpin_nongchanpintupian10.jpg', '产品分类8', '有机', '品牌8', '规格包装8', '产地8', '农产品介绍8', 8, 99, '2023-03-19 17:44:35', 8, 99.9, NULL, '否', 0.00, '否', 0, NULL, NULL, 1),(1770951130916, '2026-02-13 10:52:10', '1770950893188', '加贺精选·叶濑高山有机原味红枣', 'upload/1770965446973.jpg', '产品分类1', '有机', '加贺艺作 (KAGA ARTISANAL)', '500g / 礼盒装（内含独立充氮小包装）', ' 叶濑示范农业基地（高海拔日照区）', '<p><span style=\"background-color: rgb(255, 255, 255); color: rgb(43, 45, 49);\">“加贺精选”系列红枣，产自叶濑地区核心高海拔种植带。由加贺农技团队严格把控种植流程，旨在为高强度脑力劳动者（如职业棋手、学生及科研人员）提供纯天然、无添加的高营养补给。</span></p>', 10, 1500, '2026-02-13 14:50:57', 5, 68, 'sj001', '否', 0.00, '否', 0, NULL, NULL, 1)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`shangjia` WRITE;
DELETE FROM `springbootw1eo4`.`shangjia`;
INSERT INTO `springbootw1eo4`.`shangjia` (`id`,`addtime`,`shangjiazhango`,`mima`,`shangjianame`,`dianpumingcheng`,`touxiang`,`lianxifangshi`,`dizhi`,`money`) VALUES (1, '2026-02-12 15:13:37', 'sj001', '123456', '测试商家', '我的优质农家店', NULL, '13800138000', NULL, 0)
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`storeup` WRITE;
DELETE FROM `springbootw1eo4`.`storeup`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`token` WRITE;
DELETE FROM `springbootw1eo4`.`token`;
INSERT INTO `springbootw1eo4`.`token` (`id`,`userid`,`username`,`tablename`,`role`,`token`,`addtime`,`expiratedtime`) VALUES (1, 1, 'admin', 'users', '管理员', '6tzu7o29g5enckiqu8hsrh4arqrddhc5', '2026-02-12 14:40:53', '2026-02-13 16:17:42'),(2, 11, '用户账号1', 'yonghu', '用户', 'iom3ml6rj1bbv0k5bcqb977xuk28i79o', '2026-02-12 14:45:40', '2026-02-12 15:45:40'),(3, 1, 'sj001', 'shangjia', '商家', 'oad2v0ovv34oe27vcpbbw1i29u7pty8q', '2026-02-13 10:14:33', '2026-02-13 13:47:23'),(4, 18, '用户账号8', 'yonghu', '用户', 'shglnni9n717gnfevr9abanmalb9w43b', '2026-02-13 14:49:06', '2026-02-13 17:43:14')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`users` WRITE;
DELETE FROM `springbootw1eo4`.`users`;
INSERT INTO `springbootw1eo4`.`users` (`id`,`username`,`password`,`role`,`addtime`) VALUES (1, 'admin', 'admin', '管理员', '2023-03-19 17:44:35')
;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `springbootw1eo4`.`yonghu` WRITE;
DELETE FROM `springbootw1eo4`.`yonghu`;
INSERT INTO `springbootw1eo4`.`yonghu` (`id`,`addtime`,`yonghuzhanghao`,`mima`,`yonghuxingming`,`touxiang`,`xingbie`,`lianxifangshi`,`money`,`jifen`) VALUES (11, '2023-03-19 17:44:35', '用户账号1', '123456', '用户姓名1', 'upload/yonghu_touxiang1.jpg', '男', '13823888881', 200, 0),(12, '2023-03-19 17:44:35', '用户账号2', '123456', '用户姓名2', 'upload/yonghu_touxiang2.jpg', '男', '13823888882', 200, 0),(13, '2023-03-19 17:44:35', '用户账号3', '123456', '用户姓名3', 'upload/yonghu_touxiang3.jpg', '男', '13823888883', 200, 0),(14, '2023-03-19 17:44:35', '用户账号4', '123456', '用户姓名4', 'upload/yonghu_touxiang4.jpg', '男', '13823888884', 200, 0),(15, '2023-03-19 17:44:35', '用户账号5', '123456', '用户姓名5', 'upload/yonghu_touxiang5.jpg', '男', '13823888885', 200, 0),(16, '2023-03-19 17:44:35', '用户账号6', '123456', '用户姓名6', 'upload/yonghu_touxiang6.jpg', '男', '13823888886', 200, 0),(17, '2023-03-19 17:44:35', '用户账号7', '123456', '用户姓名7', 'upload/yonghu_touxiang7.jpg', '男', '13823888887', 200, 0),(18, '2023-03-19 17:44:35', '用户账号8', '123456', '用户姓名8', 'upload/yonghu_touxiang8.jpg', '男', '13823888888', 9680.85, 219)
;
UNLOCK TABLES;
COMMIT;
