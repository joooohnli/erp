/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.right;

import java.sql.*;
import java.util.*;
import include.nseer_db.*;
import javax.servlet.*;

public class UpdateImg {

  private String[] cols=new String[1000];
  private String ID="";
  private String database="";
  private String sql="";
  private ResultSet rs=null;
  private ResultSet rs1=null;
  private ServletContext dbApplication;

	public UpdateImg(ServletContext dbApplication){
		this.dbApplication=dbApplication;
	}

	public void update(String unit_db_name,String ID,String dbase,String[] right) {
		this.ID=ID;
		this.database=dbase;
		this.cols=right;
		nseer_db_backup db=new nseer_db_backup(dbApplication);
		nseer_db_backup db1=new nseer_db_backup(dbApplication);
		try{
		if(db.conn(unit_db_name)&&db1.conn(unit_db_name)){
		String ids=",";
		String tree_view=database+"_view";
		String tree=database+"_tree";
		for(int i=0;i<cols.length;i++){
			if(cols[i]!=null){
				ids+=cols[i]+",";
				}
			}
		String sql1="";
		String sql2="";
		String module="";
		String main="";
		String secondary="";
		String third="";
		StringTokenizer tokenTO =null;
		sql="select * from drag_img where human_ID='"+ID+"' and tree_view_name='"+tree_view+"'";
		rs=db.executeQuery(sql);
		while(rs.next()){
			sql1="";
			tokenTO = new StringTokenizer(rs.getString("drag_text"),"--");
			int tokencount=tokenTO.countTokens();
			switch(tokencount){
		case 1:
			break;
		case 2:
			while (tokenTO.hasMoreTokens()) {
				module = tokenTO.nextToken();
				main = tokenTO.nextToken();
			}
			sql1="select * from "+tree+" where main='"+main+"'";
			break;
		case 3:
			while (tokenTO.hasMoreTokens()) {
				module = tokenTO.nextToken();
				main = tokenTO.nextToken();
				secondary = tokenTO.nextToken();
			}
			sql1="select * from "+tree+" where main='"+main+"' and secondary='"+secondary+"'";
			break;
		case 4:
			while (tokenTO.hasMoreTokens()) {
				module = tokenTO.nextToken();
				main = tokenTO.nextToken();
				secondary = tokenTO.nextToken();
				third = tokenTO.nextToken();
			}
			sql1="select * from "+tree+" where main='"+main+"' and secondary='"+secondary+"' and third='"+third+"'";
}
		if(!sql1.equals("")){
			rs1=db1.executeQuery(sql1);
			if(rs1.next()){
				if(ids.indexOf(","+rs1.getString("id")+",")==-1){
					sql2="delete from drag_img where id='"+rs.getString("id")+"'";
					db1.executeUpdate(sql2);
				}
			}
		}
		}
			}else{
			System.out.println("i am sorry");
		}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
			db.close();
			db1.close();
}
}