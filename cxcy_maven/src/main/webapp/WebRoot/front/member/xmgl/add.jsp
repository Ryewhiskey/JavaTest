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

<title>项目添加</title>

<link href="../../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../../res/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="../../../thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../../res/js/regcheckdata.js" type="text/javascript"></script>

<script type="text/javascript">
function datacheck(){
	
	if(form1.xmbh.value=="" || checkWhite(form1.xmbh.value)){
		alert("项目编号不能为空！");		
		return false;
	}
	if(form1.xmmc.value=="" || checkWhite(form1.xmmc.value)) {
		alert("项目名称不能为空！");		
		return false;
	}	
	if(form1.xmlx.value=="" || checkWhite(form1.xmlx.value)){
		alert("项目类型不能为空！");		
		return false;
	}
	
	if(form1.lxnf.value=="" || checkWhite(form1.lxnf.value)){
		alert("立项年份不能为空！");		
		return false;
	}
	
	if(form1.fzr.value=="" || checkWhite(form1.fzr.value)){
		alert("负责人不能为空！");		
		return false;
	}
	if(form1.cyrs.value=="" || checkWhite(form1.cyrs.value) || !isNumber(form1.cyrs.value)){
		alert("参与学生人数不能为空！");		
		return false;
	}
	if(form1.yjxkdm.value=="" || checkWhite(form1.yjxkdm.value)){
		alert("一级学科不能为空！");		
		return false;
	}
	if(form1.dsbh.value=="" || checkWhite(form1.dsbh.value)){
		alert(" 指导教师不能为空！");		
		return false;
	}
	if(form1.jtsj.value=="" || checkWhite(form1.jtsj.value)){
		alert("结题时间不能为空！");		
		return false;
	}
	if(form1.zzje.value=="" || checkWhite(form1.zzje.value)){
		alert("资助金额不能为空！");		
		return false;
	}
	if(form1.xmjj.value=="" || checkWhite(form1.xmjj.value)){
		alert("项目简介不能为空！");		
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
	
	String id=UId,lxnf="",xmjb="校级",xmbh="111111111111",xmmc="",xmlx="",fzr="";
	String cyrs="",qtcy="",dsbh="",qtds="",yjxkdm="",zzje="0.0",jtsj="",xmjj="";
		
	String yhm = ((Map<String,String>)session.getAttribute("front_userinfo")).get("yhm");
						
	if( "3".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz")) ){
		dsbh=yhm;
	}
	if( "4".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz")) ){
		fzr = yhm;
			
	}
	flag = request.getParameter("flag");
	if( flag != null && flag.equals("true") )
	{		
		lxnf=request.getParameter("lxnf");
		if(lxnf!=null) lxnf=lxnf.trim();
		else lxnf = "";
		
		xmjb=request.getParameter("xmjb");
		if(xmjb!=null) xmjb=xmjb.trim();
		else xmjb = "";
		
		xmbh=request.getParameter("xmbh");
		if(xmbh!=null) xmbh=xmbh.trim();
		else xmbh = "";
		if("111111111111".equals(xmbh)) xmbh=null;
		
		xmmc=request.getParameter("xmmc");
		if(xmmc!=null) xmmc=xmmc.trim();
		else xmmc = "";
		
		xmlx=request.getParameter("xmlx");
		if(xmlx!=null) xmlx=xmlx.trim();
		else xmlx = "";		
		
		fzr=request.getParameter("fzr"); 
		if(fzr!=null) fzr=fzr.trim();
		else fzr = "";
		
		cyrs=request.getParameter("cyrs");
		if(cyrs!=null) cyrs=cyrs.trim();
		else cyrs = "";
		
		qtcy=request.getParameter("qtcy");
		if(qtcy!=null) qtcy=qtcy.trim();
		else qtcy = "";
		
		dsbh=request.getParameter("dsbh");
		if(dsbh!=null) dsbh=dsbh.trim();
		else dsbh = "";
		
		qtds=request.getParameter("qtds");
		if(qtds!=null) qtds=qtds.trim();
		else qtds = "";
		
		yjxkdm=request.getParameter("yjxkdm");
		if(yjxkdm!=null) yjxkdm=yjxkdm.trim();
		else yjxkdm = "";
		
		zzje=request.getParameter("zzje");
		if(zzje!=null) zzje=zzje.trim();
		else zzje = "";
		
		jtsj=request.getParameter("jtsj");
		if(jtsj!=null) jtsj=jtsj.trim();
		else jtsj = "";
		
		xmjj=request.getParameter("xmjj");
		if(xmjj!=null) xmjj=xmjj.trim();
		else xmjj = "";
		
		if( "3".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz")) ){
			dsbh=yhm;
		}
		if( "4".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz")) ){
			fzr = yhm;
				
		}
		
		String prepsql="insert into xmhzb(id,lxnf,xmjb,xmbh,xmmc,xmlx,fzr,cyrs,qtcy,dsbh,qtds,yjxkdm,zzje,jtsj,xmjj) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,UId,lxnf,xmjb,xmbh,xmmc,xmlx,fzr,cyrs,qtcy,dsbh,qtds,yjxkdm,zzje,jtsj,xmjj);					
		 
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
		if(xmbh==null) xmbh="111111111111";
	}
 	
%>
<div class="box-positon">
	<div class="rpos">当前位置: 管理中心 - 项目管理 - 项目添加</div>
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
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>项目编号:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="xmbh" value="<%=xmbh %>" />				
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>项目名称:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="xmmc" value="<%=xmmc %>" style="width:98%"/>				
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>项目类型:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<select name="xmlx">
					<option value="" ></option>
					<option value="创新训练项目" <% if("创新训练项目".equals(xmlx)) out.print("selected"); %>>创新训练项目</option>
					<option value="创业训练项目" <% if("创业训练项目".equals(xmlx)) out.print("selected"); %>>创业训练项目</option>
					<option value="创业实践项目" <% if("创业实践项目".equals(xmlx)) out.print("selected"); %>>创业实践项目</option>
				</select>
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>立项年份:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="lxnf" value="<%=lxnf %>" onclick="WdatePicker({dateFmt:'yyyy'})" class="Wdate"/>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>项目级别:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<label><input type="radio" value="国家级" name="xmjb" <%if("国家级".equals(xmjb)) out.print("checked"); %>/>国家级</label> 
				<label><input type="radio" value="校级" name="xmjb" <%if("校级".equals(xmjb)) out.print("checked"); %>/>校级</label> 
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>负责人:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<select name="fzr" <% if( "4".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz")) ) out.print("disabled"); %> >
				<option value="" ></option>
<%
				
				List<Object[]> notes = DataBase.listQuery(datasource,"select xh,name from student order by name");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
					<option value="<%=note[0].toString() %>" <% if(fzr.equals(note[0].toString())) out.print("selected"); %>><%=note[1].toString() %></option>
					
<%} %>			
				</select>
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>参与学生人数:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="cyrs" value="<%=cyrs %>" />
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>一级学科:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<select name="yjxkdm">
				<option value="" ></option>
<%				
				notes = DataBase.listQuery(datasource,"select id,name from xkdmb order by id");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
					<option value="<%=note[0].toString() %>" <% if(yjxkdm.equals(note[0].toString())) out.print("selected"); %>><%=note[0].toString()+note[1].toString() %></option>
					
<%} %>			
				</select>
			</td>
		</tr>
		<tr>			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>项目其他成员:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<input type="text" name="qtcy" value="<%=qtcy %>"  size="50" style="margin-bottom:5px;"/><br/>
				填写格式(姓名/学号)：如成员1/2014001,成员2/2014002,成员3/2014003,注意：逗号请用英文状态下的格式填写；
			</td>
		</tr>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>指导教师:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="dsbh" value="<%=dsbh %>"/>填写格式(姓名/职称)
			</td>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>结题时间:</td>
			<td colspan="1" width="38%" class="pn-fcontent">
				<input type="text" name="jtsj" value="<%=jtsj %>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate"/>
			</td>
		</tr>
		<tr>
			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>其他指导教师:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<input type="text" name="qtds" value="<%=qtds %>" size="50" style="margin-bottom:5px;"/><br/>
				填写格式(姓名/职称)：如姓名1/教授,姓名2/副教授,姓名3/高级工程师,注意：逗号请用英文状态下的格式填写；
			</td>
		</tr>		
		<tr>
			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>资助金额:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<input type="text" name="zzje" value="<%=zzje %>" />
			</td>
		</tr>					
		
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h">项目简介:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<textarea rows="10" name="xmjj" style="width:660px;resize:none;"><%=xmjj %></textarea>
				
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