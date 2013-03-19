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
import include.nseer_db.nseer_db;

public class CostCaution{

    private ResultSet rs=null;
    private ResultSet rs1=null;
    private String sql1="";
    private String date="";
	private String dbase,table1,table2,table3,field1,field2,field3,field4;
    private String[] idgroup=new String[1000000];
    private String[] alarmgroup=new String[1000000];
    private double tradeTotal=0.0d;
    private double receipt=0.0d;
    private double unreceipt=0.0d;
    public void cost(String dbase,String table1,String table2,String table3,String field1,String field2,String field3,String field4) {
		try{
			this.dbase=dbase;
			this.table1 = table1;
			this.table2 = table2;
			this.table3 = table3;
			this.field1 = field1;
			this.field2 = field2;
			this.field3 = field3;
			this.field4 = field4;
			nseer_db db=new nseer_db(dbase);

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
				unreceipt=0;
				sql1="select * from "+table3+" where "+field1+"='"+idgroup[j]+"'";
				rs1=db.executeQuery(sql1);
				while(rs1.next()){
					tradeTotal+=rs1.getDouble(field3);
					receipt+=rs1.getDouble(field4);
					unreceipt=tradeTotal-receipt;
					}
 				if(unreceipt>Double.parseDouble(alarmgroup[j])){
					double overfund=unreceipt-Double.parseDouble(alarmgroup[j]);
 					String sql2 = "insert into "+table1+"("+field1+",unreceipt,"+field2+",overfund) values('"+idgroup[j]+"','"+unreceipt+"','"+alarmgroup[j]+"','"+overfund+"')";
 					db.executeUpdate(sql2);
					}
				}
			db.close();
	 		} 
		catch (Exception ex) {
 			}
	}
}