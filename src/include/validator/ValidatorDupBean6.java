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

public class ValidatorDupBean6 {
	private boolean a;
	public boolean isDup(HttpSession session,String tn,String fn,String value,String values){
		try{
		
		nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
		String sql="select * from "+tn+" where "+fn+"='"+value+"' and kind='"+values+"' ";
		ResultSet rs=db.executeQuery(sql);
		if(rs.next()){
			a=true;
		}else{
			a=false;
		}
		db.close();
		}catch(Exception ex){
		ex.printStackTrace();
		}
		
		return a;
	}
}
