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

public class getAvailable {
	//查询条件信息

	public double available(String unit_db_name,String stock) {
		nseer_db dba=new nseer_db(unit_db_name);
		double available_percent=0.0d;
		try{
				String sql="select sum(amount/max_capacity_amount) as sum1 from stock_balance_details where stock_name='"+stock+"'";
				ResultSet rs=dba.executeQuery(sql);
				double used_percent=0.0d;
				if(rs.next()){
					used_percent=rs.getDouble("sum1");
				}
				available_percent=1-used_percent;
			dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return available_percent;
	}

}