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
@WebServlet(name="front_user_login",urlPatterns="/front_user_login")
public class front_user_login extends HttpServlet {

	/**
	 * 
	 */
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("front_user_login get");
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ServletContext application = this.getServletContext();
		ComboPooledDataSource datasource = (ComboPooledDataSource)application.getAttribute("datasource");	
		HttpSession session = req.getSession();

		req.setCharacterEncoding("utf-8");
		
		String username=req.getParameter("username");
		if(username!=null) username=username.trim();
		else username = "";		
		
		String password=req.getParameter("password");
		if(password!=null) password=password.trim();
		else password = "";		
		
		List<Object[]> notes = DataBase.listQuery(datasource,"select yhbh,yhm,realname,bmbh,mm,yhz,islock from v_member where yhm='"+username+"' and mm='"+password+"'");
		Iterator<Object[]> it=notes.iterator();
		if(it.hasNext()) {
			Object[] note = it.next();
			if("2".equals(note[6].toString())){
				req.setAttribute("result", "0");//用户禁用
			}else{
				req.setAttribute("result", "1");//用户可以登录
				Map<String,String> front_userinfo = new HashMap<String,String>();
				front_userinfo.put("yhbh", note[0].toString());
				front_userinfo.put("yhm", note[1].toString());
				front_userinfo.put("realname", note[2].toString());
				front_userinfo.put("bmbh", note[3].toString());
				front_userinfo.put("yhz", note[5].toString());				
				
				session.setAttribute("front_userinfo", front_userinfo);
			}
		}else{
			req.setAttribute("result", "2");//用户或密码错误
		}	
		
		req.getRequestDispatcher("/front/home/index.jsp").forward(req, resp);
	}
}
