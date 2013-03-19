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

public class getListPrice {
	//查询条件信息

	public double getListPrice(String unit_db_name,String product_ID) {
		nseer_db dba=new nseer_db(unit_db_name);
		double list_price=0.0d;
		try{
			String sql1="select list_price from design_file where product_ID='"+product_ID+"'";
			ResultSet rs1=dba.executeQuery(sql1);
			if(rs1.next()){
				list_price=rs1.getDouble("list_price");						
			}
			dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return list_price;
	}

}