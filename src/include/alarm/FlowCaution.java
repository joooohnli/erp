/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.alarm;

import java.sql.*;
import java.text.*;
import include.nseer_db.nseer_db;

public class FlowCaution{

    private ResultSet rs=null;
    private ResultSet rs1=null;
    private String sql1="";
    private String date="";
	private String dbase,table1,table2,table3,field1,field2,field3;
    private String[] idgroup=new String[1000000];
    private String[] alarmgroup=new String[1000000];
    public void flow(String dbase,String table1,String table2,String table3,String field1,String field2,String field3) {
		this.dbase=dbase;
		this.table1 = table1;
		this.table2 = table2;
		this.table3 = table3;
		this.field1 = field1;
		this.field2 = field2;
		this.field3 = field3;
		nseer_db db=new nseer_db(dbase);
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date  now  =  new  java.util.Date();
		try{
			String sql3="delete from "+table1+"";
 			db.executeUpdate(sql3);
 			String sql = "select * from "+table2+" where tag='1'";
 			rs=db.executeQuery(sql);
 			int i=0;
 			while(rs.next()){
				idgroup[i]=rs.getString(field1);
				alarmgroup[i]=rs.getString(field2);
 				i++;
 				}
 			for(int j=0;j<i;j++){
 				sql1 = "select * from "+table3+" where "+field1+"='"+idgroup[j]+"' order by "+field3+" desc";
 				rs1=db.executeQuery(sql1);
 				if(rs1.next()){
 					date=rs1.getString(field3);
 					}else{
					date="";
					}
 				if(!date.equals("")){
					java.util.Date date1 = formatter.parse(date);
					long Time=(date1.getTime()/1000)+60*60*24*Integer.parseInt(alarmgroup[j]);
					date1.setTime(Time*1000);
					if((date1.getTime()-now.getTime())<0){
						long days = (long)((now.getTime() - date1.getTime()) / (1000 * 60 * 60 *24) + 0.5);
 						String sql2 = "insert into "+table1+"("+field1+",lasttime,"+field2+",days) values('"+idgroup[j]+"','"+date+"','"+alarmgroup[j]+"','"+days+"')";
 						db.executeUpdate(sql2);
						}
					}
				}
			db.close();
	 		} 
		catch (Exception ex) {
 			}
	}
}