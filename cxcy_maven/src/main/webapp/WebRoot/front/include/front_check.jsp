<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	if( session.isNew()){
%>
		<script type="text/javascript">			
			top.location.href("<%=path %>");			
		</script>
<%	
		return;	
	}
	
	if( (Map<String,String>)session.getAttribute("front_userinfo")==null || "null".equals((Map<String,String>)session.getAttribute("front_userinfo")) ){
%>
		<script type="text/javascript">			
			top.location.href("<%=path %>");			
		</script>
<%			
		return;
	}	
	if( ((Map<String,String>)session.getAttribute("front_userinfo")).get("yhm")==null || "".equals(((Map<String,String>)session.getAttribute("front_userinfo")).get("yhm"))){
%>
		<script type="text/javascript">
			top.location.href("<%=path %>");			
		</script>
<%		
		return;
	}	
%>