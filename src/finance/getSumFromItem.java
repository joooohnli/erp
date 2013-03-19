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

public class getSumFromItem {
	//查询条件信息  
	public double getSumFromItem(nseer_db db,String number_in_asset_table,String account_period) {
		double itema_sum=0.0d;
		try{
			if(number_in_asset_table.indexOf("◇")!=-1){
				StringTokenizer tk=new StringTokenizer(number_in_asset_table,"◇");
				while(tk.hasMoreTokens()){
					String sql="select current_balance_sum from finance_gl where account_period='"+account_period+"' and itema_name='"+tk.nextToken()+"' and length(file_id)=4";			
					ResultSet rs=db.executeQuery(sql);			
					while(rs.next()){
						itema_sum+=rs.getDouble("current_balance_sum");	
					}
				}
			}else{
				String sql="select current_balance_sum from finance_gl where account_period='"+account_period+"' and itema_name='"+number_in_asset_table+"' and length(file_id)=4";			
				ResultSet rs=db.executeQuery(sql);			
				while(rs.next()){
					itema_sum+=rs.getDouble("current_balance_sum");	
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return itema_sum;
	}

	public double getLastYearSumFromItem(nseer_db db,String number_in_asset_table,String account_period) {	
		double last_year_itema_sum=0.0d;
		try{
			if(number_in_asset_table.indexOf("◇")!=-1){
				StringTokenizer tk=new StringTokenizer(number_in_asset_table,"◇");
				while(tk.hasMoreTokens()){
					String sql="select last_year_balance_sum from finance_gl where account_period='"+account_period+"' and itema_name='"+tk.nextToken()+"' and length(file_id)=4";			
					ResultSet rs=db.executeQuery(sql);			
					while(rs.next()){
						last_year_itema_sum+=rs.getDouble("last_year_balance_sum");	
					}
				}
			}else{
				String sql="select last_year_balance_sum from finance_gl where account_period='"+account_period+"' and itema_name='"+number_in_asset_table+"' and length(file_id)=4";			
				ResultSet rs=db.executeQuery(sql);
				while(rs.next()){
					last_year_itema_sum+=rs.getDouble("last_year_balance_sum");	
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return last_year_itema_sum;
	}
}