/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.auto_execute;

import java.sql.*;
import include.nseer_db.*;
import javax.servlet.*;

public class GatherSumLimit{

    private nseer_db_backup nseer_db;
	private nseer_db_backup nseerdb;
    private ResultSet rs=null;
    private ResultSet rs1=null;
    private String sql1="";
    private String date="";
    private String[] idgroup=new String[100000];
	private String[] namegroup=new String[100000];
    private String[] alarmgroup=new String[100000];
    private double tradeTotal=0.0d;
    private double receipt=0.0d;
    private double unreceipt=0.0d;
    public void cost(ServletContext dbApplication) {
		try{
			nseer_db_backup db=new nseer_db_backup(dbApplication);
			if(db.conn("mysql")){
		String sqldb="show databases";
		ResultSet rsdb=db.executeQuery(sqldb);
		while(rsdb.next()){
			if(rsdb.getString("database").equals("ondemand1")){
			nseer_db=new nseer_db_backup(dbApplication);
			nseerdb=new nseer_db_backup(dbApplication);
			if(nseer_db.conn(rsdb.getString("database"))&&nseerdb.conn(rsdb.getString("database"))){
		String sql3="delete from crm_alarm_gather_sum_limit";
 	        nseer_db.executeUpdate(sql3);
 		String sql = "select * from crm_file where check_tag='1'";
 		rs=nseer_db.executeQuery(sql);
 		int i=0;
 		while(rs.next()){
		idgroup[i]=rs.getString("customer_ID");
		namegroup[i]=rs.getString("customer_name");
		alarmgroup[i]=rs.getString("gather_sum_limit");
 		i++;
 		}
 	for(int j=0;j<i;j++){
		tradeTotal=0;
		receipt=0;
		unreceipt=0;
		sql1="select * from fund_fund where funder_ID='"+idgroup[j]+"' and (fund_execute_tag='1' or (fund_pre_tag='0' and fund_execute_tag='0')) and file_chain_name like '应收账款%'";
		rs1=nseerdb.executeQuery(sql1);
		while(rs1.next()){
		tradeTotal+=rs1.getDouble("demand_cost_price_sum");
		receipt+=rs1.getDouble("executed_cost_price_sum");
		unreceipt=tradeTotal-receipt;
	}
 	if(unreceipt>Double.parseDouble(alarmgroup[j])){
		double overfund=unreceipt-Double.parseDouble(alarmgroup[j]);
 		String sql2 = "insert into crm_alarm_gather_sum_limit(customer_ID,customer_name,gather_sum_limit,gather_sum_absent,sum_absent_over) values('"+idgroup[j]+"','"+namegroup[j]+"','"+alarmgroup[j]+"','"+unreceipt+"','"+overfund+"')";
 		nseer_db.executeUpdate(sql2);
	}
					}
	nseerdb.close();
	nseer_db.close();
	} else {
				System.out.println("i am sorry!");
 		}
			}
		}
		db.close();
		} else {
				System.out.println("i am sorry!");
 		}
	 		} catch (Exception ex) {
				ex.printStackTrace();
 		}
	}

}