<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>大学生创新创业训练计划管理平台</title>
<meta content="" name="keywords" />
<meta content="" name="description" />
<link rel="stylesheet" type="text/css" href="front/res/css/admin.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/theme.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/default.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/dropmenu.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/list_detail.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/front_login.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/mytheme.css"/>

<script type="text/javascript" src="front/res/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="front/res/js/dropmenu.js"></script>
<script type="text/javascript" src="front/res/js/login.js"></script>

</head>

<body>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	request.setCharacterEncoding("UTF-8");
	
%>
    <%@include file="/front/include/header.jsp" %>
    <div id="subcontent" >    	
    	<%@include file="/front/include/left1.jsp" %>

<%
	String resp=(String)session.getAttribute("resp");
	String flag="";
	String tid="",jsbh="",name="",zy="",phone="",xb="",mm="",zc="",bmbh="",yjly="",email="",islock="";//1-否   2-禁用	
	int count = 0; 	
	
	tid = request.getParameter("tid");
	
	if( tid!=null && !"".equals(tid.trim()) ){
		String sql = "select jsbh,name,xb,zy,bmbh,zc,yjly,phone,email,mm,islock from teacher where islock='1' and tid = '" + tid + "'";
		
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	jsbh=note[0].toString();
			if(note[1]!=null) 	name=note[1].toString();
			if(note[2]!=null) 	xb=note[2].toString();
			if(note[3]!=null) 	zy=note[3].toString();
			if(note[4]!=null) 	bmbh=note[4].toString();	
			if(note[5]!=null) 	zc=note[5].toString();
			if(note[6]!=null) 	yjly=note[6].toString();
			if(note[7]!=null) 	phone=note[7].toString();
			if(note[8]!=null) 	email=note[8].toString();
			if(note[10]!=null) 	islock=note[10].toString();
		}
	}

%>
        <div class="right" >
        	<div class="content_right_search">        
        	<div class="content_search_result">
                <div class="search_result_border" >
                    <div style="float:left;"><span>导师库</span></div>
	                <div style="margin-right:10px;float:right;">
	                	<form class="ropt" method="post">
							<input type="submit" value="返回列表" onclick="this.form.action='front/dsk/index.jsp<%=resp %>';" class="return-button"/>
						</form>
	                </div>
                </div>                
			</div>   
			<div id="search_result">
				<div class="result_content">
					<div id="newsquery">
						<ul id="queryul">
							<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
								<tr>
									<td width="12%" class="pn-flabel pn-flabel-h">教工号:</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										<%=jsbh %>
									</td>
									<td width="12%" class="pn-flabel pn-flabel-h">姓名:</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										<%=name %>
									</td>
								</tr>
										
								<tr>
									<td width="12%" class="pn-flabel pn-flabel-h">联系电话:</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										<%=phone %>
									</td>
									<td width="12%" class="pn-flabel pn-flabel-h">性别:</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										<%=xb %>
									</td>
								</tr>
								<tr>
									<td width="12%" class="pn-flabel pn-flabel-h">学院:</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										
						<%
										
										notes = DataBase.listQuery(datasource,"select id,name from v_leaf where pid='1' and id='"+bmbh+"'");
										for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
											Object[] note = it.next();	
						%>
											<%=note[1].toString() %>
											
						<%} %>			
										
									</td>
									<td width="12%" class="pn-flabel pn-flabel-h">专业</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										<%=zy %>
									</td>
								</tr>
								<tr>
									<td width="12%" class="pn-flabel pn-flabel-h">职称:</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										<%=zc %>
									</td>
									<td width="12%" class="pn-flabel pn-flabel-h">研究领域</td>
									<td colspan="1" width="38%" class="pn-fcontent">
										<%=yjly %>
									</td>
								</tr>		
								
								<tr>
									<td width="12%" class="pn-flabel pn-flabel-h">邮箱:</td>
									<td colspan="3" width="88%" class="pn-fcontent">
										<%=email %>
									</td>
									
								</tr>
								
							</table>        
						</ul>
					</div>
					
				</div>
			</div>
			</div>            
		</div>	
	</div>      
   
    <%@include file="/front/include/bottom.html" %>
</body>
</html>
