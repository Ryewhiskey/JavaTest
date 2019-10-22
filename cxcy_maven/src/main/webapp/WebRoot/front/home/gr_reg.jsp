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
	
	if(form1.name.value=="" || checkWhite(form1.name.value)) {
		alert("姓名不能为空！");		
		return false;
	}	
	if(form1.sfz.value=="" || checkWhite(form1.sfz.value)){
		alert("身份证不能为空！");		
		return false;
	} 
	if(!isvalidId(form1.sfz)){
		alert("身份证不正确！");		
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
	if(form1.mz.value=="" || checkWhite(form1.mz.value)){
		alert("民族不能为空！");		
		return false;
	}
	if(form1.birth.value=="" || checkWhite(form1.birth.value)){
		alert("出生日期不能为空！");		
		return false;
	}
	if(form1.xl.value=="" || checkWhite(form1.xl.value)){
		alert("学历不能为空！");		
		return false;
	}
	if(form1.szx.value=="" || checkWhite(form1.szx.value)){
		alert("所在乡不能为空！");		
		return false;
	}
	if(form1.szc.value=="" || checkWhite(form1.szc.value)){
		alert("所在村不能为空！");		
		return false;
	}
	if(form1.addr.value=="" || checkWhite(form1.addr.value)){
		alert("住址不能为空！");		
		return false;
	}
	if(!isNumber(form1.jtrk.value)){
		alert("家庭人口不正确！");		
		return false;
	}	
	if(!checkMobile(form1.phone.value) && !checkPhone(form1.phone.value)){
		alert("联系电话不正确！");		
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
    <%@include file="/front/include/header.jsp" %>
    <div id="subcontent" >
    	
    	<%@include file="/front/include/left1.jsp" %>
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";	
	String wgryid=UId,name="",sfz="",sex="男",mz="",birth="",xl="",szx="";
	String szc="",addr="",jtrk="",phone="",zc="",islock="2",mm="";	
	
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		name=request.getParameter("name");
		if(name!=null) name=name.trim();
		else name = "";
		
		sfz=request.getParameter("sfz");
		if(sfz!=null) sfz=sfz.trim();
		else sfz = "";
		
		sex=request.getParameter("sex");
		if(sex!=null) sex=sex.trim();
		else sex = "";
		
		mz=request.getParameter("mz");
		if(mz!=null) mz=mz.trim();
		else mz = "";
		
		birth=request.getParameter("birth");
		if(birth!=null) birth=birth.trim();
		else birth = "";
		
		xl=request.getParameter("xl");
		if(xl!=null) xl=xl.trim();
		else xl = "";
		
		szx=request.getParameter("szx");
		if(szx!=null) szx=szx.trim();
		else szx = "";
		
		szc=request.getParameter("szc");
		if(szc!=null) szc=szc.trim();
		else szc = "";
		
		addr=request.getParameter("addr");
		if(addr!=null) addr=addr.trim();
		else addr = "";
		
		jtrk=request.getParameter("jtrk");
		if(jtrk!=null) jtrk=jtrk.trim();
		else jtrk = "";
		
		phone=request.getParameter("phone");
		if(phone!=null) phone=phone.trim();
		else phone = "";
		
		zc=request.getParameter("zc");
		if(zc!=null) zc=zc.trim();
		else zc = "";
		
		mm=request.getParameter("mm");
		if(mm!=null) mm=mm.trim();
		else mm = "";
		
		//System.out.println(sbbh);
		String prepsql="insert into wgryb(wgryid,name,sfz,sex,mz,birth,xl,szx,szc,addr,jtrk,phone,zc,islock,mm) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,UId,name,sfz,sex,mz,birth,xl,szx,szc,addr,jtrk,phone,zc,islock,mm);					
		 
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
                    <span>个人注册</span>
                </div>
                
                <div class="body-box" style="width:100%;">
					
		<form method="post" action="front/home/gr_reg.jsp" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		<tr>
			<td width="20%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>姓名:</td>
			<td colspan="1" width="30%" class="pn-fcontent">
				<input type="text" name="name" value="<%=name %>"/>				
			</td>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>身份证号:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="sfz" value="<%=sfz %>"/>				
			</td>
		</tr>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="password" autocomplete="off" name="mm"/>
			</td>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>确认密码:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="password" name="mm2" autocomplete="off"/>
			</td>
		</tr>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>性别:</td>
			<td colspan="1" class="pn-fcontent">
				<label><input type="radio" value="男" name="sex" <%if("男".equals(sex)) out.print("checked"); %>/>男</label> 
				<label><input type="radio" value="女" name="sex" <%if("女".equals(sex)) out.print("checked"); %>/>女</label> 
			</td>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>民族:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="mz" value="<%=mz %>"/>
			</td>
		</tr>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>出生日期:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="birth" value="<%=birth %>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"/>
			</td>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>学历:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="xl" value="<%=xl %>"/>
			</td>
		</tr>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>所在乡:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="szx" value="<%=szx %>" />
			</td>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>所在村:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="szc" value="<%=szc %>" />
			</td>
		</tr>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>住址:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="addr" value="<%=addr %>" size="50"/>
			</td>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>家庭人口:</td>
			<td colspan="1" class="pn-fcontent">
				<input type="text" name="jtrk" value="<%=jtrk %>" />
			</td>
		</tr>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>联系电话:</td>
			<td colspan="3" class="pn-fcontent">
				<input type="text" name="phone" value="<%=phone %>" />
			</td>
			
		</tr>					
		
		<tr>
			<td class="pn-flabel pn-flabel-h">专长:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<textarea rows="3" cols="100" name="zc"><%=zc %></textarea>
				
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
