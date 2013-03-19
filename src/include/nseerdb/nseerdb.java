/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseerdb;

import java.sql.*;
import java.util.*;
import java.io.*;

public class nseerdb 
{ 
private String drivername,url,driverName;
private String table,url1,url2;
Connection conn = null; 
Statement stmt = null;
Connection conn1 = null; 
Statement stmt1 = null;
 
ResultSet rs = null;
 
public nseerdb(String table) 
{
     setProperty();
	 this.table = table;	  
     url =url1+table+"?"+
                url2;
    driverName =drivername;
try 
{ 
Class.forName(driverName); 
} 
catch (java.lang.ClassNotFoundException e) 
{ 
System.err.println("nseerdb(String): " + e.getMessage()); 
} 
} 
  public void setProperty(){
    Properties properties = new Properties();
		Properties properties1 = new Properties();
        try
        {
            InputStream inputstream = getClass().getClassLoader().getResourceAsStream("/conf/db.properties");
			InputStream inputstream1 = getClass().getClassLoader().getResourceAsStream("/conf/dbip.properties");
            properties.load(inputstream);
			properties1.load(inputstream1);
            if(inputstream != null)
                inputstream.close();
				inputstream1.close();
        }
        
        catch(IOException ex)
        {
            System.err.println("Open Propety File Error");
        }
        drivername = properties.getProperty("DRIVER");
        url1 = properties.getProperty("URL1")+properties1.getProperty("IP")+":3306/";
        url2 = properties.getProperty("URL2");
  }
  public String getTable(){
  		 return table;
  	}
  public void setTable(String table){
  		this.table = table;
  	}
public ResultSet executeQuery(String sql) throws SQLException 
{ 
conn = DriverManager.getConnection(url); 
stmt = conn.createStatement(); 
rs = stmt.executeQuery(sql); 
return rs; 
}



public boolean executeUpdate(String sql) throws SQLException
{
try 
{
conn1 = DriverManager.getConnection(url); 
stmt1 = conn1.createStatement();
stmt1.executeUpdate(sql);
return true;
} 
catch ( SQLException ex ) 
{ 
System.err.println("closeConn: " + ex.getMessage()); 
return false;
}
}

public boolean closeConn() 
{ 
try 
{ 
if (rs!=null) rs.close(); 
if (stmt!=null) stmt.close(); 
if (conn!=null) conn.close();
if (stmt1!=null) stmt1.close(); 
if (conn1!=null) conn1.close(); 
return true; 
} 
catch ( SQLException ex ) 
{ 
System.err.println("closeConn: " + ex.getMessage()); 
return false; 
} 
} 
}