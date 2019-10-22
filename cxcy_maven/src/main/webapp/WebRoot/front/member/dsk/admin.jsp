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

<title>导师管理</title>

<link href="../../res/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="../../res/css/theme.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	request.setCharacterEncoding("UTF-8");
	
%>
<%@include file="/front/include/front_check.jsp" %> 
<% 
	int pageNo = 0;
	int PAGE_SIZE = 0; 
	int totalPages = 0;	
	int totalRecords =0;
	String flag = "",sql="";	
	flag = request.getParameter("flag");	
	String strPageNo = request.getParameter("pageNo");	
	String bmbh = ((Map<String,String>)session.getAttribute("front_userinfo")).get("bmbh");
%>
<%
	//System.out.println(flag);
	String query1="",query2="",query3="";
	if(flag == null || flag.equals("form1") ){	
		
		query1 = request.getParameter("query1");
		if(query1!=null) query1 = query1.trim();
		else query1="";
				
		query2 = request.getParameter("query2");
		if(query2!=null) query2 = query2.trim();
		else query2="";
		
		query3 = request.getParameter("query3");
		if(query3!=null) query3 = query3.trim();
		else query3="";
				
		sql = "select tid,jsbh,name,xb,zy,bmbh,zc,yjly,phone,email,islock from teacher where bmbh='"+bmbh+"' ";						
		if( query1 !=null && !"".equals(query1) ){
			sql += " and " + "jsbh like '%"+query1+"%' ";
		}
		if( query2 !=null && !"".equals(query2) ){
			sql += " and " + "name like '%"+query2+"%' ";
		}		
		if( query3 !=null && !"".equals(query3) ){
			sql += " and " + "zy like '%"+query3+"%' ";
		}
		
		session.setAttribute("sql",sql);
		session.setAttribute("query1",query1);
		session.setAttribute("query2",query2);
		session.setAttribute("query3",query3);		
				
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
		
		query1=(String)session.getAttribute("query1");		
		if(query1==null) query1="";
		
		query2=(String)session.getAttribute("query2");		
		if(query2==null) query2="";
		
		query3=(String)session.getAttribute("query3");		
		if(query3==null) query3="";
		
	}
	
	//删除代码
	String act = request.getParameter("act");
	if(act!=null && act.equals("d") )
	{	String tid="";	
		tid = request.getParameter("tid");		
		DataBase.executeUpdate(datasource,"delete from teacher where tid = '" + tid + "'");
			
	}

%>
<div class="box-positon">
	<div class="rpos">当前位置: 管理中心 - 导师库</div>
	<form class="ropt">
		<input class="add" type="submit" value="添加" onclick="this.form.action='add.jsp';"/>
	</form>
	<div class="clear"></div>
</div>
<div class="body-box">
<form name="form1" action="admin.jsp" method="post" style="padding-top:5px;padding-bottom:5px;">
	<input type="hidden" name="flag" value="form1"/>
	教工号: <input type="text" name="query1" value="<%=query1 %>" style="width:100px"/>
	姓名: <input type="text" name="query2" value="<%=query2 %>" style="width:100px"/>
	专业: <input type="text" name="query3" value="<%=query3 %>" style="width:100px"/>	
	<input class="query" type="submit" value="查询"/>
</form>

<form id="tableForm" name="form2" method="post" target="_self">
<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
<thead class="pn-lthead"><tr>
  	<th>教工号</th>  	  
    <th>姓名</th>
    <th>性别</th>
   	<th>专业</th>
    <th>学院</th>
    <th>职称</th>
    <th>联系电话</th>
    <th>邮箱</th>    
    <th>禁用</th>
    <th width="120px;">操作</th>    
  </tr>
</thead>
<tbody  class="pn-ltbody">
<%
	if(sql!=null && !"".equals(sql) ){	
		
		List<Object[]> notes = new ArrayList<Object[]>();
		
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
		
		for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
			Object[] note = it.next();	
						
			Iterator<Object[]> it1 = DataBase.listQuery(datasource, "select name from department where id='"+note[5].toString()+"'").iterator();
			if(it1.hasNext()) 				
				note[5] = it1.next()[0];
			
			
			if("1".equals(note[10].toString()))  note[10]="否";
			if("2".equals(note[10].toString()))  note[10]="是";
											
%>
  <tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'"> 
  	  	  
    <td class="style3" ><div align="center"><% if(note[1]!=null) out.print(note[1].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[2]!=null) out.print(note[2].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[3]!=null) out.print(note[3].toString());else out.print("&nbsp;"); %></div></td>    
    <td class="style3" ><div align="center"><% if(note[4]!=null) out.print(note[4].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[5]!=null) out.print(note[5].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[6]!=null) out.print(note[6].toString());else out.print("&nbsp;"); %></div></td>
    <td class="style3" ><div align="center"><% if(note[8]!=null) out.print(note[8].toString());else out.print("&nbsp;"); %></div></td>    
    <td class="style3" ><div align="center"><% if(note[9]!=null) out.print(note[9].toString());else out.print("&nbsp;"); %></div></td>    
    <td class="style3" ><div align="center"><% if(note[10]!=null) out.print(note[10].toString());else out.print("&nbsp;"); %></div></td>    
    <td class="style3" ><div align="center">
<%    	 
	
	if( "admin".equals(note[1].toString()) )
		{

		}else{
 %>
    	<a href="admin.jsp?tid=<%=note[0].toString() %>&act=d" onclick="return confirm('删除操作无法恢复！是否继续？')" >删除</a>|| 
<%
		}
 %>		
		<a href="updt.jsp?tid=<%=note[0].toString() %> ">修改</a>
		
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