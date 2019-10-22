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

<title>学生维护</title>

<link href="../../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../../res/css/theme.css" rel="stylesheet" type="text/css"/>

<script src="../../res/js/regcheckdata.js" type="text/javascript"></script>
<script type="text/javascript">
function datacheck(){
	
	if(form1.xh.value=="" || checkWhite(form1.xh.value) || !isNumber(form1.xh.value)) {
		alert("学号不能为空,且是数字串！");		
		return false;
	}	
	if(form1.name.value=="" || checkWhite(form1.name.value)){
		alert("姓名不能为空！");		
		return false;
	}	
	if(!checkMobile(form1.phone.value) && !checkPhone(form1.phone.value)){
		alert("电话不正确！");		
		return false;
	}
	if(form1.zy.value=="" || checkWhite(form1.zy.value)){
		alert("专业不能为空！");		
		return false;
	}		
	if(form1.email.value=="" || checkWhite(form1.email.value) || !checkEmail(form1.email.value)){
		alert("邮箱不能为空或邮箱不正确！");		
		return false;
	}	
	if( ltrim(rtrim(form1.mm.value)) != ltrim(rtrim(form1.remm.value)) ){
		alert("密码不一致！");		
		return false;
	}
	return true;
}

</script>
<script type="text/javascript">
	var xmlhttp;
	function loadXMLDoc(url,cfunc)
	{
		if (window.XMLHttpRequest){
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}else{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=cfunc;
		xmlhttp.open("GET",url,true);
		xmlhttp.send();
	}
	function uni_id(url){
		loadXMLDoc(url,function(){
	  		if (xmlhttp.readyState==4 && xmlhttp.status==200){	    		    			
	    		document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
	    	    		 
	    	}
	  	});
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
	String sid="",xh="",name="",xb="",zy="",bmbh="",phone="",mm="",email="",islock="";//1-否   2-禁用	
	int count = 0; 	
	
	sid = request.getParameter("sid");
	flag = request.getParameter("flag");
	if( sid!=null && !"".equals(sid.trim()) ){
		String sql = "select xh,name,xb,zy,bmbh,phone,email,mm,islock from student where sid = '" + sid + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	xh=note[0].toString();
			if(note[1]!=null) 	name=note[1].toString();
			if(note[2]!=null) 	xb=note[2].toString();
			if(note[3]!=null) 	zy=note[3].toString();
			if(note[4]!=null) 	bmbh=note[4].toString();	
			if(note[5]!=null) 	phone=note[5].toString();
			if(note[6]!=null) 	email=note[6].toString();
			if(note[8]!=null) 	islock=note[8].toString();
			
		}
	}
	
	if( flag != null && flag.equals("true") )
	{		
		xh=request.getParameter("xh");
		if(xh!=null) xh=xh.trim();
		else xh = "";
		
		name=request.getParameter("name");
		if(name!=null) name=name.trim();
		else name = "";
		
		zy=request.getParameter("zy");
		if(zy!=null) zy=zy.trim();
		else zy = "";
		
		phone=request.getParameter("phone");
		if(phone!=null) phone=phone.trim();
		else phone = "";
		
		xb=request.getParameter("xb");
		if(xb!=null) xb=xb.trim();
		else xb = "";
		
		mm=request.getParameter("mm");
		if(mm!=null) mm=mm.trim();
		else mm="";
				
		bmbh=request.getParameter("bmbh");
		if(bmbh!=null) bmbh=bmbh.trim();
		else bmbh="";
		
		email=request.getParameter("email");
		if(email!=null) email=email.trim();
		else email="";
		
		islock=request.getParameter("islock");
		if(islock!=null) islock=islock.trim();
		else islock="";
		boolean result = false;
		if(!"".equals(mm)){		
			String prepsql="update student set xh=?,name=?,xb=?,zy=?,bmbh=?,phone=?,email=?,mm=?,islock=? where sid='"+sid+"'";		
			result = DataBase.prepare(datasource,prepsql,xh,name,xb,zy,bmbh,phone,email,mm,Integer.parseInt(islock));					
		}else{
			String prepsql="update student set xh=?,name=?,xb=?,zy=?,bmbh=?,phone=?,email=?,islock=? where sid='"+sid+"'";		
			result = DataBase.prepare(datasource,prepsql,xh,name,xb,zy,bmbh,phone,email,Integer.parseInt(islock));					
		}
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
	<div class="rpos">当前位置: 学生 - 学生维护</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="updt.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="sid" value="<%=sid %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>学号:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" maxlength="100" name="xh" value="<%=xh %>" onchange="uni_id('uni_id.jsp?id='+this.value)"/>
				<div id="myDiv" class="pn-frequired"></div>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>姓名:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="name" value="<%=name %>" class="email"/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="password" autocomplete="off" id="password" name="mm" class="required" maxlength="100"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>确认密码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="password" name="remm" autocomplete="off"/>
			</td>
		</tr>		
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h">联系电话:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="phone" value="<%=phone %>"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h">性别:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<label><input type="radio" value="男" name="xb" <%if("男".equals(xb)) out.print("checked"); %>/>男</label> 
				<label><input type="radio" value="女" name="xb" <%if("女".equals(xb)) out.print("checked"); %>/>女</label> 
				
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>学院:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<select name="bmbh">
<%
				int i=0;
				List<Object[]> notes = DataBase.listQuery(datasource,"select id,name from v_leaf where pid='1' order by ord");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
					Object[] note = it.next();	
%>
					<option value="<%=note[0].toString() %>" <% if(bmbh.equals(note[0].toString())) out.print("selected"); %>><%=note[1].toString() %></option>
					
<%} %>			
				</select>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>专业</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="zy" value="<%=zy %>"/>
			</td>
		</tr>
		
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>邮箱:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="email" value="<%=email %>"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h">是否禁用:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<label><input type="radio" value="1" name="islock" <%if("1".equals(islock)) out.print("checked"); %>/>否</label> 
				<label><input type="radio" value="2" name="islock" <%if("2".equals(islock)) out.print("checked"); %>/>是</label> 
				
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