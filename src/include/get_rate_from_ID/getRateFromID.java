/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.get_rate_from_ID;

import java.sql.*;
import include.nseer_db.nseer_db;

public class getRateFromID {
	//查询条件信息
  private String file_ID="";
  private String table_name="";
  private String field_name="";
  private String sql="";
  private String field_name1="";


  private double getRateFromID=0.0d;

	public double getRateFromID(String unit_db_name,String table_name,String field_name,String file_ID,String field_name1) {
		this.file_ID=file_ID;
		this.table_name=table_name;
		this.field_name=field_name;
		this.field_name1=field_name1;

		nseer_db db=new nseer_db(unit_db_name);

		try{
			sql="select * from "+table_name+" where "+field_name+"='"+file_ID+"'";
			
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
			getRateFromID=rs.getDouble(field_name1);	
			}
			db.close();
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return getRateFromID;
	}

}