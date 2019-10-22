<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
 
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	
	request.setCharacterEncoding("gbk");	
	
	String id="";	
	
	id = request.getParameter("xmbh");
	if(id==null) id="";
	
	//System.out.println("id="+id);	
	if( !"".equals(id.trim()) ){
		String sql = "select xmbh from xmhzb where xmbh = '" + id + "'";
		
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {
			//Object[] note = it.next();
			out.print("该项目编号已经被使用");
		}else{
			out.print("");
		}
	}

%>
