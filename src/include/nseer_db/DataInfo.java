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
import java.util.*;

public class DataInfo {

  private nseer_db db=null;
  private boolean init=false;
  String database=null;

  public DataInfo(String database) {
    setDatabase(database);
    init();
  }

  public DataInfo(){};

  public void setDatabase(String database){
    this.database=database;
  }

  private void init(){
    if (!init) {
      db=new nseer_db(database);
      init=true;
    }
  }

  private ResultSetMetaData getResultSetMetaDate(String table) {
    try {
      ResultSet rs=db.executeQuery("select * from "+table);
      if (rs.next()) {
	ResultSetMetaData rsmd=rs.getMetaData();      
	return rsmd;
      }
    } catch (SQLException e) {
      e.printStackTrace();
      return null;
    }
    return null;
  }

  public int getNumberOfColumns(String table) {
    ResultSetMetaData rsmd=getResultSetMetaDate(table);
    int result=0;
    if (rsmd==null) {
      return 0;
    }
    try {
      result=rsmd.getColumnCount();  
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return result;
  }

  public String[] getColumnNames(String table) {
    ResultSetMetaData rsmd=getResultSetMetaDate(table);
    try {
      int numberOfColumns=rsmd.getColumnCount();
      String[] result=new String[numberOfColumns];
      for (int i=1;i<=numberOfColumns;i++) {
	result[i-1]=rsmd.getColumnName(i);
      }
      return result;
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return null;
  }

  public String getColumnType(String table,String column) {
    ResultSetMetaData rsmd=getResultSetMetaDate(table);
    try {
      int numberOfColumns=rsmd.getColumnCount();
      for (int i=1;i<=numberOfColumns;i++) {
	if ((rsmd.getColumnName(i)).equals(column)) {
	  return rsmd.getColumnTypeName(i);
	} // end of if ()
      }
    } catch (SQLException e) {
      e.printStackTrace();
    } // end of try-catch
    return "UNKOWN";
  }

  public String[] getNumericColumn(String table) {
    Vector vt=new Vector();
    String[] names=getColumnNames(table);
    for (int i=0;i<names.length;i++) {
      String type=getColumnType(table,names[i]);
      if (type.equals("INT")||type.equals("LONG")||
	  type.equals("TINY")||type.equals("FLOAT")||
	  type.equals("DOUBLE")) {
	vt.addElement(names[i]);
      }
    }
    String[] result=new String[vt.size()];
    vt.toArray(result);
    return result;
  }

  public void finalize() {
    db.close();
  }

  public static void main(String[] args) {
    DataInfo data=new DataInfo("rajdb");
    String[] names=data.getNumericColumn("product");
    for (int i=0;i<names.length;i++) {
      System.out.println("type:"+data.getColumnType("product",names[i]));
    }
  }
  
}
