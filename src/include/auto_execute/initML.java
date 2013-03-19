/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.auto_execute;

import java.sql.*;
import include.nseer_db.*;
import javax.servlet.*;

public class initML{

    public void initML(ServletContext dbApplication) {
		try{
					nseer_db db=new nseer_db("ondemand1");
					String sql="select * from document_multilanguage";
					ResultSet rs=db.executeQuery(sql);
					ResultSetMetaData rsmd = rs.getMetaData();
						int number = rsmd.getColumnCount();
						String ref=",";
						for(int i=1;i<=number;i++){
							ref=ref+rsmd.getColumnName(i)+",";							
						}
					String sql1="select * from document_config_public_char where kind='语言类型'";
					ResultSet rs1=db.executeQuery(sql1);
					while(rs1.next()){
						if(ref.indexOf(rs1.getString("type_name"))==-1){
							String sql2="delete from document_config_public_char where id='"+rs1.getString("id")+"'";
							db.executeUpdate(sql2);
							}
					}
					db.close();
	 		} catch (Exception ex) {
				ex.printStackTrace();
 		}
	}

}