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
@WebServlet(name="Editor_gljg",urlPatterns="/servlet/Editor/gljg")
public class Editor_gljg extends HttpServlet {

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
		
		String jgmc=req.getParameter("jgmc");
		if(jgmc!=null) jgmc=jgmc.trim();
		else jgmc = "";
						
		String lxr=req.getParameter("lxr");
		if(lxr!=null) lxr=lxr.trim();
		else lxr = "";
				
		String phone=req.getParameter("phone");
		if(phone!=null) phone=phone.trim();
		else phone = "";
		
		String ord=req.getParameter("ord");
		if(ord!=null) ord=ord.trim();
		else ord = "";
		
		String content=req.getParameter("content");
		if(content!=null) content=content.trim();
		else content="";
		
		String prepsql="insert into gljgb(id,jgmc,lxr,phone,ord,content) values(?,?,?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,id,jgmc,lxr,phone,Integer.parseInt(ord),content);					
		
		req.setAttribute("result", result);
		
		req.getRequestDispatcher("/backsys/contents/lwgljg/add.jsp").forward(req, resp);
	}
}
