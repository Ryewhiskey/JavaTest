<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.text.*,java.util.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新闻</title>

<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>


</head>
<body class="lbody">
<div class="left">
	 <%@include file="../include/date.jsp" %>
     <ul class="w-lful">
     	
     	<li><a href="../include/list.jsp?welcome=内容" target="rightFrame">欢迎页</a></li>
     	
     	<li><a href="gggl/admin.jsp" target="rightFrame">公告管理</a></li>
    	
    	<li><a href="download/admin.jsp" target="rightFrame">下载专区</a></li>
    	
    	<li><a href="friendlink/admin.jsp" target="rightFrame">友情链接</a></li>
  	
    	<li><a href="news/alone.jsp?id=1" target="rightFrame">大创简介</a></li>
    	
    	<li><a href="news/alone.jsp?id=2" target="rightFrame">联系我们</a></li>

     </ul>
</div>
</body>
</html>