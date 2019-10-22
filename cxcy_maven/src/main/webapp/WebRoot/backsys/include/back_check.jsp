<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	if( session.isNew()){
%>
		<script type="text/javascript">			
			top.location.href("<%=basePath %>backsys/login.jsp");			
		</script>
<%	
		return;	
	}
	
	if( (Map<String,String>)session.getAttribute("userinfo")==null || "null".equals((Map<String,String>)session.getAttribute("userinfo")) ){
%>
		<script type="text/javascript">			
			top.location.href("<%=basePath %>backsys/login.jsp");			
		</script>
<%			
		return;
	}	
	if( ((Map<String,String>)session.getAttribute("userinfo")).get("yhm")==null || "".equals(((Map<String,String>)session.getAttribute("userinfo")).get("yhm"))){
%>
		<script type="text/javascript">
			top.location.href("<%=basePath %>backsys/login.jsp");			
		</script>
<%		
		return;
	}	
%>