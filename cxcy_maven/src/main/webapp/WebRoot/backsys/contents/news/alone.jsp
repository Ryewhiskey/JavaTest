<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%@taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@taglib uri="http://ckfinder.com" prefix="ckfinder"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title>联系我们修改</title>

<link href="<%=path %>/backsys/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="<%=path %>/backsys/res/css/theme.css" rel="stylesheet" type="text/css"/>

<script src="<%=path %>/backsys/res/js/regcheckdata.js" type="text/javascript"></script>

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
	String id="",content="",title="";	
	
	flag = request.getParameter("flag");
	id = request.getParameter("id");
	if( id!=null && !"".equals(id.trim()) ){
		String sql = "select content,title from news where id = '" + id + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	content=note[0].toString();
			if(note[1]!=null) 	title=note[1].toString();
		}
	}
	if( flag != null && flag.equals("true") )
	{		
		content=request.getParameter("content");
		if(content!=null) content=content.trim();
		else content="";
		
		String prepsql="update news set content=? where id='"+id+"'";
		boolean result = DataBase.prepare(datasource,prepsql,content);						
		
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
	<div class="rpos">当前位置: 内容 - <%=title %></div>	
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="alone.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="id" value="<%=id %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><%=title %>:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<div style="width:99%;">
					<textarea id="editor1" name="content"><%=content %></textarea>
				</div>
			</td>
		</tr>
		
		<tr>
			<td colspan="4" class="pn-fbutton">
				<input type="submit" value="提交" class="submit" /> &nbsp; 
				<input type="reset" value="重置" class="reset" />
			</td>
		</tr>
		</table>
	</form>
	<%@include file="/backsys/include/ckeditor1.html" %>
</div>
</body>
</html>