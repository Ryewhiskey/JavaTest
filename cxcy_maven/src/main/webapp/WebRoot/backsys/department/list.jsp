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
<title></title>
<link href="../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../res/css/theme.css" rel="stylesheet" type="text/css"/>

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
	//String resp=(String)session.getAttribute("resp");
%>
<%	
	String pid="";
	pid = request.getParameter("pid");
	if(pid==null) pid = "1";
	//System.out.println("pid"+pid);
	if(flag == null ){		
		 	
		sql = "select id,name,pid,ord from department where pid='"+pid+"'";
				
		session.setAttribute("sql",sql);		
		
		if( (Integer)session.getAttribute("pagesize") != null) 
			PAGE_SIZE=(Integer)session.getAttribute("pagesize");		
		else 
			PAGE_SIZE = Integer.parseInt(sysconfig.get("pagesize"));
	}

	if(flag != null )
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
		//System.out.println("flag!=null "+sql);		
	}
	
	//删除代码
	String act = request.getParameter("act");
	if(act!=null && act.equals("d") )
	{	
		String id="";	
		id = request.getParameter("id");		
		int count = DataBase.executeUpdate(datasource,"delete from department where id = '" + id + "'");
		
		if(count==0){
%>
			<script type="text/javascript">			
				alert("操作失败，请检查数据？");						
			</script>
<%
		}	
	}
%>

<div class="box-positon">
	<div class="rpos">当前位置: 部门 - 列表</div>
	<form class="ropt" method="post">
		<input class="add4" type="submit" value="添加部门" onclick="this.form.action='add.jsp?pid=<%=pid%>';"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
<form id="tableForm" method="post">
	
	<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
	<thead class="pn-lthead"><tr>
		
		<th width="220">ID</th>
		<th>部门名称</th>		
		<th>排列顺序</th>
		<th>操作选项</th>
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
			notes = DataBase.listQuery(datasource,sql+" order by ord,name",pageNo,PAGE_SIZE);			
		}
		
		session.setAttribute("resp","?flag=true&pid="+pid+"&pageNo="+pageNo+"&pagesize="+PAGE_SIZE);		
		session.setAttribute("pagesize",PAGE_SIZE);		
		int i=0;
		for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
			Object[] note = it.next();									
%>
	<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
		<td align="center"><% if(note[0]!=null) out.print(note[0].toString());else out.print("&nbsp;"); %></td>
		<td align="center"><% if(note[1]!=null) out.print(note[1].toString());else out.print("&nbsp;"); %></td>
		<td align="center"><% if(note[3]!=null) out.print(note[3].toString());else out.print("&nbsp;"); %></td>
		<td align="center">	
			<a href="updt.jsp?id=<%=note[0].toString() %>" class="pn-opt">修改</a> 
<%
if( DataBase.recordCount(datasource, "select * from department where pid='"+note[0].toString()+"'") == 0)
 	{
 %>
			| <a href="list.jsp?act=d&id=<%=note[0].toString() %>" class="pn-opt" onclick="if(!confirm('您确定删除吗？')) {return false;}">删除</a>
<%	} %>
		</td>
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
		<input class="first-page" type="button" value="首 页" onclick="this.form.action='list.jsp?pageNo=1';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
		<input class="pre-page" type="button" value="上一页" onclick="this.form.action='list.jsp?pageNo=<%=pageNo-1 %>';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
		<input class="next-page" type="button" value="下一页" onclick="this.form.action='list.jsp?pageNo=<%=pageNo+1 %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>
		<input class="last-page" type="button" value="尾 页" onclick="this.form.action='list.jsp?pageNo=<%=totalPages %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>&nbsp;
		当前 <%=pageNo %>/<%=totalPages %> 页 &nbsp;转到第<input type="text" name="gopageno" id="_goPs" value="<%=pageNo %>" style="width:50px" onkeypress="if(event.keyCode==13){this.form.action='list.jsp?pageNo='+this.value;this.form.submit();}"/>页
		<input class="go" name="_goPage" type="button" value="转" onclick="this.form.action='list.jsp?pageNo='+this.form._goPs.value;this.form.submit();"/>
	</td></tr>
	</table>
	
	<input type="hidden" name="flag" value="true"/>
	<input type="hidden" name="pid" value="<%=pid %>"/>
	<input type="hidden" name="totalPages" value="<%=totalPages %>"/>

</form>
</div>
</body>

</html>