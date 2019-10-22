package cn.lut.bear.servlet;


import java.beans.PropertyVetoException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import cn.lut.bear.admin.DataBase;

import com.mchange.v2.c3p0.ComboPooledDataSource;


@SuppressWarnings("serial")
@WebServlet(name="startupServlet",urlPatterns="/startupServlet",loadOnStartup=1)
public class StartupServlet extends HttpServlet {
		
	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	
	public void init() throws ServletException {
		super.init();
		//运行环境
		System.gc();
		Properties props = System.getProperties();
		ServletContext application = getServletContext();	
		Map<String,String> sysconfig = new HashMap<String,String>();
				
		//连接数据库		
		ComboPooledDataSource datasource = new ComboPooledDataSource();		
		ServletContext context = getServletContext();
	
		try {
			datasource.setDriverClass(context.getInitParameter("jdbc.driverClassName"));
		} catch (PropertyVetoException e) {			
			System.out.println("数据库连接出错！");
			e.printStackTrace();
		} 
		datasource.setJdbcUrl(context.getInitParameter("jdbc.url"));
		datasource.setUser(context.getInitParameter("jdbc.username"));
		datasource.setPassword(context.getInitParameter("jdbc.password"));
		datasource.setMaxPoolSize(Integer.parseInt(context.getInitParameter("cpool.maxPoolSize")));
		datasource.setMinPoolSize(Integer.parseInt(context.getInitParameter("cpool.minPoolSize")));
		datasource.setInitialPoolSize(Integer.parseInt(context.getInitParameter("cpool.initialPoolSize")));
		datasource.setCheckoutTimeout(Integer.parseInt(context.getInitParameter("cpool.checkoutTimeout")));
		datasource.setMaxIdleTime(Integer.parseInt(context.getInitParameter("cpool.maxIdleTime")));
		datasource.setMaxIdleTimeExcessConnections(Integer.parseInt(context.getInitParameter("cpool.maxIdleTimeExcessConnections")));
		datasource.setAcquireIncrement(Integer.parseInt(context.getInitParameter("cpool.acquireIncrement")));
		
		
		String type = context.getInitParameter("jdbc.type");
		String pagesize = context.getInitParameter("page.size");
		sysconfig.put("type", type);
		sysconfig.put("pagesize", pagesize);
		sysconfig.put("maxusercount", "100");
		
		application.setAttribute("props", props);
		application.setAttribute("sysconfig", sysconfig);
		application.setAttribute("datasource", datasource);		
		
		DataBase.executeUpdate(datasource, "delete from onlineuser");
	}

}
