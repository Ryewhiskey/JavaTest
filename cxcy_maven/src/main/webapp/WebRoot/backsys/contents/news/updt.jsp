<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%@taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@taglib uri="http://ckfinder.com" prefix="ckfinder"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title>新闻添加</title>

<link href="/sbgl/backsys/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="/sbgl/backsys/res/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="/sbgl/thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/sbgl/backsys/res/js/regcheckdata.js" type="text/javascript"></script>

<script type="text/javascript">
function datacheck(){
	
	if(form1.title.value=="" || checkWhite(form1.title.value)) {
		alert("新闻标题不能为空！");		
		return false;
	}	
	if(form1.fbr.value=="" || checkWhite(form1.fbr.value)){
		alert("发布人不能为空！");		
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
	
	request.setCharacterEncoding("UTF-8");
		
%>
<%@include file="/backsys/include/back_check.jsp" %> 
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";
	String id="",title="",fbr="",fbrq="",content="",issuccess="";	
	
	flag = request.getParameter("flag");
	id = request.getParameter("id");
	if( id!=null && !"".equals(id.trim()) ){
		String sql = "select title,fbr,fbrq,content,issuccess from news where id = '" + id + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	title=note[0].toString();
			if(note[1]!=null) 	fbr=note[1].toString();
			if(note[2]!=null) 	fbrq=note[2].toString();
			
			if(note[3]!=null) 	content=note[3].toString();
			if(note[4]!=null) 	issuccess=note[4].toString();
								
		}
	}
	if( flag != null && flag.equals("true") )
	{		
		title=request.getParameter("title");
		if(title!=null) title=title.trim();
		else title = "";
				
		fbr=request.getParameter("fbr");
		if(fbr!=null) fbr=fbr.trim();
		else fbr = "";
		
		fbrq=request.getParameter("fbrq");
		if(fbrq!=null) fbrq=fbrq.trim();
		else fbrq = "";
		
		content=request.getParameter("content");
		if(content!=null) content=content.trim();
		else content="";
						
		issuccess=request.getParameter("issuccess");
		if(issuccess!=null) issuccess=issuccess.trim();
		else issuccess="";	
		
		String prepsql="update news set title=?,fbr=?,fbrq=?,content=?,issuccess=? where id='"+id+"'";
		boolean result = DataBase.prepare(datasource,prepsql,title,fbr,fbrq,content,issuccess);					
							
		
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
	<div class="rpos">当前位置: 新闻 - 新闻修改</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='/sbgl/backsys/contents/news/admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="/sbgl/backsys/contents/news/updt.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="id" value="<%=id %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>新闻标题:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="title" value="<%=title %>" size="90" />
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="fbr" value="<%=fbr %>" readonly/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>发布日期:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="fbrq" value="<%=fbrq %>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>审核:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<label><input type="radio" value="0" name="issuccess" <%if("0".equals(issuccess)) out.print("checked"); %>/>未审核</label> 
				<label><input type="radio" value="1" name="issuccess" <%if("1".equals(issuccess)) out.print("checked"); %>/>审核</label> 
				
			</td>
		</tr>
		
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>新闻内容:</td>
			<td colspan="3" class="pn-fcontent">
				<div Style="width:800px">
					<textarea id="editor1" name="content"><%=content %></textarea>
				</div>
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
	<ckfinder:setupCKEditor basePath="/sbgl/thirdparty/ckfinder/" editor="editor1" />
	<ckeditor:replace replace="editor1" basePath="/sbgl/thirdparty/ckeditor/" />
</div>
</body>
</html>