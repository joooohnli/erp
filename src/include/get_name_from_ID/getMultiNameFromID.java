/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.get_name_from_ID;

import java.sql.*;
import include.nseer_db.*;

public class getMultiNameFromID {
	//查询条件信息
	public String[] getNameFromID(String unit_db_name,String file_ID) {
		nseer_db db=new nseer_db(unit_db_name);
		String[] name=new String[8];
		try{
			String sql="select * from finance_config_file_kind where file_ID='"+file_ID+"'";
			ResultSet rs=db.executeQuery(sql);
		    if(rs.next()){
				name[0]=rs.getString("file_name");
				name[1]=rs.getString("debit_or_loan");
				name[2]=rs.getString("itema_name");
				name[3]=rs.getString("itemb_name");
				name[4]=rs.getString("itemd_name");
				name[5]=rs.getString("profit_or_cost");
				name[6]=rs.getString("chain_name");
				name[7]=rs.getString("corr_stock_tag");
			}
			db.close();		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return name;
	}
}