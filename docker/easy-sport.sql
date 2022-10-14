/*
 Navicat Premium Data Transfer

 Source Server         : ruoyi-vue
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : 47.100.185.109:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001

 Date: 14/07/2022 15:29:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日历信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (4, 'sport_comment', '', NULL, NULL, 'SportComment', 'crud', 'com.ruoyi.system', 'system', 'comment', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2022-06-30 13:24:52', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (5, 'sport_fields', '场地信息', '', '', 'SportFields', 'tree', 'com.ruoyi.system', 'system', 'fields', '场地管理', 'ruoyi', '0', '/', '{\"treeCode\":\"id\",\"treeName\":\"name\",\"treeParentCode\":\"parent_id\",\"parentMenuId\":\"2030\"}', 'admin', '2022-06-30 13:24:53', '', '2022-06-30 14:29:01', NULL);
INSERT INTO `gen_table` VALUES (6, 'sport_games', '比赛信息', 'sport_item', 'item_name', 'SportGames', 'sub', 'com.ruoyi.system', 'system', 'games', '比赛管理', 'ruoyi', '0', '/', '{\"parentMenuId\":\"2030\"}', 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12', NULL);
INSERT INTO `gen_table` VALUES (7, 'sport_item', '项目管理', NULL, NULL, 'SportItem', 'crud', 'com.ruoyi.system', 'system', 'item', '项目管理', 'ruoyi', '0', '/', '{\"parentMenuId\":\"2030\"}', 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:16:02', NULL);
INSERT INTO `gen_table` VALUES (8, 'sport_nums', '号码段', NULL, NULL, 'SportNums', 'crud', 'com.ruoyi.system', 'system', 'nums', '号码段管理', 'ruoyi', '0', '/', '{\"parentMenuId\":\"2030\"}', 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:42:50', NULL);
INSERT INTO `gen_table` VALUES (13, 'sport_registrations', '报名', NULL, NULL, 'SportRegistrations', 'crud', 'com.ruoyi.system', 'system', 'registrations', '报名管理', 'leftHand', '0', '/', '{\"parentMenuId\":\"2030\"}', 'admin', '2022-07-01 22:38:59', '', '2022-07-06 12:25:54', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (13, '4', 'id', NULL, 'int(11)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-06-30 13:24:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (14, '4', 'article_id', NULL, 'int(11)', 'Long', 'articleId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-06-30 13:24:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (15, '4', 'user_id', NULL, 'int(11)', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-06-30 13:24:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (16, '4', 'text', NULL, 'varchar(255)', 'String', 'text', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-06-30 13:24:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (17, '4', 'create_time', NULL, 'timestamp', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 5, 'admin', '2022-06-30 13:24:53', '', NULL);
INSERT INTO `gen_table_column` VALUES (18, '5', 'id', 'id', 'int(11)', 'Long', 'id', '1', '1', NULL, NULL, NULL, NULL, '1', 'EQ', 'input', '', 1, 'admin', '2022-06-30 13:24:53', '', '2022-06-30 14:29:01');
INSERT INTO `gen_table_column` VALUES (19, '5', 'name', '场地名', 'varchar(255)', 'String', 'name', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-06-30 13:24:53', '', '2022-06-30 14:29:01');
INSERT INTO `gen_table_column` VALUES (20, '5', 'max_person', '人数限制', 'int(11)', 'Long', 'maxPerson', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-06-30 13:24:53', '', '2022-06-30 14:29:01');
INSERT INTO `gen_table_column` VALUES (21, '5', 'parent_id', '父级场地', 'int(11)', 'Long', 'parentId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2022-06-30 13:24:53', '', '2022-06-30 14:29:01');
INSERT INTO `gen_table_column` VALUES (22, '6', 'id', 'id', 'int(11)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (23, '6', 'item_id', '项目', 'int(11)', 'Long', 'itemId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (24, '6', 'game_name', '比赛名', 'varchar(255)', 'String', 'gameName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (25, '6', 'next_game', '决赛', 'int(11)', 'Long', 'nextGame', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (26, '6', 'gender', '性别', 'int(11)', 'Integer', 'gender', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sys_user_sex', 5, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (27, '6', 'field_id', '场地', 'int(11)', 'Long', 'fieldId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (28, '6', 'max_person', '限制人数', 'int(11)', 'Long', 'maxPerson', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (29, '6', 'status', '状态', 'int(11)', 'Long', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sport_game_status', 8, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:12');
INSERT INTO `gen_table_column` VALUES (30, '6', 'start_time', '开始时间', 'datetime', 'Date', 'startTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:13');
INSERT INTO `gen_table_column` VALUES (31, '6', 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 10, 'admin', '2022-06-30 13:24:53', '', '2022-07-05 15:51:13');
INSERT INTO `gen_table_column` VALUES (32, '6', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2022-06-30 13:24:54', '', '2022-07-05 15:51:13');
INSERT INTO `gen_table_column` VALUES (33, '7', 'id', '自增id', 'int(11)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:16:02');
INSERT INTO `gen_table_column` VALUES (34, '7', 'item_name', '项目名称', 'varchar(255)', 'String', 'itemName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:16:02');
INSERT INTO `gen_table_column` VALUES (35, '7', 'max_person', '限制最多人数', 'int(11)', 'Long', 'maxPerson', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:16:02');
INSERT INTO `gen_table_column` VALUES (36, '7', 'type', '项目类型（田赛、径赛、团体赛等）', 'int(11)', 'Long', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sport_item_type', 4, 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:16:02');
INSERT INTO `gen_table_column` VALUES (37, '7', 'unit', '成绩单位', 'varchar(255)', 'String', 'unit', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:16:02');
INSERT INTO `gen_table_column` VALUES (38, '7', 'is_desc', '是否降序排序', 'int(11)', 'Long', 'isDesc', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', 'sport_sort_type', 6, 'admin', '2022-06-30 13:24:54', '', '2022-07-01 23:16:02');
INSERT INTO `gen_table_column` VALUES (39, '8', 'id', '', 'int(11)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-06-30 13:24:54', NULL, '2022-07-06 15:21:58');
INSERT INTO `gen_table_column` VALUES (40, '8', 'id_num', '', 'int(11)', 'Long', 'idNum', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-06-30 13:24:54', NULL, '2022-07-06 15:21:58');
INSERT INTO `gen_table_column` VALUES (71, '13', 'id', 'id', 'int(11)', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-07-01 22:38:59', NULL, '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (72, '13', 'game_id', '比赛', 'int(11)', 'Long', 'gameId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-07-01 22:38:59', NULL, '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (73, '13', 'user_id', '用户', 'int(11)', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-07-01 22:38:59', NULL, '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (74, '13', 'field_id', '场地', 'int(11)', 'Long', 'fieldId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-07-01 22:39:00', NULL, '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (75, '13', 'status', '审核状态', 'varchar(255)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'sport_status', 5, 'admin', '2022-07-01 22:39:00', NULL, '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (76, '13', 'create_time', '报名时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 9, 'admin', '2022-07-01 22:39:00', NULL, '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (77, '13', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', NULL, 10, 'admin', '2022-07-01 22:39:00', NULL, '2022-07-06 12:25:55');
INSERT INTO `gen_table_column` VALUES (78, '13', 'score', '比赛成绩', 'int(11)', 'Long', 'score', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, '', '2022-07-01 22:42:13', NULL, '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (79, '8', 'user_id', '', 'int(11)', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, '', '2022-07-01 23:38:18', NULL, '2022-07-06 15:21:58');
INSERT INTO `gen_table_column` VALUES (80, '13', 'points', '比赛积分', 'int(11)', 'Long', 'points', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, '', '2022-07-05 22:44:27', '', '2022-07-06 12:25:54');
INSERT INTO `gen_table_column` VALUES (81, '13', 'comment', '备注信息(是否破纪录等)', 'varchar(255)', 'String', 'comment', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 8, '', '2022-07-05 22:44:27', '', '2022-07-06 12:25:54');

-- ----------------------------
-- Table structure for sport_fields
-- ----------------------------
DROP TABLE IF EXISTS `sport_fields`;
CREATE TABLE `sport_fields`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `max_person` int(11) NULL DEFAULT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_???ػ????ӳ??أ??????飩`(`parent_id`) USING BTREE,
  CONSTRAINT `父场地` FOREIGN KEY (`parent_id`) REFERENCES `sport_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sport_fields
-- ----------------------------
INSERT INTO `sport_fields` VALUES (65, '【不可删除】麦庐校区', 99999, NULL);
INSERT INTO `sport_fields` VALUES (66, '【不可删除】蛟桥校区', 99999, NULL);
INSERT INTO `sport_fields` VALUES (67, '麦庐田径场', 9999, 65);
INSERT INTO `sport_fields` VALUES (68, '蛟桥田径场', 0, 66);
INSERT INTO `sport_fields` VALUES (69, '1', 1, 67);
INSERT INTO `sport_fields` VALUES (70, '2', NULL, 67);
INSERT INTO `sport_fields` VALUES (71, '3', NULL, 67);
INSERT INTO `sport_fields` VALUES (72, '4', NULL, 67);
INSERT INTO `sport_fields` VALUES (73, '5', NULL, 67);
INSERT INTO `sport_fields` VALUES (74, '6', NULL, 67);
INSERT INTO `sport_fields` VALUES (75, '7', NULL, 67);
INSERT INTO `sport_fields` VALUES (76, '8', NULL, 67);
INSERT INTO `sport_fields` VALUES (77, '麦庐篮球馆', NULL, 65);
INSERT INTO `sport_fields` VALUES (78, '1号', NULL, 77);
INSERT INTO `sport_fields` VALUES (79, '2号', NULL, 77);
INSERT INTO `sport_fields` VALUES (80, '3号', NULL, 77);
INSERT INTO `sport_fields` VALUES (81, '沙坑', 9999, 68);
INSERT INTO `sport_fields` VALUES (82, '天然草地足球场', 9999, 65);
INSERT INTO `sport_fields` VALUES (83, '蛟桥室外篮球场', 9999, 66);
INSERT INTO `sport_fields` VALUES (84, '麦庐网球场', 9999, 65);
INSERT INTO `sport_fields` VALUES (85, '蛟桥体育馆', 9999, 66);

-- ----------------------------
-- Table structure for sport_games
-- ----------------------------
DROP TABLE IF EXISTS `sport_games`;
CREATE TABLE `sport_games`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NULL DEFAULT NULL,
  `game_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `next_game` int(11) UNSIGNED NULL DEFAULT 0,
  `gender` int(11) NULL DEFAULT NULL,
  `field_id` int(11) NULL DEFAULT NULL,
  `max_person` int(11) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_?????????`(`next_game`) USING BTREE,
  INDEX `FK_????????ָ?`(`field_id`) USING BTREE,
  INDEX `比赛项目`(`item_id`) USING BTREE,
  CONSTRAINT `场地` FOREIGN KEY (`field_id`) REFERENCES `sport_fields` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `比赛项目` FOREIGN KEY (`item_id`) REFERENCES `sport_item` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sport_games
-- ----------------------------
INSERT INTO `sport_games` VALUES (26, 7, '【女子】1500米(决赛)', 0, 1, 67, 50, 0, '2022-10-14 12:00:00', NULL, '2022-07-11 19:44:56');
INSERT INTO `sport_games` VALUES (27, 7, '【男子】1500米(决赛)', 0, 0, 67, 50, 0, '2022-10-14 03:14:00', NULL, '2022-07-11 19:47:24');
INSERT INTO `sport_games` VALUES (30, 8, '【女子】3000米(决赛)', 0, 1, 67, 30, 0, '2022-10-15 10:38:00', NULL, '2022-07-11 20:11:21');
INSERT INTO `sport_games` VALUES (31, 10, '【男子】5000米(决赛)', 0, 0, 67, 50, 0, '2022-10-16 14:00:00', NULL, '2022-07-11 20:19:36');
INSERT INTO `sport_games` VALUES (32, 15, '【男子】三级跳远(决赛)', 0, 0, 81, 30, 0, '2022-10-14 10:00:00', NULL, '2022-07-11 20:20:59');
INSERT INTO `sport_games` VALUES (33, 13, '【女子】跳高(决赛)', 0, 1, 68, 30, 0, '2022-10-14 10:00:00', NULL, '2022-07-11 20:24:11');
INSERT INTO `sport_games` VALUES (34, 16, '【女子】铅球(决赛)', 0, 1, 82, 30, 0, '2022-10-14 14:00:00', NULL, '2022-07-11 20:29:38');
INSERT INTO `sport_games` VALUES (35, 14, '【女子】跳远(决赛)', 0, 1, 81, 50, 0, '2022-10-14 14:00:00', NULL, '2022-07-11 20:31:11');
INSERT INTO `sport_games` VALUES (36, 13, '【男子】跳高(决赛)', 0, 0, 68, 30, 0, '2022-10-15 14:00:00', NULL, '2022-07-11 20:31:59');
INSERT INTO `sport_games` VALUES (37, 14, '【男子】跳远(决赛)', 0, 0, 81, 30, 0, '2022-10-15 08:30:00', NULL, '2022-07-11 20:33:06');
INSERT INTO `sport_games` VALUES (38, 16, '【男子】铅球(决赛)', 0, 0, 82, 30, 0, '2022-10-14 14:00:00', NULL, '2022-07-11 20:34:21');
INSERT INTO `sport_games` VALUES (39, 5, '【女子】400米(决赛)', 0, 1, 67, 40, 0, '2022-10-15 08:30:00', NULL, '2022-07-11 20:37:42');
INSERT INTO `sport_games` VALUES (40, 5, '【男子】400米(决赛)', 0, 0, 67, 50, 0, '2022-10-15 08:30:03', NULL, '2022-07-11 21:34:58');
INSERT INTO `sport_games` VALUES (41, 8, '【男子】3000米(决赛)', 0, 0, 67, 0, 0, '2022-10-15 10:38:00', NULL, '2022-07-11 21:40:50');
INSERT INTO `sport_games` VALUES (42, 1, '【女子】100米(决赛)', 0, 1, 67, 0, 0, NULL, NULL, '2022-07-11 21:51:35');
INSERT INTO `sport_games` VALUES (43, 4, '【女子】200米(决赛)', 0, 1, 67, 0, 0, NULL, NULL, '2022-07-11 21:55:36');
INSERT INTO `sport_games` VALUES (44, 6, '【女子】800米(决赛)', 0, 1, 67, 0, 0, NULL, NULL, '2022-07-11 22:00:56');
INSERT INTO `sport_games` VALUES (45, 1, '【男子】100米(决赛)', 0, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:01:55');
INSERT INTO `sport_games` VALUES (46, 4, '【男子】200米(决赛)', 0, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:02:06');
INSERT INTO `sport_games` VALUES (47, 6, '【男子】800米(决赛)', 0, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:02:21');
INSERT INTO `sport_games` VALUES (48, 7, '【女子】1500米(预赛)', 26, 1, 67, 0, 0, NULL, NULL, '2022-07-11 22:07:37');
INSERT INTO `sport_games` VALUES (49, 7, '【男子】1500米(预赛)', 27, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:07:51');
INSERT INTO `sport_games` VALUES (50, 8, '【女子】3000米(预赛)', 30, 1, 67, 0, 0, NULL, NULL, '2022-07-11 22:10:20');
INSERT INTO `sport_games` VALUES (51, 10, '【男子】5000米(预赛)', 31, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:10:31');
INSERT INTO `sport_games` VALUES (52, 5, '【女子】400米(预赛)', 39, 1, 67, 0, 0, NULL, NULL, '2022-07-11 22:11:01');
INSERT INTO `sport_games` VALUES (53, 5, '【男子】400米(预赛)', 40, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:11:16');
INSERT INTO `sport_games` VALUES (54, 8, '【男子】3000米(预赛)', 41, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:11:43');
INSERT INTO `sport_games` VALUES (55, 1, '【女子】100米(预赛)', 42, 1, 67, 0, 0, NULL, NULL, '2022-07-11 22:11:59');
INSERT INTO `sport_games` VALUES (56, 11, '【男子】4×100(决赛)', 0, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:39:43');
INSERT INTO `sport_games` VALUES (57, 12, '【女子】4×400(决赛)', 0, 1, 67, 0, 0, NULL, NULL, '2022-07-11 22:40:00');
INSERT INTO `sport_games` VALUES (58, 12, '【男子】4×400(决赛)', 0, 0, 67, 0, 0, NULL, NULL, '2022-07-11 22:47:31');
INSERT INTO `sport_games` VALUES (59, 11, '【女子】4×100(决赛)', 0, 1, 67, 0, 0, NULL, NULL, '2022-07-11 22:48:21');

-- ----------------------------
-- Table structure for sport_item
-- ----------------------------
DROP TABLE IF EXISTS `sport_item`;
CREATE TABLE `sport_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `item_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `max_person` int(11) NULL DEFAULT NULL COMMENT '限制最多人数',
  `type` int(11) NULL DEFAULT NULL COMMENT '项目类型（田赛、径赛、团体赛等）',
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '成绩单位',
  `is_desc` int(11) NULL DEFAULT 1 COMMENT '是否降序排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sport_item
-- ----------------------------
INSERT INTO `sport_item` VALUES (1, '100米', 99, 2, '毫秒', 0);
INSERT INTO `sport_item` VALUES (4, '200米', 99, 2, '毫秒', 0);
INSERT INTO `sport_item` VALUES (5, '400米', 99, 2, '毫秒', 0);
INSERT INTO `sport_item` VALUES (6, '800米', 99, 2, '秒', 0);
INSERT INTO `sport_item` VALUES (7, '1500米', 99, 2, '秒', 0);
INSERT INTO `sport_item` VALUES (8, '3000米', 99, 2, '秒', 0);
INSERT INTO `sport_item` VALUES (10, '5000米', 99, 2, '秒', 0);
INSERT INTO `sport_item` VALUES (11, '4×100', 99, 3, '毫秒', 0);
INSERT INTO `sport_item` VALUES (12, '4×400', 99, 3, '秒', 0);
INSERT INTO `sport_item` VALUES (13, '跳高', 99, 1, 'CM', 1);
INSERT INTO `sport_item` VALUES (14, '跳远', 99, 1, 'CM', 1);
INSERT INTO `sport_item` VALUES (15, '三级跳远', 99, 1, 'CM', 1);
INSERT INTO `sport_item` VALUES (16, '铅球', 99, 1, 'CM', 1);
INSERT INTO `sport_item` VALUES (17, '同心鼓', 99, 3, '个', 1);
INSERT INTO `sport_item` VALUES (18, '推小车', 99, 3, '', 1);
INSERT INTO `sport_item` VALUES (19, '30 米火车跑', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (20, '摸石头过河', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (21, '有轨电车', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (22, '袋鼠跳', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (23, '运球上篮', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (24, '足球带球绕杆接力', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (25, '背夹球接力', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (26, '30 米龙卷风', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (27, '不倒森林', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (28, '原地双手头上前抛实心球', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (29, '趣味轮滑', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (30, '拔河比赛', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (31, '火线运送伤员（30 米负重搬运接力）', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (32, '红军的扁担（20 米挑粮竞速）', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (33, '8x30 秒单双摇跳绳接力', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (34, '10 人长绳集体赛', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (35, '学生体质健康大比拼', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (36, '团体操', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (37, '男子 5 人足球', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (38, '男子、女子 3 人篮球', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (39, '男女混合气排球赛', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (40, '中国象棋', 99, 3, NULL, 1);
INSERT INTO `sport_item` VALUES (41, '中国围棋', 99, 3, NULL, 1);

-- ----------------------------
-- Table structure for sport_nums
-- ----------------------------
DROP TABLE IF EXISTS `sport_nums`;
CREATE TABLE `sport_nums`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_num` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_????????????ѧԺ`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 274 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sport_nums
-- ----------------------------

-- ----------------------------
-- Table structure for sport_registrations
-- ----------------------------
DROP TABLE IF EXISTS `sport_registrations`;
CREATE TABLE `sport_registrations`  (
  `id` int(11) NOT NULL,
  `game_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `field_id` int(11) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int(11) NULL DEFAULT NULL,
  `points` int(11) NULL DEFAULT NULL COMMENT '比赛积分',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息(是否破纪录等)',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `game`(`game_id`) USING BTREE,
  INDEX `user`(`user_id`) USING BTREE,
  INDEX `field`(`field_id`) USING BTREE,
  CONSTRAINT `field` FOREIGN KEY (`field_id`) REFERENCES `sport_fields` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `game` FOREIGN KEY (`game_id`) REFERENCES `sport_games` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sport_registrations
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-06-29 22:36:25', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-06-29 22:36:25', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-06-29 22:36:25', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2022-06-29 22:36:25', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2022-06-29 22:36:25', 'admin', '2022-06-30 15:34:26', '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 215 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '学校', 0, '左手', '18359088114', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:32:43');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:43');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '裁判', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:18');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '体育学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '会计学院', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:57');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '财税学院', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:34:04');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '信管学院', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:34:13');
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', 'VR学院', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:34:21');
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '记录组', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:34:35');
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '编排组', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:34:44');
INSERT INTO `sys_dept` VALUES (200, 101, '0,100,101', '国际学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (201, 101, '0,100,101', '产经学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (202, 101, '0,100,101', '工商学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (203, 101, '0,100,101', '国贸学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (204, 101, '0,100,101', '经济学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (205, 101, '0,100,101', '金融学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (206, 101, '0,100,101', '统计学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (207, 101, '0,100,101', '信管学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (208, 101, '0,100,101', '旅城学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (209, 101, '0,100,101', '软件学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (210, 101, '0,100,101', '外语学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (211, 101, '0,100,101', '人文学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (212, 101, '0,100,101', '法学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (213, 101, '0,100,101', '艺术学院', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');
INSERT INTO `sys_dept` VALUES (214, 101, '0,100,101', '国际处', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:33:50');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-06-29 22:36:25', 'admin', '2022-07-11 22:38:08', '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '报名中', '0', 'sport_game_status', NULL, 'default', 'N', '0', 'admin', '2022-06-30 15:16:25', 'admin', '2022-07-01 22:51:11', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 0, '准备中', '1', 'sport_game_status', NULL, 'default', 'N', '0', 'admin', '2022-06-30 15:16:38', 'admin', '2022-07-01 22:51:26', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 0, '比赛中', '2', 'sport_game_status', NULL, 'default', 'N', '0', 'admin', '2022-06-30 15:16:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 0, '结束', '3', 'sport_game_status', NULL, 'default', 'N', '0', 'admin', '2022-06-30 15:17:07', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 0, '待审核', '0', 'sport_status', NULL, 'info', 'N', '0', 'admin', '2022-07-01 22:54:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 0, '通过', '1', 'sport_status', NULL, 'success', 'N', '0', 'admin', '2022-07-01 22:55:04', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 0, '未通过', '-1', 'sport_status', NULL, 'danger', 'N', '0', 'admin', '2022-07-01 22:55:23', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 0, '田赛', '1', 'sport_item_type', NULL, 'default', 'N', '0', 'admin', '2022-07-01 23:03:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 0, '径赛', '2', 'sport_item_type', NULL, 'default', 'N', '0', 'admin', '2022-07-01 23:04:02', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 0, '团体赛', '3', 'sport_item_type', NULL, 'default', 'N', '0', 'admin', '2022-07-01 23:04:13', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 0, '降序', '1', 'sport_sort_type', NULL, 'default', 'N', '0', 'admin', '2022-07-01 23:12:54', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 0, '升序', '0', 'sport_sort_type', NULL, 'default', 'N', '0', 'admin', '2022-07-01 23:14:22', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-06-29 22:36:25', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '比赛状态', 'sport_game_status', '0', 'admin', '2022-06-30 15:15:26', 'admin', '2022-06-30 15:15:44', '比赛状态列表');
INSERT INTO `sys_dict_type` VALUES (101, '审核状态', 'sport_status', '0', 'admin', '2022-07-01 22:54:04', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '项目类型', 'sport_item_type', '0', 'admin', '2022-07-01 22:57:31', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (103, '排序方式', 'sport_sort_type', '0', 'admin', '2022-07-01 23:12:37', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-06-29 22:36:25', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-06-29 22:36:25', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-06-29 22:36:25', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 197 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-06-29 22:54:15');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-06-30 13:20:29');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-06-30 13:34:57');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-30 13:35:01');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-30 14:05:15');
INSERT INTO `sys_logininfor` VALUES (105, 'gh', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '注册成功', '2022-06-30 15:34:34');
INSERT INTO `sys_logininfor` VALUES (106, 'gh', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '验证码错误', '2022-06-30 15:34:41');
INSERT INTO `sys_logininfor` VALUES (107, 'gh', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '1', '验证码错误', '2022-06-30 15:34:44');
INSERT INTO `sys_logininfor` VALUES (108, 'gh', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-06-30 15:34:47');
INSERT INTO `sys_logininfor` VALUES (109, 'gh', '127.0.0.1', '内网IP', 'Firefox 10', 'Windows 10', '0', '退出成功', '2022-06-30 15:41:19');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '1', '验证码错误', '2022-06-30 20:31:37');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '1', '验证码错误', '2022-06-30 20:31:40');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '1', '验证码错误', '2022-06-30 20:31:44');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-06-30 20:31:52');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-01 22:26:03');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '退出成功', '2022-07-01 22:40:27');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-01 22:40:36');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '退出成功', '2022-07-01 23:56:20');
INSERT INTO `sys_logininfor` VALUES (118, 'gh', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-01 23:56:29');
INSERT INTO `sys_logininfor` VALUES (119, 'gh', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-02 12:54:28');
INSERT INTO `sys_logininfor` VALUES (120, 'gh', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '退出成功', '2022-07-02 12:54:48');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-02 12:54:55');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '验证码错误', '2022-07-05 15:37:04');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '验证码错误', '2022-07-05 15:37:08');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-05 15:37:11');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-05 20:15:08');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '退出成功', '2022-07-05 20:27:11');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '1', '验证码已失效', '2022-07-05 20:27:12');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-05 20:27:20');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '1', '验证码错误', '2022-07-05 20:27:25');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-05 20:27:27');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-05 21:05:58');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-07-06 12:04:57');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-06 12:05:00');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-06 15:07:14');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-06 17:02:55');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-06 19:48:36');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-06 21:53:13');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-07 20:22:17');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-07 22:29:02');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '1', '验证码错误', '2022-07-08 19:43:54');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-08 19:43:59');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '退出成功', '2022-07-08 21:58:17');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-08 22:01:09');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-09 09:26:13');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '192.168.31.242', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-09 09:30:19');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '192.168.31.242', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '退出成功', '2022-07-09 09:47:39');
INSERT INTO `sys_logininfor` VALUES (147, 'gh', '192.168.31.242', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-09 09:47:55');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '退出成功', '2022-07-09 10:02:38');
INSERT INTO `sys_logininfor` VALUES (149, 'zgx949', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '注册成功', '2022-07-09 10:06:58');
INSERT INTO `sys_logininfor` VALUES (150, 'zgx949', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-09 10:07:18');
INSERT INTO `sys_logininfor` VALUES (151, 'zgx949', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '退出成功', '2022-07-09 10:07:26');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-09 10:07:41');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-09 11:16:14');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-11 15:32:20');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-11 16:36:49');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-11 19:39:16');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-07-11 21:34:42');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-07-11 21:34:45');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-11 21:34:50');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-07-11 22:29:08');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-07-11 22:29:20');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-11 22:29:23');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-11 22:29:24');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '110.90.126.242', 'XX XX', 'Firefox 10', 'Windows 10', '1', '验证码已失效', '2022-07-12 11:38:14');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '110.90.126.242', 'XX XX', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-07-12 11:38:17');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '110.90.126.242', 'XX XX', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-07-12 11:42:08');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '110.90.126.242', 'XX XX', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-12 11:42:11');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '110.90.126.242', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-12 12:44:46');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '110.90.126.242', 'XX XX', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-12 12:45:02');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '220.197.235.180', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-07-12 13:05:50');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '116.248.95.40', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-07-12 13:59:14');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '116.248.95.40', 'XX XX', 'Chrome 8', 'Windows 10', '0', '登录成功', '2022-07-12 14:18:38');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '110.90.126.242', 'XX XX', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-12 14:19:01');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '110.90.126.242', 'XX XX', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-12 16:45:14');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-12 17:31:03');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '218.66.73.90', 'XX XX', 'Chrome 10', 'Mac OS X', '0', '登录成功', '2022-07-12 22:36:39');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '110.90.126.242', 'XX XX', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-13 13:49:48');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '110.90.126.242', 'XX XX', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-07-13 13:52:28');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-07-13 13:59:49');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-13 13:59:53');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '110.90.126.242', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-13 14:04:03');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '退出成功', '2022-07-13 15:36:44');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-13 15:37:54');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '退出成功', '2022-07-13 15:44:43');
INSERT INTO `sys_logininfor` VALUES (185, 'gh', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2022-07-13 15:44:52');
INSERT INTO `sys_logininfor` VALUES (186, 'gh', '127.0.0.1', '内网IP', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '用户不存在/密码错误', '2022-07-13 15:44:59');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-07-13 15:55:33');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-07-13 15:55:37');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '110.90.126.242', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '验证码错误', '2022-07-13 16:31:32');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '110.90.126.242', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '验证码已失效', '2022-07-13 16:36:05');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '110.90.126.242', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-13 16:36:10');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '110.90.126.242', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '1', '验证码错误', '2022-07-13 17:15:29');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '110.90.126.242', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-13 17:15:34');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '110.90.126.242', 'XX XX', 'Firefox 10', 'Windows 10', '0', '登录成功', '2022-07-13 17:37:07');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '223.104.51.10', 'XX XX', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '登录成功', '2022-07-13 19:24:46');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '218.66.73.90', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-07-13 21:36:53');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2093 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-06-29 22:36:24', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-06-29 22:36:24', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-06-29 22:36:24', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '0', '1', '', 'guide', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 23:49:05', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-06-29 22:36:24', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-06-29 22:36:24', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-06-29 22:36:24', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-06-29 22:36:24', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-06-29 22:36:24', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-06-29 22:36:24', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-06-29 22:36:24', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-06-29 22:36:24', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-06-29 22:36:24', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-06-29 22:36:24', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-06-29 22:36:24', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-06-29 22:36:24', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-06-29 22:36:24', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-06-29 22:36:24', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-06-29 22:36:24', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-06-29 22:36:24', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-06-29 22:36:24', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-06-29 22:36:24', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-06-29 22:36:24', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-06-29 22:36:24', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '赛事管理', 0, 5, 'game', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'log', 'admin', '2022-06-30 14:07:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '场地管理', 2030, 1, 'fields', 'system/fields/index', NULL, 1, 0, 'C', '0', '0', 'system:fields:list', 'tree-table', 'admin', '2022-06-30 14:21:12', 'admin', '2022-07-01 23:48:27', '场地管理菜单');
INSERT INTO `sys_menu` VALUES (2032, '场地管理查询', 2031, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fields:query', '#', 'admin', '2022-06-30 14:21:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '场地管理新增', 2031, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fields:add', '#', 'admin', '2022-06-30 14:21:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '场地管理修改', 2031, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fields:edit', '#', 'admin', '2022-06-30 14:21:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '场地管理删除', 2031, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fields:remove', '#', 'admin', '2022-06-30 14:21:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '场地管理导出', 2031, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fields:export', '#', 'admin', '2022-06-30 14:21:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '比赛管理', 2030, 1, 'games', 'system/games/index', NULL, 1, 0, 'C', '0', '0', 'system:games:list', 'guide', 'admin', '2022-06-30 14:21:14', 'admin', '2022-07-01 23:48:50', '比赛管理菜单');
INSERT INTO `sys_menu` VALUES (2038, '比赛管理查询', 2037, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:games:query', '#', 'admin', '2022-06-30 14:21:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '比赛管理新增', 2037, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:games:add', '#', 'admin', '2022-06-30 14:21:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '比赛管理修改', 2037, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:games:edit', '#', 'admin', '2022-06-30 14:21:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '比赛管理删除', 2037, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:games:remove', '#', 'admin', '2022-06-30 14:21:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '比赛管理导出', 2037, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:games:export', '#', 'admin', '2022-06-30 14:21:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '项目管理', 2030, 1, 'item', 'system/item/index', NULL, 1, 0, 'C', '0', '0', 'system:item:list', 'list', 'admin', '2022-06-30 14:21:15', 'admin', '2022-07-01 23:50:33', '项目管理菜单');
INSERT INTO `sys_menu` VALUES (2044, '项目管理查询', 2043, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:item:query', '#', 'admin', '2022-06-30 14:21:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '项目管理新增', 2043, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:item:add', '#', 'admin', '2022-06-30 14:21:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '项目管理修改', 2043, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:item:edit', '#', 'admin', '2022-06-30 14:21:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '项目管理删除', 2043, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:item:remove', '#', 'admin', '2022-06-30 14:21:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '项目管理导出', 2043, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:item:export', '#', 'admin', '2022-06-30 14:21:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '号码段管理', 2030, 1, 'nums', 'system/nums/index', NULL, 1, 0, 'C', '0', '0', 'system:nums:list', 'number', 'admin', '2022-06-30 14:21:17', 'admin', '2022-07-01 23:46:35', '号码段管理菜单');
INSERT INTO `sys_menu` VALUES (2050, '号码段管理查询', 2049, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:nums:query', '#', 'admin', '2022-06-30 14:21:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '号码段管理新增', 2049, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:nums:add', '#', 'admin', '2022-06-30 14:21:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '号码段管理修改', 2049, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:nums:edit', '#', 'admin', '2022-06-30 14:21:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '号码段管理删除', 2049, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:nums:remove', '#', 'admin', '2022-06-30 14:21:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '号码段管理导出', 2049, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:nums:export', '#', 'admin', '2022-06-30 14:21:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '报名管理', 2030, 1, 'registrations', 'system/registrations/index', NULL, 1, 0, 'C', '0', '0', 'system:registrations:list', 'build', 'admin', '2022-06-30 14:21:18', 'admin', '2022-07-01 23:47:13', '报名管理菜单');
INSERT INTO `sys_menu` VALUES (2056, '报名管理查询', 2055, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:registrations:query', '#', 'admin', '2022-06-30 14:21:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '报名管理新增', 2055, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:registrations:add', '#', 'admin', '2022-06-30 14:21:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '报名管理修改', 2055, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:registrations:edit', '#', 'admin', '2022-06-30 14:21:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '报名管理删除', 2055, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:registrations:remove', '#', 'admin', '2022-06-30 14:21:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '报名管理导出', 2055, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:registrations:export', '#', 'admin', '2022-06-30 14:21:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '用户报名', 2092, 6, 'game_register', 'game_register', NULL, 1, 1, 'C', '0', '0', '', 'edit', 'admin', '2022-07-08 22:32:28', 'admin', '2022-07-08 22:45:01', '');
INSERT INTO `sys_menu` VALUES (2092, '用户中心', 0, 8, 'user_center', NULL, NULL, 1, 0, 'M', '0', '0', '', 'user', 'admin', '2022-07-08 22:44:51', 'admin', '2022-07-08 22:46:16', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (10, '测试标题', '2', 0x3C703EE5958AE5AE9EE68993E5AE9EE79A843C2F703E, '0', 'admin', '2022-06-30 15:00:07', 'admin', '2022-06-30 15:39:08', NULL);
INSERT INTO `sys_notice` VALUES (11, '测试', '1', 0x3C7020636C6173733D22716C2D616C69676E2D63656E746572223E3C62723E3C2F703E3C7020636C6173733D22716C2D616C69676E2D63656E746572223E3C7374726F6E67207374796C653D22636F6C6F723A2072676228302C20302C2030293B223EE4BBA3E8A1A8E9989FE5908DE58D953C2F7374726F6E673E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE59BBDE99985E5ADA6E999A220266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703BE9A286E9989FEFBC9AE59095E99587E59DA420266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703BE69599E7BB83E59198EFBC9AE5BB96E5AEB6E6A08B20266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303120266E6273703BE5BB96E5AEB6E6A08B20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B323030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303220266E6273703BE696B9E7919E20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B323030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303320266E6273703BE69DA8E5928FE8BE8920266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B323030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303420266E6273703BE590B4E4BDB3E4BC9F20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303520266E6273703BE78E8BE5A682E6B69B20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303620266E6273703BE7A88BE4BF8AE8BE8920266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B383030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303720266E6273703BE69D8EE9928A20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B383030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303820266E6273703BE7BF81E69DB020266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031303920266E6273703BE98293E699A820266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B31353030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313020266E6273703BE99988E698A5E69E9720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B31353030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313120266E6273703BE7BD97E88892E5BAB720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B35303030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313220266E6273703BE9AB98E790AAE68DB720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B35303030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313320266E6273703BE69DA8E5A082E59DA420266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703BE794B7E5AD90E4BA94E4BABAE8B6B3E79083266E6273703B266E6273703BE8B7B3E9AB9820266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313420266E6273703BE6A281E581A5E7828020266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE8B7B3E9AB9820266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313520266E6273703BE5B7A2E5878CE587AF20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703BE4B889E7BAA7E8B7B3E8BF9C20266E6273703B266E6273703B266E6273703BE8B7B3E8BF9C20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313620266E6273703BE58898E4BF8AE69DB020266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE8B7B3E8BF9C20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313720266E6273703BE99988E88080E4B89C20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE4B889E7BAA7E8B7B3E8BF9C20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313820266E6273703BE88B8FE794B2E8AFBA20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE99385E7908320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031313920266E6273703BE58898E4BF8AE59F8E20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B383030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323020266E6273703BE9A9ACE6ACA3E699A820266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B31353030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333220266E6273703BE78E8BE9A9B020266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE794B7E5AD90E4B889E4BABAE7AFAEE79083E5898DE68A9BE5AE9EE5BF83E7908320266E6273703BE8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333320266E6273703BE5AD99E895B4E99FAC20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE794B7E5AD90E4B889E4BABAE7AFAEE79083E8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333420266E6273703BE58898E5B195E9B98F20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE794B7E5AD90E4B889E4BABAE7AFAEE79083E8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333520266E6273703BE99988E698B1E9BA9F20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE794B7E5AD90E4B889E4BABAE7AFAEE79083E8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333620266E6273703BE58898E8B4A4E8BEBE20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333720266E6273703BE8B5B5E5AEB6E6968C20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343420266E6273703BE98391E7B4ABE998B320266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE68EA8E5B08FE8BDA620266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343520266E6273703BE8AEB8E4BAA6E5B0A720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B3330E7B1B3E781ABE8BDA6E8B79120266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343620266E6273703BE69893E4BDB3E7A6BE20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE691B8E79FB3E5A4B4E8BF87E6B2B320266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343720266E6273703BE5B494E99BA8E6A18920266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE69C89E8BDA8E794B5E8BDA620266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343820266E6273703BE88296E4BABAE58D8720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE8A28BE9BCA0E8B7B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353020266E6273703BE9929FE5ADA6E6B69B20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE8838CE5A4B9E79083E68EA5E58A9B20266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353120266E6273703BE69E97E58B87E593B220266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B3330E7B1B3E9BE99E58DB7E9A38E20266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353220266E6273703BE58898E8BDA920266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE4B88DE58092E6A3AEE69E9720266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353620266E6273703BE590B4E6988A20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE781ABE7BABFE8BF90E98081E4BCA4E591983C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353720266E6273703BE7A7A6E59889E7929820266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE7BAA2E5869BE79A84E68981E68B8520266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353820266E6273703BE99988E6B5A9E6968C20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE58D95E58F8CE69187E8B7B3E7BBB320266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353920266E6273703BE89684E4B880E5A58720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703B3130E4BABAE995BFE7BBB3E99B86E4BD933C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031363320266E6273703BE9A9ACE5AE97E998B320266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE4B8ADE59BBDE8B1A1E6A38B20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031363720266E6273703BE590B4E6988A20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE99385E7908320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E093C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E3031363820266E6273703BE4BA8EE7BF94E8BF9C20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE794B720266E6273703B266E6273703B266E6273703BE8B7B3E8BF9C3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323120266E6273703BE5BE90E58D83E790B320266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323220266E6273703BE99988E5A595E6968720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323320266E6273703BE9A9ACE4B990E4B99020266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B383030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323420266E6273703BE69D8EE7B4ABE5A89F20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B323030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703BE8B7B3E8BF9C20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323520266E6273703BE58898E5A4A9E5AE8720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B323030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478313030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323620266E6273703BE69D8EE790B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B31353030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B383030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323720266E6273703BE58898E6809DE5BDA420266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B383030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE8B7B3E9AB9820266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323820266E6273703BE582A8E98791E5BBB720266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B31353030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3478343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031323920266E6273703BE8AEA1E6BD87E6A19020266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B31353030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333020266E6273703BE9BB84E8B68A20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE99385E7908320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333120266E6273703BE58285E4BDB3E8908C20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE99385E7908320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333820266E6273703BE6B19FE682A620266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE5A5B3E5AD90E4B889E4BABAE7AFAEE79083E8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031333920266E6273703BE99988E4B8BDE6B48120266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE5A5B3E5AD90E4B889E4BABAE7AFAEE79083E8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343020266E6273703BE7B4A2E58D97E99D92E69CA820266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE5A5B3E5AD90E4B889E4BABAE7AFAEE79083E8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343120266E6273703BE58DA2E8BFA6E5928F20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE5A5B3E5AD90E4B889E4BABAE7AFAEE79083E8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343220266E6273703BE88B8FE99BAFE580A920266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE8BF90E79083E4B88AE7AFAE20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343320266E6273703BE6A281E6A0A2E5B9B320266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE5908CE5BF83E9BC9320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031343920266E6273703BE88296E6958FE7BF8E20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE8B6B3E79083E5B8A6E79083E7BB95E69D863C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353420266E6273703BE591A8E4BDB3E6978B20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE8B6A3E591B3E8BDAEE6BB9120266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031353520266E6273703BE982B9E6B791E680A120266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE68B94E6B2B3E6AF94E8B59B20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031363020266E6273703BE4BAA2E4B880E5908D20266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE4BD93E8B4A8E581A5E5BAB7E6AF94E68BBC3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031363120266E6273703BE58898E5A595E6989520266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE59BA2E4BD93E6938D20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031363220266E6273703BE78E8BE5AD90E682A620266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE6B7B7E59088E6B094E68E92E79083E8B59B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031363420266E6273703BE58898E6B0B8E7BAA220266E6273703B266E6273703B266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703BE4B8ADE59BBDE59BB4E6A38B20266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A2072676228302C20302C2030293B223E266E6273703B3031363520266E6273703BE6ACA7E998B3E88AB7E5A68D20266E6273703BE5ADA6E7949F20266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703BE5A5B320266E6273703B266E6273703B266E6273703B323030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B343030E7B1B320266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B266E6273703B3C2F7370616E3E3C2F703E, '0', 'admin', '2022-07-13 17:17:34', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 367 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', NULL, '/system/notice/1', '127.0.0.1', '内网IP', '{noticeIds=1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-29 23:04:41');
INSERT INTO `sys_oper_log` VALUES (101, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', NULL, '/system/notice/2', '127.0.0.1', '内网IP', '{noticeIds=2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-29 23:04:44');
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'sport_registrations,sport_user,sport_fields,sport_games,sport_item,sport_nums,sport_comment,sport_colleges,sport_article,sport_adminlog', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 13:24:55');
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'sport_admin', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 13:25:14');
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/1', '127.0.0.1', '内网IP', '{tableIds=1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 13:25:45');
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/11', '127.0.0.1', '内网IP', '{tableIds=11}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 13:26:06');
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-30 13:26:48');
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"赛事管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"game\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:07:59');
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/registrations/index\",\"createTime\":\"2022-06-30 13:30:57\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"报名\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":3,\"path\":\"registrations\",\"perms\":\"system:registrations:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:08:39');
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"fields\",\"className\":\"SportFields\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":18,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnId\":19,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MaxPerson\",\"columnId\":20,\"columnName\":\"max_person\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"maxPerson\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ParentId\",\"columnId\":21,\"columnName\":\"parent_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"parentId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":4,\"superColumn\":true,\"tableId\":5,\"updateBy\":\"\",\"usa', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:14:27');
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"games\",\"className\":\"SportGames\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnId\":23,\"columnName\":\"item_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GameName\",\"columnId\":24,\"columnName\":\"game_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"NextGame\",\"columnId\":25,\"columnName\":\"next_game\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"nextGame\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":4,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:15:34');
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"item\",\"className\":\"SportItem\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增id\",\"columnId\":33,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ItemName\",\"columnComment\":\"项目名称\",\"columnId\":34,\"columnName\":\"item_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MaxPerson\",\"columnComment\":\"限制最多人数\",\"columnId\":35,\"columnName\":\"max_person\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"maxPerson\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Type\",\"columnComment\":\"项目类型（田赛、径赛、团体赛等）\",\"columnId\":36,\"columnName\":\"type\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"type\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"q', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:16:07');
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"nums\",\"className\":\"SportNums\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":39,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"IdNum\",\"columnId\":40,\"columnName\":\"id_num\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"idNum\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CollegeId\",\"columnId\":41,\"columnName\":\"college_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"collegeId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"号码段管理\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{\\\"parentMenuId\\\":2030}\",\"packageName\":\"com.ruoyi.system\",\"params\":{\"parentMenuId\":2030},\"parentMenuId\":\"2030\",\"sub\":false,\"tableComment\":\"号码段\",\"tableId\":8,\"tableName\":\"sport_nums\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:16:57');
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"registrations\",\"className\":\"SportRegistrations\",\"columns\":[{\"capJavaField\":\"Id\",\"columnId\":42,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"GameId\",\"columnId\":43,\"columnName\":\"game_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnId\":44,\"columnName\":\"user_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FieldId\",\"columnId\":45,\"columnName\":\"field_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fieldId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":4,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"u', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:18:24');
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-30 14:19:01');
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2006', '127.0.0.1', '内网IP', '{menuId=2006}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', 0, NULL, '2022-06-30 14:22:01');
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2007', '127.0.0.1', '内网IP', '{menuId=2007}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:09');
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2008', '127.0.0.1', '内网IP', '{menuId=2008}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:10');
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2009', '127.0.0.1', '内网IP', '{menuId=2009}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:12');
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2010', '127.0.0.1', '内网IP', '{menuId=2010}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:13');
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2011', '127.0.0.1', '内网IP', '{menuId=2011}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:15');
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2006', '127.0.0.1', '内网IP', '{menuId=2006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:17');
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2001', '127.0.0.1', '内网IP', '{menuId=2001}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:24');
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2002', '127.0.0.1', '内网IP', '{menuId=2002}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:26');
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2003', '127.0.0.1', '内网IP', '{menuId=2003}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:28');
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2004', '127.0.0.1', '内网IP', '{menuId=2004}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:29');
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2005', '127.0.0.1', '内网IP', '{menuId=2005}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:31');
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2000', '127.0.0.1', '内网IP', '{menuId=2000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:36');
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2013', '127.0.0.1', '内网IP', '{menuId=2013}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:40');
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2015', '127.0.0.1', '内网IP', '{menuId=2015}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:42');
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2016', '127.0.0.1', '内网IP', '{menuId=2016}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:44');
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2017', '127.0.0.1', '内网IP', '{menuId=2017}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:45');
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2014', '127.0.0.1', '内网IP', '{menuId=2014}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:47');
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2012', '127.0.0.1', '内网IP', '{menuId=2012}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:52');
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2019', '127.0.0.1', '内网IP', '{menuId=2019}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:55');
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2020', '127.0.0.1', '内网IP', '{menuId=2020}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:57');
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2021', '127.0.0.1', '内网IP', '{menuId=2021}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:22:59');
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2022', '127.0.0.1', '内网IP', '{menuId=2022}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:02');
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2023', '127.0.0.1', '内网IP', '{menuId=2023}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:04');
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2018', '127.0.0.1', '内网IP', '{menuId=2018}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:07');
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2025', '127.0.0.1', '内网IP', '{menuId=2025}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:11');
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2024', '127.0.0.1', '内网IP', '{menuId=2024}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', 0, NULL, '2022-06-30 14:23:13');
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2026', '127.0.0.1', '内网IP', '{menuId=2026}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:16');
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2027', '127.0.0.1', '内网IP', '{menuId=2027}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:17');
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2028', '127.0.0.1', '内网IP', '{menuId=2028}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:20');
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2029', '127.0.0.1', '内网IP', '{menuId=2029}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:21');
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2024', '127.0.0.1', '内网IP', '{menuId=2024}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:23:24');
INSERT INTO `sys_oper_log` VALUES (147, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"fields\",\"className\":\"SportFields\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":18,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isPk\":\"1\",\"isQuery\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:14:26\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"场地名\",\"columnId\":19,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:14:26\",\"usableColumn\":false},{\"capJavaField\":\"MaxPerson\",\"columnComment\":\"人数限制\",\"columnId\":20,\"columnName\":\"max_person\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"maxPerson\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:14:26\",\"usableColumn\":false},{\"capJavaField\":\"ParentId\",\"columnComment\":\"父级场地\",\"columnId\":21,\"columnName\":\"parent_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:29:02');
INSERT INTO `sys_oper_log` VALUES (148, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"games\",\"className\":\"SportGames\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:15:33\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnComment\":\"项目\",\"columnId\":23,\"columnName\":\"item_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:15:33\",\"usableColumn\":false},{\"capJavaField\":\"GameName\",\"columnComment\":\"比赛名\",\"columnId\":24,\"columnName\":\"game_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:15:33\",\"usableColumn\":false},{\"capJavaField\":\"NextGame\",\"columnComment\":\"决赛\",\"columnId\":25,\"columnName\":\"next_game\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:31:34');
INSERT INTO `sys_oper_log` VALUES (149, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-06-30 14:33:26');
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2061', '127.0.0.1', '内网IP', '{menuId=2061}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', 0, NULL, '2022-06-30 14:37:57');
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2066', '127.0.0.1', '内网IP', '{menuId=2066}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:01');
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2062', '127.0.0.1', '内网IP', '{menuId=2062}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:04');
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2063', '127.0.0.1', '内网IP', '{menuId=2063}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:07');
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2064', '127.0.0.1', '内网IP', '{menuId=2064}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:09');
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2065', '127.0.0.1', '内网IP', '{menuId=2065}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:11');
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2061', '127.0.0.1', '内网IP', '{menuId=2061}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:13');
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2067', '127.0.0.1', '内网IP', '{menuId=2067}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', 0, NULL, '2022-06-30 14:38:16');
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2068', '127.0.0.1', '内网IP', '{menuId=2068}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:20');
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2069', '127.0.0.1', '内网IP', '{menuId=2069}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:22');
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2070', '127.0.0.1', '内网IP', '{menuId=2070}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:23');
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2071', '127.0.0.1', '内网IP', '{menuId=2071}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:25');
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2067', '127.0.0.1', '内网IP', '{menuId=2067}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":500}', 0, NULL, '2022-06-30 14:38:26');
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2072', '127.0.0.1', '内网IP', '{menuId=2072}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:28');
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2067', '127.0.0.1', '内网IP', '{menuId=2067}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:38:29');
INSERT INTO `sys_oper_log` VALUES (165, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":69,\"maxPerson\":1,\"name\":\"跑道1\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 14:40:52');
INSERT INTO `sys_oper_log` VALUES (166, '比赛管理', 5, 'com.ruoyi.system.controller.SportGamesController.export()', 'POST', 1, 'admin', NULL, '/system/games/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-06-30 14:41:15');
INSERT INTO `sys_oper_log` VALUES (167, '通知公告', 1, 'com.ruoyi.web.controller.system.SysNoticeController.add()', 'POST', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"noticeContent\":\"<p>啊实打实的</p>\",\"noticeTitle\":\"测试标题\",\"noticeType\":\"1\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:00:07');
INSERT INTO `sys_oper_log` VALUES (168, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"games\",\"className\":\"SportGames\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:31:33\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnComment\":\"项目\",\"columnId\":23,\"columnName\":\"item_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:31:33\",\"usableColumn\":false},{\"capJavaField\":\"GameName\",\"columnComment\":\"比赛名\",\"columnId\":24,\"columnName\":\"game_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:31:33\",\"usableColumn\":false},{\"capJavaField\":\"NextGame\",\"columnComment\":\"决赛\",\"columnId\":25,\"columnName\":\"next_game\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:05:02');
INSERT INTO `sys_oper_log` VALUES (169, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"games\",\"className\":\"SportGames\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:05:02\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnComment\":\"项目\",\"columnId\":23,\"columnName\":\"item_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:05:02\",\"usableColumn\":false},{\"capJavaField\":\"GameName\",\"columnComment\":\"比赛名\",\"columnId\":24,\"columnName\":\"game_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:05:02\",\"usableColumn\":false},{\"capJavaField\":\"NextGame\",\"columnComment\":\"决赛\",\"columnId\":25,\"columnName\":\"next_game\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:10:30');
INSERT INTO `sys_oper_log` VALUES (170, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"比赛状态\",\"dictType\":\"sport_game_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:15:26');
INSERT INTO `sys_oper_log` VALUES (171, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-30 15:15:26\",\"dictId\":100,\"dictName\":\"比赛状态\",\"dictType\":\"sport_game_status\",\"params\":{},\"remark\":\"比赛状态列表\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:15:44');
INSERT INTO `sys_oper_log` VALUES (172, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"未开始\",\"dictSort\":0,\"dictType\":\"sport_game_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:16:25');
INSERT INTO `sys_oper_log` VALUES (173, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"检录中\",\"dictSort\":0,\"dictType\":\"sport_game_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:16:38');
INSERT INTO `sys_oper_log` VALUES (174, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"比赛中\",\"dictSort\":0,\"dictType\":\"sport_game_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:16:53');
INSERT INTO `sys_oper_log` VALUES (175, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"结束\",\"dictSort\":0,\"dictType\":\"sport_game_status\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:17:07');
INSERT INTO `sys_oper_log` VALUES (176, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"games\",\"className\":\"SportGames\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:10:29\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnComment\":\"项目\",\"columnId\":23,\"columnName\":\"item_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:10:30\",\"usableColumn\":false},{\"capJavaField\":\"GameName\",\"columnComment\":\"比赛名\",\"columnId\":24,\"columnName\":\"game_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:10:30\",\"usableColumn\":false},{\"capJavaField\":\"NextGame\",\"columnComment\":\"决赛\",\"columnId\":25,\"columnName\":\"next_game\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:17:39');
INSERT INTO `sys_oper_log` VALUES (177, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"games\",\"className\":\"SportGames\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:17:38\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnComment\":\"项目\",\"columnId\":23,\"columnName\":\"item_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:17:38\",\"usableColumn\":false},{\"capJavaField\":\"GameName\",\"columnComment\":\"比赛名\",\"columnId\":24,\"columnName\":\"game_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:17:38\",\"usableColumn\":false},{\"capJavaField\":\"NextGame\",\"columnComment\":\"决赛\",\"columnId\":25,\"columnName\":\"next_game\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:18:33');
INSERT INTO `sys_oper_log` VALUES (178, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:25\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:32:58');
INSERT INTO `sys_oper_log` VALUES (179, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:25\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2022-06-30 15:32:58\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:33:53');
INSERT INTO `sys_oper_log` VALUES (180, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:25\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2022-06-30 15:33:53\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:34:26');
INSERT INTO `sys_oper_log` VALUES (181, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', NULL, '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-30 15:00:07\",\"noticeContent\":\"<p>啊实打实的</p>\",\"noticeId\":10,\"noticeTitle\":\"测试标题\",\"noticeType\":\"2\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 15:39:08');
INSERT INTO `sys_oper_log` VALUES (182, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"registrations\",\"className\":\"SportRegistrations\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":42,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:18:23\",\"usableColumn\":false},{\"capJavaField\":\"GameId\",\"columnComment\":\"比赛\",\"columnId\":43,\"columnName\":\"game_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:18:23\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":44,\"columnName\":\"user_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:18:23\",\"usableColumn\":false},{\"capJavaField\":\"FieldId\",\"columnComment\":\"场地\",\"columnId\":45,\"columnName\":\"field_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 20:36:16');
INSERT INTO `sys_oper_log` VALUES (183, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"registrations\",\"className\":\"SportRegistrations\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":42,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 20:36:15\",\"usableColumn\":false},{\"capJavaField\":\"GameId\",\"columnComment\":\"比赛\",\"columnId\":43,\"columnName\":\"game_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 20:36:15\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":44,\"columnName\":\"user_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 20:36:15\",\"usableColumn\":false},{\"capJavaField\":\"FieldId\",\"columnComment\":\"场地\",\"columnId\":45,\"columnName\":\"field_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-06-30 20:39:41');
INSERT INTO `sys_oper_log` VALUES (184, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/2', '127.0.0.1', '内网IP', '{tableIds=2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:27:00');
INSERT INTO `sys_oper_log` VALUES (185, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/10', '127.0.0.1', '内网IP', '{tableIds=10}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:27:18');
INSERT INTO `sys_oper_log` VALUES (186, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/sport_registrations', '127.0.0.1', '内网IP', '{tableName=sport_registrations}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:27:46');
INSERT INTO `sys_oper_log` VALUES (187, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/9', '127.0.0.1', '内网IP', '{tableIds=9}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:29:11');
INSERT INTO `sys_oper_log` VALUES (188, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'sport_registrations', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:29:23');
INSERT INTO `sys_oper_log` VALUES (189, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"负责审核学院报名信息\",\"roleId\":100,\"roleKey\":\"monitor\",\"roleName\":\"学院管理员\",\"roleSort\":\"0\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:31:33');
INSERT INTO `sys_oper_log` VALUES (190, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"负责录入成绩\",\"roleId\":101,\"roleKey\":\"referee\",\"roleName\":\"裁判\",\"roleSort\":\"0\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:32:14');
INSERT INTO `sys_oper_log` VALUES (191, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":100,\"deptName\":\"学校\",\"email\":\"ry@qq.com\",\"leader\":\"左手\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"18359088114\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:32:43');
INSERT INTO `sys_oper_log` VALUES (192, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":101,\"deptName\":\"教工\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:33:09');
INSERT INTO `sys_oper_log` VALUES (193, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":102,\"deptName\":\"裁判\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:33:18');
INSERT INTO `sys_oper_log` VALUES (194, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":101,\"deptName\":\"学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:33:44');
INSERT INTO `sys_oper_log` VALUES (195, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":103,\"deptName\":\"体育学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:33:50');
INSERT INTO `sys_oper_log` VALUES (196, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":104,\"deptName\":\"会计学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:33:57');
INSERT INTO `sys_oper_log` VALUES (197, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":105,\"deptName\":\"财税学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:34:05');
INSERT INTO `sys_oper_log` VALUES (198, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":106,\"deptName\":\"信管学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":4,\"params\":{},\"parentId\":101,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:34:14');
INSERT INTO `sys_oper_log` VALUES (199, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":107,\"deptName\":\"VR学院\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":5,\"params\":{},\"parentId\":101,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:34:21');
INSERT INTO `sys_oper_log` VALUES (200, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":108,\"deptName\":\"记录组\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:34:35');
INSERT INTO `sys_oper_log` VALUES (201, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"deptId\":109,\"deptName\":\"编排组\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":102,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:34:45');
INSERT INTO `sys_oper_log` VALUES (202, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', NULL, '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"flag\":false,\"params\":{},\"postCode\":\"user\",\"postId\":4,\"postName\":\"普通用户\",\"postSort\":\"4\",\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:36:08');
INSERT INTO `sys_oper_log` VALUES (203, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/3', '127.0.0.1', '内网IP', '{tableIds=3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:37:58');
INSERT INTO `sys_oper_log` VALUES (204, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/sport_registrations', '127.0.0.1', '内网IP', '{tableName=sport_registrations}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:38:25');
INSERT INTO `sys_oper_log` VALUES (205, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/12', '127.0.0.1', '内网IP', '{tableIds=12}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:38:51');
INSERT INTO `sys_oper_log` VALUES (206, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', 'sport_registrations', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:39:00');
INSERT INTO `sys_oper_log` VALUES (207, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/sport_registrations', '127.0.0.1', '内网IP', '{tableName=sport_registrations}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:40:50');
INSERT INTO `sys_oper_log` VALUES (208, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/sport_registrations', '127.0.0.1', '内网IP', '{tableName=sport_registrations}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:42:14');
INSERT INTO `sys_oper_log` VALUES (209, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"registrations\",\"className\":\"SportRegistrations\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":71,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-01 22:42:13\",\"usableColumn\":false},{\"capJavaField\":\"GameId\",\"columnComment\":\"比赛\",\"columnId\":72,\"columnName\":\"game_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-01 22:42:13\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":73,\"columnName\":\"user_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-01 22:42:13\",\"usableColumn\":false},{\"capJavaField\":\"FieldId\",\"columnComment\":\"场地\",\"columnId\":74,\"columnName\":\"field_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:39:00\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fieldId\",\"javaType\":\"Long\",\"li', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:44:13');
INSERT INTO `sys_oper_log` VALUES (210, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-30 15:16:25\",\"dictCode\":100,\"dictLabel\":\"报名中\",\"dictSort\":0,\"dictType\":\"sport_game_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:51:11');
INSERT INTO `sys_oper_log` VALUES (211, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-30 15:16:38\",\"dictCode\":101,\"dictLabel\":\"准备中\",\"dictSort\":0,\"dictType\":\"sport_game_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:51:27');
INSERT INTO `sys_oper_log` VALUES (212, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"审核状态\",\"dictType\":\"sport_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:54:04');
INSERT INTO `sys_oper_log` VALUES (213, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"待审核\",\"dictSort\":0,\"dictType\":\"sport_status\",\"dictValue\":\"0\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:54:48');
INSERT INTO `sys_oper_log` VALUES (214, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"通过\",\"dictSort\":0,\"dictType\":\"sport_status\",\"dictValue\":\"1\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:55:04');
INSERT INTO `sys_oper_log` VALUES (215, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"未通过\",\"dictSort\":0,\"dictType\":\"sport_status\",\"dictValue\":\"-1\",\"listClass\":\"danger\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:55:23');
INSERT INTO `sys_oper_log` VALUES (216, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"项目类型\",\"dictType\":\"sport_item_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 22:57:31');
INSERT INTO `sys_oper_log` VALUES (217, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"田赛\",\"dictSort\":0,\"dictType\":\"sport_item_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:03:54');
INSERT INTO `sys_oper_log` VALUES (218, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"径赛\",\"dictSort\":0,\"dictType\":\"sport_item_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:04:02');
INSERT INTO `sys_oper_log` VALUES (219, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"团体赛\",\"dictSort\":0,\"dictType\":\"sport_item_type\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:04:14');
INSERT INTO `sys_oper_log` VALUES (220, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"item\",\"className\":\"SportItem\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增id\",\"columnId\":33,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:16:06\",\"usableColumn\":false},{\"capJavaField\":\"ItemName\",\"columnComment\":\"项目名称\",\"columnId\":34,\"columnName\":\"item_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:16:06\",\"usableColumn\":false},{\"capJavaField\":\"MaxPerson\",\"columnComment\":\"限制最多人数\",\"columnId\":35,\"columnName\":\"max_person\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"maxPerson\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 14:16:06\",\"usableColumn\":false},{\"capJavaField\":\"Type\",\"columnComment\":\"项目类型（田赛、径赛、团体赛等）\",\"columnId\":36,\"columnName\":\"type\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"sport_item_type\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInse', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:09:08');
INSERT INTO `sys_oper_log` VALUES (221, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', NULL, '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"排序方式\",\"dictType\":\"sport_sort_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:12:38');
INSERT INTO `sys_oper_log` VALUES (222, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"降序\",\"dictSort\":0,\"dictType\":\"sport_sort_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:12:55');
INSERT INTO `sys_oper_log` VALUES (223, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictLabel\":\"升序\",\"dictSort\":0,\"dictType\":\"sport_sort_type\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:14:22');
INSERT INTO `sys_oper_log` VALUES (224, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"item\",\"className\":\"SportItem\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"自增id\",\"columnId\":33,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2022-07-01 23:09:08\",\"usableColumn\":false},{\"capJavaField\":\"ItemName\",\"columnComment\":\"项目名称\",\"columnId\":34,\"columnName\":\"item_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2022-07-01 23:09:08\",\"usableColumn\":false},{\"capJavaField\":\"MaxPerson\",\"columnComment\":\"限制最多人数\",\"columnId\":35,\"columnName\":\"max_person\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"maxPerson\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2022-07-01 23:09:08\",\"usableColumn\":false},{\"capJavaField\":\"Type\",\"columnComment\":\"项目类型（田赛、径赛、团体赛等）\",\"columnId\":36,\"columnName\":\"type\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"sport_item_type\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInse', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:16:03');
INSERT INTO `sys_oper_log` VALUES (225, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":1,\"isDesc\":0,\"itemName\":\"100米\",\"maxPerson\":100,\"params\":{},\"type\":1,\"unit\":\"毫秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:17:43');
INSERT INTO `sys_oper_log` VALUES (226, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":3,\"isDesc\":1,\"itemName\":\"跳远\",\"maxPerson\":100,\"params\":{},\"type\":0,\"unit\":\"厘米\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:17:56');
INSERT INTO `sys_oper_log` VALUES (227, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":2,\"isDesc\":0,\"itemName\":\"跳高\",\"maxPerson\":100,\"params\":{},\"type\":0,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:18:03');
INSERT INTO `sys_oper_log` VALUES (228, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":3,\"isDesc\":1,\"itemName\":\"跳远\",\"maxPerson\":100,\"params\":{},\"type\":0,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:18:08');
INSERT INTO `sys_oper_log` VALUES (229, '场地管理', 2, 'com.ruoyi.system.controller.SportFieldsController.edit()', 'PUT', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":69,\"maxPerson\":1,\"name\":\"1\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:29');
INSERT INTO `sys_oper_log` VALUES (230, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":70,\"name\":\"2\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:33');
INSERT INTO `sys_oper_log` VALUES (231, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":71,\"name\":\"3\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:36');
INSERT INTO `sys_oper_log` VALUES (232, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":72,\"name\":\"4\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:41');
INSERT INTO `sys_oper_log` VALUES (233, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":73,\"name\":\"5\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:45');
INSERT INTO `sys_oper_log` VALUES (234, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":74,\"name\":\"6\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:48');
INSERT INTO `sys_oper_log` VALUES (235, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":75,\"name\":\"7\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:53');
INSERT INTO `sys_oper_log` VALUES (236, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":76,\"name\":\"8\",\"params\":{},\"parentId\":67}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:34:58');
INSERT INTO `sys_oper_log` VALUES (237, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":77,\"name\":\"篮球馆\",\"params\":{},\"parentId\":65}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:35:25');
INSERT INTO `sys_oper_log` VALUES (238, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":78,\"name\":\"1号\",\"params\":{},\"parentId\":77}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:35:40');
INSERT INTO `sys_oper_log` VALUES (239, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":79,\"name\":\"2号\",\"params\":{},\"parentId\":77}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:35:50');
INSERT INTO `sys_oper_log` VALUES (240, '场地管理', 1, 'com.ruoyi.system.controller.SportFieldsController.add()', 'POST', 1, 'admin', NULL, '/system/fields', '127.0.0.1', '内网IP', '{\"children\":[],\"id\":80,\"name\":\"3号\",\"params\":{},\"parentId\":77}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:35:56');
INSERT INTO `sys_oper_log` VALUES (241, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/sport_nums', '127.0.0.1', '内网IP', '{tableName=sport_nums}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:38:18');
INSERT INTO `sys_oper_log` VALUES (242, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"nums\",\"className\":\"SportNums\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":39,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateTime\":\"2022-07-01 23:38:17\",\"usableColumn\":false},{\"capJavaField\":\"IdNum\",\"columnComment\":\"号码\",\"columnId\":40,\"columnName\":\"id_num\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"idNum\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateTime\":\"2022-07-01 23:38:18\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":79,\"columnName\":\"user_id\",\"columnType\":\"int(11)\",\"createBy\":\"\",\"createTime\":\"2022-07-01 23:38:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"号码段管理\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{\\\"parentMenuId\\\":\\\"2030\\\"}\",\"packageName\":\"com.ruoyi.system\",\"params\":{\"parentMenuId\":\"2030\"},\"parentMenuId\":\"2030\",\"sub\":false,\"tableComment\":\"号码段\",\"tableId\":8,\"tableName\":\"sport_nums\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:42:50');
INSERT INTO `sys_oper_log` VALUES (243, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/nums/index\",\"createTime\":\"2022-06-30 14:21:17\",\"icon\":\"number\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2049,\"menuName\":\"号码段管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2030,\"path\":\"nums\",\"perms\":\"system:nums:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:46:35');
INSERT INTO `sys_oper_log` VALUES (244, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/registrations/index\",\"createTime\":\"2022-06-30 14:21:18\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2055,\"menuName\":\"报名管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2030,\"path\":\"registrations\",\"perms\":\"system:registrations:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:47:13');
INSERT INTO `sys_oper_log` VALUES (245, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/fields/index\",\"createTime\":\"2022-06-30 14:21:12\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"场地管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2030,\"path\":\"fields\",\"perms\":\"system:fields:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:48:01');
INSERT INTO `sys_oper_log` VALUES (246, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/fields/index\",\"createTime\":\"2022-06-30 14:21:12\",\"icon\":\"tree-table\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"场地管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2030,\"path\":\"fields\",\"perms\":\"system:fields:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:48:27');
INSERT INTO `sys_oper_log` VALUES (247, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/games/index\",\"createTime\":\"2022-06-30 14:21:14\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2037,\"menuName\":\"比赛管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2030,\"path\":\"games\",\"perms\":\"system:games:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:48:50');
INSERT INTO `sys_oper_log` VALUES (248, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-07-01 23:48:56');
INSERT INTO `sys_oper_log` VALUES (249, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-06-29 22:36:24\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:49:05');
INSERT INTO `sys_oper_log` VALUES (250, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":500}', 0, NULL, '2022-07-01 23:49:08');
INSERT INTO `sys_oper_log` VALUES (251, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/item/index\",\"createTime\":\"2022-06-30 14:21:15\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2043,\"menuName\":\"项目管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2030,\"path\":\"item\",\"perms\":\"system:item:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:50:33');
INSERT INTO `sys_oper_log` VALUES (252, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', NULL, '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"flag\":false,\"params\":{},\"postCode\":\"ceo\",\"postId\":1,\"postName\":\"管理员\",\"postSort\":\"1\",\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:53:59');
INSERT INTO `sys_oper_log` VALUES (253, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', NULL, '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"flag\":false,\"params\":{},\"postCode\":\"se\",\"postId\":2,\"postName\":\"运动员\",\"postSort\":\"2\",\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:54:15');
INSERT INTO `sys_oper_log` VALUES (254, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2022-07-01 22:31:32\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2030,2049,2050,2051,2052,2053,2054,2055,2056,2057,2058,2059,2060,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048],\"params\":{},\"remark\":\"负责审核学院报名信息\",\"roleId\":100,\"roleKey\":\"monitor\",\"roleName\":\"学院管理员\",\"roleSort\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:55:31');
INSERT INTO `sys_oper_log` VALUES (255, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2022-06-30 15:34:33\",\"delFlag\":\"0\",\"deptId\":108,\"email\":\"\",\"loginDate\":\"2022-06-30 15:34:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"gh\",\"params\":{},\"password\":\"\",\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[100],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"gh\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-01 23:56:11');
INSERT INTO `sys_oper_log` VALUES (256, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":1,\"isDesc\":0,\"itemName\":\"100米\",\"maxPerson\":100,\"params\":{},\"type\":2,\"unit\":\"毫秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 15:39:11');
INSERT INTO `sys_oper_log` VALUES (257, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":2,\"isDesc\":0,\"itemName\":\"跳高\",\"maxPerson\":100,\"params\":{},\"type\":1,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 15:39:18');
INSERT INTO `sys_oper_log` VALUES (258, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":3,\"isDesc\":1,\"itemName\":\"跳远\",\"maxPerson\":100,\"params\":{},\"type\":1,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 15:39:37');
INSERT INTO `sys_oper_log` VALUES (259, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"games\",\"className\":\"SportGames\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:18:32\",\"usableColumn\":false},{\"capJavaField\":\"ItemId\",\"columnComment\":\"项目\",\"columnId\":23,\"columnName\":\"item_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"itemId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:18:32\",\"usableColumn\":false},{\"capJavaField\":\"GameName\",\"columnComment\":\"比赛名\",\"columnId\":24,\"columnName\":\"game_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"updateTime\":\"2022-06-30 15:18:32\",\"usableColumn\":false},{\"capJavaField\":\"NextGame\",\"columnComment\":\"决赛\",\"columnId\":25,\"columnName\":\"next_game\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-06-30 13:24:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 15:51:13');
INSERT INTO `sys_oper_log` VALUES (260, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-07-05 15:55:30');
INSERT INTO `sys_oper_log` VALUES (261, '比赛管理', 2, 'com.ruoyi.system.controller.SportGamesController.edit()', 'PUT', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-05-15 13:48:30\",\"endTime\":\"2022-07-05 00:00:00\",\"fieldId\":65,\"gameName\":\"啊实打\",\"gender\":1,\"id\":20,\"itemId\":1,\"maxPerson\":999,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-07-05 00:00:00\",\"status\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 16:10:09');
INSERT INTO `sys_oper_log` VALUES (262, '比赛管理', 2, 'com.ruoyi.system.controller.SportGamesController.edit()', 'PUT', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-05-15 13:48:30\",\"endTime\":\"2022-07-05 00:00:00\",\"fieldId\":67,\"gameName\":\"\",\"gender\":1,\"id\":20,\"itemId\":1,\"maxPerson\":999,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-07-05 00:00:00\",\"status\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 22:29:42');
INSERT INTO `sys_oper_log` VALUES (263, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/sport_registrations', '127.0.0.1', '内网IP', '{tableName=sport_registrations}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 22:44:27');
INSERT INTO `sys_oper_log` VALUES (264, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"registrations\",\"className\":\"SportRegistrations\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":71,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-05 22:44:26\",\"usableColumn\":false},{\"capJavaField\":\"GameId\",\"columnComment\":\"比赛\",\"columnId\":72,\"columnName\":\"game_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-05 22:44:26\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":73,\"columnName\":\"user_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-05 22:44:26\",\"usableColumn\":false},{\"capJavaField\":\"FieldId\",\"columnComment\":\"场地\",\"columnId\":74,\"columnName\":\"field_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:39:00\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fieldId\",\"javaType\":\"Long\",\"li', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-05 22:47:25');
INSERT INTO `sys_oper_log` VALUES (265, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-07-05 22:47:43');
INSERT INTO `sys_oper_log` VALUES (266, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"registrations\",\"className\":\"SportRegistrations\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":71,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-05 22:47:24\",\"usableColumn\":false},{\"capJavaField\":\"GameId\",\"columnComment\":\"比赛\",\"columnId\":72,\"columnName\":\"game_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gameId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-05 22:47:24\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":73,\"columnName\":\"user_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:38:59\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":13,\"updateTime\":\"2022-07-05 22:47:24\",\"usableColumn\":false},{\"capJavaField\":\"FieldId\",\"columnComment\":\"场地\",\"columnId\":74,\"columnName\":\"field_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2022-07-01 22:39:00\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fieldId\",\"javaType\":\"Long\",\"li', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-06 12:25:55');
INSERT INTO `sys_oper_log` VALUES (267, '报名管理', 5, 'com.ruoyi.system.controller.SportRegistrationsController.export()', 'POST', 1, 'admin', NULL, '/system/registrations/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-06 15:11:08');
INSERT INTO `sys_oper_log` VALUES (268, '比赛管理', 5, 'com.ruoyi.system.controller.SportGamesController.export()', 'POST', 1, 'admin', NULL, '/system/games/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-06 15:11:47');
INSERT INTO `sys_oper_log` VALUES (269, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', NULL, '/tool/gen/synchDb/sport_nums', '127.0.0.1', '内网IP', '{tableName=sport_nums}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-06 15:21:59');
INSERT INTO `sys_oper_log` VALUES (270, '比赛管理', 5, 'com.ruoyi.system.controller.SportGamesController.export()', 'POST', 1, 'admin', NULL, '/system/games/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-06 15:24:39');
INSERT INTO `sys_oper_log` VALUES (271, '报名管理', 5, 'com.ruoyi.system.controller.SportRegistrationsController.export()', 'POST', 1, 'admin', NULL, '/system/registrations/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-06 15:30:43');
INSERT INTO `sys_oper_log` VALUES (272, '报名管理', 5, 'com.ruoyi.system.controller.SportRegistrationsController.export()', 'POST', 1, 'admin', NULL, '/system/registrations/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-06 15:30:58');
INSERT INTO `sys_oper_log` VALUES (273, '比赛管理', 5, 'com.ruoyi.system.controller.SportGamesController.export()', 'POST', 1, 'admin', NULL, '/system/games/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-06 15:33:24');
INSERT INTO `sys_oper_log` VALUES (274, '用户管理', 5, 'com.ruoyi.web.controller.system.SysUserController.export()', 'POST', 1, 'admin', NULL, '/system/user/export', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{\"dataScope\":\"\"}}', NULL, 0, NULL, '2022-07-06 17:09:15');
INSERT INTO `sys_oper_log` VALUES (275, '比赛管理', 5, 'com.ruoyi.system.controller.SportGamesController.export()', 'POST', 1, 'admin', NULL, '/system/games/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-07 22:41:40');
INSERT INTO `sys_oper_log` VALUES (276, '报名管理', 5, 'com.ruoyi.system.controller.SportRegistrationsController.export()', 'POST', 1, 'admin', NULL, '/system/registrations/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-07 22:42:35');
INSERT INTO `sys_oper_log` VALUES (277, '报名管理', 2, 'com.ruoyi.system.controller.SportRegistrationsController.edit()', 'PUT', 1, 'admin', NULL, '/system/registrations', '127.0.0.1', '内网IP', '{\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"game\":{\"endTime\":\"2022-07-05 00:00:00\",\"gameName\":\"\",\"gender\":1,\"id\":20,\"itemId\":1,\"params\":{},\"startTime\":\"2022-07-05 00:00:00\",\"status\":3},\"gameId\":20,\"id\":1,\"params\":{},\"status\":\"1\",\"updateTime\":\"2022-07-08T20:11:23.286+08:00\",\"user\":{\"admin\":false,\"avatar\":\"\",\"deptId\":108,\"email\":\"\",\"nickName\":\"gh\",\"params\":{},\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"1\",\"userId\":100,\"userName\":\"gh\"},\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 20:11:23');
INSERT INTO `sys_oper_log` VALUES (278, '报名管理', 2, 'com.ruoyi.system.controller.SportRegistrationsController.edit()', 'PUT', 1, 'admin', NULL, '/system/registrations', '127.0.0.1', '内网IP', '{\"comment\":\"asdasd\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"game\":{\"endTime\":\"2022-07-05 00:00:00\",\"gameName\":\"\",\"gender\":1,\"id\":20,\"itemId\":1,\"params\":{},\"startTime\":\"2022-07-05 00:00:00\",\"status\":3},\"gameId\":20,\"id\":1,\"params\":{},\"points\":100,\"score\":100,\"status\":\"1\",\"updateTime\":\"2022-07-08T20:12:31.426+08:00\",\"user\":{\"admin\":false,\"avatar\":\"\",\"deptId\":108,\"email\":\"\",\"nickName\":\"gh\",\"params\":{},\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"1\",\"userId\":100,\"userName\":\"gh\"},\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 20:12:31');
INSERT INTO `sys_oper_log` VALUES (279, '报名管理', 2, 'com.ruoyi.system.controller.SportRegistrationsController.edit()', 'PUT', 1, 'admin', NULL, '/system/registrations', '127.0.0.1', '内网IP', '{\"comment\":\"asdasd\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"game\":{\"endTime\":\"2022-07-05 00:00:00\",\"gameName\":\"\",\"gender\":1,\"id\":20,\"itemId\":1,\"params\":{},\"startTime\":\"2022-07-05 00:00:00\",\"status\":3},\"gameId\":20,\"id\":1,\"params\":{},\"points\":100,\"score\":100,\"status\":\"0\",\"updateTime\":\"2022-07-08T20:15:01.669+08:00\",\"user\":{\"admin\":false,\"avatar\":\"\",\"deptId\":108,\"email\":\"\",\"nickName\":\"gh\",\"params\":{},\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"1\",\"userId\":100,\"userName\":\"gh\"},\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 20:15:02');
INSERT INTO `sys_oper_log` VALUES (280, '报名管理', 2, 'com.ruoyi.system.controller.SportRegistrationsController.edit()', 'PUT', 1, 'admin', NULL, '/system/registrations', '127.0.0.1', '内网IP', '{\"comment\":\"asdasd\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"game\":{\"endTime\":\"2022-07-05 00:00:00\",\"gameName\":\"\",\"gender\":1,\"id\":20,\"itemId\":1,\"params\":{},\"startTime\":\"2022-07-05 00:00:00\",\"status\":3},\"gameId\":20,\"id\":1,\"params\":{},\"points\":100,\"score\":100,\"status\":\"1\",\"updateTime\":\"2022-07-08T20:15:12.429+08:00\",\"user\":{\"admin\":false,\"avatar\":\"\",\"deptId\":108,\"email\":\"\",\"nickName\":\"gh\",\"params\":{},\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"gh\"},\"userId\":100}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 20:15:13');
INSERT INTO `sys_oper_log` VALUES (281, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2022-06-30 15:34:33\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"记录组\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"status\":\"0\"},\"deptId\":108,\"email\":\"\",\"loginDate\":\"2022-07-02 12:54:27\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"王八犊子\",\"params\":{},\"password\":\"\",\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"monitor\",\"roleName\":\"学院管理员\",\"roleSort\":\"0\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"gh\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 20:27:11');
INSERT INTO `sys_oper_log` VALUES (282, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-08T21:20:29.827+08:00\",\"endTime\":\"2022-07-09 12:00:00\",\"fieldId\":67,\"gameName\":\"【男子】跳高(预赛)\",\"gender\":0,\"id\":23,\"itemId\":2,\"maxPerson\":10,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-07-08 09:20:23\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 21:20:30');
INSERT INTO `sys_oper_log` VALUES (283, '比赛管理', 2, 'com.ruoyi.system.controller.SportGamesController.edit()', 'PUT', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-08 21:20:30\",\"endTime\":\"2022-07-09 12:00:00\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"gameName\":\"【男子】跳高(决赛)\",\"gender\":0,\"id\":23,\"item\":{\"id\":2,\"isDesc\":0,\"itemName\":\"跳高\",\"maxPerson\":100,\"params\":{},\"type\":1,\"unit\":\"CM\"},\"itemId\":2,\"maxPerson\":10,\"nextGame\":0,\"params\":{},\"startTime\":\"2022-07-08 09:20:23\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 21:23:15');
INSERT INTO `sys_oper_log` VALUES (284, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-08T21:23:40.092+08:00\",\"endTime\":\"2022-07-21 12:00:00\",\"fieldId\":68,\"gameName\":\"【男子】100米(决赛)\",\"gender\":0,\"id\":24,\"itemId\":1,\"maxPerson\":8,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-07-08 09:23:33\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 21:23:40');
INSERT INTO `sys_oper_log` VALUES (285, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"用户报名\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:32:28');
INSERT INTO `sys_oper_log` VALUES (286, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:32:54');
INSERT INTO `sys_oper_log` VALUES (287, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:34:12');
INSERT INTO `sys_oper_log` VALUES (288, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:34:50');
INSERT INTO `sys_oper_log` VALUES (289, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"game_register\",\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:35:54');
INSERT INTO `sys_oper_log` VALUES (290, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"game_register\",\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:38:27');
INSERT INTO `sys_oper_log` VALUES (291, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"game_register\",\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:39:04');
INSERT INTO `sys_oper_log` VALUES (292, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"game_register\",\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:40:27');
INSERT INTO `sys_oper_log` VALUES (293, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"game_register\",\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:40:43');
INSERT INTO `sys_oper_log` VALUES (294, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"用户中心\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"game_register\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:44:51');
INSERT INTO `sys_oper_log` VALUES (295, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"game_register\",\"createTime\":\"2022-07-08 22:32:28\",\"icon\":\"edit\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2091,\"menuName\":\"用户报名\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2092,\"path\":\"game_register\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:45:02');
INSERT INTO `sys_oper_log` VALUES (296, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-07-08 22:44:51\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2092,\"menuName\":\"用户中心\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"user_center\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-08 22:46:16');
INSERT INTO `sys_oper_log` VALUES (297, '比赛管理', 3, 'com.ruoyi.system.controller.SportGamesController.remove()', 'DELETE', 1, 'admin', NULL, '/system/games/22', '127.0.0.1', '内网IP', '{ids=22}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-09 09:26:45');
INSERT INTO `sys_oper_log` VALUES (298, '比赛管理', 3, 'com.ruoyi.system.controller.SportGamesController.remove()', 'DELETE', 1, 'admin', NULL, '/system/games/20', '127.0.0.1', '内网IP', '{ids=20}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-09 09:26:49');
INSERT INTO `sys_oper_log` VALUES (299, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2022-06-30 15:34:33\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"记录组\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"loginDate\":\"2022-07-09 09:47:55\",\"loginIp\":\"192.168.31.242\",\"nickName\":\"王八犊子\",\"params\":{},\"password\":\"\",\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"monitor\",\"roleName\":\"学院管理员\",\"roleSort\":\"0\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"gh\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-09 09:48:54');
INSERT INTO `sys_oper_log` VALUES (300, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2022-06-29 22:36:24\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2092,2091],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"2\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-09 09:49:47');
INSERT INTO `sys_oper_log` VALUES (301, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2022-06-30 15:34:33\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"体育学院\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"loginDate\":\"2022-07-09 09:47:55\",\"loginIp\":\"192.168.31.242\",\"nickName\":\"王八犊子\",\"params\":{},\"password\":\"\",\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[100,2],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"monitor\",\"roleName\":\"学院管理员\",\"roleSort\":\"0\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"gh\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-09 09:50:16');
INSERT INTO `sys_oper_log` VALUES (302, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2022-06-30 15:34:33\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"体育学院\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"\",\"loginDate\":\"2022-07-09 09:47:55\",\"loginIp\":\"192.168.31.242\",\"nickName\":\"王八犊子\",\"params\":{},\"password\":\"\",\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"2\",\"status\":\"0\"},{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"monitor\",\"roleName\":\"学院管理员\",\"roleSort\":\"0\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"gh\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-09 09:50:27');
INSERT INTO `sys_oper_log` VALUES (303, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'gh', NULL, '/system/user/profile/avatar', '192.168.31.242', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2022/07/09/blob_20220709095144A001.jpeg\",\"code\":200}', 0, NULL, '2022-07-09 09:51:44');
INSERT INTO `sys_oper_log` VALUES (304, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', NULL, '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2022-06-29 22:36:24\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[100,101,103,104,105,106,107],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":\"2\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-09 10:08:20');
INSERT INTO `sys_oper_log` VALUES (305, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":4,\"isDesc\":0,\"itemName\":\"200米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"毫秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:48:58');
INSERT INTO `sys_oper_log` VALUES (306, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":5,\"isDesc\":0,\"itemName\":\"400米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"毫秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:49:25');
INSERT INTO `sys_oper_log` VALUES (307, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":6,\"isDesc\":0,\"itemName\":\"800米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"毫秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:49:45');
INSERT INTO `sys_oper_log` VALUES (308, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":7,\"isDesc\":0,\"itemName\":\"1500米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:50:24');
INSERT INTO `sys_oper_log` VALUES (309, '项目管理', 2, 'com.ruoyi.system.controller.SportItemController.edit()', 'PUT', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":6,\"isDesc\":0,\"itemName\":\"800米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:50:36');
INSERT INTO `sys_oper_log` VALUES (310, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":8,\"isDesc\":0,\"itemName\":\"3000米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:50:58');
INSERT INTO `sys_oper_log` VALUES (311, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":9,\"isDesc\":0,\"itemName\":\"3000米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:51:23');
INSERT INTO `sys_oper_log` VALUES (312, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":10,\"isDesc\":0,\"itemName\":\"5000米\",\"maxPerson\":9999,\"params\":{},\"type\":2,\"unit\":\"秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:53:26');
INSERT INTO `sys_oper_log` VALUES (313, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":11,\"isDesc\":0,\"itemName\":\"4×100\",\"maxPerson\":999,\"params\":{},\"type\":3,\"unit\":\"毫秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:54:08');
INSERT INTO `sys_oper_log` VALUES (314, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":12,\"isDesc\":0,\"itemName\":\"4×400\",\"maxPerson\":999,\"params\":{},\"type\":3,\"unit\":\"秒\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:54:30');
INSERT INTO `sys_oper_log` VALUES (315, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":13,\"isDesc\":1,\"itemName\":\"跳高\",\"maxPerson\":9999,\"params\":{},\"type\":1,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:54:56');
INSERT INTO `sys_oper_log` VALUES (316, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":14,\"isDesc\":1,\"itemName\":\"跳远\",\"maxPerson\":999,\"params\":{},\"type\":1,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:55:14');
INSERT INTO `sys_oper_log` VALUES (317, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":15,\"isDesc\":1,\"itemName\":\"三级跳远\",\"maxPerson\":9999,\"params\":{},\"type\":1,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:55:34');
INSERT INTO `sys_oper_log` VALUES (318, '项目管理', 1, 'com.ruoyi.system.controller.SportItemController.add()', 'POST', 1, 'admin', NULL, '/system/item', '127.0.0.1', '内网IP', '{\"id\":16,\"isDesc\":1,\"itemName\":\"铅球\",\"maxPerson\":9999,\"params\":{},\"type\":1,\"unit\":\"CM\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 15:55:51');
INSERT INTO `sys_oper_log` VALUES (319, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T16:01:32.976+08:00\",\"endTime\":\"2022-07-28 12:00:00\",\"fieldId\":67,\"gameName\":\"【女子】100米(决赛)\",\"gender\":1,\"id\":25,\"itemId\":1,\"maxPerson\":50,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-07-11 12:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 16:01:31');
INSERT INTO `sys_oper_log` VALUES (320, '比赛管理', 2, 'com.ruoyi.system.controller.SportGamesController.edit()', 'PUT', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11 16:01:33\",\"endTime\":\"2022-07-28 12:00:00\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"gameName\":\"【女子】100米(决赛)\",\"gender\":1,\"id\":25,\"item\":{\"id\":1,\"isDesc\":0,\"itemName\":\"100米\",\"maxPerson\":100,\"params\":{},\"type\":2,\"unit\":\"毫秒\"},\"itemId\":1,\"maxPerson\":50,\"nextGame\":0,\"params\":{},\"startTime\":\"2022-07-11 12:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 16:01:42');
INSERT INTO `sys_oper_log` VALUES (321, '比赛管理', 2, 'com.ruoyi.system.controller.SportGamesController.edit()', 'PUT', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11 16:01:33\",\"endTime\":\"2022-07-28 12:00:00\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"gameName\":\"【女子】100米(决赛)\",\"gender\":1,\"id\":25,\"item\":{\"id\":1,\"isDesc\":0,\"itemName\":\"100米\",\"maxPerson\":100,\"params\":{},\"type\":2,\"unit\":\"毫秒\"},\"itemId\":1,\"maxPerson\":50,\"nextGame\":1,\"params\":{},\"startTime\":\"2022-07-11 12:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 16:01:49');
INSERT INTO `sys_oper_log` VALUES (322, '比赛管理', 2, 'com.ruoyi.system.controller.SportGamesController.edit()', 'PUT', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11 16:01:33\",\"endTime\":\"2022-07-28 12:00:00\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"gameName\":\"\",\"gender\":1,\"id\":25,\"item\":{\"id\":1,\"isDesc\":0,\"itemName\":\"100米\",\"maxPerson\":100,\"params\":{},\"type\":2,\"unit\":\"毫秒\"},\"itemId\":1,\"maxPerson\":50,\"nextGame\":1,\"params\":{},\"startTime\":\"2022-07-11 12:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 16:01:56');
INSERT INTO `sys_oper_log` VALUES (323, '比赛管理', 3, 'com.ruoyi.system.controller.SportGamesController.remove()', 'DELETE', 1, 'admin', NULL, '/system/games/25', '127.0.0.1', '内网IP', '{ids=25}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 16:02:00');
INSERT INTO `sys_oper_log` VALUES (324, '比赛管理', 3, 'com.ruoyi.system.controller.SportGamesController.remove()', 'DELETE', 1, 'admin', NULL, '/system/games/24', '127.0.0.1', '内网IP', '{ids=24}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 16:02:04');
INSERT INTO `sys_oper_log` VALUES (325, '比赛管理', 3, 'com.ruoyi.system.controller.SportGamesController.remove()', 'DELETE', 1, 'admin', NULL, '/system/games/23', '127.0.0.1', '内网IP', '{ids=23}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 16:02:07');
INSERT INTO `sys_oper_log` VALUES (326, '报名管理', 3, 'com.ruoyi.system.controller.SportRegistrationsController.remove()', 'DELETE', 1, 'admin', NULL, '/system/registrations/1', '127.0.0.1', '内网IP', '{ids=1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 17:24:54');
INSERT INTO `sys_oper_log` VALUES (327, '比赛管理', 5, 'com.ruoyi.system.controller.SportGamesController.export()', 'POST', 1, 'admin', NULL, '/system/games/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2022-07-11 17:25:05');
INSERT INTO `sys_oper_log` VALUES (328, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T19:44:55.917+08:00\",\"fieldId\":67,\"gameName\":\"【女子】1500米(决赛)\",\"gender\":1,\"id\":26,\"itemId\":7,\"maxPerson\":50,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-14 12:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 19:44:54');
INSERT INTO `sys_oper_log` VALUES (329, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T19:47:24.002+08:00\",\"fieldId\":67,\"gameName\":\"【男子】1500米(决赛)\",\"gender\":0,\"id\":27,\"itemId\":7,\"maxPerson\":50,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-14 03:14:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 19:47:22');
INSERT INTO `sys_oper_log` VALUES (330, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:11:21.352+08:00\",\"fieldId\":67,\"gameName\":\"【女子】3000米(决赛)\",\"gender\":1,\"id\":30,\"itemId\":9,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-15 10:38:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:11:20');
INSERT INTO `sys_oper_log` VALUES (331, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:19:35.811+08:00\",\"fieldId\":67,\"gameName\":\"【男子】5000米(决赛)\",\"gender\":0,\"id\":31,\"itemId\":10,\"maxPerson\":50,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-16 14:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:19:33');
INSERT INTO `sys_oper_log` VALUES (332, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:20:59.099+08:00\",\"fieldId\":81,\"gameName\":\"【男子】三级跳远(决赛)\",\"gender\":0,\"id\":32,\"itemId\":15,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-14 10:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:20:57');
INSERT INTO `sys_oper_log` VALUES (333, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:24:10.721+08:00\",\"fieldId\":68,\"gameName\":\"【女子】跳高(决赛)\",\"gender\":1,\"id\":33,\"itemId\":13,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-14 10:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:24:08');
INSERT INTO `sys_oper_log` VALUES (334, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:29:38.143+08:00\",\"fieldId\":82,\"gameName\":\"【女子】铅球(决赛)\",\"gender\":1,\"id\":34,\"itemId\":16,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-14 14:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:29:36');
INSERT INTO `sys_oper_log` VALUES (335, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:31:10.649+08:00\",\"fieldId\":81,\"gameName\":\"【女子】跳远(决赛)\",\"gender\":1,\"id\":35,\"itemId\":14,\"maxPerson\":50,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-14 14:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:31:09');
INSERT INTO `sys_oper_log` VALUES (336, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:31:58.876+08:00\",\"fieldId\":68,\"gameName\":\"【男子】跳高(决赛)\",\"gender\":0,\"id\":36,\"itemId\":13,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-15 14:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:31:57');
INSERT INTO `sys_oper_log` VALUES (337, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:33:06.047+08:00\",\"fieldId\":81,\"gameName\":\"【男子】跳远(决赛)\",\"gender\":0,\"id\":37,\"itemId\":14,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-15 08:30:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:33:04');
INSERT INTO `sys_oper_log` VALUES (338, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:34:21.481+08:00\",\"fieldId\":82,\"gameName\":\"【男子】铅球(决赛)\",\"gender\":0,\"id\":38,\"itemId\":16,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-14 14:00:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:34:19');
INSERT INTO `sys_oper_log` VALUES (339, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T20:37:42.279+08:00\",\"fieldId\":67,\"gameName\":\"【女子】400米(决赛)\",\"gender\":1,\"id\":39,\"itemId\":5,\"maxPerson\":40,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-15 08:30:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 20:37:40');
INSERT INTO `sys_oper_log` VALUES (340, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T21:34:58.036+08:00\",\"fieldId\":67,\"gameName\":\"【男子】400米(决赛)\",\"gender\":0,\"id\":40,\"itemId\":5,\"maxPerson\":50,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-15 08:30:03\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 21:34:56');
INSERT INTO `sys_oper_log` VALUES (341, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T21:40:50.112+08:00\",\"fieldId\":67,\"gameName\":\"【男子】3000米(决赛)\",\"gender\":0,\"id\":41,\"itemId\":8,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"startTime\":\"2022-10-15 10:38:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 21:40:48');
INSERT INTO `sys_oper_log` VALUES (342, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T21:51:35.003+08:00\",\"fieldId\":67,\"gameName\":\"【女子】100米(决赛)\",\"gender\":1,\"id\":42,\"itemId\":1,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 21:51:33');
INSERT INTO `sys_oper_log` VALUES (343, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T21:55:36.128+08:00\",\"fieldId\":67,\"gameName\":\"【女子】200米(决赛)\",\"gender\":1,\"id\":43,\"itemId\":4,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 21:55:34');
INSERT INTO `sys_oper_log` VALUES (344, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:00:56.262+08:00\",\"fieldId\":67,\"gameName\":\"【女子】800米(决赛)\",\"gender\":1,\"id\":44,\"itemId\":6,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:00:54');
INSERT INTO `sys_oper_log` VALUES (345, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:01:55.045+08:00\",\"fieldId\":67,\"gameName\":\"【男子】100米(决赛)\",\"gender\":0,\"id\":45,\"itemId\":1,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:01:53');
INSERT INTO `sys_oper_log` VALUES (346, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:02:05.676+08:00\",\"fieldId\":67,\"gameName\":\"【男子】200米(决赛)\",\"gender\":0,\"id\":46,\"itemId\":4,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:02:03');
INSERT INTO `sys_oper_log` VALUES (347, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:02:21.157+08:00\",\"fieldId\":67,\"gameName\":\"【男子】800米(决赛)\",\"gender\":0,\"id\":47,\"itemId\":6,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:02:19');
INSERT INTO `sys_oper_log` VALUES (348, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:07:37.104+08:00\",\"fieldId\":67,\"gameName\":\"【女子】1500米(预赛)\",\"gender\":1,\"id\":48,\"itemId\":7,\"maxPerson\":0,\"nextGame\":26,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:07:35');
INSERT INTO `sys_oper_log` VALUES (349, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:07:50.779+08:00\",\"fieldId\":67,\"gameName\":\"【男子】1500米(预赛)\",\"gender\":0,\"id\":49,\"itemId\":7,\"maxPerson\":0,\"nextGame\":27,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:07:48');
INSERT INTO `sys_oper_log` VALUES (350, '项目管理', 3, 'com.ruoyi.system.controller.SportItemController.remove()', 'DELETE', 1, 'admin', NULL, '/system/item/9', '127.0.0.1', '内网IP', '{ids=9}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:08:21');
INSERT INTO `sys_oper_log` VALUES (351, '比赛管理', 2, 'com.ruoyi.system.controller.SportGamesController.edit()', 'PUT', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11 20:11:21\",\"field\":{\"children\":[],\"id\":67,\"name\":\"【不可删除】麦庐校区--麦庐田径场\",\"params\":{},\"parentId\":65},\"fieldId\":67,\"gameName\":\"【女子】3000米(决赛)\",\"gender\":1,\"id\":30,\"itemId\":8,\"maxPerson\":30,\"nextGame\":0,\"params\":{},\"startTime\":\"2022-10-15 10:38:00\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:09:18');
INSERT INTO `sys_oper_log` VALUES (352, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:10:19.525+08:00\",\"fieldId\":67,\"gameName\":\"【女子】3000米(预赛)\",\"gender\":1,\"id\":50,\"itemId\":8,\"maxPerson\":0,\"nextGame\":30,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:10:17');
INSERT INTO `sys_oper_log` VALUES (353, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:10:30.896+08:00\",\"fieldId\":67,\"gameName\":\"【男子】5000米(预赛)\",\"gender\":0,\"id\":51,\"itemId\":10,\"maxPerson\":0,\"nextGame\":31,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:10:29');
INSERT INTO `sys_oper_log` VALUES (354, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:11:00.998+08:00\",\"fieldId\":67,\"gameName\":\"【女子】400米(预赛)\",\"gender\":1,\"id\":52,\"itemId\":5,\"maxPerson\":0,\"nextGame\":39,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:10:59');
INSERT INTO `sys_oper_log` VALUES (355, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:11:15.649+08:00\",\"fieldId\":67,\"gameName\":\"【男子】400米(预赛)\",\"gender\":0,\"id\":53,\"itemId\":5,\"maxPerson\":0,\"nextGame\":40,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:11:13');
INSERT INTO `sys_oper_log` VALUES (356, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"fieldId\":67,\"itemId\":8,\"maxPerson\":0,\"nextGame\":41,\"params\":{},\"sportItemList\":[],\"status\":0}', NULL, 1, 'Cannot invoke \"java.lang.Integer.equals(Object)\" because the return value of \"com.ruoyi.system.domain.SportGames.getGender()\" is null', '2022-07-11 22:11:35');
INSERT INTO `sys_oper_log` VALUES (357, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:11:43.468+08:00\",\"fieldId\":67,\"gameName\":\"【男子】3000米(预赛)\",\"gender\":0,\"id\":54,\"itemId\":8,\"maxPerson\":0,\"nextGame\":41,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:11:41');
INSERT INTO `sys_oper_log` VALUES (358, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:11:59.16+08:00\",\"fieldId\":67,\"gameName\":\"【女子】100米(预赛)\",\"gender\":1,\"id\":55,\"itemId\":1,\"maxPerson\":0,\"nextGame\":42,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:11:57');
INSERT INTO `sys_oper_log` VALUES (359, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:25\",\"cssClass\":\"\",\"dictCode\":3,\"dictLabel\":\"不限\",\"dictSort\":3,\"dictType\":\"sys_user_sex\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"\",\"params\":{},\"remark\":\"性别未知\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:37:41');
INSERT INTO `sys_oper_log` VALUES (360, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', NULL, '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:25\",\"cssClass\":\"\",\"dictCode\":3,\"dictLabel\":\"未知\",\"dictSort\":3,\"dictType\":\"sys_user_sex\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"\",\"params\":{},\"remark\":\"性别未知\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:38:08');
INSERT INTO `sys_oper_log` VALUES (361, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:39:43.165+08:00\",\"fieldId\":67,\"gameName\":\"【男子】4×100(决赛)\",\"gender\":0,\"id\":56,\"itemId\":11,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:39:41');
INSERT INTO `sys_oper_log` VALUES (362, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:40:00.02+08:00\",\"fieldId\":67,\"gameName\":\"【女子】4×400(决赛)\",\"gender\":1,\"id\":57,\"itemId\":12,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:39:58');
INSERT INTO `sys_oper_log` VALUES (363, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:47:31.384+08:00\",\"fieldId\":67,\"gameName\":\"【男子】4×400(决赛)\",\"gender\":0,\"id\":58,\"itemId\":12,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:47:29');
INSERT INTO `sys_oper_log` VALUES (364, '比赛管理', 1, 'com.ruoyi.system.controller.SportGamesController.add()', 'POST', 1, 'admin', NULL, '/system/games', '127.0.0.1', '内网IP', '{\"createTime\":\"2022-07-11T22:48:20.851+08:00\",\"fieldId\":67,\"gameName\":\"【女子】4×100(决赛)\",\"gender\":1,\"id\":59,\"itemId\":11,\"maxPerson\":0,\"nextGame\":0,\"params\":{},\"sportItemList\":[],\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-11 22:48:18');
INSERT INTO `sys_oper_log` VALUES (365, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":true,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2022-06-29 22:36:24\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"体育学院\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"ry@163.com\",\"loginDate\":\"2022-07-13 13:52:29\",\"loginIp\":\"110.90.126.242\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-13 15:19:07');
INSERT INTO `sys_oper_log` VALUES (366, '通知公告', 1, 'com.ruoyi.web.controller.system.SysNoticeController.add()', 'POST', 1, 'admin', NULL, '/system/notice', '110.90.126.242', 'XX XX', '{\"createBy\":\"admin\",\"noticeContent\":\"<p class=\\\"ql-align-center\\\"><br></p><p class=\\\"ql-align-center\\\"><strong style=\\\"color: rgb(0, 0, 0);\\\">代表队名单</strong></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;国际学院 &nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;领队：吕镇坤 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;教练员：廖家栋 &nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;0101 &nbsp;廖家栋 &nbsp;&nbsp;&nbsp;学生 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;男 &nbsp;&nbsp;&nbsp;100米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;200米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4x100米 &nbsp;&nbsp;&nbsp;&nbsp;4x400米 &nbsp;&nbsp;&nbsp;&nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;0102 &nbsp;方瑞 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学生 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;男 &nbsp;&nbsp;&nbsp;100米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;200米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4x100米 &nbsp;&nbsp;&nbsp;&nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;0103 &nbsp;杨咏辉 &nbsp;&nbsp;&nbsp;学生 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;男 &nbsp;&nbsp;&nbsp;100米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;200米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4x100米 &nbsp;&nbsp;&nbsp;&nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;0104 &nbsp;吴佳伟 &nbsp;&nbsp;&nbsp;学生 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;男 &nbsp;&nbsp;&nbsp;400米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4x100米 &nbsp;&nbsp;&nbsp;&nbsp;4x400米 &nbsp;&nbsp;&nbsp;&nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0);\\\">&nbsp;0105 &nbsp;王如涛 &nbsp;&nbsp;&nbsp;学生 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;男 &nbsp;&nbsp;&nbsp;400米 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4x400米 &nbsp;&nbsp;&nbsp;&nbsp;</span></p><p><span style=\\\"color: rgb(0, 0, 0)', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-07-13 17:17:35');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '管理员', 1, '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 23:53:59', '');
INSERT INTO `sys_post` VALUES (2, 'se', '运动员', 2, '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 23:54:15', '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-06-29 22:36:24', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通用户', 4, '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-01 22:36:08', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-06-29 22:36:24', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-06-29 22:36:24', 'admin', '2022-07-09 10:08:19', '普通角色');
INSERT INTO `sys_role` VALUES (100, '学院管理员', 'monitor', 0, '1', 1, 1, '0', '0', 'admin', '2022-07-01 22:31:32', 'admin', '2022-07-01 23:55:31', '负责审核学院报名信息');
INSERT INTO `sys_role` VALUES (101, '裁判', 'referee', 0, '1', 1, 1, '0', '0', 'admin', '2022-07-01 22:32:14', '', NULL, '负责录入成绩');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 103);
INSERT INTO `sys_role_dept` VALUES (2, 104);
INSERT INTO `sys_role_dept` VALUES (2, 105);
INSERT INTO `sys_role_dept` VALUES (2, 106);
INSERT INTO `sys_role_dept` VALUES (2, 107);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 2091);
INSERT INTO `sys_role_menu` VALUES (2, 2092);
INSERT INTO `sys_role_menu` VALUES (100, 2030);
INSERT INTO `sys_role_menu` VALUES (100, 2031);
INSERT INTO `sys_role_menu` VALUES (100, 2032);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (100, 2034);
INSERT INTO `sys_role_menu` VALUES (100, 2035);
INSERT INTO `sys_role_menu` VALUES (100, 2036);
INSERT INTO `sys_role_menu` VALUES (100, 2037);
INSERT INTO `sys_role_menu` VALUES (100, 2038);
INSERT INTO `sys_role_menu` VALUES (100, 2039);
INSERT INTO `sys_role_menu` VALUES (100, 2040);
INSERT INTO `sys_role_menu` VALUES (100, 2041);
INSERT INTO `sys_role_menu` VALUES (100, 2042);
INSERT INTO `sys_role_menu` VALUES (100, 2043);
INSERT INTO `sys_role_menu` VALUES (100, 2044);
INSERT INTO `sys_role_menu` VALUES (100, 2045);
INSERT INTO `sys_role_menu` VALUES (100, 2046);
INSERT INTO `sys_role_menu` VALUES (100, 2047);
INSERT INTO `sys_role_menu` VALUES (100, 2048);
INSERT INTO `sys_role_menu` VALUES (100, 2049);
INSERT INTO `sys_role_menu` VALUES (100, 2050);
INSERT INTO `sys_role_menu` VALUES (100, 2051);
INSERT INTO `sys_role_menu` VALUES (100, 2052);
INSERT INTO `sys_role_menu` VALUES (100, 2053);
INSERT INTO `sys_role_menu` VALUES (100, 2054);
INSERT INTO `sys_role_menu` VALUES (100, 2055);
INSERT INTO `sys_role_menu` VALUES (100, 2056);
INSERT INTO `sys_role_menu` VALUES (100, 2057);
INSERT INTO `sys_role_menu` VALUES (100, 2058);
INSERT INTO `sys_role_menu` VALUES (100, 2059);
INSERT INTO `sys_role_menu` VALUES (100, 2060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '218.66.73.90', '2022-07-13 21:36:53', 'admin', '2022-06-29 22:36:24', '', '2022-07-13 21:36:53', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-06-29 22:36:24', 'admin', '2022-06-29 22:36:24', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 103, 'gh', '王八犊子', '00', '', '', '0', '/profile/avatar/2022/07/09/blob_20220709095144A001.jpeg', '$2a$10$ooZYY9XaSknb0he9EYjcJ.fESc4lIdtIXQhPY8a2ddRmtOkgmuddW', '0', '0', '192.168.31.242', '2022-07-09 09:47:55', '', '2022-06-30 15:34:33', 'admin', '2022-07-09 09:50:27', NULL);
INSERT INTO `sys_user` VALUES (101, NULL, 'zgx949', 'zgx949', '00', '', '', '0', '', '$2a$10$awjdOgXBYKmrW32X0Uqes.m6pB3o4JOC0Gy/SqPvErSVDIPTXf0/m', '0', '0', '127.0.0.1', '2022-07-09 10:07:18', '', '2022-07-09 10:06:51', '', '2022-07-09 10:07:18', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);

SET FOREIGN_KEY_CHECKS = 1;
