/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.ecommerce;

import include.nseer_db.nseer_db;

import java.sql.ResultSet;

public class ColumnMain{

private nseer_db db;

public String[] getColumn(String dbname,String unit,String column_name){
	String[] cols=new String[1];
	try{
		db = new nseer_db(dbname);
		int amount=0;
		int i=0;
		String sql="select count(id) from "+column_name+" where unit_id='"+unit+"'";
		ResultSet rs=db.executeQuery(sql);
		if(rs.next()){
			amount=rs.getInt("count(id)");
		}
		cols=new String[amount];
		sql="select first_kind_name from "+column_name+" where unit_id='"+unit+"' order by id";
		rs=db.executeQuery(sql);
		while(rs.next()){
			cols[i]=rs.getString("first_kind_name");
			i++;
		}
		db.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}

	return cols;
}

}