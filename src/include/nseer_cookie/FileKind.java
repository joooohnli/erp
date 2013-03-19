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

import java.sql.*;
import include.nseer_db.nseer_db;

public class FileKind {

	public String[] getKind(String unit_db_name,String table_name,String field_name,String file_ID) {
	
		nseer_db db=new nseer_db(unit_db_name);
		String[] kind_chain=new String[2];
		try{
			String sql="select chain_id,chain_name from "+table_name+" where "+field_name+"='"+file_ID+"'";			
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
				kind_chain[0]=rs.getString("chain_id");
				kind_chain[1]=rs.getString("chain_name");
			}
			db.close();
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return kind_chain;
	}

}