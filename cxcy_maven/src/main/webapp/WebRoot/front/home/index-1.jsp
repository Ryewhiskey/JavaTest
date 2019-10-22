<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.mchange.v2.c3p0.ComboPooledDataSource,java.sql.*,cn.lut.bear.admin.*,java.io.*,java.text.*,java.util.*,java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		
%>
<%
	ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
	//Map<String,String> sysconfig = (Map)application.getAttribute("sysconfig");
	//Map<String,String> userinfo = (Map)session.getAttribute("userinfo");
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<title>西和县劳务信息管理平台</title>
<meta content="" name="keywords" />
<meta content="" name="description" />

<link rel="stylesheet" type="text/css" href="front/res/css/default.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/dropmenu.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/front_login.css"/>
<link rel="stylesheet" type="text/css" href="front/res/css/slider.css"/>

<script type="text/javascript" src="front/res/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="front/res/js/login.js"></script>
<script type="text/javascript" src="front/res/js/dropmenu.js"></script>
<script type="text/javascript" src="front/res/js/jssor.slider.mini.js"></script>
<script type="text/javascript" src="front/res/js/slider.js"></script>

</head>

<body>
<%@include file="/front/include/header.jsp" %>
	
    <div id="content">
   		<div class="content_line">    		
			<div class="image_border" id="slider1_container">            
		        <div u="slides" id="slide1">
<%
				int i=0;
				List<Object[]> notes = DataBase.listQuery(datasource,"select id,title,fbrq,filename from news where issuccess='2' and newtype='3' and rownum <= 5 order by fbrq desc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
					Object[] note = it.next();	
%>
		        	<div><img u="image" src="UploadDir/news/<%=(note[3].toString()) %>" /></div>
<%} %>		            
		        </div>
		        <!-- bullet navigator container -->
		        <div u="navigator" class="jssorb03" >
		            <!-- bullet navigator item prototype -->
		            <div u="prototype" id="slider1_prototype" ><div u="numbertemplate"></div></div>
		        </div>
        
		        <!-- Bullet Navigator Skin End -->
				<!-- Arrow Left -->
		        <span u="arrowleft" class="jssora12l" style="width: 30px; height: 46px; top: 123px; left: 0px;">
		        </span>
		        <!-- Arrow Right -->
		        <span u="arrowright" class="jssora12r" style="width: 30px; height: 46px; top: 123px; right: 0px">
		        </span>
        		<!-- Arrow Navigator Skin End -->
        
    		</div> 
    		<!-- Jssor Slider End -->            
   			<div id="news" title="新闻资讯" >      			 
           		<div class="border_l">
					<div class="border_r">
						<div class="border_top">
							<span>新闻资讯</span>	
							<div class="border_top_r">

                               	<a href="front/news/index.jsp"><img  class="more" src="front/res/images/more.png"></a>

                            </div>
						</div>
                        
						<div class="list_content">
                       		<ul class="newslist">
<%
				i=0;
				notes = DataBase.listQuery(datasource,"select id,title,fbrq,filename from news where issuccess='2' and rownum <= 7 order by fbrq desc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
					Object[] note = it.next();	
%>
                            <li>
                                <a target="_self" href="front/news/second.jsp?id=<%=note[0].toString() %>">
                                <%if(note[1].toString().length()>16) out.print(note[1].toString().substring(0, 16)+"..."); else out.print(note[1].toString()); %>
                                </a>
                                <span ><%=note[2].toString() %></span>
                            </li>
                            
<%} %>                                                           
                            
                            </ul>
                        </div>
                       
					</div>          
                	
				</div>
                <div class="border_bottom"> </div>
				<div class="border_bottom_r_corner"> </div>
       		</div>
        	
    	</div>
        
        
    	
        <div class="content_line">
            <div id="announcement" title="通知公告" >
                     
                    <div class="border_l">
                        <div class="border_r">
                            <div class="border_top">
                                <span>通知公告</span>	
                                    <div class="border_top_r">
                                    
                                        <a href="front/tzgg/index.jsp"><img  class="more" src="front/res/images/more.png"></a>
                                    
                                    </div>
                            </div>
                            
                            <div class="list_content">
                                <ul class="newslist">
<%
				i=0;
				notes = DataBase.listQuery(datasource,"select id,title,fbrq from ggb where issuccess='2' and rownum <= 8  order by fbrq desc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
					Object[] note = it.next();	
%>
                            <li>
                                <a target="_self" href="front/tzgg/second.jsp?id=<%=note[0].toString() %>">
                                <%if(note[1].toString().length()>16) out.print(note[1].toString().substring(0, 16)+"..."); else out.print(note[1].toString()); %>
                                </a>
                                <span ><%=note[2].toString() %></span>
                            </li>
                            
<%} %>
                                                                
                                </ul>
                            </div>
                           
                        </div>          
                        
                    </div>
                    <div class="border_bottom"> </div>
                    <div class="border_bottom_r_corner"> </div>
                </div> 
            <div id="policy" title="政策法规" >
                     
                    <div class="border_l">
                        <div class="border_r">
                            <div class="border_top">
                                <span>政策法规</span>	
                                    <div class="border_top_r">
                                    
                                        <a href="front/zcfg/index.jsp"><img  class="more" src="front/res/images/more.png"></a>
                                    
                                    </div>
                            </div>
                            
                            <div class="list_content">
                                <ul class="newslist">
<%
				i=0;
				notes = DataBase.listQuery(datasource,"select id,title,fbrq from gzzdb where issuccess='2' and rownum <= 8 order by fbrq desc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();i++) {	
					Object[] note = it.next();	
%>
                            <li>
                                <a target="_self" href="front/zcfg/second.jsp?id=<%=note[0].toString() %>">
                                <%if(note[1].toString().length()>16) out.print(note[1].toString().substring(0, 16)+"..."); else out.print(note[1].toString()); %>
                                </a>
                                <span ><%=note[2].toString() %></span>
                            </li>
                            
<%} %>
                                                               
                                </ul>
                            </div>
                           
                        </div>          
                        
                    </div>
                    <div class="border_bottom"> </div>
                    <div class="border_bottom_r_corner"> </div>
                </div>
            <div id="download" title="西和县劳务管理机构" >
                     
                    <div class="border_l">
                        <div class="border_r">
                            <div class="border_top">
                                <span>劳务管理机构</span>	
                                    <div class="border_top_r">
                                    
                                        <a href="front/download/index.jsp"><img  class="more" src="front/res/images/more.png"></a>
                                    
                                    </div>
                            </div>
                            
                            <div class="list_content">
                                <ul class="newslist">
<%
				
				notes = DataBase.listQuery(datasource,"select id,name,fbrq from zlxzb where issuccess='2' and rownum <= 8 order by fbrq desc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
                            <li>
                                <a target="_self" href="front/news/second.jsp?id=<%=note[0].toString() %>">
                                <%if(note[1].toString().length()>16) out.print(note[1].toString().substring(0, 16)+"..."); else out.print(note[1].toString()); %>
                                </a>
                                <span ><%=note[2].toString() %></span>
                            </li>
                            
<%} %>
                                                                 
                                </ul>
                            </div>
                           
                        </div>          
                        
                    </div>
                    <div class="border_bottom"> </div>
                    <div class="border_bottom_r_corner"> </div>
                </div>
               
        </div>
        <div class="content_line">
        	<!-- Jssor Slider Begin -->
    <!-- You can move inline styles to css file or css block. -->
    <div id="slider2_container" style="position: relative; top: 0px; left: 0px; width: 809px; height: 150px; overflow: hidden;">

        <!-- Loading Screen -->
        <div u="loading" class="loading">
            <div class="image_filter"/></div>
            <div class="loading_image"></div>
        </div>

        <!-- Slides Container -->
        <div u="slides" id = "slide2">
            
<%
				
				notes = DataBase.listQuery(datasource,"select id,title,fbrq,filename from news where issuccess='2' and newtype='2' and rownum <= 5 order by fbrq desc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
		        	<div><img u="image" src="UploadDir/news/<%=(note[3].toString()) %>" /></div>
<%} %>
        </div>
       <!-- Arrow Left -->
        <span u="arrowleft" class="jssora03l" style="width: 55px; height: 55px; top: 123px; left: 8px;">
        </span>
        <!-- Arrow Right -->
        <span u="arrowright" class="jssora03r" style="width: 55px; height: 55px; top: 123px; right: 8px">
        </span>
    </div>
    <!-- Jssor Slider End -->
              
        
        <div class="content_line">
            <div id="friendlink" title="友情链接" >
                     
                    <div class="border_l">
                        <div class="border_r">
                            <div class="border_top">
                                <span>友情链接</span>	
                                    <div class="border_top_r">
                                    
                                        <a href="javascript:void(0);"><img  class="more" src="front/res/images/more.png"></a>
                                    
                                    </div>
                            </div>
                            
                            <div class="list_content">
                                <ul class="newslist">
<%				
				notes = DataBase.listQuery(datasource,"select id,name,addr from friendlink where rownum <= 8");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
                            <li>
                                <a target="_self" href="<%=note[2].toString() %>">
                                <%if(note[1].toString().length()>16) out.print(note[1].toString().substring(0, 16)+"..."); else out.print(note[1].toString()); %>
                                </a>
                                
                            </li>
                            
<%} %>                                                                   
                                </ul>
                            </div>
                           
                        </div>          
                        
                    </div>
                    <div class="border_bottom"> </div>
                    <div class="border_bottom_r_corner"> </div>
                </div> 
            <div id="agency" title="中介机构" >
                     
                    <div class="border_l">
                        <div class="border_r">
                            <div class="border_top">
                                <span>企业招聘</span>	
                                    <div class="border_top_r <%if((Map<String,String>)session.getAttribute("front_userinfo")==null) out.print("front_login"); %>" >
                                    
                                        <a href="front/qyzp/index.jsp"><img  class="more" src="front/res/images/more.png"></a>
                                    
                                    </div>
                            </div>
                            
                            <div class="list_content">
                                <ul class="newslist">
<%
				
				notes = DataBase.listQuery(datasource,"select id,zjmc,gz,fbrq from v_zj_zp where zpxxb_islock='1' and rownum <= 8 order by fbrq desc");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
                            <li <%if((Map<String,String>)session.getAttribute("front_userinfo")==null) out.print("class='front_login'"); %>>
                                <a target="_self" href="front/qyzp/detail.jsp?id=<%=note[0].toString() %>">
                                <%	String str=note[1].toString()+"招聘"+note[2].toString();
                                	if(str.length()>16) out.print(str.substring(0, 16)+"..."); else out.print(str); %>
                                </a>
                                <span ><%=note[3].toString() %></span>
                            </li>
                            
<%} %>                                                           
                                </ul>
                            </div>
                           
                        </div>          
                        
                    </div>
                    <div class="border_bottom"> </div>
                    <div class="border_bottom_r_corner"> </div>
                </div>
            <div id="labor" title="培训信息" >
                     
                    <div class="border_l">
                        <div class="border_r">
                            <div class="border_top">
                                <span>培训信息</span>	
                                    <div class="border_top_r">
                                        <a href="front/rlzy/index.jsp"><img  class="more" src="front/res/images/more.png"></a>
                                    </div>
                            </div>
                            
                            <div class="list_content">
                                <ul class="newslist">
<%
				
				notes = DataBase.listQuery(datasource,"select wgryid,name,zc from wgryb where islock='1' and rownum <= 8");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
                            <li>
                                <a target="_self" href="front/rlzy/detail.jsp?id=<%=note[0].toString() %>">
                                <%	String str = note[1].toString()+ "  专长  " + note[2].toString();
                                	if(str.length()>16) out.print(str.substring(0, 16)+"..."); else out.print(str); %>
                                </a>
                                
                            </li>
                            
<%} %>                                                                  
                                </ul>
                            </div>
                           
                        </div>          
                        
                    </div>
                    <div class="border_bottom"> </div>
                    <div class="border_bottom_r_corner"> </div>
                </div>
               
        </div>
    </div>
    <%@include file="/front/include/bottom.html" %>
  
    
</body>
</html>
