/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.sql.*;
import include.nseer_db.nseer_db;

public class UnitInfo {
	//查询条件信息
  private String unit_db_name="";
  private String unit_name="";
  private nseer_db db;

	public String getDbName(String unit_id) {

		

		try{
			db=new nseer_db("mysql");
			String sql="select * from unit_info where unit_id='"+unit_id+"'";
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
			unit_db_name=rs.getString("unit_db_name");	
			}
			db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return unit_db_name;
	}

	public String getUnitName(String unit_id) {

		

		try{
			db=new nseer_db("mysql");
			String sql="select * from unit_info where unit_id='"+unit_id+"'";
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
			unit_name=rs.getString("unit_name");	
			}
			db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return unit_name;
	}

}