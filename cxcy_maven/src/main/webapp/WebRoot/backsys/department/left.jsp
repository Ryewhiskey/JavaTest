<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<title>left</title>

<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>
<link href="../../thirdparty/dtree/dtree.css" rel="StyleSheet" type="text/css" />

<script type="text/javascript" src="../../thirdparty/dtree/dtree.js"></script>

</head>
<body class="lbody">

	<div class="left">
		<%@include file="/backsys/include/date.jsp" %>	
		<div class="fresh">
			 <table width="100%" border="0" cellspacing="0" cellpadding="0">
		          <tr>
		            <td height="35" align="center"><img src="../res/img/images/refresh-icon.png" />&nbsp;&nbsp;<a href="javascript:location.href=location.href">刷新</a></td>
<!-- 	            
					<td width="2" height="35" valign="middle"><img src="../res/img/images/left-line.png" /></td>
		            <td height="35" align="center"><img src="../res/img/images/model-icon.png" />&nbsp;&nbsp;<a href="javascript:void(0);" target="rightFrame">模型管理</a></td>
 -->
		      	 </tr>
		     </table>
		</div>
	</div>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	request.setCharacterEncoding("UTF-8");
%>
<% 	
	String sql="";	
	sql = "select id,name,pid from department";	
	//session.setAttribute("sql",sql);	
	List<Object[]> notes = null;
	notes = DataBase.listQuery(datasource,sql+" order by ord,name");		
%>
<div class="dtree">

<script type="text/javascript">	
	
	d = new dTree('d');
	d.config.closeSameLevel=true;
	d.config.target='rightFrame';
<%
	String id="",name="",pid="";
	int i=0;
	for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
		Object[] note = it.next();
		if(note[0]!=null) id=note[0].toString();
		if(note[1]!=null) name=note[1].toString();
		if(note[2]!=null) pid=note[2].toString();
		if( DataBase.recordCount(datasource, "select * from department where pid='"+id+"'") > 0){
%>		
			d.add('<%=id%>','<%=pid%>','<%=name%>','list.jsp?pid=<%=id%>');
<%
		}else{
%>
			d.add('<%=id%>','<%=pid%>','<%=name%>','updt.jsp?enter=list&id=<%=id%>');
<%
		}
	}
%>
	document.write(d);
	//d.openTo('1',true);
	d.s('0');
	
	
</script>

</div>
</body>
</html>
