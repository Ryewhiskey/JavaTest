<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");		
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<title>大学生创新创业训练计划管理平台</title>
<link rel="stylesheet" type="text/css" href="front/res/css/admin.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/theme.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/default.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/dropmenu.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/front_login.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/newscontent.css"/>

<script type="text/javascript" src="front/res/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="front/res/js/login.js"></script>
<script type="text/javascript" src="front/res/js/dropmenu.js"></script>
</head>

<body>
    <%@include file="/front/include/header.jsp" %>
    <div id="subcontent">
    	<%@include file="/front/include/left1.jsp" %>
        <div class="right">
            <div id="newscontent">
<%			
			
			notes = DataBase.listQuery(datasource,"select title,dw,fbrq,content from ggb where id='"+request.getParameter("id")+"'");
			for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
				Object[] note = it.next();	
%>
                        <div class="newstitle"><%=note[0].toString()  %></div>
    
                            <div class="info">
                              	发布单位：<%=note[1].toString()  %>&nbsp;&nbsp;&nbsp;&nbsp;
								发布时间：<%=note[2].toString()  %>
                                     
                            </div>
                            
                            <div class="con" id="con">
                            	<%=note[3].toString()  %>
                            </div>
<%
				}
%>            
             </div>
                
        </div>      
    </div>
    <%@include file="/front/include/bottom.html" %>
</body>
</html>
