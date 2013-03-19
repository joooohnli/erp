/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance;

import java.sql.*;
import include.nseer_db.nseer_db;

public class getYearProfitSumFromItemb {
	//查询条件信息
	public double getYearProfitSumFromItemb(nseer_db db,String field_name,String account_period) {	
		double itemd_sum=0.0d;
		try{		
			String sql="select "+field_name+" from finance_report_02 where account_period='"+account_period+"' order by id desc";			
			ResultSet rs=db.executeQuery(sql);			
		    if(rs.next()){
				itemd_sum=rs.getDouble(field_name);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return itemd_sum;
	}
}