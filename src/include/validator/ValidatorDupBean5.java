/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.validator;

import include.nseer_db.*;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class ValidatorDupBean5 {
	private boolean a;
	public boolean isDup(HttpSession session,String tn,String fn,String value,String values){
		try{
		String unit_db_name="";
		nseer_db db = new nseer_db("mysql");
		String sql1="select * from unit_info where unit_id='"+values+"'";

		ResultSet rs=db.executeQuery(sql1);
		if(rs.next()){
			unit_db_name=rs.getString("unit_db_name");
		}
		value=values+"_"+value;

		nseer_db db1 = new nseer_db(unit_db_name);
		String sql="select * from "+tn+" where "+fn+"='"+value+"'";

		rs=db1.executeQuery(sql);
		if(rs.next()){
			a=true;
			
		}else{
			a=false;
			
		}
		db.close();
		db1.close();
		}catch(Exception ex){
		ex.printStackTrace();
		}
		
		return a;
	}
}
