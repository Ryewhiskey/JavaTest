package cn.lut.bear.listener;

import java.util.Date;
import java.text.SimpleDateFormat;


import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cn.lut.bear.admin.DataBase;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@WebListener
public class OnlineListener implements HttpSessionListener {
	public void sessionCreated(HttpSessionEvent se){
		HttpSession session = se.getSession();
		
		if( session.isNew() ){
			ServletContext application = session.getServletContext();
			String sessionid = session.getId();
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
			String logintime=sdf.format(date.getTime());			
								
			ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
			String prepsql="insert into onlineuser(sessionid,logintime) values(?,?)";		
			
			DataBase.prepare(datasource,prepsql,sessionid,logintime);
			
		}
	}
	
	public void sessionDestroyed (HttpSessionEvent se){
		HttpSession session = se.getSession();
		String sessionid = session.getId();
		//System.out.println("sessionid:"+sessionid);
		ServletContext application = session.getServletContext();
		ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
		String prepsql="delete from onlineuser where sessionid='"+sessionid+"'";		
		DataBase.prepare(datasource,prepsql);
	}

}
