/*
Navicat MySQL Data Transfer

Source Server         : 132.246.27.29
Source Server Version : 50718
Source Host           : 132.246.27.29:20000
Source Database       : docker_admin

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-02-07 16:53:38
*/

CREATE DATABASE IF NOT EXISTS docker_admin DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

use docker_admin;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for docker_app
-- ----------------------------
DROP TABLE IF EXISTS `docker_app`;
CREATE TABLE `docker_app` (
  `app_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '应用id',
  `app_name` varchar(100) NOT NULL COMMENT '应用名称',
  `app_desc` varchar(250) DEFAULT NULL COMMENT '概述',
  `cluster_id` int(11) NOT NULL COMMENT 'k8s集群id',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of docker_app
-- ----------------------------

-- ----------------------------
-- Table structure for docker_autoscale_policy
-- ----------------------------
DROP TABLE IF EXISTS `docker_autoscale_policy`;
CREATE TABLE `docker_autoscale_policy` (
  `autoscale_policy_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` int(11) NOT NULL COMMENT '对应服务id',
  `elastic_indicator` varchar(3) DEFAULT NULL COMMENT '指标',
  `min_pod_num` int(11) DEFAULT NULL COMMENT '最小容器数',
  `max_pod_num` int(11) DEFAULT NULL COMMENT '最大容器数',
  `cpu_threshold` int(11) DEFAULT NULL COMMENT 'cpu阈值(最大100)',
  `elastic_start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `elastic_end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `time_rate` char(1) DEFAULT NULL COMMENT '伸缩周期（共5个状态，1：一次，2：每天，3：每周，4：每月，5：每年）',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`autoscale_policy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='自动伸缩策略表';

-- ----------------------------
-- Records of docker_autoscale_policy
-- ----------------------------

-- ----------------------------
-- Table structure for docker_build_config
-- ----------------------------
DROP TABLE IF EXISTS `docker_build_config`;
CREATE TABLE `docker_build_config` (
  `build_config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '构建配置标识',
  `image_version_id` int(11) NOT NULL COMMENT '基础镜像版本标识',
  `build_version_id` int(11) DEFAULT NULL COMMENT '镜像构建版本标识',
  `build_image_state` char(1) NOT NULL COMMENT '构建镜像状态 （1：构建中，2：构建成功，3：构建失败，4：未构建）',
  `repository_id` int(11) NOT NULL COMMENT '仓库标识',
  `build_dockerfile` longtext NOT NULL COMMENT 'dockerfile',
  `image_name` varchar(250) NOT NULL COMMENT '镜像名称',
  `image_version` varchar(250) NOT NULL COMMENT '镜像版本',
  `build_time` datetime DEFAULT NULL COMMENT '构建时间',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`build_config_id`),
  KEY `FK_Reference_41` (`image_version_id`) USING BTREE,
  KEY `FK_Reference_45` (`build_version_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='镜像构建配置表';

-- ----------------------------
-- Records of docker_build_config
-- ----------------------------

-- ----------------------------
-- Table structure for docker_build_file
-- ----------------------------
DROP TABLE IF EXISTS `docker_build_file`;
CREATE TABLE `docker_build_file` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '构建配置附件标识',
  `build_config_id` int(11) NOT NULL COMMENT '构建配置标识',
  `container_path` varchar(500) NOT NULL COMMENT '文件在容器中的存放路径',
  `file_name` varchar(250) NOT NULL COMMENT '附件名',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`file_id`),
  KEY `FK_Reference_44` (`build_config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='镜像构建文件表';

-- ----------------------------
-- Records of docker_build_file
-- ----------------------------

-- ----------------------------
-- Table structure for docker_config_file
-- ----------------------------
DROP TABLE IF EXISTS `docker_config_file`;
CREATE TABLE `docker_config_file` (
  `config_file_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '配置文件标识',
  `config_group_id` int(11) NOT NULL COMMENT '配置组id',
  `config_file_name` varchar(50) NOT NULL COMMENT '配置文件名称',
  `config_file_content` longtext NOT NULL COMMENT '配置文件内容',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`config_file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='服务配置文件表';

-- ----------------------------
-- Records of docker_config_file
-- ----------------------------

-- ----------------------------
-- Table structure for docker_config_group
-- ----------------------------
DROP TABLE IF EXISTS `docker_config_group`;
CREATE TABLE `docker_config_group` (
  `config_group_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '配置组标识',
  `cluster_id` int(11) DEFAULT NULL COMMENT '集群标识',
  `config_group_name` varchar(100) NOT NULL COMMENT '配置组名称',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`config_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='docker配置组（配置文件）';

-- ----------------------------
-- Records of docker_config_group
-- ----------------------------

-- ----------------------------
-- Table structure for docker_image
-- ----------------------------
DROP TABLE IF EXISTS `docker_image`;
CREATE TABLE `docker_image` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '镜像标识',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '团队id',
  `image_tag_id` int(11) DEFAULT NULL COMMENT '镜像标签标识',
  `repository_id` int(11) NOT NULL COMMENT '仓库标识',
  `image_name` varchar(100) NOT NULL COMMENT '镜像名',
  `title_desc` varchar(200) DEFAULT NULL COMMENT '标题描述',
  `icon_path` varchar(100) DEFAULT 'default' COMMENT '镜像图标路径',
  `image_content` longtext COMMENT '概述',
  `state` char(1) NOT NULL COMMENT '镜像状态（1：正常 2：删除）',
  `image_type` char(1) NOT NULL COMMENT '镜像类型（1：表示公有 2：表示私有）',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='镜像表';

-- ----------------------------
-- Records of docker_image
-- ----------------------------
INSERT INTO `docker_image` VALUES ('1', '1', '1', '1', 'centos', 'CentOS', 'centos', 'CentOS', '1', '1', '1', '2017-05-16 20:19:13', '1', '2017-06-04 16:00:23');
INSERT INTO `docker_image` VALUES ('2', '1', '1', '1', 'java', 'Java Runtime Environment', 'java', 'Environment', '1', '1', '1', '2017-05-16 20:19:13', '1', '2017-05-23 19:40:18');
INSERT INTO `docker_image` VALUES ('3', '1', '1', '1', 'tomcat', 'Tomcat运行环境', 'tomcat', 'Tomcat运行环境', '1', '1', '1', '2017-05-16 20:19:13', '1', '2017-05-23 19:40:18');
INSERT INTO `docker_image` VALUES ('4', '1', '1', '1', 'mysql', 'MySQL数据库', 'mysql', 'MySQL数据库', '1', '1', '1', '2017-05-16 20:19:13', '1', '2017-05-23 19:40:18');
INSERT INTO `docker_image` VALUES ('5', '1', '1', '1', 'zookeeper', 'Zookeeper单节点', 'default', 'Zookeeper单节点', '1', '1', '1', '2017-05-16 20:19:13', '1', '2017-05-23 19:40:18');
INSERT INTO `docker_image` VALUES ('6', '1', '1', '1', 'redis', 'Redis单节点', 'redis', 'Redis单节点', '1', '1', '1', '2017-05-16 20:19:13', '1', '2017-05-23 19:40:18');
INSERT INTO `docker_image` VALUES ('7', '1', '1', '1', 'router', 'router', 'default', 'router', '1', '1', '1', '2017-05-16 20:19:13', '1', '2017-05-23 19:40:18');

-- ----------------------------
-- Table structure for docker_image_collection
-- ----------------------------
DROP TABLE IF EXISTS `docker_image_collection`;
CREATE TABLE `docker_image_collection` (
  `collection_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏标识',
  `image_id` int(11) NOT NULL COMMENT '镜像id',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '团队id',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户镜像收藏表';

-- ----------------------------
-- Records of docker_image_collection
-- ----------------------------

-- ----------------------------
-- Table structure for docker_image_tag
-- ----------------------------
DROP TABLE IF EXISTS `docker_image_tag`;
CREATE TABLE `docker_image_tag` (
  `image_tag_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '镜像标签标识',
  `image_tag_name` varchar(50) NOT NULL COMMENT '标签名称',
  PRIMARY KEY (`image_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='镜像标签表';

-- ----------------------------
-- Records of docker_image_tag
-- ----------------------------

-- ----------------------------
-- Table structure for docker_image_version
-- ----------------------------
DROP TABLE IF EXISTS `docker_image_version`;
CREATE TABLE `docker_image_version` (
  `image_version_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '镜像版本标识',
  `image_id` int(11) NOT NULL COMMENT '镜像列表ID',
  `image_version` varchar(255) NOT NULL COMMENT '版本号',
  `state` char(1) NOT NULL COMMENT '状态（0：不稳定 1：正常 2：删除 3：损坏）',
  `version_desc` varchar(255) DEFAULT NULL,
  `content` longtext COMMENT '概述',
  `down_num` int(11) DEFAULT NULL COMMENT '申请下载次数',
  `dockerfile` longtext COMMENT '镜像版本构建时的dockerfile',
  `source` char(1) NOT NULL COMMENT '镜像来源（1：build、2：push、3：others）',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`image_version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='镜像版本表';

-- ----------------------------
-- Records of docker_image_version
-- ----------------------------
INSERT INTO `docker_image_version` VALUES ('1', '1', 'centos7', '1', null, '123', '0', '', '1', '1', '2017-05-16 20:20:45', null, null);
INSERT INTO `docker_image_version` VALUES ('2', '2', '8u_112', '1', null, '', '0', '', '1', '1', '2017-05-16 20:20:45', null, null);
INSERT INTO `docker_image_version` VALUES ('3', '3', '8', '1', null, '', '0', '', '1', '1', '2017-05-16 20:20:45', null, null);
INSERT INTO `docker_image_version` VALUES ('4', '7', 'latest', '1', null, '', '0', '', '1', '1', '2017-05-16 20:20:45', null, null);
INSERT INTO `docker_image_version` VALUES ('5', '4', '5.7.18', '1', null, '', '0', '', '1', '1', '2017-05-16 20:20:45', null, null);
INSERT INTO `docker_image_version` VALUES ('6', '5', '3.4.10', '1', null, null, '0', null, '1', '1', '2017-07-03 10:41:17', null, null);
INSERT INTO `docker_image_version` VALUES ('7', '6', '3.2.9', '1', null, null, '0', null, '1', '1', '2017-07-03 10:43:24', null, null);

-- ----------------------------
-- Table structure for docker_port_mapping
-- ----------------------------
DROP TABLE IF EXISTS `docker_port_mapping`;
CREATE TABLE `docker_port_mapping` (
  `mapping_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` int(11) NOT NULL COMMENT '服务id',
  `container_port` int(11) DEFAULT NULL COMMENT '容器端口',
  `protocol` varchar(50) DEFAULT NULL COMMENT '协议（TCP、HTTP）',
  `mapping_type` char(1) DEFAULT NULL COMMENT '映射类型（0：动态生成，1：指定端口）',
  `external_port` int(11) DEFAULT NULL COMMENT '外网域名端口',
  `inner_domain` varchar(200) DEFAULT NULL COMMENT '内网域名',
  `external_domain` varchar(200) DEFAULT NULL COMMENT '外网域名',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`mapping_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='服务端口和域名映射关系表';

-- ----------------------------
-- Records of docker_port_mapping
-- ----------------------------

-- ----------------------------
-- Table structure for docker_repository
-- ----------------------------
DROP TABLE IF EXISTS `docker_repository`;
CREATE TABLE `docker_repository` (
  `repository_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '仓库标识',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '团队id',
  `repository_name` varchar(100) NOT NULL COMMENT '镜像仓库名称，对应harbor中的project',
  `harbor_user_name` varchar(50) NOT NULL COMMENT 'harbor用户名',
  `harbor_password` varchar(255) NOT NULL COMMENT 'harbor用户密码',
  `is_default` char(1) DEFAULT '0' COMMENT '是否为团队默认仓库，构建镜像默认仓库（0：否，1：是）',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='docker镜像仓库';

-- ----------------------------
-- Records of docker_repository
-- ----------------------------
INSERT INTO `docker_repository` VALUES ('1', '1', 'library', 'admin', 'Harbor12345', '1', '1', '2017-05-20 14:27:45', '1', '2017-05-20 14:27:45');

-- ----------------------------
-- Table structure for docker_service
-- ----------------------------
DROP TABLE IF EXISTS `docker_service`;
CREATE TABLE `docker_service` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务标识',
  `service_name` varchar(100) NOT NULL COMMENT '服务名称',
  `app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `image_version_id` int(11) DEFAULT NULL COMMENT '镜像版本标识',
  `service_spec_id` int(11) DEFAULT NULL COMMENT '服务规格标识',
  `replicas` int(11) NOT NULL COMMENT '服务启动实例数',
  `enter_point` varchar(255) DEFAULT NULL COMMENT '进入点',
  `start_command_type` char(1) DEFAULT NULL COMMENT '启动命令类型（0：镜像默认，1：自定义）',
  `start_command` varchar(500) DEFAULT NULL COMMENT '启动命令，多个命令之间用竖线（|）分隔',
  `deploy_strategy` char(1) DEFAULT NULL COMMENT '重新部署策略（0：优先使用本地镜像，1：始终拉取云端该版本镜像）',
  `time_zone` char(1) DEFAULT NULL COMMENT '时区设置（0：使用所在主机节点的时区，1：无）',
  `dp_name` varchar(100) DEFAULT NULL COMMENT 'deployment名字',
  `yaml_content` text COMMENT 'yaml编排文件',
  `is_auto_scalable` char(1) DEFAULT NULL COMMENT '是否开启自动伸缩（1：表示开启，0：表示没有开启）',
  `namespace` varchar(100) DEFAULT NULL COMMENT '所属namespace',
  `service_state` char(1) NOT NULL COMMENT '状态（1：启用  0：停用）',
  `release_state` char(1) NOT NULL COMMENT '发布状态（1：创建中 2：发布成功 3：发布失败 ）',
  `release_desc` text COMMENT '发布描述',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='服务表';

-- ----------------------------
-- Records of docker_service
-- ----------------------------

-- ----------------------------
-- Table structure for docker_service_config_file
-- ----------------------------
DROP TABLE IF EXISTS `docker_service_config_file`;
CREATE TABLE `docker_service_config_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '配置标识',
  `config_file_id` int(11) NOT NULL COMMENT '配置文件id',
  `service_id` int(11) NOT NULL COMMENT '服务id',
  `container_path` varchar(255) NOT NULL COMMENT '挂载容器路径',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='配置文件挂载服务表';

-- ----------------------------
-- Records of docker_service_config_file
-- ----------------------------

-- ----------------------------
-- Table structure for docker_service_env
-- ----------------------------
DROP TABLE IF EXISTS `docker_service_env`;
CREATE TABLE `docker_service_env` (
  `service_env_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '环境变量标识',
  `service_env_key` varchar(100) NOT NULL COMMENT '环境变量键',
  `service_env_value` varchar(200) NOT NULL COMMENT '环境变量值',
  `service_id` int(11) NOT NULL COMMENT '服务标识',
  PRIMARY KEY (`service_env_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='服务环境变量配置表';

-- ----------------------------
-- Records of docker_service_env
-- ----------------------------

-- ----------------------------
-- Table structure for docker_service_label
-- ----------------------------
DROP TABLE IF EXISTS `docker_service_label`;
CREATE TABLE `docker_service_label` (
  `service_label_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_id` int(11) DEFAULT NULL COMMENT '服务标识',
  `label_id` int(11) DEFAULT NULL COMMENT '主键',
  PRIMARY KEY (`service_label_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='服务标签对应表，一个服务目前只有一个标签，以后可能会有多个';

-- ----------------------------
-- Records of docker_service_label
-- ----------------------------

-- ----------------------------
-- Table structure for docker_service_spec
-- ----------------------------
DROP TABLE IF EXISTS `docker_service_spec`;
CREATE TABLE `docker_service_spec` (
  `service_spec_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务规格标识',
  `spec_alias` varchar(12) DEFAULT NULL COMMENT '规格编码',
  `cpu_num` int(11) DEFAULT NULL COMMENT 'cpu个数',
  `memory` double DEFAULT NULL COMMENT '内存（单位：Gi）',
  PRIMARY KEY (`service_spec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='服务cpu内存规格表';

INSERT INTO `docker_service_spec` VALUES (1, '1C1Gi', 1, 1);
INSERT INTO `docker_service_spec` VALUES (2, '1C2Gi', 1, 2);
INSERT INTO `docker_service_spec` VALUES (3, '1C4Gi', 1, 4);
INSERT INTO `docker_service_spec` VALUES (4, '1C8Gi', 1, 8);
INSERT INTO `docker_service_spec` VALUES (5, '1C32Gi', 1, 32);
INSERT INTO `docker_service_spec` VALUES (6, '1C64Gi', 1, 64);
INSERT INTO `docker_service_spec` VALUES (7, '2C1Gi', 2, 1);
INSERT INTO `docker_service_spec` VALUES (8, '2C2Gi', 2, 2);
INSERT INTO `docker_service_spec` VALUES (9, '2C4Gi', 2, 4);
INSERT INTO `docker_service_spec` VALUES (10, '2C8Gi', 2, 8);
INSERT INTO `docker_service_spec` VALUES (11, '2C32Gi', 2, 32);
INSERT INTO `docker_service_spec` VALUES (12, '2C64Gi', 2, 64);
INSERT INTO `docker_service_spec` VALUES (13, '4C1Gi', 4, 1);
INSERT INTO `docker_service_spec` VALUES (14, '4C2Gi', 4, 2);
INSERT INTO `docker_service_spec` VALUES (15, '4C4Gi', 4, 4);
INSERT INTO `docker_service_spec` VALUES (16, '4C8Gi', 4, 8);
INSERT INTO `docker_service_spec` VALUES (17, '4C32Gi', 4, 32);
INSERT INTO `docker_service_spec` VALUES (18, '4C64Gi', 4, 64);
INSERT INTO `docker_service_spec` VALUES (19, '8C1Gi', 8, 1);
INSERT INTO `docker_service_spec` VALUES (20, '8C2Gi', 8, 2);
INSERT INTO `docker_service_spec` VALUES (21, '8C4Gi', 8, 4);
INSERT INTO `docker_service_spec` VALUES (22, '8C8Gi', 8, 8);
INSERT INTO `docker_service_spec` VALUES (23, '8C32Gi', 8, 32);
INSERT INTO `docker_service_spec` VALUES (24, '8C64Gi', 8, 64);
INSERT INTO `docker_service_spec` VALUES (25, '16C1Gi', 16, 1);
INSERT INTO `docker_service_spec` VALUES (26, '16C2Gi', 16, 2);
INSERT INTO `docker_service_spec` VALUES (27, '16C4Gi', 16, 4);
INSERT INTO `docker_service_spec` VALUES (28, '16C8Gi', 16, 8);
INSERT INTO `docker_service_spec` VALUES (29, '16C32Gi', 16, 32);
INSERT INTO `docker_service_spec` VALUES (30, '16C64Gi', 16, 64);
INSERT INTO `docker_service_spec` VALUES (31, '32C1Gi', 32, 1);
INSERT INTO `docker_service_spec` VALUES (32, '32C2Gi', 32, 2);
INSERT INTO `docker_service_spec` VALUES (33, '32C4Gi', 32, 4);
INSERT INTO `docker_service_spec` VALUES (34, '32C8Gi', 32, 8);
INSERT INTO `docker_service_spec` VALUES (35, '32C32Gi', 32, 32);
INSERT INTO `docker_service_spec` VALUES (36, '32C64Gi', 32, 64);
INSERT INTO `docker_service_spec` VALUES (37, '0C0Gi', 0, 0);
-- ----------------------------
-- Records of docker_service_spec
-- ----------------------------

-- ----------------------------
-- Table structure for docker_service_volume
-- ----------------------------
DROP TABLE IF EXISTS `docker_service_volume`;
CREATE TABLE `docker_service_volume` (
  `service_volume_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '挂载卷标识',
  `service_id` int(11) DEFAULT NULL COMMENT '服务标识',
  `host_path` varchar(255) NOT NULL COMMENT '宿主机路径',
  `container_path` varchar(255) NOT NULL COMMENT '容器路径',
  `volume_type` char(1) DEFAULT '1' COMMENT '挂载类型（1：普通，2：日志）',
  PRIMARY KEY (`service_volume_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='容器挂载卷数据表（映射容器日志，存储数据）';

-- ----------------------------
-- Records of docker_service_volume
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_alert_config
-- ----------------------------
DROP TABLE IF EXISTS `k8s_alert_config`;
CREATE TABLE `k8s_alert_config` (
  `alert_config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cluster_id` int(11) NOT NULL COMMENT 'k8s集群',
  `name` varchar(100) DEFAULT NULL COMMENT '名字',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `email` varchar(100) DEFAULT NULL COMMENT '邮件',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`alert_config_id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='k8s告警表';

-- ----------------------------
-- Records of k8s_alert_config
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_alert_info
-- ----------------------------
DROP TABLE IF EXISTS `k8s_alert_info`;
CREATE TABLE `k8s_alert_info` (
  `alert_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '告警信息标识',
  `level` varchar(16) DEFAULT NULL COMMENT '告警等级',
  `alert_type` varchar(16) DEFAULT NULL COMMENT '告警类型',
  `cluster_id` int(11) NOT NULL COMMENT 'k8s集群id',
  `namespace` varchar(32) NOT NULL COMMENT '命名空间',
  `service_name` varchar(64) NOT NULL COMMENT '对应服务名称',
  `per_num` int(11) DEFAULT NULL COMMENT '告警实例百分比或个数',
  `rule` varchar(128) DEFAULT NULL COMMENT '告警规则',
  `message` varchar(1024) DEFAULT NULL COMMENT '告警信息',
  `is_active` tinyint(1) NOT NULL COMMENT '告警标志',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`alert_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='告警信息表';

-- ----------------------------
-- Records of k8s_alert_info
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_alert_item
-- ----------------------------
DROP TABLE IF EXISTS `k8s_alert_item`;
CREATE TABLE `k8s_alert_item` (
  `alert_item_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `unit` varchar(100) DEFAULT NULL COMMENT '单位',
  `type` varchar(100) DEFAULT NULL COMMENT '类型',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`alert_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='k8s告警项表';

-- ----------------------------
-- Records of k8s_alert_item
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_alert_object
-- ----------------------------
DROP TABLE IF EXISTS `k8s_alert_object`;
CREATE TABLE `k8s_alert_object` (
  `alert_object_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `alert_config_id` int(11) NOT NULL COMMENT '告警id',
  `service_id` int(11) NOT NULL COMMENT '服务id',
  PRIMARY KEY (`alert_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='告警对象表';

-- ----------------------------
-- Records of k8s_alert_object
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_alert_rule
-- ----------------------------
DROP TABLE IF EXISTS `k8s_alert_rule`;
CREATE TABLE `k8s_alert_rule` (
  `alert_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `alert_config_id` int(11) NOT NULL COMMENT '告警id',
  `alert_item_id` int(11) NOT NULL COMMENT '告警项id',
  `max` int(11) DEFAULT NULL COMMENT '最大值',
  `min` int(11) DEFAULT NULL COMMENT '最小值',
  `opts` varchar(100) DEFAULT NULL COMMENT '选项',
  PRIMARY KEY (`alert_rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='k8s告警规则表';

-- ----------------------------
-- Records of k8s_alert_rule
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_cluster
-- ----------------------------
DROP TABLE IF EXISTS `k8s_cluster`;
CREATE TABLE `k8s_cluster` (
  `cluster_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '集群标识',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '团队id',
  `cluster_name` varchar(100) NOT NULL COMMENT '集群名称',
  `cluster_desc` varchar(200) DEFAULT NULL COMMENT '集群描述',
  `monitor_url` varchar(100) DEFAULT NULL COMMENT '监控集群的url，包括ip和端口',
  `api_server_url` varchar(255) DEFAULT NULL COMMENT '集群api_server_url，包括ip和端口',
  `lb_address` varchar(255) DEFAULT NULL COMMENT '负载均衡地址',
  `state` char(1) NOT NULL COMMENT '状态（1：正常 2：删除）',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`cluster_id`),
  UNIQUE KEY `uniq_cluster_name` (`cluster_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='k8s集群表';

-- ----------------------------
-- Records of k8s_cluster
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_cluster_host
-- ----------------------------
DROP TABLE IF EXISTS `k8s_cluster_host`;
CREATE TABLE `k8s_cluster_host` (
  `cluster_host_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '集群主机标识',
  `cluster_id` int(11) NOT NULL COMMENT '集群id',
  `install_state` char(1) NOT NULL DEFAULT '4' COMMENT 'K8s安装状态（1：安装中，2：安装成功，3：安装失败，4：未安装）',
  `host_id` int(11) NOT NULL COMMENT '主机id',
  `host_port` varchar(10) DEFAULT NULL COMMENT '端口',
  `host_type` char(1) DEFAULT NULL COMMENT '主机类型（1：master，2：slave）',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`cluster_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='k8s集群与主机关联表';

-- ----------------------------
-- Records of k8s_cluster_host
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_label
-- ----------------------------
DROP TABLE IF EXISTS `k8s_label`;
CREATE TABLE `k8s_label` (
  `label_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cluster_id` int(11) DEFAULT NULL COMMENT '集群标识',
  `label_name` varchar(100) DEFAULT NULL COMMENT '标签名',
  `label_content` varchar(500) DEFAULT NULL COMMENT '标签说明',
  `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`label_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='k8s的主机含有不同的标签，根据标签可以把服务发布到相应的主机上';

-- ----------------------------
-- Records of k8s_label
-- ----------------------------

-- ----------------------------
-- Table structure for k8s_label_host
-- ----------------------------
DROP TABLE IF EXISTS `k8s_label_host`;
CREATE TABLE `k8s_label_host` (
  `label_host_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `label_id` int(11) DEFAULT NULL COMMENT '主键',
  `host_id` int(11) DEFAULT NULL COMMENT '主键',
  PRIMARY KEY (`label_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='一个标签包含了哪些主机';

-- ----------------------------
-- Records of k8s_label_host
-- ----------------------------

-- ----------------------------
-- Table structure for res_host
-- ----------------------------
DROP TABLE IF EXISTS `res_host`;
CREATE TABLE `res_host` (
  `host_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '团队id',
  `host_name` varchar(50) DEFAULT NULL COMMENT '主机名称',
  `host_ip` varchar(50) NOT NULL COMMENT '主机ip',
  `ssh_port` varchar(50) NOT NULL COMMENT 'ssh端口',
  `user_name` varchar(255) NOT NULL COMMENT 'ssh用户名',
  `password` varchar(255) NOT NULL COMMENT 'ssh用户密码',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  `modified_by` bigint(20) DEFAULT NULL COMMENT '修改人',
  `modified_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='主机表';

-- ----------------------------
-- Records of res_host
-- ----------------------------

-- ----------------------------
-- Table structure for ssh_session_log
-- ----------------------------
DROP TABLE IF EXISTS `ssh_session_log`;
CREATE TABLE `ssh_session_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `session_tm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ssh_session_log
-- ----------------------------

-- ----------------------------
-- Table structure for ssh_status
-- ----------------------------
DROP TABLE IF EXISTS `ssh_status`;
CREATE TABLE `ssh_status` (
  `id` int(11) NOT NULL DEFAULT '0',
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `status_cd` varchar(255) NOT NULL DEFAULT 'INITIAL',
  PRIMARY KEY (`id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ssh_status
-- ----------------------------

-- ----------------------------
-- Table structure for ssh_system
-- ----------------------------
DROP TABLE IF EXISTS `ssh_system`;
CREATE TABLE `ssh_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_nm` varchar(255) DEFAULT NULL,
  `user` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `authorized_keys` varchar(255) DEFAULT NULL,
  `status_cd` varchar(255) NOT NULL DEFAULT 'INITIAL',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ssh_system
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志标识',
  `request_ip` char(15) NOT NULL COMMENT '请求IP',
  `log_desc` varchar(1000) DEFAULT NULL COMMENT '描述',
  `module` varchar(500) DEFAULT NULL COMMENT '模块',
  `target_obj` varchar(255) DEFAULT NULL COMMENT '目标对象',
  `params` longtext COMMENT '参数',
  `method` varchar(255) DEFAULT NULL COMMENT '方法',
  `exception_code` varchar(255) DEFAULT NULL COMMENT '异常编码',
  `exception_detail` longtext COMMENT '异常详情',
  `cost_time` int(11) DEFAULT NULL COMMENT '耗时',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='用户操作日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------


DROP TABLE IF EXISTS `k8s_cicd_code`;
CREATE TABLE `k8s_cicd_code` (
  `code_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '代码仓库标识',
  `code_name` varchar(256) NOT NULL COMMENT '代码仓库名称',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `reposity_url` varchar(64) NOT NULL COMMENT '仓库url',
  `reposity_type` int(11) NOT NULL COMMENT '仓库类型',
  `reposity_pass` varchar(64) NOT NULL COMMENT '仓库密码',
  `reposity_username` varchar(64) NOT NULL COMMENT '仓库用户名',
  `public_res` int(11) NOT NULL COMMENT '方法',
  `created_by` bigint(20) NOT NULL COMMENT '创建人',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cicd代码仓库表';

DROP TABLE IF EXISTS `k8s_cicd_project`;
CREATE TABLE `k8s_cicd_project` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '发布标识',
  `project_name` varchar(32) NOT NULL COMMENT '项目名',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `state` varchar(32) NOT NULL COMMENT '状态',
  `log` varchar(1024) DEFAULT NULL COMMENT '日志',
  `auto_build` int(11) NOT NULL COMMENT '自动发布',
  `build_crontab` varchar(64) DEFAULT NULL COMMENT '自动发布crontab',
  `update_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cicd项目';
