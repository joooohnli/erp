


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

public class getYearSumFromAccount {
	//查询条件信息

public double getYearSumFromAccountCurrent(nseer_db db,String account_period) {
	double itemb_sum=0.0d;	
	String file_id="";
	try{
		String sql="select file_id from finance_config_file_kind where cash_tag='1' and parent_category_id='0'";
		ResultSet rs=db.executeQuery(sql);
		while(rs.next()){
			file_id+=rs.getString("file_id")+"◇";
		}
		file_id=file_id.substring(0,file_id.length()-1);
		if(file_id.indexOf("◇")!=-1){
			StringTokenizer tk=new StringTokenizer(file_id,"◇");
				while(tk.hasMoreTokens()){
					sql="select current_balance_sum from finance_gl where account_period='"+account_period+"' and file_id='"+tk.nextToken()+"'";
					rs=db.executeQuery(sql);
					if(rs.next()){
						itemb_sum+=rs.getDouble("current_balance_sum");
						}
				}
		}else{
			sql="select current_balance_sum from finance_gl where account_period='"+account_period+"' and file_id='"+file_id+"'";
					rs=db.executeQuery(sql);
					if(rs.next()){
						itemb_sum+=rs.getDouble("current_balance_sum");
						}
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return itemb_sum;
	}

public double getYearSumFromAccountLast(nseer_db db,String account_period) {
	double itemb_sum1=0.0d;
	String file_id="";
		try{
			String sql="select file_id from finance_config_file_kind where cash_tag='1' and parent_category_id='0'";
			ResultSet rs=db.executeQuery(sql);
			while(rs.next()){
				file_id+=rs.getString("file_id")+"◇";
			}
			file_id=file_id.substring(0,file_id.length()-1);
		if(file_id.indexOf("◇")!=-1){
			StringTokenizer tk=new StringTokenizer(file_id,"◇");
				while(tk.hasMoreTokens()){
					sql="select last_year_balance_sum from finance_gl where account_period='"+account_period+"' and file_id='"+tk.nextToken()+"'";
					rs=db.executeQuery(sql);
					if(rs.next()){
						itemb_sum1+=rs.getDouble("last_year_balance_sum");
						}
				}
		}else{
			sql="select last_year_balance_sum from finance_gl where account_period='"+account_period+"' and file_id='"+file_id+"'";
					rs=db.executeQuery(sql);
					if(rs.next()){
						itemb_sum1+=rs.getDouble("last_year_balance_sum");
						}
		}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return itemb_sum1;
	}
}