<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>数据导出</title>
</head>
<body>
<%@include file="/backsys/include/back_check.jsp" %>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	request.setCharacterEncoding("UTF-8");
	
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmmssSSS");
	String UId=sdf.format(date)+String.format("%1$03d",(new Random()).nextInt(1000));
	
	String sql = (String)session.getAttribute("sql");		
	if(sql==null) sql="";
	//System.out.println(flag);
			
	List<Object[]> notes = new ArrayList<Object[]>();
	
	notes = DataBase.listQuery(datasource,sql);
	for (Iterator<Object[]> it = notes.iterator(); it.hasNext();) {
		Object[] note = it.next();			    	    
	    if(note[16]!=null && !"".equals(note[16].toString()) ) {
		    String []temp_str = note[16].toString().replace("，", ",").split(",");
		    if(note[10].toString().indexOf('/')==-1) note[10] = note[10] + "/";		    
		    note[11] = note[10]+"";		    
		    note[10] = note[10].toString().substring(0,note[10].toString().indexOf('/'));
		    note[11] = note[11].toString().substring(note[11].toString().indexOf('/')+1);
		    for(int i =0;i<temp_str.length;i++){
		    	if(temp_str[i].indexOf('/')==-1) temp_str[i] = temp_str[i] + "/";
		    	note[10] =note[10]+","+temp_str[i].substring(0, temp_str[i].indexOf('/')) ;
		    	note[11] =note[11]+","+temp_str[i].substring(temp_str[i].indexOf('/')+1) ;
		    }
	    }else{
	    	if(note[10].toString().indexOf('/')==-1) note[10] = note[10] + "/";
	    	note[11] = note[10]+"";		    
		    note[10] = note[10].toString().substring(0,note[10].toString().indexOf('/'));
		    note[11] = note[11].toString().substring(note[11].toString().indexOf('/')+1);
		    
	    }
    }
       
	String[] str = {"立项年份","3000","项目级别","3000","项目编号","3000","项目名称","4000","项目类型","3000","项目负责人姓名","4500","项目负责人学号","4500","项目负责人联系方式","5500","参与学生人数","4000","项目其他成员信息","5500","指导教师姓名","4000","指导教师职称","4000","项目所属一级学科代码","6500","资助金额","3000","项目结题时间","4000","项目简介(200字以内)","20000"};
	String title2 = "联系人："+((Map<String,String>)session.getAttribute("userinfo")).get("realname");
	title2 += "  联系电话："+((Map<String,String>)session.getAttribute("userinfo")).get("phone");
	title2 += "  电子邮箱：  ";    				
	RWExcel.createTable(UId+".xls","信息表","国家级大学生创新创业训练计划项目信息表",title2,str,notes,request,response,response.getOutputStream());
%>
</body>
</html>