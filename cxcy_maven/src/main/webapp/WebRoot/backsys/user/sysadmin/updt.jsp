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

<title>管理员修改</title>

<link href="../../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../../res/css/theme.css" rel="stylesheet" type="text/css"/>

<script src="../../res/js/regcheckdata.js" type="text/javascript"></script>
<script type="text/javascript">
function datacheck(){
	
	if(form1.yhm.value=="" || checkWhite(form1.yhm.value)) {
		alert("用户名不能为空！");		
		return false;
	}	
	if(form1.realname.value=="" || checkWhite(form1.realname.value)){
		alert("真实姓名不能为空！");		
		return false;
	}
	
	if( ltrim(rtrim(form1.mm.value)) != ltrim(rtrim(form1.remm.value)) ){
		alert("密码不一致！");		
		return false;
	}
	if(!checkMobile(form1.phone.value) && !checkPhone(form1.phone.value)){
		alert("电话不正确！");		
		return false;
	}
	return true;
}

</script>
<script type="text/javascript">
	var xmlhttp;
	function loadXMLDoc(url,cfunc)
	{
		if (window.XMLHttpRequest){
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=cfunc;
		xmlhttp.open("GET",url,true);
		xmlhttp.send();
	}
	function uni_yhm(url){
		loadXMLDoc(url,function(){
	  		if (xmlhttp.readyState==4 && xmlhttp.status==200){	    		    			
	    		document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
	    	    		 
	    	}
	  	});
	}
</script>
</head>
<body> 
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");	
	
	request.setCharacterEncoding("UTF-8");	
%>
<%@include file="/backsys/include/back_check.jsp" %> 
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";
	String yhbh="",yhm="",realname="",phone="",xb="",mm="",bmbh="",glyz="",islock="";//1-否   2-禁用	
	int count = 0; 	
	
	yhbh = request.getParameter("yhbh");
	if( yhbh!=null && !"".equals(yhbh.trim()) ){
		String sql = "select yhm,realname,phone,xb,bmbh,glyz,islock from admin where yhbh = '" + yhbh + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	yhm=note[0].toString();
			if(note[1]!=null) 	realname=note[1].toString();
			if(note[2]!=null) 	phone=note[2].toString();
			if(note[3]!=null) 	xb=note[3].toString();
			if(note[4]!=null) 	bmbh=note[4].toString();	
			if(note[5]!=null) 	glyz=note[5].toString();
			if(note[6]!=null) 	islock=note[6].toString();													
		}
	}
	
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		yhm=request.getParameter("yhm");
		if(yhm!=null) yhm=yhm.trim();
		else yhm = "";
				
		realname=request.getParameter("realname");
		if(realname!=null) realname=realname.trim();
		else realname = "";
		
		phone=request.getParameter("phone");
		if(phone!=null) phone=phone.trim();
		else phone = "";
		
		xb=request.getParameter("xb");
		if(xb!=null) xb=xb.trim();
		else xb = "";
		
		mm=request.getParameter("mm");
		if(mm!=null) mm=mm.trim();
		else mm="";
		
		bmbh=request.getParameter("bmbh");
		if(bmbh!=null) bmbh=bmbh.trim();
		else bmbh="";
		
		glyz=request.getParameter("glyz");
		if(glyz!=null) glyz=glyz.trim();
		else glyz="";
		
		islock=request.getParameter("islock");
		if(islock!=null) islock=islock.trim();
		else islock="";
		boolean result = true;		
		if(!"".equals(mm)){
			String prepsql="update admin set yhm=?,realname=?,phone=?,xb=?,mm=?,bmbh=?,glyz=?,islock=? where yhbh='"+yhbh+"'";		
			result = DataBase.prepare(datasource,prepsql,yhm,realname,phone,xb,mm,bmbh,Integer.parseInt(glyz),Integer.parseInt(islock));					
		}else{
			String prepsql="update admin set yhm=?,realname=?,phone=?,xb=?,bmbh=?,glyz=?,islock=? where yhbh='"+yhbh+"'";		
			result = DataBase.prepare(datasource,prepsql,yhm,realname,phone,xb,bmbh,Integer.parseInt(glyz),Integer.parseInt(islock));					
		}
		
		if(result==false) {
%>
			<script type="text/javascript">			
				alert("操作失败，请检查数据？");						
			</script>

<%
		}else{	    	
%>
			<script type="text/javascript">			
				alert("操作成功！");						
			</script>			
<%
		}
	}

%>
<div class="box-positon">
	<div class="rpos">当前位置: 管理员 - 管理员修改</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="updt.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="yhbh" value="<%=yhbh %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户名:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" maxlength="100" name="yhm" value="<%=yhm %>" onchange="uni_yhm('uni_yhm.jsp?yhm='+this.value)" <%if("admin".equals(yhm)) out.print("readonly"); %>/>
				<div id="myDiv" class="pn-frequired"></div>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>真实姓名:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="realname" value="<%=realname %>" class="email"/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="password" autocomplete="off" id="password" maxlength="100" name="mm" class="required" maxlength="100"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>确认密码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="password" name="remm" autocomplete="off"/>
			</td>
		</tr>		
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h">联系电话:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="phone" value="<%=phone %>"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h">性别:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<label><input type="radio" value="男" name="xb" <%if("男".equals(xb)) out.print("checked"); %>/>男</label> 
				<label><input type="radio" value="女" name="xb" <%if("女".equals(xb)) out.print("checked"); %>/>女</label> 
				
			</td>
		</tr>		
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>部门:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<select name="bmbh">
<%
				int i=0;
				List<Object[]> notes = DataBase.listQuery(datasource,"select id,name from v_leaf where pid='1' order by ord");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
					Object[] note = it.next();	
%>
					<option value="<%=note[0].toString() %>" <% if(bmbh.equals(note[0].toString())) out.print("selected"); %>><%=note[1].toString() %></option>
					
<%} %>			
				</select>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h">管理员组:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<select name="glyz">
					<option value="1" <% if("1".equals(glyz)) out.print("selected"); %> >校级管理员</option>
					<option value="2" <% if("2".equals(glyz)) out.print("selected"); %> >院级管理员</option>
					
				</select>
			</td>
		</tr>
		<tr>
			
			<td width="12%" class="pn-flabel pn-flabel-h">是否禁用:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<label><input type="radio" value="1" name="islock" <%if("1".equals(islock)) out.print("checked"); %>/>否</label> 
				<label><input type="radio" value="2" name="islock" <%if("2".equals(islock)) out.print("checked"); %>/>是</label> 
				
			</td>
		</tr>
		<tr>
			<td colspan="4" class="pn-fbutton">
				<input type="submit" value="提交" class="submit" class="submit"/> &nbsp; 
				<input type="reset" value="重置" class="reset" class="reset"/>
			</td>
		</tr>
		</table>
	</form>
</div>
</body>
</html>