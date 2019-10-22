package cn.lut.bear.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import cn.lut.bear.admin.DataBase;
@SuppressWarnings("serial")
@WebServlet(name="front_exit_login",urlPatterns="/front_exit_login")
public class front_exit_login extends HttpServlet {

	/**
	 * 
	 */
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		//System.out.println("front_exit_login get");
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
							
		HttpSession session = req.getSession();

		req.setCharacterEncoding("utf-8");
		
		Map<String,String> front_userinfo = null;
				
		session.setAttribute("front_userinfo", front_userinfo);		
		
		req.getRequestDispatcher("/front/home/index.jsp").forward(req, resp);
		
		//System.out.println("front_exit_login post");
	}
}
