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

public class Table{

private nseer_db db;

public String[] getTable(String dbname,String unit,String column_name){
	String[] cols=new String[8];
	try{
		db = new nseer_db(dbname);
		
		String sql="select * from ecommerce_config_cols_first where first_kind_name='"+column_name+"'";
		ResultSet rs=db.executeQuery(sql);
		if(rs.next()){
			cols[0]=rs.getString("describe1");
			cols[1]=rs.getString("describe2");
			cols[2]=rs.getString("describe3");
			cols[3]=rs.getString("describe4");
			cols[4]=rs.getString("describe5");
			cols[5]=rs.getString("describe6");
			cols[6]=rs.getString("first_kind_name");
			cols[7]=rs.getString("first_kind_ID");
		}
		db.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	return cols;
}

}