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

<title>个人资料</title>

<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>

<script src="../res/js/regcheckdata.js" type="text/javascript"></script>

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

</head>
<body>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	
	request.setCharacterEncoding("UTF-8");
		
%>
<%@include file="/backsys/include/back_check.jsp" %>
<%
	String flag="";
	String yhbh="",yhm="",realname="",xb="",mm="",phone="";	
	int count = 0; 	
	
	flag = request.getParameter("flag");
	if( flag!=null && "true".equals(flag) )
		yhbh = request.getParameter("yhbh");
	else yhbh = ((Map<String,String>)session.getAttribute("userinfo")).get("yhbh");
	
	if( yhbh!=null && !"".equals(yhbh.trim()) ){
		String sql = "select yhm,realname,xb,mm,phone from admin where yhbh = '" + yhbh + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	yhm=note[0].toString();
			if(note[1]!=null) 	realname=note[1].toString();
			if(note[2]!=null) 	xb=note[2].toString();			
			if(note[4]!=null) 	phone=note[4].toString();
								
		}
	}
	if( flag != null && flag.equals("true") )
	{		
		yhbh=request.getParameter("yhbh");
		if(yhbh!=null) yhbh=yhbh.trim();
		else yhbh = "";
		
		yhm=request.getParameter("yhm");
		if(yhm!=null) yhm=yhm.trim();
		else yhm = "";
				
		realname=request.getParameter("realname");
		if(realname!=null) realname=realname.trim();
		else realname = "";
		
		xb=request.getParameter("xb");
		if(xb!=null) xb=xb.trim();
		else xb = "";
		
		mm=request.getParameter("mm");
		if(mm!=null) mm=mm.trim();
		else mm="";
		
		phone=request.getParameter("phone");
		if(phone!=null) phone=phone.trim();
		else phone="";		
				
		String prepsql="";
		boolean result=false;
		if( "".equals(mm.trim()) ){
			prepsql="update admin set yhm=?,realname=?,xb=?,phone=? where yhbh='"+yhbh+"'";		
			result = DataBase.prepare(datasource,prepsql,yhm,realname,xb,phone);
		}else{
			prepsql="update admin set yhm=?,realname=?,xb=?,mm=?,phone=? where yhbh='"+yhbh+"'";
			result = DataBase.prepare(datasource,prepsql,yhm,realname,xb,mm,phone);
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
	<div class="rpos">当前位置: 首页 - 个人资料</div>	
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="grzl.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="yhbh" value="<%=yhbh %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户名:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" maxlength="100" name="yhm" value="<%=yhm %>" readonly/>
				
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>真实姓名:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="realname" value="<%=realname %>" class="email" size="30"/>
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