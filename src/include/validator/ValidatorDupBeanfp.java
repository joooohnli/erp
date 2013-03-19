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

public class ValidatorDupBeanfp {
	private String a;
	public String isDup(HttpSession session,String tn,String fn,String value,String valued,String urlr){
		try{
		nseer_db db = new nseer_db("ondemand1");
		String sql="select * from "+tn+" where "+fn+" like '%"+value+"%'";
		ResultSet rs=db.executeQuery(sql);
		a="";
		if(rs.next()){
			do{
			a+="<a href=\""+urlr+"?"+valued+"="+rs.getString(valued)+"\" target=\"_blank\"><u><font color=\"#ffffff\">"+rs.getString(fn)+"</font></u></a>、";
			}while(rs.next());
			a=a.substring(0,a.length()-1);
		}else{
			a="";
		}
		db.close();
		}catch(Exception ex){
		ex.printStackTrace();
		}
		return a;
	}
}
