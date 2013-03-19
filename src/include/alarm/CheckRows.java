/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.alarm;
import java.util.Iterator;
import java.util.List;
import java.sql.*;
import include.nseer_db.*;

public class CheckRows{
	
	

	public void addRowCount(String db_name,String tablename){
		nseer_db db=new nseer_db(db_name);
		String sql="";
		int count_row=0;
		sql = "select count_row from erpPlatform_checkAlarm where tablename='"+tablename+"'";
		try{		
		ResultSet rs =db.executeQuery(sql);
		if(rs.next()){
		count_row=rs.getInt("count_row");
		}
        count_row++;
		sql="update erpPlatform_checkAlarm set count_row='"+count_row+"' where tablename='"+tablename+"'";
        db.executeUpdate(sql);

		db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		}


	public void delRowCount(String db_name,String tablename){
		nseer_db db=new nseer_db(db_name);

		String sql="";
		int count_row=0;
		sql = "select count_row from erpPlatform_checkAlarm where tablename='"+tablename+"'";
		try{		
		ResultSet rs =db.executeQuery(sql);
		if(rs.next()){
		count_row=rs.getInt("count_row");
		}
        count_row--;
		sql="update erpPlatform_checkAlarm set count_row='"+count_row+"' where tablename='"+tablename+"'";
        db.executeUpdate(sql);

		db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		}

	
}	
