<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>大学生创新创业训练计划管理平台</title>
<meta content="" name="keywords" />
<meta content="" name="description" />
<link rel="stylesheet" type="text/css" href="front/res/css/admin.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/theme.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/default.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/dropmenu.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/list_detail.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/front_login.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/mytheme.css"/>

<script type="text/javascript" src="front/res/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="front/res/js/login.js"></script>
<script type="text/javascript" src="front/res/js/dropmenu.js"></script>



</head>

<body>
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	request.setCharacterEncoding("UTF-8");
	
%>
    <%@include file="/front/include/header.jsp" %>
    <div id="subcontent" >    	
    	<%@include file="/front/include/left1.jsp" %>

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
				
		sql = "select tid,jsbh,name,xb,zy,bmbh,zc,yjly,phone,email,islock from teacher where islock='1' ";						
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
	
%> 
        <div class="right" >
        	<div class="content_right_search">        
        	<div class="content_search_result">
                <div class="search_result_border" >
                    <span>导师库</span>
                </div>
				<div id="search">
					<form name="form1" method="post" action="front/dsk/index.jsp">
						<input type="hidden" name="flag" value="form1"/>
						教工号: <input type="text" name="query1" value="<%=query1 %>" style="width:100px"/>
						姓名: <input type="text" name="query2" value="<%=query2 %>" style="width:100px"/>
						专业: <input type="text" name="query3" value="<%=query3 %>" style="width:100px"/>	
						<input class="query" type="submit" value="查询"/>                             
					</form>
					
				</div>
			   
			<div id="search_result">
				<div class="result_content">
					<div id="newsquery">
						<ul id="queryul">
							<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
								<thead class="pn-lthead">
								<tr>									  	  
								    <th>姓名</th>
								    <th>性别</th>
								   	<th>专业</th>
								    <th>学院</th>
								    <th>职称</th>
								    <th>联系电话</th>
								    <th>邮箱</th>							       
								</tr>
								</thead>
								<tbody  class="pn-ltbody">
<%
	if(sql!=null && !"".equals(sql) ){	
		
		notes = new ArrayList<Object[]>();
		
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

			<a href="front/dsk/detail.jsp?tid=<%=note[0].toString() %>" >
			
			<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
				<td class="style3" ><div align="center"><% if(note[2]!=null) out.print(note[2].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[3]!=null) out.print(note[3].toString());else out.print("&nbsp;"); %></div></td>    
			    <td class="style3" ><div align="center"><% if(note[4]!=null) out.print(note[4].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[5]!=null) out.print(note[5].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[6]!=null) out.print(note[6].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[8]!=null) out.print(note[8].toString());else out.print("&nbsp;"); %></div></td>    
			    <td class="style3" ><div align="center"><% if(note[9]!=null) out.print(note[9].toString());else out.print("&nbsp;"); %></div></td>    
			    
			</tr>
			</a>
<% 
 	} 	
 }
  
%>
								</tbody>
							</table>                
						</ul>
					</div>
					<div id="showpages" style="text-align:center;">
 						<form name="form2" method="post" target="_self">
							共 <%=totalRecords %> 条&nbsp;
							每页<input type="text" name="pagesize" value="<%=PAGE_SIZE %>" style="width:30px;" />条&nbsp;
							<input class="first-page" type="button" value="首 页" onclick="this.form.action='front/dsk/index.jsp?pageNo=1';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
							<input class="pre-page" type="button" value="上一页" onclick="this.form.action='front/dsk/index.jsp?pageNo=<%=pageNo-1 %>';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
							<input class="next-page" type="button" value="下一页" onclick="this.form.action='front/dsk/index.jsp?pageNo=<%=pageNo+1 %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>
							<input class="last-page" type="button" value="尾 页" onclick="this.form.action='front/dsk/index.jsp?pageNo=<%=totalPages %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>&nbsp;
							当前 <%=pageNo %>/<%=totalPages %> 页 &nbsp;转到第<input type="text" name="gopageno" id="_goPs" value="<%=pageNo %>" style="width:50px" onkeypress="if(event.keyCode==13){this.form.action='front/dsk/index.jsp?pageNo='+this.value;this.form.submit();}"/>页
							<input class="go" name="_goPage" type="button" value="转" onclick="this.form.action='front/dsk/index.jsp?pageNo='+this.form._goPs.value;this.form.submit();"/>
							
							<input type="hidden" name="flag" value="form2"/>
							<input type="hidden" name="totalPages" value="<%//=totalPages %>"/>
						</form>
					</div>
				</div>
			</div>
			</div>            
		</div>	
	</div>      
   
    <%@include file="/front/include/bottom.html" %>
</body>
</html>
