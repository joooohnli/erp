/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import include.nseer_db.nseer_db;
import java.sql.*;

public class getAttachmentType {
	private String fileType=",";
	public String getAttachmentType(String dbase,String table){
		try{
		nseer_db db=new nseer_db(dbase);
		String sql="select * from "+table+" where kind='附件类型'";
		ResultSet rs=db.executeQuery(sql);
		while(rs.next()){
			fileType=fileType+rs.getString("type_name")+",";
		}
		db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return fileType;
	}

}