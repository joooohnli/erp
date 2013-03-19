/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.get_three_kinds;

import java.sql.*;
import include.nseer_db.nseer_db;

public class getThreeKinds1 {
	//查询条件信息

	public String[] getThreeKinds(String unit_db_name,String table_name,String field_name,String file_ID) {
		String[] three_kinds_chain=new String[2];
		nseer_db db=new nseer_db(unit_db_name);

		try{
			String sql="select chain_ID,chain_name from "+table_name+" where "+field_name+"='"+file_ID+"'";
			
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
				three_kinds_chain[0]=rs.getString("chain_ID");
				three_kinds_chain[1]=rs.getString("chain_name");
			}
			db.close();
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return three_kinds_chain;
	}

}