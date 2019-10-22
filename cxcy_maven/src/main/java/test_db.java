
import java.sql.*;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class test_db
{
	public static void main(String arg[])
	{
		String drv="",url="",user="",pwd="";
		Connection conn=null;
		ResultSet rs=null;
    		Statement stmt=null;
  		drv="oracle.jdbc.driver.OracleDriver";
  		url="jdbc:oracle:thin:@172.18.229.116:1521:orcl";
		user="xhlwpt_user";
		pwd="xhlwpt%user";
  		
  		/*Oracle 数据库的连接方法*/
		try
		{			
			Class.forName(drv);
			conn=DriverManager.getConnection(url,user,pwd);
	 	}
		catch(ClassNotFoundException ec)
		{
			System.out.println("直接连接数据库时出错；\r\n错误为："+ec);
		}
		catch(SQLException es)
		{
			System.out.println("直接连接数据库时出错；\r\n错误为："+es);
		}
		catch(Exception ex)
		{
			System.out.println("直接连接数据库时出错；\r\n错误为："+ex);
		}
		
		 
		/*数据选择*/
		try {
			stmt = conn.createStatement();
			rs=stmt.executeQuery("select * from  SYSTEM.HELP");
		} catch (SQLException e) {			
			e.printStackTrace();
		}
  		int i;
		try{
		for(i=1;i<=rs.getMetaData().getColumnCount();i++)
  		{  
    			System.out.print("\t" + rs.getMetaData().getColumnName(i));
  		}
		System.out.println();

  		if(rs!=null)
  		{
			
   			while(rs.next())
    			{
   				System.out.print("\t"+rs.getString(1));
				System.out.print("\t"+rs.getDouble(2));
				System.out.print("\t"+rs.getString(3));
				System.out.print("\n");
			}
		
  		}
  		else System.out.print("没有结果");
		}
		catch(Exception ex)
		{
			System.out.println("关闭参数是出错6： \r\n错误为："+ex);
		}

		/*关闭数据库连接*/
  		try
		{
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}
		catch(Exception ex)
		{
			System.out.println("关闭参数是出错5： \r\n错误为："+ex);
		}
	}
}