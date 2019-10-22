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
@WebServlet(name="Editor_pxxx",urlPatterns="/servlet/Editor/pxxx")
public class Editor_pxxx extends HttpServlet {

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
		
		String pxmc=req.getParameter("pxmc");
		if(pxmc!=null) pxmc=pxmc.trim();
		else pxmc = "";
						
		String lxr=req.getParameter("lxr");
		if(lxr!=null) lxr=lxr.trim();
		else lxr = "";
				
		String phone=req.getParameter("phone");
		if(phone!=null) phone=phone.trim();
		else phone = "";
		
		String fbrq=req.getParameter("fbrq");
		if(fbrq!=null) fbrq=fbrq.trim();
		else fbrq = "";
		
		String qsrq=req.getParameter("qsrq");
		if(qsrq!=null) qsrq=qsrq.trim();
		else qsrq = "";
		
		String jsrq=req.getParameter("jsrq");
		if(jsrq!=null) jsrq=jsrq.trim();
		else jsrq = "";
		
		String content=req.getParameter("content");
		if(content!=null) content=content.trim();
		else content="";
		
		String prepsql="insert into pxxxb(id,pxmc,lxr,phone,fbrq,qsrq,jsrq,content) values(?,?,?,?,?,?,?,?)";		
		boolean result = DataBase.prepare(datasource,prepsql,id,pxmc,lxr,phone,fbrq,qsrq,jsrq,content);					
		
		req.setAttribute("result", result);
		
		req.getRequestDispatcher("/backsys/contents/pxxx/add.jsp").forward(req, resp);
	}
}
