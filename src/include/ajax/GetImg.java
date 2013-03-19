/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.ajax;

import include.nseer_db.nseer_db;
import java.util.*;
import java.sql.ResultSet;

public class GetImg{

private nseer_db db;
private String pic;

public String get(String dbname,String tname,String module,String sub,String subvalue,String href){
	try{
		db = new nseer_db(dbname);
		String first_kind_name="";
		String second_kind_name="";
		if(tname.equals("document_first")){		
		String sql="select picture from "+tname+" where main_kind_name='"+module+"' and "+sub+"='"+subvalue+"'";
		ResultSet rs=db.executeQuery(sql);
		if(rs.next()){
			pic=rs.getString("picture");
		}
		}else if(tname.equals("document_second")&&href.indexOf("?")==-1){
			StringTokenizer tokenTO = new StringTokenizer(href,"/");
			while (tokenTO.hasMoreTokens()) {
				String main=tokenTO.nextToken();
				first_kind_name=tokenTO.nextToken();
				String head_file=tokenTO.nextToken();
			}
			String sql="select picture from "+tname+" where main_kind_name='"+module+"' and first_kind_name='"+first_kind_name+"' and "+sub+"='"+subvalue+"'";
			ResultSet rs=db.executeQuery(sql);
			if(rs.next()){
				pic=rs.getString("picture");
			}
		}else if(tname.equals("document_second")&&href.indexOf("?")!=-1){
			href=href.substring(href.indexOf("?")+5);
			StringTokenizer tokenTO = new StringTokenizer(href,"/");
			while (tokenTO.hasMoreTokens()) {
				String main=tokenTO.nextToken();
				first_kind_name=tokenTO.nextToken();
				second_kind_name=tokenTO.nextToken();
			}
			String sql="select picture from "+tname+" where main_kind_name='"+module+"' and first_kind_name='"+first_kind_name+"' and "+sub+"='"+subvalue+"'";
			ResultSet rs=db.executeQuery(sql);
			if(rs.next()){
				pic=rs.getString("picture");
			}
		}else if(tname.equals("document_third")){
			StringTokenizer tokenTO = new StringTokenizer(href,"/");
			while (tokenTO.hasMoreTokens()) {
				String main=tokenTO.nextToken();
				first_kind_name=tokenTO.nextToken();
				second_kind_name=tokenTO.nextToken();
				String head_file=tokenTO.nextToken();
			}
			String sql="select picture from "+tname+" where main_kind_name='"+module+"' and first_kind_name='"+first_kind_name+"' and second_kind_name='"+second_kind_name+"' and "+sub+"='"+subvalue+"'";
			ResultSet rs=db.executeQuery(sql);
			if(rs.next()){
				pic=rs.getString("picture");
			}
		}
		db.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	return pic;
}

}