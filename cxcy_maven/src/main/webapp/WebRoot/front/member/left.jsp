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
<meta http-equiv="x-ua-compatible" content="ie=7" /> 
<title>left</title>
<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>

</head>
<%@include file="/front/include/front_check.jsp" %>
<body class="lbody">
<div class="left">
	 <%@include file="../include/date.jsp" %>
     <ul class="w-lful">
<%
     	String yhz = ((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz");	
		if(yhz !=null && "2".equals(yhz)){
%>			
			<li><a href="sysadmin/updt.jsp" target="rightFrame">个人信息</a></li>
			<li><a href="dsk/admin.jsp" target="rightFrame">导师库</a></li>
<%
		}
		if(yhz !=null && "3".equals(yhz)) {	
 %>
			<li><a href="dsxx/updt.jsp" target="rightFrame">个人信息</a></li>
			
<%		
		}
		if(yhz !=null && "4".equals(yhz)) {	
 %>
			<li><a href="xsxx/updt.jsp" target="rightFrame">个人信息</a></li>
			
<%		
		}
 %>		
     		<li><a href="xmgl/admin.jsp" target="rightFrame">项目管理</a></li>
			<li><a href="cggl/admin.jsp" target="rightFrame">成果管理</a></li>
			<li><a href="zxwd/admin.jsp" target="rightFrame">咨询问答</a></li>
     </ul>
</div>
</body>
</html>