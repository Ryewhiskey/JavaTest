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

<title>部门添加</title>

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
		
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmmssSSS");
	String UId=sdf.format(date)+String.format("%1$03d",(new Random()).nextInt(1000));
	
	request.setCharacterEncoding("UTF-8");
		
%>
<%@include file="/backsys/include/back_check.jsp" %> 
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";
	String id=UId,name="",pid="",ord="10"; 
	pid = request.getParameter("pid");	
	//System.out.println(pid);
	int count = 0; 	
	
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
				
		name=request.getParameter("name");
		if(name!=null) name=name.trim();
		else name="";
		
		ord=request.getParameter("ord");
		if(ord!=null) ord=ord.trim();
		else ord="10";
		
		String prepsql="insert into department(id,name,pid,ord) values(?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,id,name,pid,Integer.parseInt(ord));					
		
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
	<div class="rpos">当前位置: 部门 - 添加部门</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='list.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="add.jsp?pid=<%=pid %>" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
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