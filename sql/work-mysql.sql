/*
SQLyog Enterprise - MySQL GUI v6.14
MySQL - 5.7.20 : Database - work
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `work`;

USE `work`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `business` */

DROP TABLE IF EXISTS `business`;

CREATE TABLE `business` (
  `CCID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id,主键,自增长',
  `XMDM` varchar(16) DEFAULT NULL COMMENT '项目代码',
  `CCLY` varchar(64) DEFAULT NULL COMMENT '出差理由',
  `CCR` varchar(16) DEFAULT NULL COMMENT '出差人',
  `CC_START` datetime DEFAULT NULL COMMENT '出差开始时间',
  `CC_STOP` datetime DEFAULT NULL COMMENT '出差结束时间',
  `XC_START` datetime DEFAULT NULL COMMENT '行程开始时间',
  `XC_STOP` datetime DEFAULT NULL COMMENT '行程结束时间',
  `XCGJ` varchar(16) DEFAULT NULL COMMENT '行程工具',
  `XCFY` varchar(16) DEFAULT NULL COMMENT '行程费用',
  `ZSFY` varchar(16) DEFAULT NULL COMMENT '住宿费用',
  `SNJTFY` varchar(16) DEFAULT NULL COMMENT '市内交通费用',
  `ZFY` varchar(32) DEFAULT NULL COMMENT '总费用',
  `DJRQ` datetime DEFAULT NULL COMMENT '登记日期',
  `WCZT` varchar(16) DEFAULT NULL COMMENT '完成状态',
  `REMARK` varchar(256) DEFAULT NULL COMMENT '说明',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`CCID`),
  KEY `FK_wczt2` (`WCZT`),
  KEY `FK_xcgj` (`XCGJ`),
  KEY `FK_ccr` (`CCR`),
  KEY `FK_xmdm2` (`XMDM`),
  CONSTRAINT `FK_ccr` FOREIGN KEY (`CCR`) REFERENCES `user` (`YHDM`),
  CONSTRAINT `FK_wczt2` FOREIGN KEY (`WCZT`) REFERENCES `status` (`ZTID`),
  CONSTRAINT `FK_xcgj` FOREIGN KEY (`XCGJ`) REFERENCES `traffic` (`GJID`),
  CONSTRAINT `FK_xmdm2` FOREIGN KEY (`XMDM`) REFERENCES `project` (`XMDM`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `business` */

insert  into `business`(`CCID`,`XMDM`,`CCLY`,`CCR`,`CC_START`,`CC_STOP`,`XC_START`,`XC_STOP`,`XCGJ`,`XCFY`,`ZSFY`,`SNJTFY`,`ZFY`,`DJRQ`,`WCZT`,`REMARK`,`SFJY`) values (1,'xm001','什么呢','yh000','2018-05-07 16:50:09','2018-05-10 16:50:14',NULL,NULL,NULL,'12','12','12','36','2018-05-07 16:50:29','1','无',0),(2,'xm002','没什么','yh000','2018-05-08 12:51:29','2018-05-08 12:51:56',NULL,NULL,'1','123','123','123','369','2018-05-08 12:53:27','1','美妙',0),(3,'xm002','无','yh006','2018-05-09 22:06:50','2018-05-10 22:06:55',NULL,NULL,'2','123','1234','1234','2591','2018-05-08 22:08:07','1','222',0);

/*Table structure for table `depart` */

DROP TABLE IF EXISTS `depart`;

CREATE TABLE `depart` (
  `BMDM` varchar(16) NOT NULL COMMENT '部门代码',
  `FBMDM` varchar(16) DEFAULT NULL COMMENT '父部门代码',
  `BMMC` varchar(32) DEFAULT NULL COMMENT '部门名称',
  `LASTUPDATE` datetime DEFAULT NULL COMMENT '最近更新',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用，默认0，不禁用',
  PRIMARY KEY (`BMDM`),
  KEY `FK_fbmdm` (`FBMDM`),
  CONSTRAINT `FK_fbmdm` FOREIGN KEY (`FBMDM`) REFERENCES `depart` (`BMDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `depart` */

insert  into `depart`(`BMDM`,`FBMDM`,`BMMC`,`LASTUPDATE`,`SFJY`) values ('1061601',NULL,'开发部','2018-03-22 00:00:00',0),('106160101','1061601','项目部','2018-03-22 00:00:00',0),('106160102','1061601','运维部','2018-03-22 00:00:00',0),('1061602',NULL,'产品设计部','2018-03-22 00:00:00',0),('1061603',NULL,'运营部','2018-03-22 00:00:00',0),('1061604',NULL,'市场销售部','2018-03-22 00:00:00',0),('1061605',NULL,'其他部门','2018-03-22 00:00:00',0);

/*Table structure for table `examine` */

DROP TABLE IF EXISTS `examine`;

CREATE TABLE `examine` (
  `SHID` int(11) NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `TYPE` varchar(16) NOT NULL COMMENT '事件类型',
  `SHDM` varchar(16) NOT NULL COMMENT '审核代码',
  `SHR1` varchar(16) DEFAULT NULL COMMENT '审核人1',
  `SHYJ1` int(2) DEFAULT NULL COMMENT '审核意见1',
  `SHSJ1` datetime DEFAULT NULL COMMENT '审核时间1',
  `SHR2` varchar(16) DEFAULT NULL COMMENT '审核人2',
  `SHYJ2` int(2) DEFAULT NULL COMMENT '审核意见2',
  `SHSJ2` datetime DEFAULT NULL COMMENT '审核时间2',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '说明/备注',
  PRIMARY KEY (`SHID`),
  KEY `FK_shr1` (`SHR1`),
  KEY `FK_shr2` (`SHR2`),
  CONSTRAINT `FK_shr1` FOREIGN KEY (`SHR1`) REFERENCES `user` (`YHDM`),
  CONSTRAINT `FK_shr2` FOREIGN KEY (`SHR2`) REFERENCES `user` (`YHDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `examine` */

/*Table structure for table `expense` */

DROP TABLE IF EXISTS `expense`;

CREATE TABLE `expense` (
  `BXID` int(11) NOT NULL AUTO_INCREMENT COMMENT '报销id',
  `XMDM` varchar(16) DEFAULT NULL COMMENT '项目代码',
  `BXFY` varchar(32) DEFAULT NULL COMMENT '报销费用',
  `BXYT` varchar(32) DEFAULT NULL COMMENT '报销用途',
  `BXR` varchar(16) NOT NULL COMMENT '报销人',
  `BXRQ` datetime DEFAULT NULL COMMENT '报销日期',
  `WCZT` varchar(16) DEFAULT NULL COMMENT '完成状态',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '备注',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`BXID`),
  KEY `FK_bxr` (`BXR`),
  KEY `FK_wczt3` (`WCZT`),
  KEY `FK_xmdm3` (`XMDM`),
  CONSTRAINT `FK_bxr` FOREIGN KEY (`BXR`) REFERENCES `user` (`YHDM`),
  CONSTRAINT `FK_wczt3` FOREIGN KEY (`WCZT`) REFERENCES `status` (`ZTID`),
  CONSTRAINT `FK_xmdm3` FOREIGN KEY (`XMDM`) REFERENCES `project` (`XMDM`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `expense` */

insert  into `expense`(`BXID`,`XMDM`,`BXFY`,`BXYT`,`BXR`,`BXRQ`,`WCZT`,`REMARK`,`SFJY`) values (1,'xm001','120','车费','yh000','2018-05-07 15:57:58','1','无',0),(2,'xm002','120','车费','yh000','2018-05-07 16:22:59','1','无',0);

/*Table structure for table `journal` */

DROP TABLE IF EXISTS `journal`;

CREATE TABLE `journal` (
  `RZID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id,主键,自增长',
  `DJR` varchar(16) DEFAULT NULL COMMENT '登记人',
  `DJSJ` datetime DEFAULT NULL COMMENT '登记时间',
  `RZNR` varchar(255) DEFAULT NULL COMMENT '日志内容',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`RZID`),
  KEY `FK_djr` (`DJR`),
  CONSTRAINT `FK_djr` FOREIGN KEY (`DJR`) REFERENCES `user` (`YHDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `journal` */

/*Table structure for table `leave` */

DROP TABLE IF EXISTS `leave`;

CREATE TABLE `leave` (
  `QJID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id,主键,自增长',
  `QJR` varchar(16) DEFAULT NULL COMMENT '请假人',
  `QJ_START` datetime DEFAULT NULL COMMENT '开始时间',
  `QJ_STOP` datetime DEFAULT NULL COMMENT '结束时间',
  `WCZT` varchar(16) DEFAULT NULL COMMENT '完成状态',
  `REMARK` varchar(256) DEFAULT NULL COMMENT '说明',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`QJID`),
  KEY `FK_qjr` (`QJR`),
  KEY `FK_wczt4` (`WCZT`),
  CONSTRAINT `FK_qjr` FOREIGN KEY (`QJR`) REFERENCES `user` (`YHDM`),
  CONSTRAINT `FK_wczt4` FOREIGN KEY (`WCZT`) REFERENCES `status` (`ZTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `leave` */

/*Table structure for table `meeting` */

DROP TABLE IF EXISTS `meeting`;

CREATE TABLE `meeting` (
  `HYID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id,主键,自增长',
  `HYFQR` varchar(16) DEFAULT NULL COMMENT '会议发起人',
  `HYSJ` datetime DEFAULT NULL COMMENT '会议时间',
  `DJSJ` datetime DEFAULT NULL COMMENT '登记时间',
  `HYDZ` varchar(64) DEFAULT NULL COMMENT '会议地址',
  `HYBT` varchar(64) DEFAULT NULL COMMENT '会议标题',
  `HYNR` varchar(256) DEFAULT NULL COMMENT '会议内容',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '说明',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`HYID`),
  KEY `FK_hyfqr` (`HYFQR`),
  CONSTRAINT `FK_hyfqr` FOREIGN KEY (`HYFQR`) REFERENCES `user` (`YHDM`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `meeting` */

insert  into `meeting`(`HYID`,`HYFQR`,`HYSJ`,`DJSJ`,`HYDZ`,`HYBT`,`HYNR`,`REMARK`,`SFJY`) values (3,'yh000','2018-05-02 00:00:00',NULL,'会议室','会议通知','为贯彻落实上级会议精神，总结回顾2012年工作，安排部署2013年工作，经研究，决定召开管理处工作会议暨职工迎春联欢会，现将有关事项通知如下','wu',0),(4,'yh000','2018-05-03 00:00:00','2018-05-02 19:58:36','会议室','会议通知2','为贯彻落实上级会议精神，总结回顾2017年工作，安排部署2018年工作，经研究，决定召开管理处工作会议暨职工迎春联欢会，现将有关事项通知如下','没什么',0),(7,'yh000','2018-05-05 20:31:41','2018-05-02 20:31:51','会议室','wq','','',0),(8,'yh001','2018-05-04 22:34:23','2018-05-02 22:34:51','会议室','会议通知3','@RequestMapping(\"toMeetingForm\")\r\n	public ModelAndView toProjectForm(){\r\n		ModelAndView model=new ModelAndView(\"daily/hyForm\");  \r\n		return model;\r\n	}','无',0);

/*Table structure for table `notify` */

DROP TABLE IF EXISTS `notify`;

CREATE TABLE `notify` (
  `GGID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id，主键，自增长',
  `GGBT` varchar(32) DEFAULT NULL COMMENT '公告标题',
  `GGNR` varchar(256) DEFAULT NULL COMMENT '公告内容',
  `FQSJ` datetime DEFAULT NULL COMMENT '发起时间',
  `FQR` varchar(16) DEFAULT NULL COMMENT '发起人',
  `LASTUPDATE` datetime DEFAULT NULL COMMENT '最近更新',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`GGID`),
  KEY `FK_fqr` (`FQR`),
  CONSTRAINT `FK_fqr` FOREIGN KEY (`FQR`) REFERENCES `user` (`YHDM`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `notify` */

insert  into `notify`(`GGID`,`GGBT`,`GGNR`,`FQSJ`,`FQR`,`LASTUPDATE`,`SFJY`) values (1,'测试','落霞与孤鹜齐飞，秋水共长天一色','2018-05-03 00:00:00','yh000','2018-05-03 00:00:00',0),(4,'凉凉夜色','来那个良夜色威尼斯年成河','2018-05-03 14:13:02','yh000','2018-05-03 14:13:02',0),(5,'凉凉','我愿做你爱的死囚，怎么说这首歌了，是一首很典型的苦情歌，让人听了有种很悲痛欲绝的感觉。但个人觉得这首歌的旋律不大适合庄心妍，我觉得她没有完全把这首歌想要表达的痛苦诠释出来，就让我承受许下那毒咒，这是一种爱到什么样的层度痛到什么样的绝望才能有这种念头啊，她的声线过于单薄，无法将那种伤痛诠释的淋漓','2018-05-03 14:33:37','yh001','2018-05-03 14:58:57',0),(6,'111','111','2018-05-03 14:57:13','yh001','2018-05-03 14:57:13',0),(7,'122','122','2018-05-03 14:57:19','yh001','2018-05-03 14:57:19',0),(8,'133','133','2018-05-03 14:57:23','yh001','2018-05-03 14:57:23',0),(9,'144','144','2018-05-03 14:57:30','yh001','2018-05-03 14:57:30',0),(10,'155','155','2018-05-03 14:57:42','yh001','2018-05-03 14:57:42',0);

/*Table structure for table `plan` */

DROP TABLE IF EXISTS `plan`;

CREATE TABLE `plan` (
  `JHID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id,主键,自增长',
  `APR` varchar(16) DEFAULT NULL COMMENT '安排人',
  `DJSJ` datetime DEFAULT NULL COMMENT '登记时间',
  `FZR` varchar(16) DEFAULT NULL COMMENT '负责人',
  `JH_START` datetime DEFAULT NULL COMMENT '开始时间',
  `JH_STOP` datetime DEFAULT NULL COMMENT '结束时间',
  `JHNR` varchar(256) DEFAULT NULL COMMENT '计划内容',
  `XMDM` varchar(16) DEFAULT NULL COMMENT '计划项目',
  `JHLX` varchar(16) DEFAULT NULL COMMENT '计划类型',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`JHID`),
  KEY `FK_apr` (`APR`),
  KEY `FK_fzr` (`FZR`),
  CONSTRAINT `FK_apr` FOREIGN KEY (`APR`) REFERENCES `user` (`YHDM`),
  CONSTRAINT `FK_fzr` FOREIGN KEY (`FZR`) REFERENCES `user` (`YHDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `plan` */

/*Table structure for table `position` */

DROP TABLE IF EXISTS `position`;

CREATE TABLE `position` (
  `ZWDM` varchar(16) NOT NULL COMMENT '职位代码',
  `ZWMC` varchar(32) NOT NULL COMMENT '职位名称',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`ZWDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `position` */

insert  into `position`(`ZWDM`,`ZWMC`,`SFJY`) values ('0001','boss',0),('0101','技术总监',0),('010102','项目经理',0),('010103','项目助理',0),('010104','测试工程师',0),('010105','实施工程师',0),('0102','web前段工程师',0),('010202','运维工程师',0),('010203','网络工程师',0),('010204','系统工程师',0),('010205','IT支持',0),('010206','系统安全',0),('0103','java工程师',0),('0104','python开发工程师',0),('0105','大数据工程师',0),('0106','数据挖掘工程师',0),('0107','自然语言处理工程师',0),('0108','DBA',0),('0109','架构师',0),('0110','其他',0),('0201','产品经理',0),('0202','产品助理',0),('0203','网页产品设计师',0),('0204','产品总监',0),('0205','网页设计师',0),('0206','平面设计师',0),('0207','原画师',0),('0208','数据分析师',0),('0209','交互设计师',0),('0210','其他',0),('0301','运营总监',0),('0302','产品运营',0),('0303','数据运营',0),('0304','网络推广',0),('0305','内容编辑',0),('0306','文案策划',0),('0307','客服经理',0),('0308','售后客服',0),('0309','其他',0),('0401','市场总监',0),('0402','市场策划',0),('0403','市场顾问',0),('0404','市场推广',0),('0405','媒介经理',0),('0406','销售专员',0),('0407','销售经理',0),('0408','采购专员',0),('0409','投资顾问',0),('0410','其他',0),('0501','HR',0);

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `XMDM` varchar(16) NOT NULL COMMENT '项目代码',
  `XMMC` varchar(64) NOT NULL COMMENT '项目名称',
  `BBH` varchar(16) DEFAULT NULL COMMENT '版本号',
  `LXRQ` datetime NOT NULL COMMENT '立项日期',
  `LXR` varchar(16) NOT NULL COMMENT '立项人',
  `XMXX` varchar(256) NOT NULL COMMENT '项目信息',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '说明',
  `FJMC` varchar(64) DEFAULT NULL COMMENT '附件名称',
  `FJGS` varchar(16) DEFAULT NULL COMMENT '附件格式',
  `FJDX` float DEFAULT NULL COMMENT '附件大小(以KB位单为)',
  `FTPURL` varchar(64) DEFAULT NULL COMMENT 'FTP路径',
  `LASTUPDATE` datetime DEFAULT NULL COMMENT '最近更新',
  `SFJY` int(2) DEFAULT NULL COMMENT '是否禁用',
  PRIMARY KEY (`XMDM`),
  KEY `FK_lxr` (`LXR`),
  CONSTRAINT `FK_lxr` FOREIGN KEY (`LXR`) REFERENCES `user` (`YHDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `project` */

insert  into `project`(`XMDM`,`XMMC`,`BBH`,`LXRQ`,`LXR`,`XMXX`,`REMARK`,`FJMC`,`FJGS`,`FJDX`,`FTPURL`,`LASTUPDATE`,`SFJY`) values ('xm001','测试项目1','1.0','2018-05-02 10:19:27','yh000','办公自动化管理系统','无','InputStreamReaderDemo','java',1.91,'/zh','2018-05-02 10:19:27',0),('xm002','测试项目2','1.0','2018-05-02 10:21:08','yh000','办公自动化管理系统','无','c3p0-config','xml',1.41,'/zh','2018-05-02 10:21:08',0);

/*Table structure for table `status` */

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `ZTID` varchar(16) NOT NULL COMMENT '状态id',
  `ZTMS` varchar(16) DEFAULT NULL COMMENT '状态描述',
  `SFJY` int(2) DEFAULT NULL COMMENT '是否禁用',
  PRIMARY KEY (`ZTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `status` */

insert  into `status`(`ZTID`,`ZTMS`,`SFJY`) values ('1','未审核',0),('2','已审核',0),('3','审核未通过',0),('4','审核通过',0),('5','正在审核',0),('6','其他状态',0);

/*Table structure for table `traffic` */

DROP TABLE IF EXISTS `traffic`;

CREATE TABLE `traffic` (
  `GJID` varchar(16) NOT NULL COMMENT 'id',
  `GJMS` varchar(16) DEFAULT NULL COMMENT '交通描述',
  `SFJY` int(2) DEFAULT NULL COMMENT '是否禁用',
  PRIMARY KEY (`GJID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `traffic` */

insert  into `traffic`(`GJID`,`GJMS`,`SFJY`) values ('1','火车',0),('2','飞机',0),('3','汽车',0),('4','轮船',0),('5','自驾',0),('6','其他',0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `YHDM` varchar(16) NOT NULL COMMENT '用户代码',
  `YHZH` varchar(16) NOT NULL COMMENT '用户账号',
  `YHKL` varchar(16) NOT NULL COMMENT '用户口令',
  `YHXM` varchar(32) NOT NULL COMMENT '用户姓名',
  `CSRQ` datetime DEFAULT NULL COMMENT '出生日期',
  `BMDM` varchar(16) NOT NULL COMMENT '部门代码',
  `YHXB` varchar(8) DEFAULT NULL COMMENT '用户性别',
  `ZWDM` varchar(16) NOT NULL COMMENT '职位代码',
  `ADDRESS` varchar(64) DEFAULT NULL COMMENT '所在地址',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '电话',
  `EMAIL` varchar(32) DEFAULT NULL COMMENT '电子邮箱',
  `REMARK` varchar(64) DEFAULT NULL COMMENT '说明',
  `SFJY` int(2) DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`YHDM`),
  KEY `FK_bmdm` (`BMDM`),
  KEY `FK_zwdm` (`ZWDM`),
  CONSTRAINT `FK_bmdm` FOREIGN KEY (`BMDM`) REFERENCES `depart` (`BMDM`),
  CONSTRAINT `FK_zwdm` FOREIGN KEY (`ZWDM`) REFERENCES `position` (`ZWDM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `user` */

insert  into `user`(`YHDM`,`YHZH`,`YHKL`,`YHXM`,`CSRQ`,`BMDM`,`YHXB`,`ZWDM`,`ADDRESS`,`PHONE`,`EMAIL`,`REMARK`,`SFJY`) values ('yh000','admin','admin','管理员','2000-01-01 00:00:00','1061601','女','0001','北京东城','110','110@qq.com','比较流弊',0),('yh001','liubei','liubei','刘备','1990-01-01 00:00:00','1061601','男','0101','四川省成都市','13031209099','120@qq.com','蜀国',0),('yh002','zhangfei','zhangfei','张飞','1999-01-10 00:00:00','1061602','男','0201','四川省成都市','13031003100','zhangsan@qq.com','长坂坡',0),('yh003','guanyu','guanyu','关羽','1995-03-03 00:00:00','1061603','男','0301','重庆万州','911','911@126.com','大学生',0),('yh004','caocao','caocao','曹操','1990-10-11 00:00:00','1061604','男','0401','重庆万州','18000002323','sanfeng@163.com','武当',0),('yh005','sunquan','sunquan','孙权','2018-04-22 00:00:00','1061605','男','0501','四川成都','13031202222','dutc@qq.com','万般留恋',0),('yh006','dutc','dutc','杜天成','2000-02-01 00:00:00','1061601','女','0102','四川省成都市','13030303030','dougg@qq.com',NULL,0),('yh007','qiji','qiji','亓霁','2000-02-01 00:00:00','1061604','女','0402','四川省成都市','13030303030','qiji@qq.com',NULL,0),('yh008','luogang','luogang','骆罡','2000-02-01 00:00:00','1061603','女','0309','四川省成都市','13030303030','luogang@qq.com',NULL,0),('yh009','lianxy','lianxy','连驯邕','2000-02-01 00:00:00','1061603','女','0302','四川省成都市','13030303030','lianxy@qq.com',NULL,0),('yh011','xingzi','xingzi','幸滓','2000-02-01 00:00:00','1061602','男','0206','四川省成都市','13030303030','xingzi@qq.com',NULL,0),('yh012','xuecha','xuecha','薛诧','2000-02-01 00:00:00','1061603','女','0302','四川省成都市','13030303030','xuecha@qq.com',NULL,0),('yh013','shanggss','shanggss','上官埏悚','2000-02-01 00:00:00','106160101','男','010105','四川省成都市','13030303030','shanggss@qq.com',NULL,0),('yh014','donggui','donggui','董炔','2000-02-01 00:00:00','106160101','男','010105','四川省成都市','13030303030','donggui@qq.com',NULL,0),('yh015','shenjiao','shenjiao','沈娇','2000-02-01 00:00:00','1061604','女','0402','四川省成都市','13030303030','shenjiao@qq.com',NULL,0),('yh016','tushua','tushua','屠唰','2000-02-01 00:00:00','1061601','男','0102','四川省成都市','13030303030','tushua@qq.com',NULL,0),('yh018','fangqu','fangqu','方祛','2000-02-01 00:00:00','1061602','男','0208','四川省成都市','13030303030','fangqu@qq.com',NULL,0),('yh019','taisz','taisz','太史毡','2000-02-01 00:00:00','1061603','女','0309','四川省成都市','13030303030','taisz@qq.com',NULL,0),('yh020','gonglc','gonglc','公良除','2000-02-01 00:00:00','1061602','男','0206','四川省成都市','13030303030','gonglc@qq.com',NULL,0),('yh021','site','site','司徒洱','2000-02-01 00:00:00','1061604','女','0403','四川省成都市','13030303030','site@qq.com',NULL,0),('yh022','kangmg','kangmg','抗慢磙','2000-02-01 00:00:00','1061601','女','0106','四川省成都市','13030303030','kangmg@qq.com',NULL,0),('yh025','renliao','renliao','任廖','2000-02-01 00:00:00','1061603','男','0309','四川省成都市','13030303030','renliao@qq.com',NULL,0),('yh026','gengao','gengao','耿岙','2000-02-01 00:00:00','106160101','女','010104','四川省成都市','13030303030','gengao@qq.com',NULL,0),('yh028','lugx','lugx','逯岗绪','2000-02-01 00:00:00','1061604','女','0408','四川省成都市','13030303030','lugx@qq.com',NULL,0),('yh029','shaochi','shaochi','韶持','2000-02-01 00:00:00','106160101','女','010102','四川省成都市','13030303030','shaochi@qq.com',NULL,0),('yh030','puyl','puyl','濮阳轹','2000-02-01 00:00:00','106160101','女','010104','四川省成都市','13030303030','puyl@qq.com',NULL,0),('yh031','danggc','danggc','党弓琛','2000-02-01 00:00:00','1061604','男','0407','四川省成都市','13030303030','danggc@qq.com',NULL,0),('yh032','qidd','qidd','戚阽埭','2000-02-01 00:00:00','1061603','男','0305','四川省成都市','13030303030','qidd@qq.com',NULL,0),('yh033','leixu','leixu','雷栩','2000-02-01 00:00:00','1061603','男','0302','四川省成都市','13030303030','leixu@qq.com',NULL,0),('yh034','niumai','niumai','牛埋','2000-02-01 00:00:00','1061604','女','0409','四川省成都市','13030303030','niumai@qq.com',NULL,0),('yh035','shaoxu','shaoxu','韶需','2000-02-01 00:00:00','1061604','男','0403','四川省成都市','13030303030','shaoxu@qq.com',NULL,0),('yh036','huoys','huoys','霍幼丨','2000-02-01 00:00:00','106160102','男','010202','四川省成都市','13030303030','huoys@qq.com',NULL,0),('yh037','chenling','chenling','陈瓴','2000-02-01 00:00:00','106160102','女','010206','四川省成都市','13030303030','chenling@qq.com',NULL,0),('yh038','tongbin','tongbin','佟滨','2000-02-01 00:00:00','1061602','女','0204','四川省成都市','13030303030','tongbin@qq.com',NULL,0),('yh039','lu:qi','lu:qi','闾迄','2000-02-01 00:00:00','1061604','女','0405','四川省成都市','13030303030','lu:qi@qq.com',NULL,0),('yh040','peilan','peilan','裴滥','2000-02-01 00:00:00','1061602','男','0206','四川省成都市','13030303030','peilan@qq.com',NULL,0),('yh041','jizz','jizz','嵇支仉','2000-02-01 00:00:00','1061604','女','0404','四川省成都市','13030303030','jizz@qq.com',NULL,0),('yh042','shangli','shangli','赏苈','2000-02-01 00:00:00','1061603','女','0303','四川省成都市','13030303030','shangli@qq.com',NULL,0),('yh043','quanyao','quanyao','全窈','2000-02-01 00:00:00','1061601','女','0107','四川省成都市','13030303030','quanyao@qq.com',NULL,0),('yh044','muhong','muhong','木哄','2000-02-01 00:00:00','106160101','男','010105','四川省成都市','13030303030','muhong@qq.com',NULL,0),('yh045','shangsc','shangsc','赏扇榇','2000-02-01 00:00:00','1061601','女','0108','四川省成都市','13030303030','shangsc@qq.com',NULL,0),('yh046','huanxin','huanxin','桓囟','2000-02-01 00:00:00','1061603','女','0307','四川省成都市','13030303030','huanxin@qq.com',NULL,0),('yh047','jiannk','jiannk','蹇你咔','2000-02-01 00:00:00','1061601','女','0103','四川省成都市','13030303030','jiannk@qq.com',NULL,0),('yh048','fengshao','fengshao','冯艄','2000-02-01 00:00:00','106160102','男','010206','四川省成都市','13030303030','fengshao@qq.com',NULL,0),('yh049','chupeng','chupeng','储捧','2000-02-01 00:00:00','106160102','男','010203','四川省成都市','13030303030','chupeng@qq.com',NULL,0),('yh050','xionghuang','xionghuang','熊遑','2000-02-01 00:00:00','106160101','男','010102','四川省成都市','13030303030','xionghuang@qq.com',NULL,0),('yh051','huafei','huafei','滑痱','2000-02-01 00:00:00','1061602','女','0206','四川省成都市','13030303030','huafei@qq.com',NULL,0),('yh052','kongts','kongts','空荑赡','2000-02-01 00:00:00','1061604','女','0409','四川省成都市','13030303030','kongts@qq.com',NULL,0),('yh053','xiangrw','xiangrw','项染雯','2000-02-01 00:00:00','1061604','女','0406','四川省成都市','13030303030','xiangrw@qq.com',NULL,0),('yh055','wengkun','wengkun','翁困','2000-02-01 00:00:00','1061604','男','0407','四川省成都市','13030303030','wengkun@qq.com',NULL,0),('yh056','shangjl','shangjl','尚佶傈','2000-02-01 00:00:00','1061603','女','0303','四川省成都市','13030303030','shangjl@qq.com',NULL,0),('yh057','hanghx','hanghx','杭号忻','2000-02-01 00:00:00','1061604','女','0409','四川省成都市','13030303030','hanghx@qq.com',NULL,0),('yh058','zuoqd','zuoqd','左丘督','2000-02-01 00:00:00','1061603','女','0305','四川省成都市','13030303030','zuoqd@qq.com',NULL,0),('yh060','raolang','raolang','饶琅','2000-02-01 00:00:00','106160101','男','010103','四川省成都市','13030303030','raolang@qq.com',NULL,0),('yh062','gongsou','gongsou','公螋','2000-02-01 00:00:00','106160102','男','010202','四川省成都市','13030303030','gongsou@qq.com',NULL,0),('yh063','qiukr','qiukr','邱寇颥','2000-02-01 00:00:00','1061601','男','0107','四川省成都市','13030303030','qiukr@qq.com',NULL,0),('yh064','huashui','huashui','滑氵','2000-02-01 00:00:00','106160102','男','010202','四川省成都市','13030303030','huashui@qq.com',NULL,0),('yh065','yandg','yandg','严堵概','2000-02-01 00:00:00','1061601','女','0106','四川省成都市','13030303030','yandg@qq.com',NULL,0),('yh066','gecr','gecr','戈操喏','2000-02-01 00:00:00','106160101','女','010103','四川省成都市','13030303030','gecr@qq.com',NULL,0),('yh067','liangqfj','liangqfj','梁丘府检','2000-02-01 00:00:00','106160101','男','010103','四川省成都市','13030303030','liangqfj@qq.com',NULL,0),('yh068','kangwang','kangwang','亢望','2000-02-01 00:00:00','1061602','男','0204','四川省成都市','13030303030','kangwang@qq.com',NULL,0),('yh069','luogg','luogg','罗纲佝','2000-02-01 00:00:00','106160102','女','010204','四川省成都市','13030303030','luogg@qq.com',NULL,0),('yh070','ganaj','ganaj','干傲贾','2000-02-01 00:00:00','1061603','男','0304','四川省成都市','13030303030','ganaj@qq.com',NULL,0),('yh071','jizhu','jizhu','吉煮','2000-02-01 00:00:00','1061602','男','0204','四川省成都市','13030303030','jizhu@qq.com',NULL,0),('yh072','chuhan','chuhan','储韩','2000-02-01 00:00:00','106160101','男','010105','四川省成都市','13030303030','chuhan@qq.com',NULL,0),('yh073','zhonggn','zhonggn','种毂难','2000-02-01 00:00:00','1061604','男','0402','四川省成都市','13030303030','zhonggn@qq.com',NULL,0),('yh074','ruanle','ruanle','阮轮洱','2000-02-01 00:00:00','106160101','女','010105','四川省成都市','13030303030','ruanle@qq.com',NULL,0),('yh075','zhugh','zhugh','诸葛菏','2000-02-01 00:00:00','1061604','女','0404','四川省成都市','13030303030','zhugh@qq.com',NULL,0),('yh076','yulw','yulw','庾蜊伪','2000-02-01 00:00:00','1061601','男','0103','四川省成都市','13030303030','yulw@qq.com',NULL,0),('yh078','lianghou','lianghou','梁猴','2000-02-01 00:00:00','1061602','女','0206','四川省成都市','13030303030','lianghou@qq.com',NULL,0),('yh079','youbo','youbo','尤钵','2000-02-01 00:00:00','1061604','男','0409','四川省成都市','13030303030','youbo@qq.com',NULL,0),('yh080','bianzy','bianzy','卞痔严','2000-02-01 00:00:00','1061603','男','0305','四川省成都市','13030303030','bianzy@qq.com',NULL,0),('yh081','jiecg','jiecg','解出矸','2000-02-01 00:00:00','106160102','女','010202','四川省成都市','13030303030','jiecg@qq.com',NULL,0),('yh082','chaofu','chaofu','巢缚','2000-02-01 00:00:00','1061601','男','0103','四川省成都市','13030303030','chaofu@qq.com',NULL,0),('yh083','zhitang','zhitang','挚汤','2000-02-01 00:00:00','1061602','女','0210','四川省成都市','13030303030','zhitang@qq.com',NULL,0),('yh084','bilz','bilz','毕稂鄹','2000-02-01 00:00:00','106160102','女','010202','四川省成都市','13030303030','bilz@qq.com',NULL,0),('yh085','nangpj','nangpj','南宫漂匠','2000-02-01 00:00:00','106160101','女','010102','四川省成都市','13030303030','nangpj@qq.com',NULL,0),('yh086','taobo','taobo','陶膊','2000-02-01 00:00:00','1061603','男','0305','四川省成都市','13030303030','taobo@qq.com',NULL,0),('yh087','yanxuan','yanxuan','闫旋','2000-02-01 00:00:00','1061603','女','0302','四川省成都市','13030303030','yanxuan@qq.com',NULL,0),('yh088','wenrlz','wenrlz','闻人炉窄','2000-02-01 00:00:00','1061601','女','0104','四川省成都市','13030303030','wenrlz@qq.com',NULL,0),('yh089','xingshuo','xingshuo','幸说','2000-02-01 00:00:00','1061602','男','0205','四川省成都市','13030303030','xingshuo@qq.com',NULL,0),('yh090','qiuxz','qiuxz','裘遐坠','2000-02-01 00:00:00','106160102','男','010202','四川省成都市','13030303030','qiuxz@qq.com',NULL,0),('yh092','zhongzhi','zhongzhi','种织','2000-02-01 00:00:00','1061601','女','0106','四川省成都市','13030303030','zhongzhi@qq.com',NULL,0),('yh093','murl','murl','慕容垄','2000-02-01 00:00:00','1061602','女','0205','四川省成都市','13030303030','murl@qq.com',NULL,0),('yh094','pangdiao','pangdiao','逄叼','2000-02-01 00:00:00','1061601','女','0105','四川省成都市','13030303030','pangdiao@qq.com',NULL,0),('yh096','putian','putian','浦添','2000-02-01 00:00:00','1061604','女','0410','四川省成都市','13030303030','putian@qq.com',NULL,0),('yh097','qiss','qiss','祁斯唆','2000-02-01 00:00:00','1061603','男','0306','四川省成都市','13030303030','qiss@qq.com',NULL,0),('yh098','shuqi','shuqi','舒奇','2000-02-01 00:00:00','1061602','男','0210','四川省成都市','13030303030','shuqi@qq.com',NULL,0),('yh099','zhuoxuan','zhuoxuan','卓楦','2000-02-01 00:00:00','106160102','女','010205','四川省成都市','13030303030','zhuoxuan@qq.com',NULL,0),('yh100','ximg','ximg','西门狗','2000-02-01 00:00:00','1061604','女','0406','四川省成都市','13030303030','ximg@qq.com',NULL,0),('yh101','dangcha','dangcha','党猹','2000-02-01 00:00:00','1061603','女','0308','四川省成都市','13030303030','dangcha@qq.com',NULL,0),('yh102','xingyy','xingyy','邢业欲','2000-02-01 00:00:00','1061604','男','0408','四川省成都市','13030303030','xingyy@qq.com',NULL,0),('yh103','yougou','yougou','游沟','2000-02-01 00:00:00','1061604','男','0408','四川省成都市','13030303030','yougou@qq.com',NULL,0),('yh104','dongmsq','dongmsq','东门讼芹','2000-02-01 00:00:00','106160101','男','010105','四川省成都市','13030303030','dongmsq@qq.com',NULL,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
