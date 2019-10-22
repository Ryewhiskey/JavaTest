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
	
	String id="",cgzsb_id="",content="",xmjb="",xmmc="",fzr="";
	String cyrs="",qtcy="",dsbh="",qtds="",yjxkdm="",filename="";
	
	id = request.getParameter("id");	
	if( id != null && !"".equals(id) ){
		String sql = "select cgzsb_id,xmjb,xmmc,student.name,cyrs,qtcy,dsbh,qtds,xkdmb.name,content,filename from v_xm_cg,student,xkdmb where v_xm_cg.fzr=student.xh and v_xm_cg.yjxkdm=xkdmb.id and cgzsb_id = '" + id + "'";
		
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[1]!=null) 	xmjb=note[1].toString();
			if("国家级".equals(xmjb)) xmjb = "精品"; else xmjb = "一般";
			if(note[2]!=null) 	xmmc=note[2].toString();
			if(note[3]!=null) 	fzr=note[3].toString();			
			if(note[4]!=null) 	cyrs=note[4].toString();	
			if(note[5]!=null) 	qtcy=note[5].toString();
			if(note[6]!=null) 	dsbh=note[6].toString();
			if(note[7]!=null) 	qtds=note[7].toString();
			if(note[8]!=null) 	yjxkdm=note[8].toString();
			if(note[9]!=null) 	content=note[9].toString();
			if(note[10]!=null) 	filename=note[10].toString();								
		}
	}
	
%>

        <div class="right" >
        	<div class="content_right_search">        
        	<div class="content_search_result">
                <div class="search_result_border" >
                    <div style="float:left;"><span>成果展示</span></div>
	                <div style="margin-right:10px;float:right;">
	                	<form class="ropt" method="post">
							<input type="submit" value="返回列表" onclick="this.form.action='front/cgzs/index.jsp<%=resp %>';" class="return-button"/>
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
								<td width="20%" class="pn-flabel pn-flabel-h">成果名称:</td>
								<td colspan="1" width="30%" class="pn-fcontent">
									<%=xmmc %>				
								</td>
								<td width="12%" class="pn-flabel pn-flabel-h">成果级别:</td>
								<td colspan="1" width="38%" class="pn-fcontent">
									<%=xmjb %>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">负责人:</td>
								<td colspan="1" class="pn-fcontent">
									<%=fzr %>
								</td>
								<td class="pn-flabel pn-flabel-h">参与人数:</td>
								<td colspan="1" class="pn-fcontent">
									<%=cyrs %>
								</td>
							</tr>
							
							<tr>			
								<td class="pn-flabel pn-flabel-h">其他成员:</td>
								<td colspan="3" class="pn-fcontent">
									<%=qtcy %>
									
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">指导教师:</td>
								<td colspan="1" class="pn-fcontent">
									<%=dsbh %>
									
								</td>
								<td class="pn-flabel pn-flabel-h">所属学科:</td>
								<td colspan="1" class="pn-fcontent">
									<%=yjxkdm %>
								</td>
							</tr>
							<tr>
								
								<td class="pn-flabel pn-flabel-h">其他指导教师:</td>
								<td colspan="3" class="pn-fcontent">
									<%=qtds %>
									
								</td>
							</tr>
							<tr>
								
								<td colspan="4" class="pn-fcontent">
									<img width="660px;" src="<%=path %>/UploadDir/news/<%=filename %>" />
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
