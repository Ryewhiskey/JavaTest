<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<title>管理员管理</title>

<link href="../../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../../res/css/theme.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	request.setCharacterEncoding("UTF-8");
	
%>
<%@include file="/backsys/include/back_check.jsp" %> 
<% 
	int pageNo = 0;
	int PAGE_SIZE = 0; 
	int totalPages = 0;	
	int totalRecords =0;
	String flag = "",sql="";	
	flag = request.getParameter("flag");	
	String strPageNo = request.getParameter("pageNo");	
	
%>
<%
	//System.out.println(flag);
	String queryyhm="",queryrealname="";
	if(flag == null || flag.equals("form1") ){	
		
		queryyhm = request.getParameter("queryyhm");
		if(queryyhm!=null) queryyhm = queryyhm.trim();
		else queryyhm="";
				
		queryrealname = request.getParameter("queryrealname");
		if(queryrealname!=null) queryrealname = queryrealname.trim();
		else queryrealname="";
				
		sql = "select yhbh,yhm,realname,phone,xb,bmbh,glyz,islock from admin where 1=1 ";						
		if( queryyhm !=null && !"".equals(queryyhm) ){
			sql += " and " + "yhm like '%"+queryyhm+"%' ";
		}
		if( queryrealname !=null && !"".equals(queryrealname) ){
			sql += " and " + "realname like '%"+queryrealname+"%' ";
		}
		
		session.setAttribute("sql",sql);
		session.setAttribute("queryyhm",queryyhm);
		session.setAttribute("queryrealname",queryrealname);
				
		if( (Integer)session.getAttribute("pagesize") != null) 
			PAGE_SIZE=(Integer)session.getAttribute("pagesize");		
		else 
			PAGE_SIZE = Integer.parseInt(sysconfig.get("pagesize"));
	}
	
	if(flag != null && flag.equals("form2") )
	{  		
		if(request.getParameter("pagesize")==null)
			PAGE_SIZE = Integer.parseInt(sysconfig.get("pagesize"));
		else{
			try{
				PAGE_SIZE = Integer.parseInt(request.getParameter("pagesize"));
			} catch (NumberFormatException e) {			
				PAGE_SIZE = Integer.parseInt(sysconfig.get("pagesize"));	
			} 
		}
			
		sql=(String)session.getAttribute("sql");		
		if(sql==null) sql="";
		
		queryyhm=(String)session.getAttribute("queryyhm");		
		if(queryyhm==null) queryyhm="";
		
		queryrealname=(String)session.getAttribute("queryrealname");		
		if(queryrealname==null) queryrealname="";
		
	}
	
	//删除代码
	String act = request.getParameter("act");
	if(act!=null && act.equals("d") )
	{	String yhbh="";	
		yhbh = request.getParameter("yhbh");		
		DataBase.executeUpdate(datasource,"delete from admin where yhbh = '" + yhbh + "'");
			
	}

%>
<div class="box-positon">
	<div class="rpos">当前位置: 管理员 - 管理员管理</div>
	<form class="ropt">
		<input class="add" type="submit" value="添加" onclick="this.form.action='add.jsp';"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
<form name="form1" action="admin.jsp" method="post" style="padding-top:5px;padding-bottom:5px;">
	<input type="hidden" name="flag" value="form1"/>
	用户名: <input type="text" name="queryyhm" value="<%=queryyhm %>" style="width:100px"/>
	真实姓名: <input type="text" name="queryrealname" value="<%=queryrealname %>" style="width:150px"/>
	<input class="query" type="submit" value="查询"/>
</form>

<form id="tableForm" name="form2" method="post" target="_self">
<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
<thead class="pn-lthead"><tr>
  	<th>用户编号</th>  	  
    <th>用户名</th>
    <th>真实姓名</th>
   	<th>联系电话</th>
    <th>性别</th>
    <th>部门</th>
    <th>管理员组</th>    
    <th>禁用</th>
    <th width="120px;">操作</th>    
  </tr>
</thead>
<tbody  class="pn-ltbody">
<%
	if(sql!=null && !"".equals(sql) ){	
		
		List<Object[]> notes = null;
		
		if(strPageNo != null && !"".equals(strPageNo.trim())) {
			try {
				pageNo = Integer.parseInt(strPageNo);
			} catch (NumberFormatException e) {
				pageNo = 1;	
			}  
		}
		
		//System.out.println("sql="+sql+"<br>");		
		if(!(PAGE_SIZE>0) )  PAGE_SIZE=1;
		totalRecords = DataBase.recordCount(datasource, sql);		
		totalPages = (totalRecords + PAGE_SIZE - 1)/PAGE_SIZE;				
	
		//分页		
		if(pageNo <= 0) pageNo = 1;		
		if(pageNo > totalPages) pageNo = totalPages;				
		
		
		notes = new ArrayList<Object[]>();
		if( totalPages>0 ){
		
			notes = DataBase.listQuery(datasource,sql,pageNo,PAGE_SIZE);	
					
		}
		
		session.setAttribute("resp","?flag=form2&pageNo="+pageNo+"&pagesize="+PAGE_SIZE);		
		session.setAttribute("pagesize",PAGE_SIZE);		
		int i=0;
		for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
			Object[] note = it.next();	
						
			Iterator<Object[]> it1 = DataBase.listQuery(datasource, "select name from department where id='"+note[5].toString()+"'").iterator();
			if(it1.hasNext()) 				
				note[5] = it1.next()[0];
			
			if("1".equals(note[6].toString()))  note[6]="校级管理员";
			if("2".equals(note[6].toString()))  note[6]="院级管理员";
			if("1".equals(note[7].toString()))  note[7]="否";
			if("2".equals(note[7].toString()))  note[7]="是";
											
%>
  <tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'"> 
  	  	  
    <td class="style3" ><div align="center"><% if(note[0]!=null) out.print(note[0].toString());else out.print("&nbsp;"); %></div></td>  	  
    <td class="style3" ><div align="center"><% if(note[1]!=null) out.print(note[1].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[2]!=null) out.print(note[2].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[3]!=null) out.print(note[3].toString());else out.print("&nbsp;"); %></div></td>    
    <td class="style3" ><div align="center"><% if(note[4]!=null) out.print(note[4].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[5]!=null) out.print(note[5].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[6]!=null) out.print(note[6].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[7]!=null) out.print(note[7].toString());else out.print("&nbsp;"); %></div></td>    
    <td class="style3" ><div align="center">
<%    	 
	
	if( "admin".equals(note[1].toString()) )
		{

		}else{
 %>
    	<a href="admin.jsp?yhbh=<%=note[0].toString() %>&act=d" onclick="return confirm('删除操作无法恢复！是否继续？')" >删除</a>|| 
<%
		}
 %>		
		<a href="updt.jsp?yhbh=<%=note[0].toString() %> ">修改</a>
		
    </div></td>
  </tr>
<% 
 	} 	
 }
  
%>
</tbody>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr><td align="center" class="pn-sp">
	共 <%=totalRecords %> 条&nbsp;
	每页<input type="text" name="pagesize" value="<%=PAGE_SIZE %>" style="width:30px;" />条&nbsp;
	<input class="first-page" type="button" value="首 页" onclick="this.form.action='admin.jsp?pageNo=1';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
	<input class="pre-page" type="button" value="上一页" onclick="this.form.action='admin.jsp?pageNo=<%=pageNo-1 %>';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
	<input class="next-page" type="button" value="下一页" onclick="this.form.action='admin.jsp?pageNo=<%=pageNo+1 %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>
	<input class="last-page" type="button" value="尾 页" onclick="this.form.action='admin.jsp?pageNo=<%=totalPages %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>&nbsp;
	当前 <%=pageNo %>/<%=totalPages %> 页 &nbsp;转到第<input type="text" name="gopageno" id="_goPs" value="<%=pageNo %>" style="width:50px" onkeypress="if(event.keyCode==13){this.form.action='admin.jsp?pageNo='+this.value;this.form.submit();}"/>页
	<input class="go" name="_goPage" type="button" value="转" onclick="this.form.action='admin.jsp?pageNo='+this.form._goPs.value;this.form.submit();"/>
</td></tr>
</table>

<input type="hidden" name="flag" value="form2"/>
<input type="hidden" name="totalPages" value="<%=totalPages %>"/>

</form>
</div>

</body>
</html>