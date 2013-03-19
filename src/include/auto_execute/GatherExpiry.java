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
import java.text.*;
import include.nseer_db.*;
import javax.servlet.*;

public class GatherExpiry{

    private nseer_db_backup db;
	private nseer_db_backup db1;
    private ResultSet rs=null;
    private ResultSet rs1=null;
    private String sql1="";
    private String date="";
    private String[] idgroup=new String[100000];
	private String[] namegroup=new String[100000];
    private String[] alarmgroup=new String[100000];
    public void back(ServletContext dbApplication) {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date  now  =  new  java.util.Date();
		try{
			nseer_db_backup dbd=new nseer_db_backup(dbApplication);
		if(dbd.conn("mysql")){
		String sqldb="show databases";
		ResultSet rsdb=dbd.executeQuery(sqldb);
		while(rsdb.next()){
			if(rsdb.getString("database").equals("ondemand1")){
			db=new nseer_db_backup(dbApplication);
			db1=new nseer_db_backup(dbApplication);
			if(db.conn(rsdb.getString("database"))&&db1.conn(rsdb.getString("database"))){
		String sql3="delete from crm_alarm_gather_expiry";
 	    db.executeUpdate(sql3);
 		String sql = "select * from crm_file where check_tag='1'";
 		rs=db.executeQuery(sql);
 		int i=0;
 		while(rs.next()){
		idgroup[i]=rs.getString("customer_ID");
		namegroup[i]=rs.getString("customer_name");
		alarmgroup[i]=rs.getString("gather_period_limit");
 		i++;
 		}
 	for(int j=0;j<i;j++){
 	java.util.Date date1 = new  java.util.Date();
	long Time=(now.getTime()/1000)-60*60*24*Integer.parseInt(alarmgroup[j]);
	date1.setTime(Time*1000);
	String time=formatter.format(date1);
 		sql1 = "select * from crm_order where customer_ID='"+idgroup[j]+"' and check_time<='"+time+"' and check_tag='1' and gather_tag!='3' order by check_time";
 		rs1=db1.executeQuery(sql1);
 		while(rs1.next()){
		java.util.Date date2 = formatter.parse(rs1.getString("check_time"));
		java.util.Date now1 = new  java.util.Date();
		long days1 = (long)((now1.getTime() - date2.getTime()) / (1000 * 60 * 60 *24) + 0.5);
		long days = (long)((date1.getTime() - date2.getTime()) / (1000 * 60 * 60 *24) + 0.5);
 		String sql2 = "insert into crm_alarm_gather_expiry(customer_ID,customer_name,order_ID,order_check_time,gather_period_limit,gather_period_expiry,period_expiry_over) values('"+idgroup[j]+"','"+namegroup[j]+"','"+rs1.getString("order_ID")+"','"+rs1.getString("check_time")+"','"+alarmgroup[j]+"','"+days1+"','"+days+"')";
 		db.executeUpdate(sql2);
		}
			}
		db.close();
		db1.close();
		} else {
				System.out.println("i am sorry!");
 		}
			}
		}
		dbd.close();
		} else {
				System.out.println("i am sorry!");
 		}
	 		} catch (Exception ex) {
				ex.printStackTrace();
 		}
	}

}