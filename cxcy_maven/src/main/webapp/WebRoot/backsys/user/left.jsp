<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>left</title>

<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>


</head>
<body class="lbody">
	<div class="left">
		 <%@include file="../include/date.jsp" %>
	     <ul class="w-lful">
	     	
	     	<li><a href="list.html" target="rightFrame">欢迎页</a></li>
	     	
			<li><a href="sysadmin/admin.jsp" target="rightFrame">管理员</a></li>
			
<!-- 			<li><a href="teacher/admin.jsp" target="rightFrame">导师</a></li>    -->
			
			<li><a href="student/admin.jsp" target="rightFrame">学生</a></li>
			
	     </ul>
	</div>
</body>
</html>