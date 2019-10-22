-- 创建设备管理数据库
CREATE DATABASE IF NOT EXISTS cxcy default charset utf8 COLLATE utf8_general_ci;
use cxcy;

-- 在线用户表
DROP TABLE IF EXISTS onlineuser;
create table onlineuser(
	sessionid varchar(48) primary key,
	yhbh varchar(20),
	loginpage varchar(50),
	logintime varchar(50) not null
);
-- 部门表
DROP TABLE IF EXISTS department;
create table department(
	id varchar(20) primary key, 	-- 部门编号
	name varchar(30) unique not null, 		-- 部门名称
	pid varchar(20),				-- 上级部门编号
	ord int not null				-- 排列顺序
	
);
insert into department 
values('1','兰州理工大学','-1',1);

-- 查找叶子部门
DROP VIEW IF EXISTS v_leaf;
create view v_leaf
as
select id,name,pid,ord
from department
where id not in (select pid from department);

-- 创建管理员表 
DROP TABLE IF EXISTS admin;
create table admin(
	yhbh varchar(20) primary key,		-- 用户编号
	yhm varchar(30) unique not null,	-- 用户名
	realname varchar(30) not null,		-- 真实姓名
	phone varchar(11),					-- 联系电话
	xb varchar(2) not null,				-- 性别
	mm varchar(20) not null,			-- 密码
	bmbh varchar(20) not null,			-- 部门编号
	glyz int not null,					-- 管理员组
	islock int not null,  				-- 是否禁用 1-否   2-禁用
	foreign key(bmbh) references department(id)
);
insert into admin 
values('20150214114212123456','admin','admin','','密','manager','1','1','1');

-- 创建管理员视图
DROP view IF EXISTS v_admin;
create VIEW v_admin(yhbh,yhm,realname,phone,xb,mm,bmbh,glyz,islock)
as
select yhbh,yhm,realname,phone,xb,mm,bmbh,glyz,islock
from admin
;

-- 创建导师表
DROP TABLE IF EXISTS teacher;
create table teacher(
	tid varchar(20) primary key,		-- 编号
	jsbh varchar(20) unique not null,	-- 教工号
	name varchar(30) not null,			-- 姓名
	xb varchar(2) not null,				-- 性别
	zy varchar(30) not null,			-- 专业
	bmbh varchar(30) not null,			-- 学院
	zc varchar(10) not null,			-- 职称
	yjly varchar(50) not null,			-- 研究领域
	phone varchar(11) not null,			-- 联系电话
	email varchar(30) not null,			-- 邮箱	
	mm varchar(20) not null,			-- 密码	
	islock varchar(2) not null,  		-- 是否禁用 1-否   2-禁用
	foreign key(bmbh) references department(id)
);


-- 创建学生表
DROP TABLE IF EXISTS student;
create table student(
	sid varchar(20) primary key,		-- id
	xh varchar(20) unique not null,		-- 学号
	name varchar(30) not null,			-- 姓名
	xb varchar(2) not null,				-- 性别
	zy varchar(30) not null,			-- 专业
	bmbh varchar(30) not null,			-- 学院
	phone varchar(11) not null,					-- 联系电话
	email varchar(30) not null,			-- 邮箱	
	mm varchar(20) not null,			-- 密码	
	islock varchar(2) not null,  		-- 是否禁用 1-否   2-禁用
	foreign key(bmbh) references department(id)
);

-- 创建前台用户视图
DROP view IF EXISTS v_member;
create view v_member(yhbh,yhm,realname,bmbh,mm,yhz,islock)
as
select yhbh,yhm,realname,bmbh,mm,glyz,islock from admin
union
select tid,jsbh,name,bmbh,mm,'3',islock from teacher
union
select sid,xh,name,bmbh,mm,'4',islock from student
;

-- 学科代码表
DROP TABLE IF EXISTS xkdmb;
create table xkdmb(
	id VARCHAR(20) primary key,	-- 学科代码
	name VARCHAR(100) not null	-- 学科名称	
);

-- 创建项目汇总表
DROP TABLE IF EXISTS xmhzb;
create table xmhzb(
	id varchar(20) primary key,		-- id
	lxnf varchar(4) not null,		-- 立项年份	 
	xmjb varchar(20) not null,		-- 项目级别
	xmbh varchar(20) unique,				-- 项目编号
	xmmc varchar(100) not null,		-- 项目名称
	xmlx varchar(20) not null,		-- 项目类型
	fzr	varchar(20) not null,		-- 负责人学号
									-- 负责人姓名
									-- 负责人联系方式
	cyrs int not null,				-- 参与学生人数
	qtcy varchar(100),				-- 项目其他成员信息
	dsbh varchar(50) not null,		-- 指导教师姓名（编号）
									-- 指导教师职称
	qtds varchar(100),				-- 其他指导教师
	yjxkdm varchar(10) not null,	-- 项目所属一级学科代码
	zzje float not null,			-- 资助金额
	jtsj varchar(10) not null,		-- 项目结题时间
	xmjj varchar(300) not null,		-- 项目简介(200字以内)
	foreign key(fzr) references student(xh),	
	foreign key(yjxkdm) references xkdmb(id)
);

-- 成果展示表
DROP TABLE IF EXISTS cgzsb;
create table cgzsb(
	id VARCHAR(20) primary key,	-- 编号
	xmid VARCHAR(20) unique not null,	-- 项目id	
	filename VARCHAR(100),		-- 文件名
	content text,				-- 内容
	issuccess VARCHAR(2),		-- 审批意见	1-未审核  2-审核
	foreign key(xmid) references xmhzb(id)
);
-- 创建项目成果视图
DROP view IF EXISTS v_xm_cg;
create view v_xm_cg(cgzsb_id,xmid,content,filename,issuccess,lxnf,xmjb,xmbh,xmmc,xmlx,fzr,cyrs,qtcy,dsbh,qtds,yjxkdm,zzje,jtsj,xmjj)
as
select cgzsb.id,xmid,content,filename,issuccess,lxnf,xmjb,xmbh,xmmc,xmlx,fzr,cyrs,qtcy,dsbh,qtds,yjxkdm,zzje,jtsj,xmjj 
from cgzsb,xmhzb 
where cgzsb.xmid=xmhzb.id;

-- 公告表
DROP TABLE IF EXISTS ggb;
create table ggb(
	id VARCHAR(20) primary key,	-- 编号
	title VARCHAR(100) not null,	-- 标题
	dw VARCHAR(100) not null,	-- 单位
	fbrq VARCHAR(10) not null,	-- 发布日期
	content text,				-- 内容
	issuccess VARCHAR(2),		-- 审批意见	1-未审核  2-审核
	unique(title,fbrq)
);

-- 资料下载表
DROP TABLE IF EXISTS zlxzb;
create table zlxzb(
	id VARCHAR(20) primary key,	-- 编号
	name VARCHAR(100) not null,	-- 资料名称	
	fbr VARCHAR(100) not null,	-- 发布人
	fbrq VARCHAR(10) not null,	-- 发布日期
	filename VARCHAR(100),		-- 文件名
	issuccess VARCHAR(2),		-- 审批意见	1-未审核  2-审核
	unique(name,fbrq)
);

-- 友情链接表
DROP TABLE IF EXISTS friendlink;
create table friendlink(
	id VARCHAR(20) primary key,	-- 编号
	name VARCHAR(100) not null,	-- 名称	
	addr VARCHAR(100) not null,	-- 链接地址	
	unique(addr)
);

-- 新闻表
DROP TABLE IF EXISTS news;
create table news(
	id VARCHAR(20) primary key,	-- 编号
	title VARCHAR(100) not null,	-- 新闻标题
	fbr VARCHAR(100) not null,	-- 发布人
	fbrq VARCHAR(10) not null,	-- 发布日期
	content text,				-- 新闻内容
	issuccess VARCHAR(2),		-- 审批意见	1-未审核  2-审核
	unique(title,fbrq)
);
insert into news values('1','平台简介','admin','2015-01-16','','2');
insert into news values('2','联系我们','admin','2015-01-16','','2');

--创建咨询表 
DROP TABLE IF EXISTS zxb;
create table zxb(
	id varchar(20) primary key,		-- id号
	zxr varchar(20) references v_member(yhbh),	-- 咨询人id
	zxrq varchar(10) not null,	-- 咨询日期	
	zxcnt varchar(1000) not null,	-- 咨询内容
	hfrq varchar(10),	-- 回复日期
	hfr varchar(20) references admin(yhbh),	-- 回复人
	hfcnt varchar(1000)	-- 回复内容 	
);

-- 创建咨询视图
DROP view IF EXISTS v_zx;
create view v_zx(id,zxr,zxrname,zxrq,zxcnt,hfr,hfrname,hfrq,hfcnt)
as
select id,zxr,v_member.realname,zxrq,zxcnt,hfr,admin.realname,hfrq,hfcnt from zxb 
left join v_member
on zxb.zxr=v_member.yhbh
left join admin
on zxb.hfr=admin.yhbh 
;

