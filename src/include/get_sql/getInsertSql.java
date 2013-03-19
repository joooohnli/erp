/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.get_sql;

import java.sql.*;
import include.nseer_db.nseer_db;

public class getInsertSql {
  private String dbase="";
  private String tableName="";
  private nseer_db erp_db;


	public String sql(String database,String tName) {
		this.dbase=database;
		this.tableName=tName;
		String sql="";
		erp_db = new nseer_db(dbase);
		try{
		String sql1="select * from "+tableName+"";
		ResultSet rs=erp_db.executeQuery(sql1);
		ResultSetMetaData rsmd = rs.getMetaData();
		int number = rsmd.getColumnCount();
		for(int i=2;i<number;i++){
			sql=sql+rsmd.getColumnName(i)+",";
		}
		sql=sql+rsmd.getColumnName(number);
		erp_db.close();
		}catch (Exception ex) {}

		return sql;
		}

}