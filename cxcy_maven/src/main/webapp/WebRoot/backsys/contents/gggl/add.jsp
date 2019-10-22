<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>公告添加</title>

<link href="<%=path %>/backsys/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="<%=path %>/backsys/res/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="<%=path %>/thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="<%=path %>/backsys/res/js/regcheckdata.js" type="text/javascript"></script>
<script type="text/javascript">
function datacheck(){
	
	if(form1.title.value=="" || checkWhite(form1.title.value)) {
		alert("标题不能为空！");		
		return false;
	}	
	if(form1.dw.value=="" || checkWhite(form1.dw.value)){
		alert("单位不能为空！");		
		return false;
	}
	if(form1.fbrq.value=="" || checkWhite(form1.fbrq.value)){
		alert("发布日期不能为空！");		
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
	String id=UId,title="",dw="",fbrq=(new SimpleDateFormat("YYYY-MM-dd")).format(date),content="",issuccess="2";	
	 	
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		title=request.getParameter("title");			
		dw=request.getParameter("dw");		
		fbrq=request.getParameter("fbrq");		
		content=request.getParameter("content");		
		issuccess=request.getParameter("issuccess");
			
		//System.out.println(sbbh);
		String result=request.getAttribute("result").toString();
		
		//System.out.println(result);
		if("false".equals(result)) {
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
	<div class="rpos">当前位置: 内容 - 公告添加</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='<%=path %>/backsys/contents/gggl/admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="<%=path %>/servlet/Editor/gggl" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>		
		<input type="hidden" name="id" value="<%=UId %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>标题:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="title" value="<%=title %>" size="90" />
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>单位:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="dw" value="<%=dw %>"/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布日期:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="fbrq" value="<%=fbrq %>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>审核:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<label><input type="radio" value="1" name="issuccess" <%if("1".equals(issuccess)) out.print("checked"); %>/>未审核</label> 
				<label><input type="radio" value="2" name="issuccess" <%if("2".equals(issuccess)) out.print("checked"); %>/>审核</label> 
				
			</td>
		</tr>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>内容:</td>
			<td colspan="3" class="pn-fcontent">
				<div style="width:98%">
					<textarea id="editor1" name="content"><%=content %></textarea>
				</div>
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
	<%@include file="/backsys/include/ckeditor1.html" %>
</div>
</body>
</html>