<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.text.*,com.mchange.v2.c3p0.ComboPooledDataSource,cn.lut.bear.admin.*"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="x-ua-compatible" content="ie=7" /> 
<title>right</title>
<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>

</head>
<%
	Runtime runtime = null;
	long freeMemoery = 0, totalMemory = 0, usedMemory = 0, maxMemory = 0, useableMemory = 0;
	
	Properties props = null;	
	Map<String,String> sysconfig = new HashMap<String,String>();	
	ComboPooledDataSource datasource = null;
	
	Connection conn = null;
%>
<%
	runtime = Runtime.getRuntime();
	freeMemoery = runtime.freeMemory()/1024/1024;
	totalMemory = runtime.totalMemory()/1024/1024;
	usedMemory = totalMemory - freeMemoery;
	maxMemory = runtime.maxMemory()/1024/1024;
	useableMemory = maxMemory - totalMemory + freeMemoery;
	//System.gc();
	props = (Properties)application.getAttribute("props");	
	sysconfig = (Map)application.getAttribute("sysconfig");	
	datasource = (ComboPooledDataSource)application.getAttribute("datasource");
	
	conn = DataBase.getConn(datasource);
	
	//System.out.println(conn);
	DataBase.close(conn);
%>
<body>
  	    <div class="box-positon">
        	 <h1>当前位置: 首页 - 欢迎页</h1>
        </div>
<div class="body-box">
        <div class="welcom-con">
        	 <div class="we-txt">
             	  <p> 
                  欢迎使用大学生创新创业训练计划管理平台！<br />
                  程序版本：大学生创新创业训练计划管理平台-2015-v1.0 <br />                 
                  已用内存：<span style="color:#0078ff;"><%=usedMemory %>MB</span>&nbsp;&nbsp;&nbsp;&nbsp;剩余内存：<span style="color:#ff8400;"><%=useableMemory %> MB </span>&nbsp;&nbsp;&nbsp;&nbsp;最大内存：<span style="color:#00ac41;"><%=maxMemory %>MB</span>
                  </p>
             </div>
             <ul class="ms">
             	
             	<li class="attribute" style="margin-left:100px;">系统属性</li>
             </ul>
             <div class="ms-xx">
                 
                 <div class="attribute-xx" style="float:left">
                 	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="30%" height="30" align="right">操作系统版本：</td>
                            <td height="30"><span class="black"><% out.print(props.getProperty("os.name")+" "+props.getProperty("os.version")); %></span></td>
                        </tr>
                          <tr>
                            <td width="30%" height="30" align="right">操作系统类型：</td>
                            <td height="30"><span class="black"><% out.print(props.getProperty("os.arch")+" "+props.getProperty("sun.arch.data.model") ); %>位</span> </td>
                        </tr>
                          <tr>
                            <td width="30%" height="30" align="right">用户、目录、临时目录：</td>
                            <td height="30"><span class="black"><% out.print(props.getProperty("user.name")+" "+props.getProperty("user.dir")+" "+props.getProperty("java.io.tmpdir") ); %></span></td>
                        </tr><tr>
                            <td width="30%" height="30" align="right">JAVA运行环境：</td>
                            <td height="30"><span class="black"><% out.print(props.getProperty("java.runtime.name")+" "+props.getProperty("java.runtime.version")); %></span></td>
                          </tr>
                          <tr>
                            <td width="30%" height="30" align="right">JAVA虚拟机：</td>
                            <td height="30"> <span class="black"><% out.print(props.getProperty("java.vm.name")+" "+props.getProperty("java.vm.version")); %></span></td>
                        </tr>
                   </table>  
               </div>

             </div>
           </div> 
  </div>
</body>
</html>