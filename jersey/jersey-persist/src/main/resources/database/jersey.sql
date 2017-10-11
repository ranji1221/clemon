/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : lemon

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-10-09 16:33:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `lemon_oauth2_client`
-- ----------------------------
DROP TABLE IF EXISTS `lemon_oauth2_client`;
CREATE TABLE `lemon_jersey_oauth2_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `clientName` varchar(255) DEFAULT NULL COMMENT '客户端名称',
  `clientId` varchar(255) DEFAULT NULL COMMENT '客户端ID',
  `clientSecret` varchar(255) DEFAULT NULL COMMENT '客户端安全key',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lemon_oauth2_client
-- ----------------------------
