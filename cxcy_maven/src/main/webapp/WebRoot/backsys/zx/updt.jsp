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

<title>咨询维护</title>

<link href="<%=path %>/backsys/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="<%=path %>/backsys/res/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="<%=path %>/thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="<%=path %>/backsys/res/js/regcheckdata.js" type="text/javascript"></script>

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
<%@include file="/backsys/include/back_check.jsp" %> 
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";	
	String id=UId,zxr="";
	String zxrname = "";
	String zxrq="";
	String zxcnt="";
	String hfrq=(new SimpleDateFormat("YYYY-MM-dd")).format(date);
	String hfr=((Map<String,String>)session.getAttribute("userinfo")).get("yhbh");
	String hfrname = ((Map<String,String>)session.getAttribute("userinfo")).get("realname");
	String hfcnt="";
	 		
	flag = request.getParameter("flag");
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
		
		hfrq=request.getParameter("hfrq");
		if(hfrq!=null) hfrq=hfrq.trim();
		else hfrq = "";
		
		hfr=request.getParameter("hfr");
		if(hfr!=null) hfr=hfr.trim();
		else hfr = "";
		
		hfcnt=request.getParameter("hfcnt");
		if(hfcnt!=null) hfcnt=hfcnt.trim();
		else hfcnt = "";		
		
		//System.out.println(sbbh);
		String prepsql="update zxb set zxr=?,zxrq=?,zxcnt=?,hfrq=?,hfr=?,hfcnt=? where id='"+id+"'";		
		boolean result = DataBase.prepare(datasource,prepsql,zxr,zxrq,zxcnt,hfrq,hfr,hfcnt);					
		 
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
	<div class="rpos">当前位置: 咨询 - 咨询维护</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="updt.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="id" value="<%=id %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="hidden" name="zxr" value="<%=zxr %>" readonly/>
				<input type="text" name="zxrname" value="<%=zxrname %>" readonly/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询日期:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="zxrq" value="<%=zxrq %>" readonly/>						
			</td>
			
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>咨询内容:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<textarea cols="110" rows="10" name="zxcnt"><%=zxcnt %></textarea>				
			</td>
			
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="hidden" name="hfr" value="<%=hfr %>" readonly/>
				<input type="text" name="hfrname" value="<%=hfrname %>" readonly/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复日期:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="hfrq" value="<%=hfrq %>" readonly />						
			</td>
		</tr>
		<tr>			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>回复内容:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<textarea cols="110" rows="10" name="hfcnt"><%=hfcnt %></textarea>				
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