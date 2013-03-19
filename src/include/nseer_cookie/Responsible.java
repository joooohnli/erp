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

import include.nseer_db.*;

import java.sql.*;
import java.util.Iterator;
import java.util.List;

import javax.servlet.*;

public class Responsible {
	public static String getString(nseer_db db,String table_name,String describe){
		String file_id_chain="";
		try{
			List rsList = (List)new java.util.ArrayList();
			String sql="select file_id,category_id from "+table_name+" where describe1 like '%"+describe+"%'";
			ResultSet rs=db.executeQuery(sql);
			while(rs.next()){
				rsList.add(rs.getString("file_id"));
				rsList.add(rs.getString("category_id"));
			}
			for(int i=0;i<rsList.size();i++){
				if(file_id_chain.indexOf(","+(String)rsList.get(i)+",")==-1){
					file_id_chain+=(String)rsList.get(i)+",";
					i++;
					if(file_id_chain.indexOf(getFileId(db,table_name,(String)rsList.get(i)))==-1){
						file_id_chain+=getFileId(db,table_name,(String)rsList.get(i));
					}
				}else{
					i++;
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return ","+file_id_chain;
	}
	private static String getFileId(nseer_db db,String table_name,String parent_category_id){
		String file_id_temp="";
		try{
			List rsList = (List)new java.util.ArrayList();
			String sql="select file_id,category_id from "+table_name+" where parent_category_id='"+parent_category_id+"'";
			ResultSet rs=db.executeQuery(sql);
			while(rs.next()){
				rsList.add(rs.getString("file_id"));
				rsList.add(rs.getString("category_id"));
			}
			for(int i=0;i<rsList.size();i++){
				file_id_temp+=(String)rsList.get(i);
				file_id_temp+=","+getFileId(db,table_name,(String)rsList.get(++i));				
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return file_id_temp;
	}
		
}