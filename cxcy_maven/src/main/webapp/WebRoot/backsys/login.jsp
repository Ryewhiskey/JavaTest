<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
 
<title>创新创业 - 后台管理</title>
<link rel="stylesheet" type="text/css" href="../backsys/res/css/login.css"/>

<script type="text/javascript">

window.onbeforeunload = shutwin; 
function shutwin(){	
	window.location.href='sessiondelete.jsp';
}
function datacheck(){
	
	if(form1.username.value=="" || checkWhite(form1.username.value)) {
		alert("用户名不能为空！");		
		return false;
	}	
	if(form1.password.value=="" || checkWhite(form1.password.value)) {
		alert("密码不能为空！");		
		return false;
	}

	return true;
}

</script>

</head>

<body>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
		
	request.setCharacterEncoding("UTF-8");
	
	String flag="",loginpage="后台";
	String yhm="", yhbh="",glyz="",realname="",islock="", mm="",sessionyhm="";	
	String phone = "";
	int count=0;
	
	Map<String,String> uinfo = (Map)session.getAttribute("userinfo");
	if(uinfo!=null)	sessionyhm = uinfo.get("yhm");
		
	flag = request.getParameter("flag");	
	yhm = request.getParameter("username");
	if(yhm==null) yhm ="";
	mm = request.getParameter("password");
	
	if( !"".equals(yhm) && yhm.equals(sessionyhm) ){//相同session
%>
			<script type="text/javascript">
				alert("用户已登录！");
				this.window.opener=null;
				window.open("","_self");    
				window.close();
				//history.go(-1);			
			</script>
<%	
		return;
	}	
		
	if( flag!=null && "true".equals(flag) ){
		String sql = "select yhbh,islock,glyz,realname,phone from v_admin where yhm = '" + yhm + "' and mm='"+mm.trim()+"'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		count = notes.size();
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	yhbh=note[0].toString();
			if(note[1]!=null) 	islock=note[1].toString();	
			if(note[2]!=null) 	glyz=note[2].toString();
			if(note[3]!=null) 	realname=note[3].toString();
			if(note[4]!=null) 	phone=note[4].toString();												
		}
		//System.out.println(sql);
	}
	
%>
	<div id="container">
		<div id="top">
		 
		</div>
		<div id="loginBar">
			<span id="showDate">欢迎您使用大学生创新创业训练计划管理平台后台管理程序，请登录</span>
		</div>
		<div id="content">
			<div id="loginForm">
			<form method="post" name="form1" id="myForm" action="login.jsp" onSubmit="return datacheck();">
					<input type="hidden" name="flag" value="true"/>
					<table cellpadding="0" cellspacing="0" width="380px" id="loginTable">
						<tr>
							<td align="right" width="90">登录用户:</td>
							<td align="left">
								<input type="text" class="text_input" name="username" value="<%=yhm %>" style="height:20px;" /> 
							</td>
						</tr>
						<tr>
							<td align="right">登录密码:</td>
							<td align="left">
								<input type="password" class="text_input" name="password" style="height:20px;"/>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<div id="msg" style="color:red;"></div>
							</td>
						</tr>						
						<tr>
							<td align="center" colspan="2">
								<input type="submit" class="mybutton" value="登录">&nbsp;&nbsp;&nbsp;
								<input type="reset" class="mybutton" value="重置"/>
							</td>
						</tr>
						
					</table>
					</form>
					
			</div>
		</div>
	</div>	
<%	
	if( count!=0 && islock!=null && "1".equals(islock) ){
		//同一用户在不同session登录	
		String sql = "select sessionid,logintime from onlineuser where loginpage='后台' and yhbh = '" + yhbh + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);		
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {
			Object[] note = it.next();
			//String logintime = ""; 
			//if(note[1]!=null) 	logintime = note[1].toString();
			//Date date = new Date();
			//SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
			//System.out.println(date.getTime());
			
%>
			<script type="text/javascript">
				alert("用户已在其他位置登录！");
				window.opener=null;
				window.open("","_self");
				window.close();
				//history.go(-1);
			</script>
<%									
			return;
		}else{//用户还没有登录			
			
			if(DataBase.recordCount(datasource, "select count(*) from onlineuser where yhbh is not null")>=Integer.valueOf(sysconfig.get("maxusercount"))){
			//并发用户达到最大值
%>
				<script type="text/javascript">
					alert("系统忙，请稍后再登录！");
					this.window.opener=null;
					window.open("","_self"); 
					window.close();		
				</script>
	<%			
				return;
			}else{//并发用户没有达到最大值
				String prepsql="update onlineuser set yhbh=?,loginpage=? where sessionid='"+session.getId()+"'";
				DataBase.prepare(datasource,prepsql,yhbh,loginpage);
				
				Map<String,String> userinfo = new HashMap<String,String>();
				userinfo.put("yhbh", yhbh);
				userinfo.put("yhm", yhm);
				userinfo.put("glyz", glyz);
				userinfo.put("realname", realname);	
				userinfo.put("phone", phone);				
				session.setAttribute("userinfo", userinfo);
				response.sendRedirect("index.jsp");
			}
		}
	}else{//用户不合法
		if( flag!=null && "true".equals(flag) ){
%>
			<script type="text/javascript">
				mdiv = document.getElementById("msg");
				mdiv.innerHTML = "用户没有授权或已过期？";			
			</script>
<%	
		}
	}	

 %>
</body>

</html>