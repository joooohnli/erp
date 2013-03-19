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

public class PriceLimit{

    private nseer_db_backup nseer_db;
	private nseer_db_backup nseer_db1;
    private ResultSet rs=null;
    public void price(ServletContext dbApplication) {
		try{
			nseer_db_backup db=new nseer_db_backup(dbApplication);
			if(db.conn("mysql")){
		String sqldb="show databases";
		ResultSet rsdb=db.executeQuery(sqldb);
		while(rsdb.next()){
			if(rsdb.getString("database").equals("ondemand1")){
			nseer_db=new nseer_db_backup(dbApplication);
			nseer_db1=new nseer_db_backup(dbApplication);
		if(nseer_db.conn(rsdb.getString("database"))&&nseer_db1.conn(rsdb.getString("database"))){
		String sql3 = "update design_file set price_alarm_tag='0'";
 		nseer_db.executeUpdate(sql3);
		String sql4 = "select * from design_config_public_char where kind='priceAlarm'";
 		ResultSet rs4=nseer_db.executeQuery(sql4);
		
 		double rate=0.0d;
 		if(rs4.next()){
			rate=Double.parseDouble(rs4.getString("type_name"))/100;
			
		}
		
 		String sql = "select * from design_file where check_tag='1'";
 		rs=nseer_db1.executeQuery(sql);
 		while(rs.next()){
		 double price_odds=rs.getDouble("cost_price")-rs.getDouble("real_cost_price");
		 if(Math.abs(price_odds/rs.getDouble("cost_price"))>=rate){
 		String sql2 = "update design_file set price_alarm_tag='1' where id='"+rs.getString("id")+"'";
 		nseer_db.executeUpdate(sql2);
			}
					}
	nseer_db.close();
	nseer_db1.close();
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