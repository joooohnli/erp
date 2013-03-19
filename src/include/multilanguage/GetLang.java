/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.multilanguage;

import java.sql.*;
import include.nseer_db.nseer_db;

public class GetLang{

	private String value="多语种配置";

	public String getChinese(String unit_db_name,String tablename,String column,String type){


	String sql="select * from document_multilanguage where tablename='"+tablename+"' and name='"+column+"'";

	nseer_db tt=new nseer_db(unit_db_name);
try{
	ResultSet rs=tt.executeQuery(sql);
	if(rs.next())
	value=rs.getString(type);
}catch(Exception r)
	
{r.printStackTrace();}
	tt.close();
	
	return value;
	
	
	}

    
}