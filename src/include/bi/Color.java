/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.bi;

import java.sql.*;
import include.nseer_db.*;

public class Color {
	//查询条件信息
  private String[] color=new String[0];

	public String[] getColor(String unit_db_name,int count) {

		nseer_db db=new nseer_db(unit_db_name);
		color=new String[count];
		int i=0;
		try{
			String sql="select * from bi_color order by id limit "+count;			
			ResultSet rs=db.executeQuery(sql);
		    while(rs.next()){
				color[i]=rs.getString("color");
				i++;
			}
			db.close();		
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return color;
	}

}
//hanhan