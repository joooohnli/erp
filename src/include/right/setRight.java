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
import include.nseer_db.*;
import javax.servlet.*;

public class setRight {

  private String[] cols=new String[1000];
  private String ID="";
  private String name="";
  private String database="";
  private String sql="";
  private ResultSet rs=null;
  private ServletContext dbApplication;

	public setRight(ServletContext dbApplication){
		this.dbApplication=dbApplication;
	}

	public void setRight(String unit_db_name,String ID,String uName,String dbase,String[] right) {
		this.ID=ID;
		this.name=uName;
		this.database=dbase;
		this.cols=right;
		nseer_db_backup db=new nseer_db_backup(dbApplication);
		try{
		if(db.conn(unit_db_name)){
		for(int i=0;i<cols.length;i++){
			if(cols[i]!=null){
				String table1=database+"_tree";
				String table2=database+"_allright";
				String table3=database+"_allright_id";
				sql="select * from "+table1+" where id='"+cols[i]+"'";
				rs=db.executeQuery(sql);
				if(rs.next()){
					String sql1="insert into "+table2+"(tree_id,human_ID,name,main,secondary,third,fourth) values ('"+rs.getString("tree_id")+"','"+ID+"','"+name+"','"+rs.getString("main")+"','"+rs.getString("secondary")+"','"+rs.getString("third")+"','"+rs.getString("fourth")+"')";
					
					db.executeUpdate(sql1);
					}
				}
			}
			}else{
			System.out.println("i am sorry");
		}
		} catch (Exception ex) {}

			db.close();
}

}