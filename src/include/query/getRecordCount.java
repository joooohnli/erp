/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.query;

import java.sql.*;
import include.nseer_db.nseer_db;

public class getRecordCount {
	//查询条件信息
  private String dbase="";
  private String sql="";
  private ResultSet rs=null;
  private int intRowCount=0;
  private nseer_db dba;

	public int count(String dbase,String query) {
		this.dbase=dbase;
		this.sql=query;
		try{
					dba=new nseer_db(dbase);
					rs=dba.executeQuery(sql);
					intRowCount=0;
					if(rs.last()){
					intRowCount=rs.getRow();
					}
	}catch(Exception ex){
		ex.printStackTrace();
		}
		dba.close();
		return intRowCount;
	}

}