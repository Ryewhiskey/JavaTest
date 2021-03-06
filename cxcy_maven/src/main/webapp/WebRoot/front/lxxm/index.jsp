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
    	<%//@include file="/front/include/left1.jsp" %>

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
	String query1="",query2="",query3="",query4="",query5="",query6="";
	int delcount = 0;
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
		
		query4 = request.getParameter("query4");  
		if(query4!=null) query4 = query4.trim();
		else query4="";
		
		query5 = request.getParameter("query5");  
		if(query5!=null) query5 = query5.trim();
		else query5="";
		
		query6 = request.getParameter("query6");  
		if(query6!=null) query6 = query6.trim();
		else query6="";
		//System.out.println(query5);	
		sql = "select xmhzb.id,lxnf,xmjb,xmbh,xmmc,xmlx,student.name as sname,cyrs,qtcy,dsbh,qtds,xkdmb.name as xkmc,zzje,jtsj from xmhzb,student,xkdmb where xmhzb.fzr=student.xh and xmhzb.yjxkdm=xkdmb.id ";						
		if( query1 !=null && !"".equals(query1) ){
			sql += " and " + "lxnf like '%"+query1+"%' ";
		}
		if( query2 !=null && !"".equals(query2) && !"0".equals(query2)){
			sql += " and " + "xmjb like '%"+query2+"%' ";
		}
		if( query3 !=null && !"".equals(query3) ){
			sql += " and " + "xmmc like '%"+query3+"%' ";
		}
		if( query4 !=null && !"".equals(query4) && !"0".equals(query4)){
			sql += " and " + "xmlx like '%"+query4+"%' ";
		}
		if( query5 !=null && !"".equals(query5)){
			sql += " and " + "student.name like '%"+query5+"%' ";
		}
		if( query6 !=null && !"".equals(query6) && !"0".equals(query6)){
			sql += " and " + "dsbh like '%"+query6+"%' ";
		}	
		
		session.setAttribute("sql",sql);
		session.setAttribute("query1",query1);
		session.setAttribute("query2",query2);
		session.setAttribute("query3",query3);
		session.setAttribute("query4",query4);
		session.setAttribute("query5",query5);
		session.setAttribute("query6",query6);
		
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
		
		query4=(String)session.getAttribute("query4");		
		if(query4==null) query4="";	
		
		query5=(String)session.getAttribute("query5");		
		if(query5==null) query5="";
		
		query6=(String)session.getAttribute("query6");		
		if(query6==null) query6="";				
		
	}
	
%> 
        <div class="right" style="width:1002px;">
        	<div class="content_right_search" style="width:1002px;">        
        	<div class="content_search_result" style="width:1002px;">
                <div class="search_result_border"  style="width:1002px;">
                    <span>项目一览</span>
                </div>
                <div id="search">
					<form name="form1" method="post" action="front/lxxm/index.jsp">
						<input type="hidden" name="flag" value="form1"/>
						<div class="searchform_line">
							<span>
								立项年份: <input type="text" name="query1" value="<%=query1 %>" style="width:70px"/>
							</span>								
							<span>项目级别: 
								<select name="query2">
									<option value="0" <% if(query2!=null && "0".equals(query2)) out.print("selected");%>>全部</option>
									<option value="国家级" <% if(query2!=null && "国家级".equals(query2)) out.print("selected");%>>国家级</option>
									<option value="校级" <% if(query2!=null && "校级".equals(query2)) out.print("selected");%>>校级</option>
								</select>
							</span>
							<span>
								项目名称: <input type="text" name="query3" value="<%=query3 %>" style="width:70px"/>
							</span>
							<span>项目类型: 
								<select name="query4">
									<option value="0" <% if(query4!=null && "0".equals(query4)) out.print("selected");%>>全部</option>
									<option value="创新训练项目" <% if(query4!=null && "创新训练项目".equals(query4)) out.print("selected");%>>创新训练项目</option>
									<option value="创业训练项目" <% if(query4!=null && "创业训练项目".equals(query4)) out.print("selected");%>>创业训练项目</option>
									<option value="创业实践项目" <% if(query4!=null && "创业实践项目".equals(query4)) out.print("selected");%>>创业实践项目</option>
								</select>
							</span>
							<span>
								负&nbsp;&nbsp;责&nbsp;&nbsp;人: <input type="text" name="query5" value="<%=query5 %>" style="width:70px"/>
							</span>
							<span>
								指导教师:<input type="text" name="query6" value="<%=query6 %>" style="width:70px"/> 
								<input type="submit" class="submit" value=""/>
							</span>	
						</div>                              
					</form>
					
				</div>
			   
			<div id="search_result" style="width:1002px;">
				<div class="result_content">
					<div id="newsquery">
						<ul id="queryul">
							<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
								<thead class="pn-lthead">
								<tr>
									<th>项目编号</th>  	  
								    <th>项目名称</th>
								    <th>立项年份</th>
								    <th>项目级别</th>    
								    <th>项目类型</th>
								    <th>负责人</th>								    
								    <th>指导教师</th>
								    <th>一级学科</th>   
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
		
			notes = DataBase.listQuery(datasource,sql+" order by lxnf desc,right(xmbh,3)",pageNo,PAGE_SIZE);	
					
		}
		
		session.setAttribute("resp","?flag=form2&pageNo="+pageNo+"&pagesize="+PAGE_SIZE);		
		session.setAttribute("pagesize",PAGE_SIZE);		
		int i=0;
		for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
			Object[] note = it.next();				
			if(note[3]==null) note[3]="111111111111";
%>    

			<a href="front/lxxm/detail.jsp?id=<%=note[0].toString() %>" >
			
			<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
				<td class="style3" ><div align="center"><% if(note[3]!=null) out.print(note[3].toString());else out.print("&nbsp;"); %></div></td>  	  
			    <td class="style3" ><div align="left"><% if(note[4]!=null) out.print("&nbsp;"+note[4].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[1]!=null) out.print(note[1].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[2]!=null) out.print(note[2].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[5]!=null) out.print(note[5].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[6]!=null) out.print(note[6].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[9]!=null) out.print(note[9].toString());else out.print("&nbsp;"); %></div></td>
			    <td class="style3" ><div align="center"><% if(note[11]!=null) out.print(note[11].toString());else out.print("&nbsp;"); %></div></td>
     
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
							<input class="first-page" type="button" value="首 页" onclick="this.form.action='front/lxxm/index.jsp?pageNo=1';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
							<input class="pre-page" type="button" value="上一页" onclick="this.form.action='front/lxxm/index.jsp?pageNo=<%=pageNo-1 %>';this.form.submit();" <% if(pageNo<=1) out.print("disabled='disabled'"); %>/>
							<input class="next-page" type="button" value="下一页" onclick="this.form.action='front/lxxm/index.jsp?pageNo=<%=pageNo+1 %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>
							<input class="last-page" type="button" value="尾 页" onclick="this.form.action='front/lxxm/index.jsp?pageNo=<%=totalPages %>';this.form.submit();" <% if(pageNo>=totalPages) out.print("disabled='disabled'"); %>/>&nbsp;
							当前 <%=pageNo %>/<%=totalPages %> 页 &nbsp;转到第<input type="text" name="gopageno" id="_goPs" value="<%=pageNo %>" style="width:50px" onkeypress="if(event.keyCode==13){this.form.action='front/lxxm/index.jsp?pageNo='+this.value;this.form.submit();}"/>页
							<input class="go" name="_goPage" type="button" value="转" onclick="this.form.action='front/lxxm/index.jsp?pageNo='+this.form._goPs.value;this.form.submit();"/>
							
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
