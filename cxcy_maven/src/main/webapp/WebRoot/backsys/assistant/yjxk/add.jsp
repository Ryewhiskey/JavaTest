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

<title>一级学科</title>

<link href="../../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../../res/css/theme.css" rel="stylesheet" type="text/css"/>

<script src="../../res/js/regcheckdata.js" type="text/javascript"></script>
<script type="text/javascript">
function datacheck(){
	
	if(form1.id.value=="" || checkWhite(form1.id.value) || !isNumber(form1.id.value) ) {
		alert("学科代码不能为空,且是数字串！");		
		return false;
	}	
	if(form1.name.value=="" || checkWhite(form1.name.value)){
		alert("学科名称不能为空！");		
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
	String resp=(String)session.getAttribute("resp");
	String flag="";	
	String id="",name="";	
	
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		id=request.getParameter("id");
		if(id!=null) id=id.trim();
		else id = "";
		
		name=request.getParameter("name");
		if(name!=null) name=name.trim();
		else name = "";
		
		String prepsql="insert into xkdmb(id,name) values(?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,id,name);					
		 
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
	<div class="rpos">当前位置: 辅助 - 一级学科添加</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="add.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>学科代码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="id" value="<%=id %>"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>名称:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="name" value="<%=name %>" style="width:300px;"/>				
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