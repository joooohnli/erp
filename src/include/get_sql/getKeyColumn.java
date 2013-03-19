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
import java.util.*;
import include.nseer_db.nseer_db;

public class getKeyColumn {
  private String dbase="";
  private String tableName="";
  private nseer_db erp_db;
  private String[] column=new String[1];


	public String[] Column(String database,String tName) {
		this.dbase=database;
		this.tableName=tName;
		erp_db = new nseer_db(dbase);
		String column_group="";
		try{
		String sql1="select * from security_publicconfig_key where tablename='"+tableName+"'";
		ResultSet rs=erp_db.executeQuery(sql1);
		if(rs.next()){
			column_group=rs.getString("column_group");
		
		int i=0;
		StringTokenizer tokenTO = new StringTokenizer(column_group,",");        
            while(tokenTO.hasMoreTokens()) {
				String a=tokenTO.nextToken();
				i++;
		}
		column=new String[i];
		i=0;
		StringTokenizer tokenTO1 = new StringTokenizer(column_group,",");        
            while(tokenTO1.hasMoreTokens()) {
				column[i]=tokenTO1.nextToken();
				i++;
		}
		}else{
			column=null;
		}
		erp_db.close();
		}catch (Exception ex) {ex.printStackTrace();}

		return column;
		}

}