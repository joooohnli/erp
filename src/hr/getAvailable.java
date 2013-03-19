/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr;

import java.sql.*;
import include.nseer_db.*;

public class getAvailable {
	//查询条件信息
  private String stock="";
  private String first="";
  private String second="";
  private String third="";
  private String sql="";

  private ResultSet rs=null;
  private int question_amount=0;

	public int available(String unit_db_name,String first,String second) {
		this.first=first;
		this.second=second;
		nseer_db dba=new nseer_db(unit_db_name);
		try{
					sql="select count(*) from hr_questiones where first_kind_name='"+first+"' and second_kind_name='"+second+"'";
					rs=dba.executeQuery(sql);
					if(rs.next()){
						question_amount=rs.getInt("count(*)");
					}
			dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return question_amount;
	}

}