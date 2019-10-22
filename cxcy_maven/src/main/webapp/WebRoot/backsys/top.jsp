<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>

<style type="text/css">        
	*{margin:0;padding:0}
	a:focus {outline:none;}
	html{height:100%;overflow:hidden;}
	body{height:100%;}
	#top{ background-color:#1d63c6; height:69px; width:100%;}
	.logo{width:215px; height:69px;}
	.topbg{background:url(res/blue/img/top-tbg.png) no-repeat; height:38px;}
	.login-welcome{padding-left:20px; color:#fff; font-size:12px;background:url(res/blue/img/topbg.gif) no-repeat;}
	.login-welcome a:link,.login-welcome a:visited{color:#fff; text-decoration:none;}
	
	#welcome {color: #FFFFFF;padding: 0 30px 0 5px;}
	#logout {color: #FFFFFF; padding-left: 5px;}
	
	.nav{height:31px; overflow:hidden;}
	.nav-menu{background:url(res/blue/img/bg.png) repeat-x; height:31px; list-style:none; padding-left:20px; font-size:14px;}
	.nav .current {background: url(res/blue/img/navcurrbg.gif) no-repeat 0px 2px; color:#fff; width:72px; text-align:center;} 
	.nav .current a{color:#fff;}
	.nav-menu li {height:31px;text-align:center; line-height:31px; float:left; }
	.nav-menu li a{color:#2b2b2b; font-weight:bold;}
	.nav-menu li.sep{background: url(res/blue/img/step.png) no-repeat; width:2px; height:31px; margin:0px 5px;}
	.nav .normal{width:72px; text-align:center;}
	.top-bottom{width:100%; background: url(res/blue/img/bg.png) repeat-x 0px -34px; height:3px;}
	.undis{display:none;}
	.dis{display:block;}
</style>

<script type="text/javascript">
	function g(o){
		return document.getElementById(o);
	}
	function HoverLi(m,n,counter){		
		for(var i=1;i<=counter;i++){
			g('tb_'+m+i).className='normal';
		}		
		g('tb_'+m+n).className='current';		
	}
	
</script>

</head>

<body>
<%@include file="/backsys/include/back_check.jsp" %> 
<div id="top">
     <div class="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="215"><div class="logo"><img src="res/blue/img/logo.jpg" width="215" height="69" /></div></td>
            <td valign="top">
                <div class="topbg">
                     <div class="login-welcome">
                             <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="420" height="38">
                                    <img src="res/blue/img/welconlogin-icon.png"/><span id="welcome">欢迎你：<%=((Map<String,String>)session.getAttribute("userinfo")).get("realname") %></span>
                                    <img src="res/blue/img/loginout-icon.png"/><a href="javascript:window.opener=null;window.open('','_self');window.close();" target="_top" id="logout" onclick="return confirm('您确定要退出吗？');">退出</a>　　
                                    
                                    </td>
                               
                                  </tr>
                                </table>
                       </div>  
                     <div class="nav">
                     	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td style="background-image:url('res/blue/img/nav-left.png')" width="14" height="31"></td>
                                <td>
                                	<ul class="nav-menu">
                                    	<li class="current" id="tb_11" onclick="HoverLi(1,1,8);"><a href="main.jsp" target="mainFrame">首页</a></li>
                                    	<li class="sep"></li><li class="normal" id="tb_12" onclick="HoverLi(1,2,8);"><a href="xm/main.html" target="mainFrame">项目</a></li>
                                    	<li class="sep"></li><li class="normal" id="tb_13" onclick="HoverLi(1,3,8);"><a href="cg/main.html" target="mainFrame">成果</a></li>		

										<li class="sep"></li><li class="normal" id="tb_14" onclick="HoverLi(1,4,8);"><a href="contents/main.html" target="mainFrame">内容</a></li>	

										<li class="sep"></li><li class="normal" id="tb_15" onclick="HoverLi(1,5,8);"><a href="department/main.html" target="mainFrame">部门</a></li>											
											
										<li class="sep"></li><li class="normal" id="tb_16" onclick="HoverLi(1,6,8);"><a href="user/main.html" target="mainFrame">用户</a></li>
										<li class="sep"></li><li class="normal" id="tb_17" onclick="HoverLi(1,7,8);"><a href="zx/main.html" target="mainFrame">咨询</a></li>
										<li class="sep"></li><li class="normal" id="tb_18" onclick="HoverLi(1,8,8);"><a href="assistant/main.html" target="mainFrame">辅助</a></li>
									
										
                                    </ul>
                                </td>
                              </tr>
                            </table>
                     </div>  
                </div>
          </tr>
        </table>
     </div>
</div>
<div class="top-bottom"></div>
</body>
</html>