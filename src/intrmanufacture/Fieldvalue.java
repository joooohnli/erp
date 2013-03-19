/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture;

import java.sql.*;
import include.nseer_db.nseer_db;

public class Fieldvalue {
	//查询条件信息
  private String dbase="";
  private String table="";
  private String fieldName1="";
  private String fieldValue1="";
  private String fieldName2="";
  private String value="";
  private String sql="";
  private ResultSet rs=null;

	public String getValue(String dbase,String table,String field1,String value1,String field2) {
		this.dbase=dbase;
		this.table=table;
		this.fieldName1=field1;
		this.fieldValue1=value1;
		this.fieldName2=field2;
		nseer_db dba=new nseer_db(dbase);
		try{
			sql="select * from "+table+" where "+field1+"='"+fieldValue1+"'";
			rs=dba.executeQuery(sql);
			if(rs.next()){
				value=rs.getString(fieldName2);
			}
		dba.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return value;
	}

}