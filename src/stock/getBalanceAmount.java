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

public class getBalanceAmount {
	//查询条件信息

	public double balanceAmount(String unit_db_name,String product) {
		double balance_amount=0.0d;
		nseer_db dba=new nseer_db(unit_db_name);
		try{
			String sql="select amount from stock_balance where product_ID='"+product+"'";
			ResultSet rs=dba.executeQuery(sql);
			if(rs.next()){
				balance_amount=rs.getDouble("amount");
			}else{
				balance_amount=0;
			}
			dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return balance_amount;
	}

}