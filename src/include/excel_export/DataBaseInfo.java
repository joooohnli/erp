/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_export;

import java.sql.*;
import include.nseer_db.*;

public class DataBaseInfo {
  /**
   * 得数据库字段详细信息
   * v1.1
   **/
  
  nseer_db db=null;
  private ResultSet rs=null;
  public DataBaseInfo(String database){
    db=new nseer_db(database);
  }

  public void setTable(String tableName){
    this.rs=db.executeQuery("select * from "+tableName);  	
  }
  /**
   * 得数据库字段类型信息
   * v1.1
   **/
  public String getColumnType(String columnName) throws Exception {
    try{
      if(rs==null) throw new Exception("请先指定数据表名称");
      ResultSetMetaData rsmd=rs.getMetaData();
      if(getColumnIndex(columnName)==-1) {
	return null;
      }
      return rsmd.getColumnTypeName(getColumnIndex(columnName));
    }
    catch (SQLException e){
      e.printStackTrace();
      return null;
    }
  }

  public String getColumnType(String columnName,String tableName) {
    try{
      ResultSet rs=db.executeQuery("select * from "+tableName);
      ResultSetMetaData rsmd=rs.getMetaData();
      if(getColumnIndex(columnName,tableName)==-1) {
	return null;
      }
      return rsmd.getColumnTypeName(getColumnIndex(columnName,tableName));
    }
    catch (SQLException e){
      e.printStackTrace();
      return null;
    }
  }


  /**
   * 得数据库字段默认值
   * v1.1
   **/
  public String getColumnDefault(String columnName) throws Exception {
    String type=getColumnType(columnName);
    if(type.equals("INT")||
       type.equals("LONG")||
       type.equals("SHORT")||
       type.equals("TINY")) {
      return "0";
    } else if(type.equals("FLOAT")||
	      type.equals("DOUBLE")||
	      type.equals("DOUBLE PRECISION")) {
      return "0.0";
    } else if(type.equals("CHAR")||
	      type.equals("VARCHAR")||
	      type.equals("TEXT")||
	      type.equals("BLOB")) {
      return "";
    } else if(type.equals("DATA")||
			type.equals("TIMESTAMP")) {
      return "0000-00-00";
    }
    return "";
  }

  /**
   * 得数据库字段默认值
   * v1.1
   **/
  public String getColumnDefault(String columnName,String tableName) {
    String type=getColumnType(columnName,tableName);
    if(type.equals("INT")||
       type.equals("LONG")||
       type.equals("SHORT")||
       type.equals("TINY")) {
      return "0";
    } else if(type.equals("FLOAT")||
	      type.equals("DOUBLE")||
	      type.equals("DOUBLE PRECISION")) {
      return "0.0";
    } else if(type.equals("CHAR")||
	      type.equals("VARCHAR")||
	      type.equals("TEXT")||
	      type.equals("BLOB")) {
      return "";
    } else if(type.equals("DATA")||
		  type.equals("TIMESTAMP")) {
      return "0000-00-00";
    }
    return "";
  }

  /**
   * 判断数据库中有没有设定的字段，是getColumnType的辅助方法
   **/
  public int getColumnIndex(String columnName) {
    try{
      ResultSetMetaData rsmd=rs.getMetaData();
      for(int i=1;i<=rsmd.getColumnCount();i++) {
	if(columnName.equals(rsmd.getColumnName(i))) {
		
	  return i;
	}
      }
    }
    catch (SQLException e){
      e.printStackTrace();
      return -1;
    }
    return -1;
  }

  /**
   * 判断数据库中有没有设定的字段，是getColumnType的辅助方法
   **/
  public int getColumnIndex(String columnName,String tableName) {
    try{
      ResultSet rs=db.executeQuery("select * from "+tableName);
      ResultSetMetaData rsmd=rs.getMetaData();
      //JDBC的column从1开始计算
      for(int i=1;i<=rsmd.getColumnCount();i++) {
	if(columnName.equals(rsmd.getColumnName(i))) {
	  return i;
	}
      }
    }
    catch (SQLException e){
      e.printStackTrace();
      return -1;
    }
    return -1;
  }

  //在查询完毕，要关闭数据库
  public void finalize() {
    db.close();
  }

}
