<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="left">
        	<div id="subannoucement" title="通知公告" >
      			 
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
				
				List<Object[]> notes = DataBase.listQuery(datasource,"select id,title,fbrq from ggb where issuccess='2' order by fbrq desc limit 0,8");
				for (Iterator<Object[]> it=notes.iterator();it.hasNext();) {	
					Object[] note = it.next();	
%>
                            <li>
                                <a target="_self" href="front/tzgg/second.jsp?id=<%=note[0].toString() %>">
                                <%if(note[1].toString().length()>15) out.print(note[1].toString().substring(0, 15)+"..."); else out.print(note[1].toString()); %>
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
            <div id="subfriendlink" title="友情链接" >
      			 
           		<div class="border_l">
					<div class="border_r">
						<div class="border_top">
							<span>下载专区</span>	
								<div class="border_top_r">
                                	<a href="front/download/index.jsp">
                                    	<img  class="more" src="front/res/images/more.png">
                                    </a>
                                </div>
						</div>
                        
						<div class="list_content">
                       		<ul class="newslist">
<%				
								notes = DataBase.listQuery(datasource,"select id,name,fbrq,filename from zlxzb where issuccess='2' order by fbrq desc limit 0,8");
								for (Iterator<Object[]> it = notes.iterator(); it.hasNext();) {
									Object[] note = it.next();	
%>
                            <li><a target="_self" href="UploadDir/download/<%=note[3].toString()%>"> 
<%
 		if (note[1].toString().length() > 16)
 			out.print(note[1].toString().substring(0, 16) + "...");
 		else
 			out.print(note[1].toString());
 %> 
 								</a> <span><%=note[2].toString()%></span></li>
                            
<%} %>                                                           
                            </ul>
                        </div>
                       
					</div>          
                	
				</div>
                <div class="border_bottom"> </div>
				<div class="border_bottom_r_corner"> </div>
       		</div>
        </div>