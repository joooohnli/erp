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

public class getYearSumFromItemd {
	//查询条件信息  

	public double getYearSumFromItemd(nseer_db db,String itemd_name,String finance_time) {
		double itemd_sum=0.0d;
		String sql="";
		ResultSet rs=null;
		try{
			if(itemd_name.indexOf("◇")!=-1){
				StringTokenizer tk=new StringTokenizer(itemd_name,"◇");
				while(tk.hasMoreTokens()){
					sql="select debit_or_loan,debit_subtotal,loan_subtotal from finance_voucher where register_time<='"+finance_time+"' and itemd_name='"+tk.nextToken()+"'";			
					rs=db.executeQuery(sql);			
					while(rs.next()){
						if(rs.getString("debit_or_loan").equals("借")){
							itemd_sum=itemd_sum+rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
						}else{
							itemd_sum=itemd_sum+rs.getDouble("loan_subtotal")-rs.getDouble("debit_subtotal");
						}
					}
				}
			}else{
				sql="select debit_or_loan,debit_subtotal,loan_subtotal from finance_voucher where register_time<='"+finance_time+"' and itemd_name='"+itemd_name+"'";			
				rs=db.executeQuery(sql);			
				while(rs.next()){
					if(rs.getString("debit_or_loan").equals("借")){
						itemd_sum=itemd_sum+rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
					}else{
						itemd_sum=itemd_sum+rs.getDouble("loan_subtotal")-rs.getDouble("debit_subtotal");
					}
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return itemd_sum;
	}
}