<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<title>创新创业-后台管理</title>

<script type="text/javascript">
window.onbeforeunload = shutwin; 
function shutwin(){	
	window.location.href='sessiondelete.jsp';
}
</script>
</head>


<frameset rows="72,*" frameborder=no border="0" framespacing="0">
	<frame src="top.jsp" name="topFrame" noresize="noresize" id="topFrame" />
	<frame src="main.jsp" name="mainFrame" id="mainFrame" />
</frameset>

<noframes>
	<body>
		对不起，您的浏览器不支持框架网页！
	</body>
</noframes>
</html>
