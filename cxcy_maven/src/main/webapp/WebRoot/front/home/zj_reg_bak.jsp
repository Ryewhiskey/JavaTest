<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>西和县劳务信息管理平台</title>
<meta content="" name="keywords" />
<meta content="" name="description" />

<link rel="stylesheet" type="text/css" href="front/res/css/admin.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/theme.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/default.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/dropmenu.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/list_detail.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/front_login.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/mytheme.css"/>
<script src="thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="front/res/js/regcheckdata.js" type="text/javascript"></script>

<script type="text/javascript" src="front/res/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="front/res/js/login.js"></script>
<script type="text/javascript" src="front/res/js/dropmenu.js"></script>
<script type="text/javascript">
function datacheck(){
	
	if(form1.zjbh.value=="" || checkWhite(form1.zjbh.value)) {
		alert("中介编号不能为空！");		
		return false;
	}	
	if(form1.jgdm.value=="" || checkWhite(form1.jgdm.value)){
		alert("机构代码不能为空！");		
		return false;
	}
	
	if(form1.zjmc.value=="" || checkWhite(form1.zjmc.value)){
		alert("中介名称不能为空！");		
		return false;
	}
	if(form1.fr.value=="" || checkWhite(form1.fr.value)){
		alert("法人不能为空！");		
		return false;
	}
	if(form1.mm.value=="" || checkWhite(form1.mm.value)){
		alert("密码不能为空！");		
		return false;
	}
	if( ltrim(rtrim(form1.mm.value)) != ltrim(rtrim(form1.mm2.value)) ){
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
	function uni_yhm(url){
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
		
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmmssSSS");
	String UId=sdf.format(date)+String.format("%1$03d",(new Random()).nextInt(1000));
	
	request.setCharacterEncoding("UTF-8");
	
%>
    <%@include file="/front/include/header.jsp" %>
    <div id="subcontent" >
    	
    	<%@include file="/front/include/left1.jsp" %>
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";	
	String zjid=UId,zjbh="",jgdm="",zjmc="",addr="",fr="",jyfw="",mm="",islock="2";	
	
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		zjbh=request.getParameter("zjbh");
		if(zjbh!=null) zjbh=zjbh.trim();
		else zjbh = "";
		
		jgdm=request.getParameter("jgdm");
		if(jgdm!=null) jgdm=jgdm.trim();
		else jgdm = "";
		
		zjmc=request.getParameter("zjmc");
		if(zjmc!=null) zjmc=zjmc.trim();
		else zjmc = "";
		
		addr=request.getParameter("addr");
		if(addr!=null) addr=addr.trim();
		else addr = "";
		
		fr=request.getParameter("fr");
		if(fr!=null) fr=fr.trim();
		else fr = "";
		
		jyfw=request.getParameter("jyfw");
		if(jyfw!=null) jyfw=jyfw.trim();
		else jyfw = "";
		
		mm=request.getParameter("mm");
		if(mm!=null) mm=mm.trim();
		else mm = "";
		
		//System.out.println(sbbh);
		String prepsql="insert into zjb(zjid,zjbh,jgdm,zjmc,addr,fr,jyfw,mm,islock) values(?,?,?,?,?,?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,UId,zjbh,jgdm,zjmc,addr,fr,jyfw,mm,islock);					
		 
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
        <div class="right" >
        	<div class="content_search_result" title="信息列表内容展示" >
                <div class="search_result_border" >
                    <span>中介注册</span>
                </div>
                
                <div class="body-box" style="width:100%;">
					
		<form method="post" action="front/home/zj_reg.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>		
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>中介编号:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" maxlength="100" name="zjbh" value="<%=zjbh %>" onchange="uni_yhm('backsys/zjjg/uni_yhm.jsp?yhm='+this.value)"/>
				<div id="myDiv" class="pn-frequired"></div>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>机构代码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="jgdm" value="<%=jgdm %>"/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>中介名称:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="zjmc" value="<%=zjmc %>"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>地址:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="addr" value="<%=addr %>"/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>法人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="fr" value="<%=fr %>"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>经营范围:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="jyfw" value="<%=jyfw %>"/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="password" autocomplete="off" name="mm"/>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>确认密码:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="password" name="mm2" autocomplete="off"/>
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
                
        </div>
            
        	
    </div>      
    
    <%@include file="/front/include/bottom.html" %>
</body>
</html>
