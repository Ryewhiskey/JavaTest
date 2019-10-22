<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%@page import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*;" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="x-ua-compatible" content="ie=8" /> 
<title>成果维护</title>

<link href="<%=path %>/front/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="<%=path %>/front/res/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="<%=path %>/thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="<%=path %>/front/res/js/regcheckdata.js" type="text/javascript"></script>

<script type="text/javascript">
function datacheck(){
	
	if(form1.xmid.value=="" || checkWhite(form1.xmid.value)) {
		alert("项目名称不能为空！");		
		return false;
	}
	if( form1.file1.value!="" && !tfile_accept(form1.file1.value) ) {
		alert("资料文件格式为：*.jpg、*.jpeg、*.bmp、*.gif、*.png");		
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
<%@include file="/front/include/front_check.jsp" %> 
<%
	String resp=(String)session.getAttribute("resp");
	String flag="";
	String id="",xmid="",content="",issuccess="",filename="";	
	String oldfile="",isuploadfile="0";
	String yhz = ((Map<String,String>)session.getAttribute("front_userinfo")).get("yhz");
	
	flag = request.getParameter("flag");
	id = request.getParameter("id");
	if( id!=null && !"".equals(id.trim()) ){
		String sql = "select xmid,content,issuccess,filename from cgzsb where id = '" + id + "'";
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {	
			Object[] note = it.next();
			if(note[0]!=null) 	xmid=note[0].toString();
			if(note[1]!=null) 	content=note[1].toString();
			if(note[2]!=null) 	issuccess=note[2].toString();
			if(note[3]!=null) 	oldfile=filename=note[3].toString();					
		}
	}
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		DiskFileItemFactory factory = new DiskFileItemFactory(); 
		ServletFileUpload uploader = new ServletFileUpload(factory);
		List<FileItem> list = null;
		
		// 如果在应用根目录下没有用于存储上传文件的simpleUplaodDir目录，创建该目录
		path = getServletContext().getRealPath("/UploadDir/news");
		File uploadDir = new File(path);
		if (!uploadDir.exists()) uploadDir.mkdir();
		
		// 小于指定尺寸（默认10KB）的文件直接保存在内存中，否则保存在磁盘临时文件夹
		factory.setSizeThreshold(1024 * 50);
		
		// 设置处理上传文件时保存临时文件的临时文件夹，没有指定则采用系统默认临时文件夹
		File tempDir = new File(getServletContext().getRealPath("/UploadDir/temp"));
		if (!tempDir.exists())	tempDir.mkdir();
		factory.setRepository(tempDir);
		
		// 设置单个上传文件的最大尺寸限制，参数为以字节为单位的long型数字
		uploader.setFileSizeMax(300 * 1024 * 1024);
		
		// 设置整个请求上传数据的最大尺寸限制，参数为以字节为单位的long型数字
		uploader.setSizeMax(301 * 1024 * 1024);
		
		// 设置字符编码
		uploader.setHeaderEncoding("UTF-8");
		
		try{
			list = uploader.parseRequest(request);
		} catch (Exception e){
%>
	<script type="text/javascript">
		alert("请求被拒绝，因为文件的最大尺寸300M！");
		history.go(-1);
	</script>
<%
	return;	
		}
		
		for (FileItem item : list) {
		
	if( item.isFormField() && "flag".equals(item.getFieldName()) ) 
		flag=item.getString("UTF-8");
	if( item.isFormField() && "id".equals(item.getFieldName()) ) 
		id=item.getString("UTF-8");
	if( item.isFormField() && "xmid".equals(item.getFieldName()) ) 
		xmid=item.getString("UTF-8");
	if( item.isFormField() && "issuccess".equals(item.getFieldName()) ) 
		issuccess=item.getString("UTF-8");			
		
	if ( !item.isFormField() ){
		if(item.getName()!=null && !"".equals(item.getName())){
	RWfile.deleteFile(getServletContext().getRealPath("/UploadDir/news")+"/"+filename);
	filename = item.getName().substring(item.getName().indexOf("."));
	String filepath = uploadDir.getAbsolutePath() + "/" + id+filename;
	//System.out.println(filepath);
	try {
		item.write(new File(filepath));
		oldfile=id+filename;
		isuploadfile="1";
	} catch (Exception e) {
%>
	<script type="text/javascript">
		alert("文件上传失败！");
		history.go(-1);
	</script>
<%
	return;	
	}
	out.flush();
								
		}
	}
		}
		
		//System.out.println(path);
	}
	if(flag!=null && "true".equals(flag)){
		boolean result=false;
		if("1".equals(isuploadfile)){
	String prepsql="update cgzsb set xmid=?,filename=?,content=?,issuccess=? where id='"+id+"'";		
	result = DataBase.prepare(datasource,prepsql,xmid,id+filename,"",issuccess);
		}else{
	String prepsql="update cgzsb set xmid=?,content=?,issuccess=? where id='"+id+"'";		
	result = DataBase.prepare(datasource,prepsql,xmid,"",issuccess);
		}	
		System.out.println(result); 
		if(result==false) {
	RWfile.deleteFile(getServletContext().getRealPath("/UploadDir/news")+"/"+id+filename);
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
	<div class="rpos">当前位置: 管理中心 - 成果管理 - 成果维护</div>
	<form class="ropt" method="post">
		<input type="submit" value="返回列表" onclick="this.form.action='admin.jsp<%=resp %>';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="updt.jsp" enctype="multipart/form-data" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>
		<input type="hidden" name="id" value="<%=id %>"/>
		<input type="hidden" name="oldfile" value="<%=oldfile %>"/>
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
<%if(!"2".equals(yhz)) { %>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>项目名称:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<input type="hidden" name="xmid" value="<%=xmid %>"/>				
<%				
				List<Object[]> notes = DataBase.listQuery(datasource,"select cgzsb_id,xmmc from v_xm_cg where cgzsb_id='"+id+"' order by lxnf desc,xmmc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
					<%=note[1].toString() %>
					
<%} %>			
				
			</td>
			
		</tr>
<%}else{ %>
		<tr>
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>项目名称:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<select name="xmid" >
				<option value="" ></option>
<%				
				List<Object[]> notes = DataBase.listQuery(datasource,"select id,xmmc from xmhzb order by lxnf desc,xmmc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
					<option value="<%=note[0].toString() %>" <% if(xmid.equals(note[0].toString())) out.print("selected"); %>><%=note[1].toString() %></option>
					
<%} %>			
				</select>
			</td>
			
		</tr>
<%} %>		
<%if(!"2".equals(yhz)) { %>
		<tr>			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>审核状态:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
			<%if( "1".equals(issuccess) ) out.print("未审核 "); else out.print("审核 ");%>			
			<input type="hidden" name="issuccess" value="<%=issuccess %>"/>
			</td>
		</tr>
		
<%}else{ %>
		<tr>			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>审核:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<label><input type="radio" value="1" name="issuccess" <%if("1".equals(issuccess)) out.print("checked"); %> />未审核</label> 
				<label><input type="radio" value="2" name="issuccess" <%if("2".equals(issuccess)) out.print("checked"); %> />审核</label> 
				
			</td>
		</tr>
<%} %>
		<tr>
			<td class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>展板上传:</td>
			<td colspan="3" class="pn-fcontent">
				<input type="file" id="file1" name="file1" style="width:350px;"/>
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