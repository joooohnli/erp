/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_db;

import java.sql.*;

public  class nseer_dbs {
  private Connection connection;
  private Statement statement;
  private String source,url1,url2;

  public nseer_dbs(){
  }

  public boolean conn(String source,String protocol,String drivername,String user,String password) {
    String url ="jdbc:"+protocol+":"+source;
    try {
      Class.forName(drivername);
    } catch(ClassNotFoundException e){
	  e.printStackTrace();
	  return false;
    }
    try {
    connection=DriverManager.getConnection(url,user,password);
    statement=connection.createStatement();
    } catch(SQLException e) {
           e.printStackTrace();
		   return false;
    }
	return true;
  }
  
  public void executeUpdate(String sqlCommand) {
     try {
       statement.executeUpdate(sqlCommand);
     } catch (SQLException e) {
       e.printStackTrace();
     }
  }

  public ResultSet executeQuery(String sqlCommand) {
     ResultSet resultset=null;
     try {
        resultset=statement.executeQuery(sqlCommand);
     } catch (SQLException e) {
       e.printStackTrace();
     }
     return resultset;
  }

  public void close() {
     try {
       statement.close();
       connection.close();
     } catch (SQLException e) {
       e.printStackTrace();
     }
  }

}

