<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page
	import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()	+ path + "/";

	ComboPooledDataSource datasource = (ComboPooledDataSource) application.getAttribute("datasource");
	//Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	//Map<String,String> userinfo = (Map)session.getAttribute("userinfo");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>大学生创新创业训练计划管理平台</title>
<meta content="" name="keywords" />
<meta content="" name="description" />
<link rel="stylesheet" type="text/css" href="front/res/css/admin.css" />
<link rel="stylesheet" type="text/css" href="front/res/css/theme.css" />
<link rel="stylesheet" type="text/css" href="front/res/css/default.css" />
<link rel="stylesheet" type="text/css" href="front/res/css/dropmenu.css" />
<link rel="stylesheet" type="text/css" href="front/res/css/loginform.css" />
<link rel="stylesheet" type="text/css" href="front/res/css/front_login.css" />
<link rel="stylesheet" type="text/css" href="front/res/css/slider.css" />

<script type="text/javascript" src="front/res/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="front/res/js/login.js"></script>
<script type="text/javascript" src="front/res/js/dropmenu.js"></script>
<script type="text/javascript" src="front/res/js/jssor.slider.mini.js"></script>
<script type="text/javascript" src="front/res/js/slider.js"></script>
<script type="text/javascript" src="front/res/js/regcheckdata.js"></script>
<script type="text/javascript">
	function datacheck_topuser(){
			
		if(topuserform.username.value=="" || checkWhite(topuserform.username.value)) {
			alert("用户名不能为空！");		
			return false;
		}	
		if(topuserform.password.value=="" || checkWhite(topuserform.password.value)) {
			alert("密码不能为空！");		
			return false;
		}
		return true;
	}
</script>
</head>

<body>
	<%@include file="/front/include/header.jsp"%>

	<div id="content">
		<div class="content_line">

			<div id="userlogin1">
				<div class="border_l">
					<div class="border_r">
						<div class="border_top">
							<span>用户登录<span>
						</div>
						<div class="list_content">
							<div id="loginform_notLogin" class="loginform">
								<form name="topuserform" id="loginform_Form" action="<%=path %>/front_user_login" method="post" onSubmit="return datacheck_topuser();">

									<div class="col">登录账号：</div>
									<div class="con">
										<input type="text" name="username" class="input" style="width:140px">
									</div>
									<div class="col">登录密码：</div>
									<div class="con">
										<input type="password" name="password" class="input" style="width:140px" >
									</div>
									<div style="clear:both;margin-bottom:20px" >  </div>
									<div id="user_login_form">
										<input type="image" src="front/res/images/denglu.png"> 
										<a href="javascript:void(0);"> <img border="0" src="front/res/images/cancel.png"></a>
									</div>
								</form>
							</div>							
						</div>
					</div>
				</div>
				<div class="border_bottom"></div>
				<div class="border_bottom_r_corner"></div>
			</div>
			
			
			
			<div id="agency" title="通知公告">

				<div class="border_l">
					<div class="border_r">
						<div class="border_top">
							<span>通知公告</span>
							<div class="border_top_r">

								<a href="front/tzgg/index.jsp"><img class="more" src="front/res/images/more.png"></a>

							</div>
						</div>

						<div class="list_content">
							<ul class="newslist">
<%
									int i = 0;
									List<Object[]> notes = DataBase.listQuery(datasource,"select id,title,fbrq from ggb where issuccess='2' order by fbrq desc limit 0,5");
									for (Iterator<Object[]> it = notes.iterator(); it.hasNext(); i++) {
										Object[] note = it.next();
%>
								<li><a target="_self" href="front/tzgg/second.jsp?id=<%=note[0].toString()%>"> 
<%
							 		Date date = new Date();
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							 		Calendar cal = Calendar.getInstance();
							        cal.setTime(date);
							        long time1 = cal.getTimeInMillis();
							        cal.setTime(sdf.parse(note[2].toString()));
							        long time2 = cal.getTimeInMillis();
							        long between_days=(time1-time2)/(1000*3600*24);	
							       	if(Math.abs(between_days)<=30){
%>
										<img src="front/res/images/new.gif"/>
<%
							 		}
							 		
							 		if (note[1].toString().length() > 15)
							 			out.print(note[1].toString().substring(0, 15) + "...");
							 		else
							 			out.print(note[1].toString());
%> 								
								</a> <span><%=note[2].toString()%></span></li>
<%
									}
%>

							</ul>
						</div>

					</div>

				</div>
				<div class="border_bottom"></div>
				<div class="border_bottom_r_corner"></div>
			</div>
			
			<div id="download" title="成果展示">

				<div class="border_l">
					<div class="border_r">
						<div class="border_top">
							<span>成果展示</span>
							<div class="border_top_r">

								<a href="front/cgzs/index.jsp"><img class="more" src="front/res/images/more.png">
								</a>

							</div>
						</div>

						<div class="list_content">
							<ul class="newslist">
								<%	
									notes = DataBase.listQuery(datasource,"select cgzsb_id,xmmc,lxnf from v_xm_cg order by lxnf desc limit 0,5");
									for (Iterator<Object[]> it = notes.iterator(); it.hasNext();) {
										Object[] note = it.next();
								%>
								<li><a target="_self"
									href="front/cgzs/detail.jsp?id=<%=note[0].toString()%>"> <%
 	if (note[1].toString().length() > 18)
 			out.print(note[1].toString().substring(0, 18) + "...");
 		else
 			out.print(note[1].toString());
 %> </a> <span><%=note[2].toString()%></span></li>
								<%
									}
								%>
							</ul>
						</div>

					</div>

				</div>
				<div class="border_bottom"></div>
				<div class="border_bottom_r_corner"></div>
			</div>
		</div>

		<div class="content_line">
			<img width="100%" border="0" src="front/res/images/advertisement.png"></img>

		</div>

		<div class="content_line">
			<div id="news" style="width:500px;">
				<div class="border_l">
					<div class="border_r">
						<div class="border_top">
							<span>项目一览</span>
							<div class="border_top_r">

								<a href="front/lxxm/index.jsp"><img class="more"
									src="front/res/images/more.png">
								</a>

							</div>
						</div>

						<div class="list_content">
							<ul class="newslist">
								<%
									i = 0;
									notes = DataBase.listQuery(datasource,"select id,xmmc,lxnf from xmhzb order by lxnf desc limit 0,8");
									for (Iterator<Object[]> it = notes.iterator(); it.hasNext(); i++) {
										Object[] note = it.next();
								%>
								<li><a target="_self"
									href="front/lxxm/detail.jsp?id=<%=note[0].toString()%>"> <%
 	if (note[1].toString().length() > 35)
 			out.print(note[1].toString().substring(0, 35) + "...");
 		else
 			out.print(note[1].toString());
 %> </a> <span><%=note[2].toString()%></span></li>

								<%
									}
								%>
														
							</ul>
						</div>

					</div>

				</div>
				<div class="border_bottom"></div>
				<div class="border_bottom_r_corner"></div>
			</div>
			
			<div id="announcement" style="width:492px;">

				<div class="border_l">
					<div class="border_r">
						<div class="border_top">
							<span>下载专区</span>
							<div class="border_top_r">

								<a href="front/download/index.jsp"><img class="more" src="front/res/images/more.png">
								</a>

							</div>
						</div>

						<div class="list_content">
							<ul class="newslist">
								<%
									notes = DataBase.listQuery(datasource,"select id,name,fbrq,filename from zlxzb where issuccess='2' order by fbrq desc limit 0,8");
									for (Iterator<Object[]> it = notes.iterator(); it.hasNext();) {
										Object[] note = it.next();
								%>
								<li><a target="_self" href="UploadDir/download/<%=note[3].toString()%>"> 
<%
 									Date date = new Date();
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							 		Calendar cal = Calendar.getInstance();
							        cal.setTime(date);
							        long time1 = cal.getTimeInMillis();
							        cal.setTime(sdf.parse(note[2].toString()));
							        long time2 = cal.getTimeInMillis();
							        long between_days=(time1-time2)/(1000*3600*24);	
							       	if(Math.abs(between_days)<=30){
%>
										<img src="front/res/images/new.gif"/>
<%
							 		}
							 		
							 		if (note[1].toString().length() > 28)
							 			out.print(note[1].toString().substring(0, 28) + "...");
							 		else
							 			out.print(note[1].toString());
 %> 
 								</a> <span><%=note[2].toString()%></span></li>

								<%
									}
								%>
							</ul>
						</div>

					</div>

				</div>
				<div class="border_bottom"></div>
				<div class="border_bottom_r_corner"></div>
			</div>

			

		</div>


	</div>
	<%@include file="/front/include/bottom.html"%>

<%
	String result = (String)request.getAttribute("result");
	if(result==null) result = "1";
	if(!"1".equals(result)){
%>
			<script type="text/javascript">			
				alert("登录失败，请重新登录");						
			</script>
<%} %>
</body>
</html>
