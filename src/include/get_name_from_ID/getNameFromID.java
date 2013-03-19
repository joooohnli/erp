/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.get_name_from_ID;

import include.nseer_db.nseer_db;

import java.sql.ResultSet;

public class getNameFromID {
	//查询条件信息

	public String getNameFromID(String unit_db_name,String table_name,String field_name,String file_ID,String field_name1) {
		nseer_db db=new nseer_db(unit_db_name);
		String getNameFromID="";
		try{
			String sql="select "+field_name1+" from "+table_name+" where "+field_name+"='"+file_ID+"'";
			
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
			getNameFromID=rs.getString(field_name1);	
			}
			db.close();
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return getNameFromID;
	}
	
	public String getNameFromID(String unit_db_name,String table_name,String field_name1,String file_ID1,String filed_name2,String file_ID2,String field_name3) {
		nseer_db db=new nseer_db(unit_db_name);
		String getNameFromID="";
		try{
			String sql="select "+field_name3+" from "+table_name+" where "+field_name1+"='"+file_ID1+"' and "+filed_name2+"='"+file_ID2+"'";
			
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
			getNameFromID=rs.getString(field_name3);	
			}
			db.close();		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return getNameFromID;
	}

}