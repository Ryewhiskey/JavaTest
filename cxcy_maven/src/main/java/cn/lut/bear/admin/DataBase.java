package cn.lut.bear.admin;

import java.sql.*;
import java.util.*;
import java.io.*;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class DataBase {	
	
	//使用C3P0连接
	public static Connection getConn(ComboPooledDataSource datasource) {
		Connection conn = null;
		try {
			conn = datasource.getConnection();
		} catch (SQLException e) {
			System.out.println("DataBase.java--连接数据库出错！");
			e.printStackTrace();
		}
		return conn;
	}
	
	public static Connection getConn(String drv,String url) {
		Connection conn = null;
		try {
			Class.forName(drv);
			conn = DriverManager.getConnection(url);
		} catch (ClassNotFoundException ex) {
			System.out.println("连接数据库:" + url + "时出错:请检查JDBC驱动包是否正确？\r\n错误为："+ex);
			ex.printStackTrace();			
		} catch (SQLException ex) {			
			System.out.println("连接数据库:" + url + "时出错：请检查数据库服务是否开启？\r\n错误为："+ex);
			ex.printStackTrace();
		} catch (Exception ex){			
			System.out.println("连接数据库:" + url + "时出错：请仔细检查数据库配置！\r\n错误为："+ex);
			ex.printStackTrace();
		}
		
		return conn;
	}
	
	public static Connection getConn(String drv,String url,String user,String pwd) {
		Connection conn = null;
		try {
			Class.forName(drv);
			conn = DriverManager.getConnection(url,user,pwd);
		} catch (ClassNotFoundException ex) {
			System.out.println("连接数据库:" + url + "时出错:请检查JDBC驱动包是否正确？\r\n错误为："+ex);
			ex.printStackTrace();			
		} catch (SQLException ex) {			
			System.out.println("连接数据库:" + url + "时出错：请检查数据库服务是否开启？\r\n错误为："+ex);
			ex.printStackTrace();
		} catch (Exception ex){			
			System.out.println("连接数据库:" + url + "时出错：请仔细检查数据库配置！\r\n错误为："+ex);
			ex.printStackTrace();
		}
		
		return conn;
	}
	public static Connection  getConn(String filepath,String filename,String user,String pwd,String dbtype)
	{
		Connection conn = null;
		String drv = "",url = "";		
		
		if("access".equals(dbtype)){
			drv = "sun.jdbc.odbc.JdbcOdbcDriver";
			url="jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ="+filepath+filename;			
		}
		
		conn = getConn(drv,url,user,pwd); 	
		
		return conn;
	}
public static String[] ReadFile(String RealPath){ 
		
		File rf = new File(RealPath+"/WEB-INF/config/jdbc.properties");
		
		InputStreamReader read = null;
		BufferedReader reader = null;
		String line = new String();
		String sLine[]; 
		List<String> list = new ArrayList<String>();
		int i = 0; 
		try {
			read = new InputStreamReader(new FileInputStream(rf),"utf-8");			
		    reader = new BufferedReader(read);
		    while ( (line = reader.readLine()) != null) { 
		      line = line.substring(0, line.length());			      
		      list.add(line);
		      i++;
			} 			    
		} catch (UnsupportedEncodingException e) {			
			e.printStackTrace();
		} catch (FileNotFoundException e) {			
			e.printStackTrace();
		} catch (IOException e) {			
			e.printStackTrace();
		} finally{
			try {
				reader.close();
				read.close();
			} catch (IOException e) {
				e.printStackTrace();
			}		    
		}
		sLine = new String[i];
	    for(i=0;i<list.size();i++)
	    	sLine[i] = (String)list.get(i);
	    return sLine; 
	}

/*	
	public static Connection getConnWithTxt(String filepath,int start,int end,String dbtype)
	{
		Connection conn = null;
		String drv = "",url = "",user="",pwd="";
		String[] str = null;	
		
		str = ReadFile(filepath);		
		drv = str[0].substring(str[0].indexOf("=")+1,str[0].length());
		user = str[2].substring(str[2].indexOf("=")+1,str[2].length());
		pwd = str[3].substring(str[3].indexOf("=")+1,str[3].length());
		url = str[1].substring(str[1].indexOf("=")+1,str[1].length())+"&user="+ user +"&password=" + pwd;
		//drv="com.mysql.jdbc.Driver";
		//user="root";
		//pwd="root@123";
		//url="jdbc:mysql://202.201.32.12:3306/cjxyappsystem?characterEncoding=UTF-8"+"&user="+ user +"&password=" + pwd;
		try {
			Class.forName(drv).newInstance();
			conn = DriverManager.getConnection(url);
		} catch (ClassNotFoundException ex) {
			System.out.println("连接数据库:" + url + "时出错:请检查JDBC驱动包是否正确？\r\n错误为："+ex);
			ex.printStackTrace();			
		} catch (SQLException ex) {			
			System.out.println("连接数据库:" + url + "时出错：请检查数据库服务是否开启？\r\n错误为："+ex);
			ex.printStackTrace();
		} catch (Exception ex){			
			System.out.println("连接数据库:" + url + "时出错：请仔细检查数据库配置！\r\n错误为："+ex);
			ex.printStackTrace();
		}		
		return conn;
		
	}

	public static Connection  getConnWithTxt(String filepath, int start,int end,String dbtype)
	{
		Connection conn = null;
		String drv = "",url = "";
		String[] str = null;
		RWtxt rwtxt = null;
		
		rwtxt=new RWtxt();	
		str=rwtxt.ReadFile(filepath,start,end);
		
		if("oracle".equals(dbtype)){
			drv = "oracle.jdbc.driver.OracleDriver";
			url="jdbc:oracle:thin:@"+str[0]+":"+str[1]+":"+str[2];
			conn = getConn(drv,url,str[3],str[4]);
		}else if("sql2005".equals(dbtype)){
			drv = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
			url="jdbc:sqlserver://"+str[0]+":"+str[1]+";DatabaseName="+str[2];
			conn = getConn(drv,url,str[3],str[4]);
		}else if("sql2000".equals(dbtype)){
			drv = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
			url="jdbc.microsoft:sqlserver://"+str[0]+":"+str[1]+";DatabaseName="+str[2];
			conn = getConn(drv,url,str[3],str[4]);
		}else if("access".equals(dbtype)){
			drv = "sun.jdbc.odbc.JdbcOdbcDriver";
			url="jdbc.microsoft:sqlserver://"+str[0]+":"+str[1]+";DatabaseName="+str[2];
			conn = getConn(drv,url,str[3],str[4]);
		}else if("mysql".equals(dbtype)){
			drv = "com.mysql.jdbc.Driver";
			url="jdbc:mysql://"+str[0]+":"+str[1]+"/"+ str[2] +"?characterEncoding=UTF-8"+"&user="+ str[3] +"&password=" + str[4];			
			conn = getConn(drv,url);
		} else {
			return null;
		}
		return conn;
	}
*/	
	
	public static Statement getStatement(Connection conn) {
		Statement stmt = null; 
		try {
			if(conn != null) {
				stmt = conn.createStatement();
			}
		} catch (SQLException ex) {			
			System.out.println("创建 Statement 对象时出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}
		return stmt;
	}	
		
	public static ResultSet getResultSet(Statement stmt, String sql) {
		ResultSet rs = null;
		try {
			if(stmt != null) {
				rs = stmt.executeQuery(sql);
			}
		} catch (SQLException ex) {			
			System.out.println("执行查询语句：" + sql + "时出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}
		return rs;
	}
	
	public static ResultSet getResultSet(ComboPooledDataSource datasource, String sql) {		
		Statement stmt = null; 
		ResultSet rs = null;
		Connection conn = getConn(datasource);
		stmt = getStatement(conn);
		try {
			if(stmt != null) {
				rs = stmt.executeQuery(sql);
			}
		} catch (SQLException ex) {			
			System.out.println("执行查询语句：" + sql + "时出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}		
		close(stmt);
		close(conn);
		return rs;
	}
	public static boolean prepare(ComboPooledDataSource datasource, String sql, Object... args) {
		Connection conn = getConn(datasource);
		PreparedStatement pstmt = null; 
		if(conn !=null){
			try {
				pstmt = conn.prepareStatement(sql);
				for(int i=0;i<args.length;i++){
					pstmt.setObject(i+1, args[i]);
				}
				if(pstmt.executeUpdate() != 1) { close(conn); return false;}
				close(conn);
				return true;
			} catch (SQLException ex) {
				System.out.println("语句：" + sql + "时出错；\r\n错误为："+ex);
				ex.printStackTrace();
			}
		}else{
			return false;
		}			
		close(conn);
		return false;
	}
	
	public static PreparedStatement prepare(Connection conn,  String sql, int autoGenereatedKeys) {
		PreparedStatement pstmt = null; 
		try {
			if(conn != null) {
				pstmt = conn.prepareStatement(sql, autoGenereatedKeys);
			}
		} catch (SQLException ex) {			
			System.out.println("语句：" + sql + "出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}
		return pstmt;
	}	
	
	public static int executeUpdate(ComboPooledDataSource datasource,String sql) {
		Connection conn = getConn(datasource);
		Statement stmt = null;
		int i = 0;
		try {
			stmt=getStatement(conn);
			if(stmt != null) {
				i = stmt.executeUpdate(sql);
			}
		} catch (SQLException ex) {			
			System.out.println("语句：" + sql + "出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}
		close(stmt);
		close(conn);
		return i;
	}
	
	public static int recordCount(ComboPooledDataSource datasource, String sql)
	{
		Connection conn = getConn(datasource);
		Statement stmt = null;
		ResultSet rs = null;
		int i=0;
		sql = "select count(*) "+sql.substring(sql.indexOf("from"));			
		try {
			if (!sql.equals("")) {			
				stmt=getStatement(conn);
	     		rs=getResultSet(stmt, sql);				
				if(rs != null && rs.next()) { 
					i = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			i=0;
			System.out.println("语句：" + sql + "出错；\r\n错误为："+e);
			e.printStackTrace();
		}	
		close(rs);
		close(stmt);
		close(conn);
		return i;
	}
	
	public static List<Object[]> listQuery(ComboPooledDataSource datasource, String sql)
	{
		Connection conn = getConn(datasource);
		Statement stmt = null;
		ResultSet rs = null;
		List<Object[]> notes = new ArrayList<Object[]>();	
		try {
			if (!sql.equals("")) {			
				stmt=getStatement(conn);
	     		rs=getResultSet(stmt, sql);				
				int columnCount = rs.getMetaData().getColumnCount();
				while (rs != null && rs.next()) { 
					Object[] note = new Object[columnCount];
					for (int i=0;i<columnCount;i++)
						note[i] = rs.getObject(i + 1);
					notes.add(note);
				}
			}
		} catch (Exception e) {
			System.out.println("------ 在检索记录时抛出异常，内容如下：");
			e.printStackTrace();
		}	
		close(rs);
		close(stmt);
		close(conn);
		return notes;
	}
	
	public static List<Object[]> listQuery(ComboPooledDataSource datasource, String sql,int pageNo,int pageSize)
	{
		Connection conn = getConn(datasource);
		Statement stmt = null;
		ResultSet rs = null;
		List<Object[]> notes = new ArrayList<Object[]>();	
		try {
			if (!sql.equals("")) {			
				stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY); 
				rs = stmt.executeQuery(sql);	
	     		rs.absolute((pageNo-1)*pageSize+1);
	     		
	     		int columnCount = rs.getMetaData().getColumnCount();
				int j = 1;
				while (rs != null &&  j<=pageSize) {											
					Object[] note = new Object[columnCount];
					for (int i=0;i<columnCount;i++)
						note[i] = rs.getObject(i + 1);
					notes.add(note);
					j++;
					if(!rs.next()) break;					
				}
			}
		} catch (Exception e) {
			System.out.println("listQuery------在检索记录时抛出异常，内容如下：");			
			e.printStackTrace();
		}
		close(rs);
		close(stmt);
		close(conn);
		return notes;
	}
	
	public static void close(Connection conn) {
		try {
			if(conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException ex) {			
			System.out.println("关闭连接Connection对象：" + conn + "时出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}
	}
	
	public static void close(Statement stmt) {
		try {
			if(stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch (SQLException ex) {			
			System.out.println("关闭Statement对象：" + stmt + "时出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}
	}
	
	public static void close(ResultSet rs) {
		try {
			if(rs != null) {
				rs.close();	
				rs = null;
			}
		} catch (SQLException ex) {			
			System.out.println("关闭结果集ResultSet对象：" + rs + "时出错；\r\n错误为："+ex);
			ex.printStackTrace();
		}
	} 
	//删除单个文件
	public static boolean deleteFile(String fileName){     
        File file = new File(fileName);     
        if(file.isFile() && file.exists()){     
            file.delete();                
            return true;     
        }else{     
            System.out.println("删除单个文件"+fileName+"失败！");     
            return false;     
        }     
    }     
/* 
	public static void main(String args[]){
		Connection conn=null;	
		Statement stmt = null;
		ResultSet rs = null;	
		
		String drv = "",url = "",user="",pwd="";
		
		
		drv = "com.mysql.jdbc.Driver";
		user = "root";
		pwd = "root@123";
		url = "jdbc:mysql://202.201.32.12:3306/cjxyappsystem?characterEncoding=UTF-8"+"&user="+ user +"&password=" + pwd;
				
		try {
			Class.forName(drv).newInstance();
			conn = DriverManager.getConnection(url);
		} catch (ClassNotFoundException ex) {
			System.out.println("连接数据库:" + url + "时出错:请检查JDBC驱动包是否正确？\r\n错误为："+ex);
			ex.printStackTrace();			
		} catch (SQLException ex) {			
			System.out.println("连接数据库:" + url + "时出错：请检查数据库服务是否开启？\r\n错误为："+ex);
			ex.printStackTrace();
		} catch (Exception ex){			
			System.out.println("连接数据库:" + url + "时出错：请仔细检查数据库配置！\r\n错误为："+ex);
			ex.printStackTrace();
		}
		stmt = DataBase.getStatement(conn);
		DataBase.executeUpdate(stmt, "INSERT INTO xyxxb1 VALUES ('20130419173005000129','2013','02','0217002','身份证','李宏宇','男','1972-08-22 00:00:00','大专','工程师','建筑工程专业',NULL,'甘肃兴华建设工程集团有限公司',NULL,'兰州市七里河区西津东路37号','13309449299','358381542@qq.com','730000','0217002','2009-02-24 00:00:00','162090901045','2009-08-12 00:00:00','甘肃','000000',NULL,'否','注册','未审核','不住宿')"); 
		System.out.print("sadff");
	}
*/
}
	