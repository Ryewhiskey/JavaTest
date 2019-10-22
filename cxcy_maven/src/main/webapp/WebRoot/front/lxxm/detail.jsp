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
	if(resp==null) resp = "";
		
	String id="",lxnf="",xmjb="",xmbh="",xmmc="",xmlx="",fzr="";
	String cyrs="",qtcy="",dsbh="",qtds="",yjxkdm="",zzje="",jtsj="",xmjj="";
	
	id = request.getParameter("id");
	
	if( id != null && !"".equals(id) ){
		String sql = "select id,lxnf,xmjb,xmbh,xmmc,xmlx,fzr,cyrs,qtcy,dsbh,qtds,yjxkdm,zzje,jtsj,xmjj from xmhzb where id = '" + id + "'";
		
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[1]!=null) 	lxnf=note[1].toString();
			if(note[2]!=null) 	xmjb=note[2].toString();
			if(note[3]!=null) 	xmbh=note[3].toString();
			if(xmbh==null || "".equals(xmbh)) xmbh = "111111111111";
			if(note[4]!=null) 	xmmc=note[4].toString();	
			if(note[5]!=null) 	xmlx=note[5].toString();
			if(note[6]!=null) 	fzr=note[6].toString();
			if(note[7]!=null) 	cyrs=note[7].toString();
			if(note[8]!=null) 	qtcy=note[8].toString();
			if(note[9]!=null) 	dsbh=note[9].toString();
			if(note[10]!=null) 	qtds=note[10].toString();
			if(note[11]!=null) 	yjxkdm=note[11].toString();
			if(note[12]!=null) 	zzje=note[12].toString();
			if(note[13]!=null) 	jtsj=note[13].toString();
			if(note[14]!=null) 	xmjj=note[14].toString();								
		}
	}
	
%>

        <div class="right" >
        	<div class="content_right_search">        
        	<div class="content_search_result">
                <div class="search_result_border" >
                    <div style="float:left;"><span>项目一览</span></div>
	                <div style="margin-right:10px;float:right;">
	                	<form class="ropt" method="post">
							<input type="submit" value="返回列表" onclick="this.form.action='front/lxxm/index.jsp<%=resp %>';" class="return-button"/>
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
								<td width="12%" class="pn-flabel pn-flabel-h">项目编号:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=xmbh %>
								</td>
								<td width="12%" class="pn-flabel pn-flabel-h">项目名称:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=xmmc %>				
								</td>
							</tr>
							<tr>
								<td width="12%" class="pn-flabel pn-flabel-h">项目类型:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=xmlx %>
								</td>
								<td width="12%" class="pn-flabel pn-flabel-h">立项年份:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=lxnf %>
								</td>
							</tr>
							<tr>
								<td width="12%" class="pn-flabel pn-flabel-h">项目级别:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=xmjb %>
								</td>
								<td width="12%" class="pn-flabel pn-flabel-h">负责人:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									
					<%				
									notes = DataBase.listQuery(datasource,"select xh,name from student where xh='"+fzr+"'");
									Iterator<Object[]> it=notes.iterator();
									if(it.hasNext()) {	
										Object[] note = it.next();	
					%>
										<%=note[1].toString() %>
										
					<%} %>			
									
								</td>
							</tr>
							<tr>
								<td width="12%" class="pn-flabel pn-flabel-h">参与学生人数:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=cyrs %>
								</td>
								<td width="12%" class="pn-flabel pn-flabel-h">一级学科:</td>
								<td colspan="1" width="38%" class="pn-fcontent">									
					<%				
									notes = DataBase.listQuery(datasource,"select id,name from xkdmb where id='"+yjxkdm+"'");
									it=notes.iterator();
									if(it.hasNext()) {	
										Object[] note = it.next();	
					%>
										<%=note[1].toString() %>
										
					<%} %>			
									
								</td>
							</tr>
							<tr>			
								<td width="12%" class="pn-flabel pn-flabel-h">项目其他成员:</td>
								<td colspan="3" width="88%" class="pn-fcontent">
									<%=qtcy %>
									
								</td>
							</tr>
							<tr>
								<td width="12%" class="pn-flabel pn-flabel-h">指导教师:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=dsbh %>
								</td>
								<td width="12%" class="pn-flabel pn-flabel-h">结题时间:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=jtsj %>
								</td>
							</tr>
							<tr>
								
								<td width="12%" class="pn-flabel pn-flabel-h">其他指导教师:</td>
								<td colspan="3" width="88%" class="pn-fcontent">
									<%=qtds %>
									
								</td>
							</tr>		
							<tr>
								
								<td width="12%" class="pn-flabel pn-flabel-h">资助金额:</td>
								<td colspan="3" width="88%" class="pn-fcontent">
									<%=zzje %>
								</td>
							</tr>					
							
							<tr>
								<td width="12%" class="pn-flabel pn-flabel-h">项目简介:</td>
								<td colspan="3" width="88%" class="pn-fcontent">
									<%=xmjj %>
									
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
