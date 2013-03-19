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

public class getRetailBalanceAmount {
	
	public double balanceAmount(String unit_db_name,String product_ID,String register_ID) {
		nseer_db dba=new nseer_db(unit_db_name);
		nseer_db dbb=new nseer_db(unit_db_name);
		double balance_amount=0.0d;
		try{
			String sql1="select stock_ID from stock_config_public_char where responsible_person_ID like '%"+register_ID+"%'";
			ResultSet rs1=dba.executeQuery(sql1);
			String stock_ID="";
			while(rs1.next()){
				stock_ID=rs1.getString("stock_ID");
				String sql2="select * from stock_balance_details where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
			ResultSet rs2=dbb.executeQuery(sql2);
			if(rs2.next()){
				balance_amount+=rs2.getDouble("amount");
			}
			
			}
			dbb.close();
			dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return balance_amount;
	}

}