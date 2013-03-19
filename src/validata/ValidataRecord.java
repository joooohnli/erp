/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package validata;

import java.sql.*;
import include.nseer_db.nseer_db;

public class ValidataRecord{
	public boolean flag ;
	private String dbase="";
	private String table="";
	private String field="";
	private String fieldValue="";
	private nseer_db dba;

	  public boolean validata(String dbase,String table,String field,String fieldValue){
		this.dbase=dbase;
		this.table=table;
		this.field=field;
		this.fieldValue=fieldValue;
		try{
					dba=new nseer_db(dbase);
					ResultSet rs=dba.executeQuery("select * from "+table+" where "+field+"='"+fieldValue+"'");
					if(rs.next()){
						flag=true;
					}else{
						flag=false;
					}
		dba.close();
	}catch(Exception ex){
		ex.printStackTrace();
		}
         return flag;
   }
}