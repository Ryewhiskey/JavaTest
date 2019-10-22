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

<title>查看咨询</title>

<link href="<%=path %>/front/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="<%=path %>/front/res/css/theme.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	
	request.setCharacterEncoding("UTF-8");
	
%>
<%@include file="/front/include/front_check.jsp" %> 
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
		List<Object[]> notes = new ArrayList<Object[]>();
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
<div class="box-positon">
	<div class="rpos">当前位置: 咨询 - 查看咨询</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" id="jvForm" name="form1">		
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="hidden" name="zxr" value="<%=zxr %>" readonly/>
				<%=zxrname %>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询日期:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<%=zxrq %>
			</td>
			
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询内容:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<textarea rows="10" style="width:660px;resize:none;" name="zxcnt"  readonly><%=zxcnt %></textarea>				
			</td>
			
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="hidden" name="hfr" value="<%=hfr %>" readonly/>
				<%=hfrname %>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复日期:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<%=hfrq %>						
			</td>
		</tr>
		<tr>			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复内容:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<textarea rows="10" style="width:660px;resize:none;" name="hfcnt" readonly><%=hfcnt %></textarea>				
			</td>
		</tr>	
		
		</table>
	</form>

</div>
</body>
</html>