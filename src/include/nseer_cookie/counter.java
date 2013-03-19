
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

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import include.nseer_db.*;
import javax.servlet.*;

public class counter {
  private String kind="";
  private String kind_name="";
  private int kind_value;
  private String sql="";
  private ResultSet rs=null;
  private int filenum;
  private ServletContext dbApplication;

	public counter(ServletContext dbApplication){
		this.dbApplication=dbApplication;
	}


	public int read(String unit_db_name,String kind) {
		this.kind=kind;
		nseer_db erp_db = new nseer_db(unit_db_name);
		kind=kind.toLowerCase();
		try{
		sql="select * from security_counter where kind='"+kind+"'";
		rs=erp_db.executeQuery(sql);
		if(rs.next()){
		filenum=Integer.parseInt(rs.getString("count_value"));
		}
		erp_db.close();
		}catch (Exception ex) {}

		return filenum;
		}
	
	public int readTime(String dbase,String mod) {
	    
		String time="";
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		time=formatter.format(now);//获得当前时间

		nseer_db erp_db = new nseer_db(dbase);
		
		mod=mod.substring(mod.lastIndexOf("/")+1);
		StringTokenizer tokenTOO = new StringTokenizer(mod,"_");//修改编号专用:I级目录名带"_"的，请注意正确分解该名称！
			  
		String sqla="";
		String main_kind1="";
		String first_kind1="";
		
		if (tokenTOO.hasMoreTokens()) {
		main_kind1 = tokenTOO.nextToken();
		first_kind1 = tokenTOO.nextToken();
		
		}
		String name_kind=main_kind1+first_kind1+"count";
		String kind =name_kind+"_"+time;
		//kind=kind.toLowerCase();
		try{
		sql="select * from security_counter where kind_name='"+name_kind+"'";
		rs=erp_db.executeQuery(sql);
		
		if(rs.next()){
			if(kind.equals(rs.getString("kind")))
			{
				filenum=Integer.parseInt(rs.getString("count_value"));
				
			}
			else{
				sqla="update security_counter set kind='"+kind+"', count_value='100001' where kind_name='"+name_kind+"'";
				erp_db.executeUpdate(sqla);
				filenum=100001;
			}
		}
		else{
			sqla="insert into security_counter(kind,count_value,kind_name) values ('"+kind+"','100001','"+name_kind+"')";
			erp_db.executeUpdate(sqla);
			filenum=100001;
		}
		erp_db.close();
		}catch (Exception ex) {}

		return filenum;
		}
	
	public void writeTime(String dbase,String mod)
	{
		String time="";
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		time=formatter.format(now);//获得当前时间

		nseer_db erp_db = new nseer_db(dbase);
		
		mod=mod.substring(mod.lastIndexOf("/")+1);
		StringTokenizer tokenTOO = new StringTokenizer(mod,"_");//修改编号专用:I级目录名带"_"的，请注意正确分解该名称！
			  
		String sqla="";
		String main_kind1="";
		String first_kind1="";
		
		if (tokenTOO.hasMoreTokens()) {
		main_kind1 = tokenTOO.nextToken();
		first_kind1 = tokenTOO.nextToken();
		
		}
		String name_kind=main_kind1+first_kind1+"count";
		String kind =name_kind+"_"+time;
		//kind=kind.toLowerCase();
		try{
		sql="select * from security_counter where kind_name='"+name_kind+"'";
		rs=erp_db.executeQuery(sql);
		
		if(rs.next()){
			
				filenum=Integer.parseInt(rs.getString("count_value"));
				filenum++;
			
				sqla="update security_counter set count_value='"+filenum+"' where kind_name='"+name_kind+"'";
				erp_db.executeUpdate(sqla);
				
			}
		
		erp_db.close();
		}catch (Exception ex) {}

		
	}
	
	public int readTime1(String dbase,String mod) {
	    
		String time="";
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		time=formatter.format(now);//获得当前时间

		nseer_db erp_db = new nseer_db(dbase);
		
		mod=mod.substring(mod.lastIndexOf("/")+1);
		StringTokenizer tokenTOO = new StringTokenizer(mod,"_");//修改编号专用:I级目录名带"_"的，请注意正确分解该名称！
			  
		String sqla="";
		String main_kind1="";
		String first_kind1="";
		String second_kind1="";
		if (tokenTOO.hasMoreTokens()) {
		main_kind1 = tokenTOO.nextToken();
		first_kind1 = tokenTOO.nextToken();
		second_kind1 = tokenTOO.nextToken();
		}
		String name_kind=main_kind1+first_kind1+second_kind1+"count";
		String kind =name_kind+"_"+time;
		//kind=kind.toLowerCase();
		try{
		sql="select * from security_counter where kind_name='"+name_kind+"'";
		rs=erp_db.executeQuery(sql);
		
		if(rs.next()){
			if(kind.equals(rs.getString("kind")))
			{
				filenum=Integer.parseInt(rs.getString("count_value"));
				
			}
			else{
				sqla="update security_counter set kind='"+kind+"', count_value='100001' where kind_name='"+name_kind+"'";
				erp_db.executeUpdate(sqla);
				filenum=100001;
			}
		}
		else{
			sqla="insert into security_counter(kind,count_value,kind_name) values ('"+kind+"','100001','"+name_kind+"')";
			erp_db.executeUpdate(sqla);
			filenum=100001;
		}
		erp_db.close();
		}catch (Exception ex) {}

		return filenum;
		}
	
	public void writeTime1(String dbase,String mod)
	{
		String time="";
		java.util.Date now = new java.util.Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		time=formatter.format(now);//获得当前时间

		nseer_db erp_db = new nseer_db(dbase);
		
		mod=mod.substring(mod.lastIndexOf("/")+1);
		StringTokenizer tokenTOO = new StringTokenizer(mod,"_");//修改编号专用:I级目录名带"_"的，请注意正确分解该名称！
			  
		String sqla="";
		String main_kind1="";
		String first_kind1="";
		String second_kind1="";
		if (tokenTOO.hasMoreTokens()) {
		main_kind1 = tokenTOO.nextToken();
		first_kind1 = tokenTOO.nextToken();
		second_kind1 = tokenTOO.nextToken();
		}
		String name_kind=main_kind1+first_kind1+second_kind1+"count";
		String kind =name_kind+"_"+time;
		//kind=kind.toLowerCase();
		try{
		sql="select * from security_counter where kind_name='"+name_kind+"'";
		rs=erp_db.executeQuery(sql);
		
		if(rs.next()){
			
				filenum=Integer.parseInt(rs.getString("count_value"));
				filenum++;
			
				sqla="update security_counter set count_value='"+filenum+"' where kind_name='"+name_kind+"'";
				erp_db.executeUpdate(sqla);
				
			}
		
		erp_db.close();
		}catch (Exception ex) {}

		
	}

	public boolean write(String unit_db_name,String kind_name,int kind_value) {
		this.kind_name=kind_name;
		this.kind_value=kind_value;
		nseer_db_backup erp_db1 = new nseer_db_backup(dbApplication);
		kind_name=kind_name.toLowerCase();
		try{
			kind_value++;
			if(erp_db1.conn(unit_db_name)){
		sql="update security_counter set count_value='"+kind_value+"' where kind='"+kind_name+"'";
		erp_db1.executeUpdate(sql);
		erp_db1.close();
			}else{
				return false;
			}
		}catch (Exception ex) {
		return false;
		}

		return true;
		}

}
