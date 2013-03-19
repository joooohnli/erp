/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock;

import java.sql.*;
import include.nseer_db.nseer_db;

public class getLength {
	//查询条件信息

  private double available_percent=0.0d;

	public int getLength(String unit_db_name) {
		nseer_db dba=new nseer_db(unit_db_name);
		int length=0;
		try{
					String sql="select stock_name from stock_config_public_char where describe1='S/N长度'";
					ResultSet rs=dba.executeQuery(sql);
					if(rs.next()){
						length=Integer.parseInt(rs.getString("stock_name"));
					}
		dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return length;
	}

	public int getLength2(String unit_db_name) {
		nseer_db dba=new nseer_db(unit_db_name);
		int length=0;
		try{
					String sql="select stock_name from stock_config_public_char where describe1='B/N长度'";
					ResultSet rs=dba.executeQuery(sql);
					if(rs.next()){
						length=Integer.parseInt(rs.getString("stock_name"));
					}
		dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return length;
	}


}