<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%@page import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*" %>
<%@page import="org.apache.poi.ss.usermodel.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.hssf.util.*,org.apache.poi.ss.usermodel.WorkbookFactory;" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title>新闻添加</title>

<link href="/xhlwpt/backsys/res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="/xhlwpt/backsys/res/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="/xhlwpt/thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/xhlwpt/backsys/res/js/regcheckdata.js" type="text/javascript"></script>
<script type="text/javascript">
function datacheck(){
	
	if(form1.file1.value=="" || checkWhite(form1.file1.value)){
		alert("文件名不能为空！");		
		return false;
	}
	if( !dfile_accept(form1.file1.value) ) {
		alert("数据文件格式为：*.xls、*.xlsx");		
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
	String flag="";	
	String filename="",yhbh=((Map<String,String>)session.getAttribute("userinfo")).get("yhbh");
	
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		DiskFileItemFactory factory = new DiskFileItemFactory(); 
		ServletFileUpload uploader = new ServletFileUpload(factory);
		List<FileItem> list = null;
		
		// 如果在应用根目录下没有用于存储上传文件的simpleUplaodDir目录，创建该目录
		String path = getServletContext().getRealPath("/UploadDir/datafile");
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
				
			if ( !item.isFormField() ){
				filename = item.getName().substring(item.getName().indexOf("."));
				String filepath = uploadDir.getAbsolutePath() + "/" + yhbh+filename;
				//System.out.println(filepath);
				try {
					item.write(new File(filepath));
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
		
		//System.out.println(path);
	}
	String errorName = "";
	int count = 0;
	if(flag!=null && "true".equals(flag)){ 		
		String path = request.getSession().getServletContext().getRealPath("");	  
		String s = path + "//UploadDir//datafile//"+yhbh+filename;
		   
		// 读取xls
		List<Object[]> notes = new ArrayList<Object[]>(); 
		notes =  RWExcel.listQuery(s,"sheet1",3,RWExcel.LastRowNum(s, "sheet1")+1,1,12);
		//System.out.println(notes.size());
		int i = 0;
		for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
			Object[] note = it.next();
			
			if(note[10].toString().indexOf(".")!=-1) 
				note[10] = note[10].toString().substring(0, note[10].toString().indexOf("."));
			if(note[9].toString().indexOf(".")!=-1) 
				note[9] = note[9].toString().substring(0, note[9].toString().indexOf("."));
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmmssSSS");
			String UId=sdf.format(date)+String.format("%1$03d",(new Random()).nextInt(1000));
	
			//excel to oracle			 
			String prepsql="insert into wgryb(wgryid,name,sfz,sex,mz,birth,xl,szx,szc,addr,jtrk,phone,zc,islock,mm) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";		
			boolean result = DataBase.prepare(datasource,prepsql,UId,note[0],note[1],note[2],note[3],note[4],note[5],note[6],note[7],note[8],note[9],note[10],note[11],"1","111111");					
			if(result) count++;	
			else errorName += "<br>" + (i+1) + "、" + note[0];
			
		 }	
		 
	}

%>

<div class="box-positon">
	<div class="rpos">当前位置: 劳务 - 批量导入</div>
	
	<div class="clear"></div>
</div>
<div class="body-box">
	<form method="post" action="pldr.jsp" enctype="multipart/form-data" id="jvForm" name="form1" onSubmit="return datacheck();">
		<input type="hidden" name="flag" value="true"/>			
		<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
		
		<tr>			
			<td width="12%" class="pn-flabel pn-flabel-h"><span class="pn-frequired"></span>选择数据文件:</td>
			<td colspan="3" width="88%" class="pn-fcontent">
				<input type="file" id="file1" name="file1" style="width:450px;"/>
				<input type="submit" value="导入" class="submit" class="submit"/>
			</td>
			
		</tr>
		<tr>
			
			<td colspan="4" class="pn-fcontent">
				<span id="msg"></span>
			</td>
		</tr>
		</table>
	</form> 
	
</div>
<%
	if(flag!=null && "true".equals(flag)){
		if("".equals(errorName.trim())){     
%>
			<script type="text/javascript">			
				mdiv = document.getElementById("msg");
				mdiv.innerHTML = "您成功导入<%=count %>条数据，没有错误。";
									
			</script>

<%	
		}else{
%>
			<script type="text/javascript">			
				
				mdiv = document.getElementById("msg");
				mdiv.innerHTML = "您成功导入<%=count %>条数据，错误姓名为：<%=errorName%>";
			</script>

<%		
		}
	}
%>
</body>
</html>