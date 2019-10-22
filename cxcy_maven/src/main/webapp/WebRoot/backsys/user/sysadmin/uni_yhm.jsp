<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
 
<%	
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	
	request.setCharacterEncoding("gbk");	
	
	String yhm="";	
	
	yhm = request.getParameter("yhm");
	if(yhm==null) yhm="";
	
	//System.out.println("yhm="+yhm);	
	if( !"".equals(yhm.trim()) && !"".equals(yhm.trim()) ){
		String sql = "select yhm from admin where yhm = '" + yhm + "'";
		//System.out.println("yhm="+sql);
		List<Object[]> notes = new ArrayList<Object[]>();
		notes = DataBase.listQuery(datasource,sql);
		Iterator<Object[]> it = notes.iterator();
		if(it.hasNext()) {
			//Object[] note = it.next();
			out.print("该用户名已经被使用");
		}else{
			out.print("");
		}
	}

%>
