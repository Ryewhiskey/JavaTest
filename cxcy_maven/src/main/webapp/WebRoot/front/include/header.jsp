<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
 

<%
	if( session.isNew() ){
%>
		<script type="text/javascript">			
			location.href("<%=path %>/front/home/index.jsp");			
		</script>
<%	
		}
		
%>
<div class="login_header" style="color:white;">
	<span id="login_left" >
<%
		if((Map<String,String>)session.getAttribute("front_userinfo")!=null){
%>
			欢迎你：<%=((Map<String,String>)session.getAttribute("front_userinfo")).get("realname") %>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=path %>/front_exit_login" target="_self" style="color:white;">退出登录</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=path %>/backsys/login.jsp" target="_self" style="color:white;">后台管理</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:window.opener=null;window.open('','_self');window.close();" onclick="return confirm('您确定要退出吗？');" style="color:white;">退出系统</a>
<%
		}else{
%>				
				您还没有登录&nbsp;&nbsp;				
				<a href="<%=path %>/backsys/login.jsp" target="_blank" style="color:white;">后台管理</a> &nbsp;
				<a href="javascript:window.opener=null;window.open('','_self');window.close();" onclick="return confirm('您确定要退出吗？');" style="color:white;">退出系统</a>
			
<%
		}
%>
	</span>
	
	<span id="login_right">
		<a href="mailto:lut@163.com" style="color:white;">电子邮箱</a> 
		| <a href="javascript:void(0);" onClick="this.style.behavior='url(#default#homepage)';this.setHomePage('<%=basePath %>');" style="color:white;">设为主页</a> 
		| <a href="javascript:void(0);" onclick="javascript:window.external.AddFavorite('<%=basePath %>', '${site.name}');" style="color:white;">加入收藏</a>
		| <a href="front/news/second.jsp?id=1" style="color:white;">大创简介</a>
	</span>	
</div>	
  
<div id="header">    	
	<h1 class="logo">
       	<img src="front/res/images/logo.png"/>
	</h1>       
       <div class="nav">
           <ul id="dropmenu">
 				<li class="current"><a href="<%=basePath %>">网站首页</a></li>
				<li><a href="front/lxxm/index.jsp">项目一览</a></li> 
				<li><a href="front/cgzs/index.jsp">成果展示</a></li>				
				<li><a href="front/tzgg/index.jsp">通知公告</a></li>
		                   
				<li><a href="front/download/index.jsp">下载专区</a></li>
				<li><a href="front/mail/index.jsp">咨询问答</a></li>
<%
			if( (Map<String,String>)session.getAttribute("front_userinfo")!=null && ((Map<String,String>)session.getAttribute("front_userinfo")).get("yhm")!=null ){ 
				if( "1".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz")) ){
%>
					<li><a href="backsys/login.jsp">管理中心</a></li>
<%
				}else if( "4".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz")) ){
%>
					<li><a href="front/member/index.jsp">管理中心</a></li>
<%				
				}else{
%>
					<li><a href="javascript:void(0);">管理中心</a></li>
<%
				}			
			}else{
%>
				<li><a href="javascript:void(0);">管理中心</a></li>
<%			
			}
%>
			<li><a href="front/news/second.jsp?id=1">大创简介</a></li>	
           </ul>
       </div>
</div>