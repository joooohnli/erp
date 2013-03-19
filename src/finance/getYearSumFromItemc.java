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

public class getYearSumFromItemc {
	//查询条件信息  
	public double getYearSumFromItemc(nseer_db db,String number_in_cash_table,String finance_time) {		double itemc_sum=0.0d;
		try{
			String cash_in_or_out="";
			String sql="";
			ResultSet rs=null;
			String number_in_cash="";			
			if(number_in_cash_table.indexOf("◇")!=-1){
				StringTokenizer tk=new StringTokenizer(number_in_cash_table,"◇");
				while(tk.hasMoreTokens()){
					number_in_cash=tk.nextToken();
					sql="select cash_in_or_out from finance_config_report_itemc where number_in_cash_table='"+number_in_cash+"'";
					rs=db.executeQuery(sql);			
					if(rs.next()){
						cash_in_or_out=rs.getString("cash_in_or_out");
					}
					sql="select debit,loan from finance_cash_table where register_time<='"+finance_time+"' and number_in_cash_table='"+number_in_cash+"'";	
					rs=db.executeQuery(sql);			
					while(rs.next()){
						if(cash_in_or_out.equals("流入")){
							itemc_sum=itemc_sum+rs.getDouble("debit")-rs.getDouble("loan");
						}else{
							itemc_sum=itemc_sum+rs.getDouble("loan")-rs.getDouble("debit");
						}
					}
				}
			}else{
				sql="select cash_in_or_out from finance_config_report_itemc where number_in_cash_table='"+number_in_cash_table+"'";
				rs=db.executeQuery(sql);			
				if(rs.next()){
					cash_in_or_out=rs.getString("cash_in_or_out");
				}
				sql="select debit,loan from finance_cash_table where register_time<='"+finance_time+"' and number_in_cash_table='"+number_in_cash_table+"'";			
				rs=db.executeQuery(sql);			
				while(rs.next()){
					if(cash_in_or_out.equals("流入")){
						itemc_sum=itemc_sum+rs.getDouble("debit")-rs.getDouble("loan");
					}else{
						itemc_sum=itemc_sum+rs.getDouble("loan")-rs.getDouble("debit");
					}
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return itemc_sum;
	}
}