<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>
<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<%	
	request.setCharacterEncoding("UTF-8");
	String welcome = "";
	welcome = request.getParameter("welcome");
%>
<div class="box-positon">
	<div class="rpos">当前位置: <%=welcome %> - 欢迎页</div>	
	<div class="clear"></div>
</div>

<div class="body-box">
	<div class="welcom-con">
		<div class="we-txt">
			<p>
			欢迎使用大学生创新创业训练计划管理平台！<br />
			程序版本：大学生创新创业训练计划管理平台-2015-v1.0 <br /><br /><br />                      
			</p>
		</div>
	</div> 
</div>
</body>
</html>