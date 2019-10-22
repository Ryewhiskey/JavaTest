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

<title>咨询添加</title>

<link href="<%=path %>/front/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="<%=path %>/front/res/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="<%=path %>/thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="<%=path %>/front/res/js/regcheckdata.js" type="text/javascript"></script>

<script type="text/javascript">
function datacheck(){
	
	if(form1.zxr.value=="" || checkWhite(form1.zxr.value)){
		alert("咨询人不能为空！");		
		return false;
	}
	if(form1.zxrq.value=="" || checkWhite(form1.zxrq.value)){
		alert("咨询日期不能为空！");		
		return false;
	}
	if(form1.zxcnt.value=="" || checkWhite(form1.zxcnt.value)){
		alert("咨询内容不能为空！");		
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
<%@include file="/front/include/front_check.jsp" %> 
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";	
	String id=UId,zxr=((Map<String,String>)session.getAttribute("front_userinfo")).get("yhbh");
	String zxrname = ((Map<String,String>)session.getAttribute("front_userinfo")).get("realname");
	String zxrq=(new SimpleDateFormat("YYYY-MM-dd")).format(date);
	String zxcnt="";
	
	 		
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		zxr=request.getParameter("zxr");
		if(zxr!=null) zxr=zxr.trim();
		else zxr = "";
		
		zxrq=request.getParameter("zxrq");
		if(zxrq!=null) zxrq=zxrq.trim();
		else zxrq = "";
		
		zxcnt=request.getParameter("zxcnt");
		if(zxcnt!=null) zxcnt=zxcnt.trim();
		else zxcnt = "";
		
		
		//System.out.println(sbbh);
		String prepsql="insert into zxb(id,zxr,zxrq,zxcnt) values(?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,UId,zxr,zxrq,zxcnt);					
		 
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
	<div class="rpos">当前位置: 咨询 - 咨询添加</div>
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
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="hidden" name="zxr" value="<%=zxr %>" readonly/>
				<%=zxrname %>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询日期:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="hidden" name="zxrq" value="<%=zxrq %>" readonly/>
				<%=zxrq %>						
			</td>
			
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询内容:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<textarea rows="10" style="width:660px;resize:none;" name="zxcnt" ><%=zxcnt %></textarea>				
			</td>
			
		</tr>
		
		<tr>
			<td colspan="4" class="pn-fbutton">
				<input type="submit" value="提交" class="submit"/> &nbsp; 
				<input type="reset" value="重置" class="reset"/>
			</td>
		</tr>
		</table>
	</form>

</div>
</body>
</html>