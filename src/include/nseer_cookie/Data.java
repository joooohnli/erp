/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import include.nseer_db.nseer_db;
import java.sql.*;

public class Data {
	private String value;
	private nseer_db db;
	private ResultSet rs;

	public Data(String dbase,String table,String fn,String fv){
		try{
		db=new nseer_db(dbase);
		String sql="select * from "+table+" where "+fn+"='"+fv+"'";
		rs=db.executeQuery(sql);		
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	public String getPara(String fn){
		try{
			if(rs.first()){
			value=rs.getString(fn);
			}else{value="";}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return value;
	}

	public void close(){
		db.close();
	}

}