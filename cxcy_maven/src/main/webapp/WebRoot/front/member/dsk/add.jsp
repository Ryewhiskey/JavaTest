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

<title>导师添加</title>

<link href="../../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../../res/css/theme.css" rel="stylesheet" type="text/css"/>

<script src="../../res/js/regcheckdata.js" type="text/javascript"></script>
<script type="text/javascript">
function datacheck(){
	
	if(form1.jsbh.value=="" || checkWhite(form1.jsbh.value) || !isNumber(form1.jsbh.value)) {
		alert("教工号不能为空,且是数字串！");		
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
	if(form1.zc.value=="" || checkWhite(form1.zc.value)){
		alert("职称不能为空！");		
		return false;
	}
	if(form1.yjly.value=="" || checkWhite(form1.yjly.value)){
		alert("研究领域不能为空！");		
		return false;
	}
	
	if(form1.email.value=="" || checkWhite(form1.email.value) || !checkEmail(form1.email.value)){
		alert("邮箱不能为空或邮箱不正确！");		
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
	    	    if(xmlhttp.responseText.length==9){	    			
	    			document.getElementById("submit").disabled=undefined;
	    		}else{
	    			document.getElementById("submit").setAttribute("disabled","disabled");
	    		}		 
	    	}
	  	});
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
	String tid=UId,jsbh="",name="",zy="",phone="",xb="男",zc="",bmbh="",yjly="",email="",islock="1";//1-否   2-禁用	
	bmbh = ((Map<String,String>)session.getAttribute("front_userinfo")).get("bmbh");
	
	int count = 0; 	
	boolean result = false;
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		jsbh=request.getParameter("jsbh");
		if(jsbh!=null) jsbh=jsbh.trim();
		else jsbh = "";
		
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
				
		zc=request.getParameter("zc");
		if(zc!=null) zc=zc.trim();
		else zc="";
		
		bmbh=request.getParameter("bmbh");
		if(bmbh!=null) bmbh=bmbh.trim();
		else bmbh="";
		
		yjly=request.getParameter("yjly");
		if(yjly!=null) yjly=yjly.trim();
		else yjly="";
		
		email=request.getParameter("email");
		if(email!=null) email=email.trim();
		else email="";
		
		islock=request.getParameter("islock");
		if(islock!=null) islock=islock.trim();
		else islock="";
				
		String prepsql="insert into teacher(tid,jsbh,name,xb,zy,bmbh,zc,yjly,phone,email,mm,islock) values(?,?,?,?,?,?,?,?,?,?,?,?)";		
		result = DataBase.prepare(datasource,prepsql,tid,jsbh,name,xb,zy,bmbh,zc,yjly,phone,email,jsbh,Integer.parseInt(islock));					
		
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
	<div class="rpos">当前位置: 导师 - 导师添加</div>
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
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>教工号:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" maxlength="100" name="jsbh" value="<%=jsbh %>" onchange="uni_id('uni_id.jsp?id='+this.value)"/>
				<div id="myDiv" class="pn-frequired"></div>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>姓名:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="name" value="<%=name %>" class="email"/>
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
				List<Object[]> notes = DataBase.listQuery(datasource,"select id,name from v_leaf where pid='1' and id='"+bmbh+"'");
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
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>职称:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="zc" value="<%=zc %>"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>研究领域</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="yjly" value="<%=yjly %>" style="width:98%;" /><br/>
				多个研究领域之间用,隔开
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
				<input type="submit" id="submit" value="提交" class="submit" <%if(result==true) out.print("disabled");  %>/> &nbsp; 
				<input type="reset" value="重置" class="reset" />
			</td>
		</tr>
		</table>
	</form>
</div>
</body>
</html>