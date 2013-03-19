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

public class WebColumn{

private nseer_db db;
private String[] cols=new String[0];
private String[] cols_ID=new String[0];

public WebColumn(String dbname,String unit){
	try{
		db = new nseer_db(dbname);
		String sql="select count(*) from ecommerce_colsa where unit_id='"+unit+"'";
		ResultSet rs=db.executeQuery(sql);
		int i=0;
		if(rs.next()){
		cols=new String[rs.getInt("count(*)")];
		cols_ID=new String[rs.getInt("count(*)")];
		sql="select * from ecommerce_colsa where unit_id='"+unit+"'";
		rs=db.executeQuery(sql);
		while(rs.next()){
			cols[i]=rs.getString("first_kind_name");
			cols_ID[i]=rs.getString("first_kind_ID");
			i++;
		}
		}
		db.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
}

public String[] getCols(){
	return this.cols;
}

public String[] getCols_ID(){
	return this.cols_ID;
}

public void close(){
		db.close();
	}

}