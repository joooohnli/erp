/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */


//nseer1
package finance;

import java.sql.*;
import include.nseer_db.*;

public class AccountPeriodTime {//获得当前会计区间的开始时间和结束时间
    private String[] name=new String[2];


	public String[] getTime(String unit_db_name) {
		nseer_db db=new nseer_db(unit_db_name);

		try{
			String sql="select start_time from finance_account_period where account_period='1' order by account_period";
			
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
			name[0]=rs.getString("start_time");
			}
			sql="select end_time from finance_account_period where account_period='12' order by account_period";
			
			rs=db.executeQuery(sql);
		    if(rs.next()){
			name[1]=rs.getString("end_time");
			}
			db.close();
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return name;
	}
	
	

}