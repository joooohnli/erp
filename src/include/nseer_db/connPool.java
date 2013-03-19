package include.nseer_db;

import java.sql.*;
import java.util.*;
import java.io.*;
import java.util.Properties;
import javax.servlet.*;

public class connPool{
	
	 	private Connection a;
		private Connection b;
	    private Statement statement;
		private Statement statement_b;
	    private String drivername;
	    private String database;
	    private String url1;
	    private String url2;
		private String url1_b;
	    private String url2_b;
		private String ip;
		private String masterIp;
		private ServletContext app;
		private String strURL1;
		private String ss;
		private int con;
		private java.sql.Connection conn[]=new Connection[0];
		private ArrayList connectPool = new ArrayList();
		private ArrayList wait_time = new ArrayList();
		private Connection trueConn = null;
		private java.sql.Connection conn_b[]=new Connection[0];
		private ArrayList connectPool_b = new ArrayList();
		private ArrayList wait_time_b = new ArrayList();
		private Connection trueConn_b = null;

	public connPool(String s,int flag,ServletContext application) {
		this.app=application;
		this.ss=s;
    if(flag == 0){
      init(ss);
    }
  }
	
	public connPool(String s,int flag,ServletContext application,int con) {
		this.app=application;
		this.ss=s;
		this.con=con;
		conn=new Connection[con];
		conn_b=new Connection[con];
    if(flag == 0){
      init(ss);
    }
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

  private Connection getConnectionFromDatabase(String s){
    try {
    	getProperty();
        String s1 = url1 + s + "?" + url2;
        String s2 = drivername;
      Class.forName(drivername).newInstance();
      trueConn= DriverManager.getConnection(s1);
    }
    catch (Exception ex) {
 
    }
    return trueConn;
  }

  private Connection getConnectionFromDatabase_b(String s){
    try {
        String s2 = drivername;
		String s1_b = url1_b + s + "?" + url2_b;
      Class.forName(drivername).newInstance();
      trueConn_b= DriverManager.getConnection(s1_b);
    }
    catch (Exception ex) {
 
    }
    return trueConn_b;
  }

  private void init(String s){
    for(int i=0;i<con;i++){
      conn[i] = getConnectionFromDatabase(s);
		   connectPool.add(i,conn[i]);
		   wait_time.add(i,System.currentTimeMillis()/1000+"");
    }
		app.setAttribute(ss,connectPool);
		app.setAttribute(ss+"time",wait_time);
	if(app.getAttribute(ss+"sync")!=null){
    for(int i=0;i<con;i++){
      conn_b[i] = getConnectionFromDatabase_b(s);
		   connectPool_b.add(i,conn_b[i]);
		   wait_time_b.add(i,System.currentTimeMillis()/1000+"");
    }
    app.setAttribute(ss+"b",connectPool_b);
    app.setAttribute(ss+"btime",wait_time_b);
			}
  }

  public synchronized Connection getConnection(){
	ArrayList connectPooll=(ArrayList)app.getAttribute(ss);
	ArrayList wait_timee=(ArrayList)app.getAttribute(ss+"time");
    if(connectPooll.size()==0){
      try {
        java.lang.Thread.sleep(1000);
        getConnection();
      }
      catch (InterruptedException ex) {
        System.out.println("连接全部用光,这里sleep出错了.");
      }
    }else{
      long time=Long.parseLong((String)wait_timee.get(0));
      if((System.currentTimeMillis()/1000-time)>28000){
    	  a=getConnectionFromDatabase(ss);
    	  connectPooll.remove(0);
    	  app.setAttribute(ss,connectPooll);
    	  wait_timee.remove(0);
    	  app.setAttribute(ss+"time",wait_timee);
      }else{
      a =  (Connection)connectPooll.remove(0);
	  app.setAttribute(ss,connectPooll);
	  wait_timee.remove(0);
	  app.setAttribute(ss+"time",wait_timee);
      }
    }

    return a;
  }

  public synchronized Connection getConnection_b(){
	ArrayList connectPooll_b=(ArrayList)app.getAttribute(ss+"b");
	ArrayList wait_timee_b=(ArrayList)app.getAttribute(ss+"btime");
    if(connectPooll_b.size()==0){
      try {
        java.lang.Thread.sleep(1000);
        getConnection_b();
      }
      catch (InterruptedException ex) {
        System.out.println("连接全部用光,这里sleep出错了.");
      }
    }else{
    	long time=Long.parseLong((String)wait_timee_b.get(0));
        if((System.currentTimeMillis()/1000-time)>28000){
      	  a=getConnectionFromDatabase_b(ss);
      	  connectPooll_b.remove(0);
      	  app.setAttribute(ss+"b",connectPooll_b);
      	  wait_timee_b.remove(0);
      	  app.setAttribute(ss+"btime",wait_timee_b);
        }else{
      b =  (Connection)connectPooll_b.remove(0);
	  app.setAttribute(ss+"b",connectPooll_b);
	  wait_timee_b.remove(0);
  	  app.setAttribute(ss+"btime",wait_timee_b);
        }
    }

    return b;
  }
  

  public void release(Connection conn){
		  	ArrayList connectPooll=(ArrayList)app.getAttribute(ss);
		  	ArrayList wait_timee=(ArrayList)app.getAttribute(ss+"time");
		      connectPooll.add(conn);
		      wait_timee.add(System.currentTimeMillis()/1000+"");
		  app.setAttribute(ss,connectPooll);
		  app.setAttribute(ss+"time",wait_timee);
  }

  public void release_b(Connection conn_b){
		  	ArrayList connectPooll_b=(ArrayList)app.getAttribute(ss+"b");
		  	ArrayList wait_timee_b=(ArrayList)app.getAttribute(ss+"btime");
		      connectPooll_b.add(conn_b);
		      wait_timee_b.add(System.currentTimeMillis()/1000+"");
		  app.setAttribute(ss+"b",connectPooll_b);
		  app.setAttribute(ss+"btime",wait_timee_b);
  }

 }
