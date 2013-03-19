
package include.nseer_db;

import java.sql.*;
import java.util.*;
import java.io.*;
import javax.servlet.*;
import java.net.*;

public class nseer_db_backup1{
	
	 	private Connection conn;
		private Connection conn_b;
	    private Statement statement;
		private Statement statement_b;
        private connPool a;
		private ServletContext app;
		private String database;
		private connPool b;
	    private String drivername;
	    private String url1;
	    private String url2;
		private String url1_b;
	    private String url2_b;
		private String ip;
		private String masterIp;
		private String strURL1;
		private String ss;

	public nseer_db_backup1(ServletContext application) {
		this.app=application;
	}

	public boolean conn(String s)
    {
		this.database=s;
        try
        {
		a = new connPool(database,1,app);
        conn=a.getConnection();
		conn.setAutoCommit(false);
		statement =conn.createStatement();
		if(app.getAttribute(database+"sync")!=null){
		b = new connPool(database,1,app);

		conn_b=b.getConnection_b();
         conn_b.setAutoCommit(false);
		statement_b =conn_b.createStatement();
			}
        }
        catch(SQLException sqlexception)
        {
            sqlexception.printStackTrace();
			return false;
        }
			return true;
    }

	public void getProperty()
		    {
		        Properties properties = new Properties();
				Properties properties_b = new Properties();
				Properties properties1 = new Properties();
				Properties properties1_b = new Properties();
		        try
		        {
		            InputStream inputstream = getClass().getClassLoader().getResourceAsStream("/conf/db.properties");
					InputStream inputstream_b = getClass().getClassLoader().getResourceAsStream("/conf/db_backup.properties");
					InputStream inputstream1 = getClass().getClassLoader().getResourceAsStream("/conf/dbip.properties");
					InputStream inputstream1_b = getClass().getClassLoader().getResourceAsStream("/conf/dbip_backup.properties");
		            properties.load(inputstream);
					properties_b.load(inputstream_b);
					properties1.load(inputstream1);
					properties1_b.load(inputstream1_b);
		            if(inputstream != null){
		                inputstream.close();
					inputstream_b.close();
					inputstream1.close();
					inputstream1_b.close();
					}
		        }
		        catch(IOException ex)
		        {
		            System.err.println("Open Propety File Error");
		        }
		        drivername = properties.getProperty("DRIVER");
		        url1 = properties.getProperty("URL1")+properties1.getProperty("IP")+":3306/";
		        url2 = properties.getProperty("URL2");
				url1_b = properties_b.getProperty("URL1")+properties1_b.getProperty("IP")+":3306/";
		        url2_b = properties_b.getProperty("URL2");
				ip=properties1_b.getProperty("IP");
				masterIp=properties1.getProperty("IP");
		    }

		    public ResultSet executeQuery(String sql)
		    {
		        ResultSet resultset = null;
		        try
		        {   					
		            resultset = statement.executeQuery(sql);
		        }
		        catch(SQLException sqlexception)
		        {
		            sqlexception.printStackTrace();
		        }
		        return resultset;
		    }

		   public void executeUpdate(String sql)
		    {
		        try
		        {
		            statement.executeUpdate(sql);
					if(app.getAttribute(database+"sync")!=null){
		            statement_b.executeUpdate(sql);
			}
		        }
		        catch(SQLException sqlexception)
		        {
		            sqlexception.printStackTrace();
		        }
			}
		    public boolean executeUpdate(String s,boolean b)
		    {
		        try
		        {
		            statement.executeUpdate(s);
		            return true;
		        }
		        catch(SQLException sqlexception)
		        {
		            sqlexception.printStackTrace();
		        	return false;
		        }
		    }

          public void close() throws SQLException{
          conn.setAutoCommit(true);	  
		  a.release(conn);
		  if(app.getAttribute(database+"sync")!=null){
			  conn_b.setAutoCommit(true);      
			  b.release_b(conn_b);
			}
		  }

	public void setProperty(String dsm,String dss)
    {
        Properties properties = new Properties();
		Properties properties_b = new Properties();
		/*String strClassName = getClass().getName(); 
	String strPackageName = ""; if(getClass().getPackage() != null) { strPackageName = getClass().getPackage().getName(); } 
	 String strClassFileName = ""; if(!"".equals(strPackageName)) 
	{ strClassFileName = strClassName.substring(strPackageName.length() + 1,strClassName.length()); } else { strClassFileName = strClassName; }
	URL url= getClass().getResource(strClassFileName + ".class");
	String strURL = url.toString(); 
	strURL = strURL.substring(strURL.indexOf('/') + 1,strURL.lastIndexOf('/')); 
	String strURL2 = strURL.substring(0,strURL.lastIndexOf("WEB-INF"));
	 strURL1=strURL2+"WEB-INF/classes/";*/

        String strURL1 =this.getClass().getClassLoader().getResource("/").getPath();//�÷���������webӦ�ó���ľ��·�� ��

        try
        {			
			if(!dsm.equals("")){
				String file1=strURL1+"conf/dbip.properties";
				FileOutputStream fos=new FileOutputStream(file1);
				properties.setProperty("IP",dsm);
				properties.store(fos,"dbip.properties");
				if(fos != null)
                fos.close();
			}
			if(!dss.equals("")){
				String file2=strURL1+"conf/dbip_backup.properties";
				FileOutputStream fos_b=new FileOutputStream(file2);
				properties_b.setProperty("IP",dss);
				properties_b.store(fos_b,"dbip_backup.properties");
				if(fos_b != null)
                fos_b.close();
			}
        }catch(IOException _ex)
        {
            System.err.println("Open Propety File Error!");
        }
    }


	public String getIp()
	{
		getProperty();
		return ip;
	}

	public String getMasterIp()
	{
		getProperty();
		return masterIp;
	}

	public String getTable()
    {
        return database;
    }

    public void setTable(String s)
    {
        database = s;
    }

	public void commit() throws SQLException{
		try{
	conn.commit();
	if(app.getAttribute(database+"sync")!=null){
		conn_b.commit();
			}
		}catch(Exception ex)
        {
			conn.rollback();
			if(app.getAttribute(database+"sync")!=null){
				conn_b.rollback();
					}
            ex.printStackTrace();
        }
	}

}
