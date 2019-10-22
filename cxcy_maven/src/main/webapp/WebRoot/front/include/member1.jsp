<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="userlogin" class="pdv pdv_class" title="会员登录" >
      			 
           		<div class="pdv_border_l">
					<div class="pdv_border_r">
						<div class="pdv_top">
							<span>会员登录</span>	
								<div class="pdv_top_r"></div>
						</div>
						<div class="pdv_content">
							<div id="loginform_notLogin" class="loginform">
                            	<form id="loginform_Form" action="" method="post">
                                	<div class="noticediv" id="loginnotice"></div>
                                    <div class="col">登录账号：</div>
                                    <div class="con">
										<input id="muser" class="input" type="text" 
                                        style="width:110px" maxlength="20" name="muser">
                                    </div>
                                    <div class="col">登录密码：</div>
                                    <div class="con">
                                    	<input id="mpass" class="input" type="password" 
                                        maxlength="20" style="width:110px" name="mpass">
                                    </div>
                                    
                                     <div style="clear:both;">
                                     	<div id="login_form_reset">
                                    
											<a href="#" >重设密码</a>
										</div>
                                     </div>
                                     
                                     <div id="login_form_imageField">
                                     	<input type="image" src="res/images/dl2.gif" name="imageField">
                                        	<a href="member/reg.php">
                                            	<img width="46" height="22" border="0" 
                                                	src="res/images/zhuce.gif">
                                            </a>
                                        <input id="act" type="hidden" value="memberlogin" name="act">
									</div>
                                              
                           		</form>
                            </div>
						</div>
                        <div style="clear:both;"></div>
					</div>          
                	
				</div>
               
                <div class="pdv_border_bottom"> </div>
				<div class="pdv_border_bottom_r_corner"> </div>
               
       		</div>