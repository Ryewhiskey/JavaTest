package cn.lut.bear.control;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import cn.lut.bear.admin.DataBase;
@SuppressWarnings("serial")
@WebServlet(name="Editor_cg",urlPatterns="/servlet/Editor/cg")
public class Editor_cg extends HttpServlet {
 
	/**
	 * 
	 */
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("here get");
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ServletContext application = this.getServletContext();
		ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
		
		req.setCharacterEncoding("utf-8");
		
		String id=req.getParameter("id");
		if(id!=null) id=id.trim();
		else id = "";		
		
		String xmid=req.getParameter("xmid");
		if(xmid!=null) xmid=xmid.trim();
		else xmid = "";
						
		String content=req.getParameter("content");
		if(content!=null) content=content.trim();
		else content="";
								
		String issuccess=req.getParameter("issuccess");
		if(issuccess!=null) issuccess=issuccess.trim();
		else issuccess="";			
		
		String prepsql="insert into cgzsb(id,xmid,content,issuccess) values(?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,id,xmid,content,issuccess);					
		
		req.setAttribute("result", result);
		
		req.getRequestDispatcher("/backsys/cg/cggl/add.jsp").forward(req, resp);
	}
}
