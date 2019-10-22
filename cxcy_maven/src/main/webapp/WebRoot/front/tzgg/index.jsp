<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	
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
<script type="text/javascript" src="front/res/js/dropmenu.js"></script>
<script type="text/javascript" src="front/res/js/login.js"></script>
</head>

<body>
    <%@include file="/front/include/header.jsp" %>
    <div id="subcontent" >
    	
    	<%@include file="/front/include/left1.jsp" %>
<% 
	int pageNo = 0;
	int PAGE_SIZE = Integer.parseInt(sysconfig.get("pagesize")); 
	//PAGE_SIZE = 1;
	int totalPages = 0;	
	int totalRecords =0;
	String sql="";	
	String strPageNo = request.getParameter("pageNo");
	
	if(!(PAGE_SIZE>0) )  PAGE_SIZE=1;
	
	//分页		
	if(strPageNo != null && !"".equals(strPageNo.trim())) {
		try {
			pageNo = Integer.parseInt(strPageNo);
		} catch (NumberFormatException e) {
			pageNo = 1;	
		}  
	}
	
	//System.out.println("sql="+sql+"<br>");
	totalRecords = DataBase.recordCount(datasource, "select id,title,fbrq from ggb where issuccess='2'");		
	totalPages = (totalRecords + PAGE_SIZE - 1)/PAGE_SIZE;				
	
	if(pageNo <= 0) pageNo = 1;		
	if(pageNo > totalPages) pageNo = totalPages;	
	
	
	notes = null;	
	if( totalPages>0 ){	
		notes = DataBase.listQuery(datasource,"select id,title,fbrq from ggb where issuccess='2' order by fbrq desc",pageNo,PAGE_SIZE);	
				
	}
	
%>
        <div class="right" >
        	<div class="content_search_result" title="通知公告" >
                <div class="search_result_border" >
                    <span>通知公告</span>
                </div>
                <div id="search_result">
                	<div class="result_content">
                    	<div id="newsquery">
                            <ul id="queryul">
 <%
								
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
                            <li class="title">
                               <div class="title">
                                <a target="_self" href="front/tzgg/second.jsp?id=<%=note[0].toString() %>">
                                <%if(note[1].toString().length()>50) out.print(note[1].toString().substring(0, 50)+"..."); else out.print(note[1].toString()); %>
                                </a>
                                </div>
                                <div class="time"><%=note[2].toString() %></div>
                            </li>
                            
<%} %>                               
                               
                            </ul>
						</div>
                        <div id="showpages" style="text-align:center;">
	                        <form name="form1" method="post" target="_self">
	                    		共 <%=totalRecords %> 条&nbsp;
								每页 <%=PAGE_SIZE %> 条&nbsp;
								<input class="first-page" type="button" value="首 页" onclick="this.form.action='front/tzgg/index.jsp?pageNo=1';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
								<input class="pre-page" type="button" value="上一页" onclick="this.form.action='front/tzgg/index.jsp?pageNo=<%=pageNo-1 %>';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
								<input class="next-page" type="button" value="下一页" onclick="this.form.action='front/tzgg/index.jsp?pageNo=<%=pageNo+1 %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>
								<input class="last-page" type="button" value="尾 页" onclick="this.form.action='front/tzgg/index.jsp?pageNo=<%=totalPages %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>&nbsp;
								当前 <%=pageNo %>/<%=totalPages %> 页 &nbsp;转到第<input type="text" name="gopageno" id="_goPs" value="<%=pageNo %>" style="width:50px" onkeypress="if(event.keyCode==13){this.form.action='front/tzgg/index.jsp?pageNo='+this.value;this.form.submit();}"/>页
								<input class="go" name="_goPage" type="button" value="转" onclick="this.form.action='front/tzgg/index.jsp?pageNo='+this.form._goPs.value;this.form.submit();"/>
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
