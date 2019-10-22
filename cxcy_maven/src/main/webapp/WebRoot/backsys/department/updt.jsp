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

<title>部门维护</title>

<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>

<script src="../res/js/regcheckdata.js" type="text/javascript"></script>

<script type="text/javascript">
function datacheck(){
	
	if(form1.name.value=="" || checkWhite(form1.name.value)) {
		alert("部门名称不能为空！");		
		return false;
	}	
	if(form1.ord.value=="" || checkWhite(form1.ord.value)){
		alert("排列顺序不能为空！");		
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
	String flag="",enter="";
	String id="",name="",pid="",ord="";	
	
	int count = 0; 
		
	flag = request.getParameter("flag");	
	pid = request.getParameter("pid");
	id = request.getParameter("id");
	enter = request.getParameter("enter");
	if( id!=null && !"".equals(id.trim()) ){
		String sql = "select name,pid,ord from department where id = '" + id + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	name=note[0].toString();
			if(note[1]!=null) 	pid=note[1].toString();
			if(note[2]!=null) 	ord=note[2].toString();				
								
		}
	}
	if( flag != null && flag.equals("true") )
	{		
				
		name=request.getParameter("name");
		if(name!=null) name=name.trim();
		else name="";
		
		pid=request.getParameter("pid");
		if(pid!=null) pid=pid.trim();
		else pid="";
		
		ord=request.getParameter("ord");
		if(ord!=null) ord=ord.trim();
		else ord="10";
				
		String prepsql="update department set name=?,pid=?,ord=? where id='"+id+"'";		
		boolean result = DataBase.prepare(datasource,prepsql,name,pid,Integer.parseInt(ord));					
		
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
	<div class="rpos">
<%
	out.print("当前位置: 部门 - 部门维护");
 %>
	</div>
	<form class="ropt" method="post">
	
		<input class="add4" type="submit" value="添加部门" onclick="this.form.action='add.jsp?pid=<%=id%>';"/>

<%
	if(enter!=null && "list".equals(enter) ){
 %>
		<input type="submit" value="返回列表" onclick="this.form.action='list.jsp?pid=<%=pid %>';" class="return-button"/>
<%
	}else{
%>
		<input type="submit" value="返回列表" onclick="this.form.action='list.jsp<%=resp %>';" class="return-button"/>
<%
	}
 %>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="updt.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="pid" value="<%=pid%>"/>
		<input type="hidden" name="id" value="<%=id%>"/>		
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>上级部门:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
<%
				List<Object[]> notes = new ArrayList<Object[]>();		
				notes = DataBase.listQuery(datasource,"select name from department where id='"+pid+"'");			
				Iterator<Object[]> it=notes.iterator();
				if( it.hasNext() ){
					Object[] note = it.next();
					out.print(note[0].toString());
				}else{
					out.print("根节点");
				}
 %>
			</td>
			
		</tr>
		<tr>			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>部门名称:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="name" value="<%=name %>" style="width:200px;"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>排列顺序:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="ord" value="<%=ord %>" />
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