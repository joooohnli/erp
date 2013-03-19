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
import include.data_backup.*;

public class initDB{

    public void initDB(ServletContext dbApplication) {
		try{
			String path=dbApplication.getRealPath("/");
			String filename=path+"WEB-INF/dynamic_backup.xml";
			Solid so=new Solid(filename);
			for(int j=1;j<3;j++){
				String db="ondemand"+j;
				String status=so.getValue(db);
				if(status!=null&&status.equals("1")){
			nseer_dbb dbb1_backup=new nseer_dbb("db_backup.properties","dbip_backup.properties","mysql");
					nseer_dbb dbb=new nseer_dbb("db.properties","dbip.properties",db);
					nseer_dbb dbb1=new nseer_dbb("db.properties","dbip.properties",db);
					nseer_dbb dbb_backup=new nseer_dbb("db_backup.properties","dbip_backup.properties",db);
					String sqld="drop database IF EXISTS "+db;
					dbb1_backup.executeUpdate(sqld);
					sqld="CREATE DATABASE "+db;
					dbb1_backup.executeUpdate(sqld);
					System.out.println("create database "+db+" ok");
					String sql="show tables";
					String column="tables_in_"+db;
					ResultSet rs=dbb.executeQuery(sql);
					while(rs.next()){
						if(!rs.getString(column).equals("dynamic_backup")){
						System.out.println("sync "+rs.getString(column)+" data");
						String sql2="DESCRIBE "+rs.getString(column);
						ResultSet rs1=dbb1.executeQuery(sql2);
						
						String sqlt="CREATE TABLE IF NOT EXISTS "+rs.getString(column)+" (id int(10) unsigned NOT NULL auto_increment,";
						rs1.next();
						while(rs1.next()){
							sqlt=sqlt+rs1.getString("Field")+" "+rs1.getString("Type")+" NOT NULL DEFAULT '"+rs1.getString("Default")+"',";
						}						
						sqlt=sqlt+"PRIMARY KEY (id))";
						dbb_backup.executeUpdate(sqlt);
						sql2="select * from "+rs.getString(column);
						rs1=dbb1.executeQuery(sql2);
						ResultSetMetaData rsmd = rs1.getMetaData();
						int number = rsmd.getColumnCount();
						while(rs1.next()){
							String sql3="";
							String sql4="";
							for(int i=1;i<number;i++){
							sql3=sql3+rsmd.getColumnName(i)+",";
							sql4=sql4+"'"+rs1.getString(rsmd.getColumnName(i))+"',";
						}
						sql3=sql3+rsmd.getColumnName(number);
						sql4=sql4+"'"+rs1.getString(rsmd.getColumnName(number))+"')";
							String sql5="insert into "+rs.getString(column)+"("+sql3+") values("+sql4;
							dbb_backup.executeUpdate(sql5);
						}
						System.out.println("sync "+rs.getString(column)+" data ok!");
						}
					}
					so.update(db,"1","0");
					dbApplication.setAttribute(db+"sync","ok");
					dbApplication.setAttribute("mysql"+"sync","ok");
					dbb.close();
					dbb1.close();
					dbb_backup.close();
					dbb1_backup.close();
				}else if(status!=null&&status.equals("2")){
				nseer_dbb dbb1_backup=new nseer_dbb("db_backup.properties","dbip_backup.properties","mysql");
					nseer_dbb dbb=new nseer_dbb("db.properties","dbip.properties",db);
					nseer_dbb dbb1=new nseer_dbb("db.properties","dbip.properties",db);
					nseer_dbb dbb_backup=new nseer_dbb("db_backup.properties","dbip_backup.properties",db);
					String sqld="drop database IF EXISTS "+db;
					dbb1_backup.executeUpdate(sqld);
					sqld="CREATE DATABASE "+db;
					dbb1_backup.executeUpdate(sqld);
					System.out.println("create database"+db+" ok");
					String sql="show tables";
					String column="tables_in_"+db;
					ResultSet rs=dbb.executeQuery(sql);
					while(rs.next()){
						if(!rs.getString(column).equals("dynamic_backup")){
						System.out.println("sync "+rs.getString(column)+" data");
						String sql2="DESCRIBE "+rs.getString(column);
						ResultSet rs1=dbb1.executeQuery(sql2);
						
						String sqlt="CREATE TABLE IF NOT EXISTS "+rs.getString(column)+" (id int(10) unsigned NOT NULL auto_increment,";
						rs1.next();
						while(rs1.next()){
							sqlt=sqlt+rs1.getString("Field")+" "+rs1.getString("Type")+" NOT NULL DEFAULT '"+rs1.getString("Default")+"',";
						}
						
						sqlt=sqlt+"PRIMARY KEY (id))";
						dbb_backup.executeUpdate(sqlt);
						sql2="select * from "+rs.getString(column);
						rs1=dbb1.executeQuery(sql2);
						ResultSetMetaData rsmd = rs1.getMetaData();
						int number = rsmd.getColumnCount();
						while(rs1.next()){
							String sql3="";
							String sql4="";
							for(int i=1;i<number;i++){
							sql3=sql3+rsmd.getColumnName(i)+",";
							sql4=sql4+"'"+rs1.getString(rsmd.getColumnName(i))+"',";
						}
						sql3=sql3+rsmd.getColumnName(number);
						sql4=sql4+"'"+rs1.getString(rsmd.getColumnName(number))+"')";
							String sql5="insert into "+rs.getString(column)+"("+sql3+") values("+sql4;
							dbb_backup.executeUpdate(sql5);
						}
						System.out.println("sync "+rs.getString(column)+" data ok!");
						}
					}
					String sql6="CREATE TABLE IF NOT EXISTS dynamic_backup (id int(10) unsigned NOT NULL auto_increment,name varchar(30) NOT NULL DEFAULT '',PRIMARY KEY (id))";
					dbb.executeUpdate(sql6);
					sql6="insert into dynamic_backup (name) values('master')";
					dbb.executeUpdate(sql6);
					so.update(db,"1","0");
					dbApplication.setAttribute(db+"sync","ok");
					dbApplication.setAttribute("mysql"+"sync","ok");
					dbb.close();
					dbb1.close();
					dbb_backup.close();
					dbb1_backup.close();
				}
			}
	 		} catch (Exception ex) {
				ex.printStackTrace();
 		}
	}

}