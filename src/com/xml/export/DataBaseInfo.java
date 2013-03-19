/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package com.xml.export;

import java.sql.*;
import include.nseer_db.*;

public class DataBaseInfo{
	//rivate static Logger _log = Logger.getLogger("DataBaseInfo.class"); 
	   ResultSet rs = null;
	   nseer_db db = null;
	   private String tablename ="";
	   private String condition ="";
	   
       public DataBaseInfo(String dbname,String tablename,String condition){
			   this.tablename = tablename;
			   this.condition = condition;
       	       db = new nseer_db(dbname);
       	       rs = db.executeQuery("select * from "+tablename+" "+condition+"");
       	       
       	}
       
      
      		 
     
      
      /*getColumnType的辅助方法 */
      
      public  int getColumnIndex(String columnName){
      	  try {
      	  	   ResultSetMetaData rsmd = rs.getMetaData();
      	  	   for(int i=1;i<=rsmd.getColumnCount();i++){
      	  	   	    if(columnName.equals(rsmd.getColumnName(i)))
      	  	   	      return i;
      	  	   	}    
		    }
		    catch (Exception ex) {
		       ex.printStackTrace();
		       return -1;
		    }	
      	     return -1; 
      	}
      
      
      public  String getColumnType(String columnName) throws Exception{
      		  try {
      		  	 if(rs ==null) throw new Exception("请指定你的数据表名称");
      		  	 ResultSetMetaData rsmd =rs.getMetaData();
      		  	 if(getColumnIndex(columnName) == -1)
      		  	    return (null);
			     else
			        return rsmd.getColumnTypeName(getColumnIndex(columnName));
			    }
			    catch (Exception ex) {
			      ex.printStackTrace();
			      return (null);
			    }
      	}
      
       public String getTableName(){
       	   return this.tablename;
       	}
       	    
	  public void close(){
	  	   db.close();
	  	   db = null;
	  	}
}	