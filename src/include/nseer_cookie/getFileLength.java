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

public class getFileLength {

	public static long getFileLength(String dbase){
		long fileLength=0;
		try{
		nseer_db db=new nseer_db(dbase);
		String sql="select * from document_config_public_char where kind='附件容量'";
		ResultSet rs=db.executeQuery(sql);
		if(rs.next()){
			fileLength=rs.getLong("type_name")*1024;
		}
		db.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return fileLength;
	}

	public static String getFileType(String dbase){
		String file_type="";
		try{
		nseer_db db=new nseer_db(dbase);
		String sql="select * from document_config_public_char where kind='附件类型' order by type_ID";
		ResultSet rs=db.executeQuery(sql);
		while(rs.next()){
			file_type+=rs.getString("type_name")+",";
		}
		db.close();
		file_type=file_type.substring(0,file_type.length()-1);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return file_type;
	}

}