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

public class ContactExpiry{

    private nseer_db_backup nseer_db;
	private nseer_db_backup db;
    private ResultSet rs=null;
    private ResultSet rs1=null;
    private String sql1="";
    private String date="";
    private String[] idgroup=new String[100000];
	private String[] namegroup=new String[100000];
    private String[] alarmgroup=new String[100000];
    private String[] dategroup=new String[100000];
    public void flow(ServletContext dbApplication) {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date  now  =  new  java.util.Date();
		try{
		nseer_db_backup dbd=new nseer_db_backup(dbApplication);
		if(dbd.conn("mysql")){
		String sqldb="show databases";
		ResultSet rsdb=dbd.executeQuery(sqldb);
		while(rsdb.next()){
			if(rsdb.getString("database").equals("ondemand1")){
			nseer_db=new nseer_db_backup(dbApplication);
		if(nseer_db.conn(rsdb.getString("database"))){
		String sql3="delete from crm_alarm_contact_expiry";
 	    nseer_db.executeUpdate(sql3);
 		String sql = "select * from crm_file where check_tag='1'";
 		rs=nseer_db.executeQuery(sql);
 		int i=0;
 		while(rs.next()){
		idgroup[i]=rs.getString("customer_ID");
		namegroup[i]=rs.getString("customer_name");
		alarmgroup[i]=rs.getString("contact_period_limit");
		dategroup[i]=rs.getString("register_time");
 		i++;
 		}
 	for(int j=0;j<i;j++){
 		sql1 = "select * from crm_contact where customer_ID='"+idgroup[j]+"' order by contact_time desc";
		rs1=nseer_db.executeQuery(sql1);
 		if(rs1.next()){
 		date=rs1.getString("contact_time");
 		}else{
		date=dategroup[j];
		}
 		if(!date.equals("")){
	java.util.Date date1 = formatter.parse(date);


	long days1 = (long)((now.getTime() - date1.getTime()) / (1000 * 60 * 60 *24) + 0.5);
	long Time=(date1.getTime()/1000)+60*60*24*Integer.parseInt(alarmgroup[j]);
	date1.setTime(Time*1000);
	if((date1.getTime()-now.getTime())<0){
	long days = (long)((now.getTime() - date1.getTime()) / (1000 * 60 * 60 *24) + 0.5);
 	String sql2 = "insert into crm_alarm_contact_expiry(customer_ID,customer_name,lately_contact_time,contact_period_limit,contact_period_expiry,period_expiry_over) values('"+idgroup[j]+"','"+namegroup[j]+"','"+date+"','"+alarmgroup[j]+"','"+days1+"','"+days+"')";
 	nseer_db.executeUpdate(sql2);
	}
					}
			}
		nseer_db.close();
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