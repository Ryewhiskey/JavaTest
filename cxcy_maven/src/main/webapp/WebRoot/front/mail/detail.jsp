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
	String id="",zxr="";
	String zxrname = "";
	String zxrq="";
	String zxcnt="";
	String hfrq="";
	String hfr="";
	String hfrname ="";
	String hfcnt="";	 		
	
	id = request.getParameter("id");
	if( id!=null && !"".equals(id.trim()) ){
		String sql = "select zxr,zxrname,zxrq,zxcnt,hfr,hfrname,hfrq,hfcnt from v_zx where id = '" + id + "'";
		
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	zxr=note[0].toString();
			if(note[1]!=null) 	zxrname=note[1].toString();
			if(note[2]!=null) 	zxrq=note[2].toString();			
			if(note[3]!=null)	zxcnt=note[3].toString();
			if(note[4]!=null) 	hfr=note[4].toString();
			if(note[5]!=null) 	hfrname=note[5].toString();
			if(note[6]!=null) 	hfrq=note[6].toString();			
			if(note[7]!=null)	hfcnt=note[7].toString();
								
		}
	}	
 
%>

        <div class="right" >
        	<div class="content_right_search">        
        	<div class="content_search_result">
                <div class="search_result_border" >
                    <div style="float:left;"><span>咨询问答</span></div>
	                <div style="margin-right:10px;float:right;">
	                	<form class="ropt" method="post">
							<input type="submit" value="返回列表" onclick="this.form.action='front/mail/index.jsp<%=resp %>';" class="return-button"/>
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
									<td width="70px;" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询人:</td>
									<td colspan="1" width="70px;" class="pn-fcontent">										
										<%=zxrname %>
									</td>
									<td width="70px;" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询日期:</td>
									<td colspan="1" width="460px;" class="pn-fcontent">
										<%=zxrq %>
									</td>
									
								</tr>
								<tr>
									<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询内容:</td>
									<td colspan="3" class="pn-fcontent">
										<div class="con" id="con" style="width:560px;line-height:30px;">
			                            	<%=zxcnt %>
			                            </div>				
									</td>
									
								</tr>
								<tr>
									<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复人:</td>
									<td colspan="1" class="pn-fcontent">										
										<%=hfrname %>
									</td>
									<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复日期:</td>
									<td colspan="1" class="pn-fcontent">
										<%=hfrq %>						
									</td>
								</tr>
								<tr>			
									<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复内容:</td>
									<td colspan="3" class="pn-fcontent">
										<div class="con" id="con" style="width:560px;line-height:30px;">
			                            	<%=hfcnt %>
			                            </div>
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
