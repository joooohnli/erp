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
import java.util.*;
import include.nseer_db.nseer_db;

public class getYearSumFromItemb {
	//查询条件信息
	public double getYearSumFromItemb(nseer_db db,String number_in_profit_table,String account_period) {
		double itemb_sum=0.0d;
		try{
					String sql1="select debit_or_loan,debit_subtotal,loan_subtotal from finance_voucher where account_period<='"+account_period+"' and itemb_name='"+number_in_profit_table+"' and check_tag='1' and account_tag='1'";
					ResultSet rs1=db.executeQuery(sql1);
					while(rs1.next()){
						if(rs1.getString("debit_or_loan").equals("借")){
							itemb_sum=itemb_sum+rs1.getDouble("debit_subtotal")-rs1.getDouble("loan_subtotal");
						}else{
							itemb_sum=itemb_sum+rs1.getDouble("loan_subtotal")-rs1.getDouble("debit_subtotal");
						}
					}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return itemb_sum;
	}
}