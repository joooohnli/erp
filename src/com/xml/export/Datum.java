
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

import java.util.*;
import java.sql.*;
import com.xml.export.DataBaseInfo;
//import include.nseer_db.*;
//import com.xml.export.DataStruts;

public class Datum{
		DataBaseInfo dbif = null;
		//nseer_db_backup db = null;
		//DataStruts dss = null;
		//Nseerdb ndb = null;
		//Nseerdb  dbutil= null;
		ResultSetMetaData rsmd = null;
     	ResultSet resultset = null;
		ArrayList ids = new ArrayList();
		ArrayList columnnames = new ArrayList();
		Vector contents = new Vector();
		//Hashtable htable = new Hashtable();
		
		public Datum(String dbname,String tablename,String condition){		
		 	 dbif = new DataBaseInfo(dbname,tablename,condition);
		}
		
		   public ArrayList getColumnName() throws Exception{
		   		try{
		   		   if(dbif.rs==null) throw new Exception("please fill in table name");  
		   		   this.rsmd = dbif.rs.getMetaData();
		   		   for(int i=1 ;i<=rsmd.getColumnCount();i++){
		   		   	    this.columnnames.add(rsmd.getColumnName(i));
		   		   	}}catch(Exception ex){
		   		   	   ex.printStackTrace();
		   		   	   return null;	
		   		   	}		   	     
		   	         return columnnames;		   	     
		   	}
		   public ArrayList getColumnId() throws Exception{
		   		  try {
		   		  	   if(dbif.rs ==null) throw new Exception("please fill in table name");
					   while(dbif.rs.next())
					      ids.add(dbif.rs.getString("id"));
					 }
					 catch (Exception ex) {
					    ex.printStackTrace();
					    return null;
					 }
				    return ids;	
		   	}
		   public Vector getContents() throws Exception{
		   		try {
		   			if(dbif.rs==null) throw new Exception("please fill in table name");
		   			this.rsmd =dbif.rs.getMetaData();
		   			while(dbif.rs.next()){
		   				 for(int j=1;j<=rsmd.getColumnCount();j++){
		   				 	  contents.addElement(dbif.rs.getObject(j));
		   				    }		
		   			} 
				   }
				   catch (Exception ex) {
				   	ex.printStackTrace();
				   	return null;
				   }
				   return contents;
		   }
		  
}                                                                   