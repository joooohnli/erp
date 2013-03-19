/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.query;

import java.sql.*;
import include.nseer_db.nseer_db;

public class query {
	//查询条件信息
  private String dbase="";
  private String tableName="";
  private String timea="";
  private String timeb="";
  private String marketarea="";
  private String sales="";
  private String trade="";
  private String fieldValue5="";
  private String fieldName="";
  private String fieldName1="";
  private String fieldName2="";
  private String fieldName3="";
  private String fieldName4="";
  private String fieldName5="";
  private String realname="";
  private String condition="";
  private String queue="";
  private String tagq="";
  private String area1="";
  private String area2="";
  private String area3="";
  private String sql="";
  private String sql1="";
  private String sql2="";
  private String sql3="";
  private String sql4="";
  private String sql5="";
  private String sql6="";
  private String sql7="";
  private nseer_db dba;
  private nseer_db dbb;
  private ResultSet rs=null;
  private ResultSet rs1=null;
  private ResultSet rs2=null;
  private ResultSet rs3=null;
  private ResultSet rs4=null;
  private ResultSet rs5=null;
  private ResultSet rs6=null;
  private ResultSet rs7=null;
  private int intRowCount=0;
  private double tradeTotal=0.0d;
  private double profitTotal=0.0d;
  private double netprofitTotal=0.0d;
  private int backTimeTotal=0;
  private double bonus=0.0d;


	public ResultSet queryDB(String dbase,String tName,String uTimea,String uTimeb,String uMarketarea,String uSales,String uTrade,String uValue,String fName1,String fName2,String fName3,String fName4,String fName5,String uCondition,String uQueue,String rName) {
		this.dbase=dbase;
		this.tableName=tName;
		this.timea=uTimea;
		this.timeb=uTimeb;
		this.marketarea=uMarketarea;
		this.sales=uSales;
		this.trade=uTrade;
		this.fieldValue5=uValue;
		this.fieldName1=fName1;
		this.fieldName2=fName2;
		this.fieldName3=fName3;
		this.fieldName4=fName4;
		this.fieldName5=fName5;
		this.condition=uCondition;
		this.queue=uQueue;
		this.realname=rName;
		//nseerdb dbb=new nseerdb("security");
		if(!timea.equals("")&&timea.length()<=10) timea=timea.substring(0,10)+" 00:00:00";
		if(!timeb.equals("")&&timeb.length()<=10) timeb=timeb.substring(0,10)+" 23:59:59";
		dba=new nseer_db(dbase);
		try{

		if(fieldValue5.equals("")){
		if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&sales.equals("")&&trade.equals("")){
			sql="select * from "+tableName+" where "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}

		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else{
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+condition+" "+queue+"";
		}
		}else{
		if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&sales.equals("")&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+condition+"&&"+fieldName5+"='"+fieldValue5+"' "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}

		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}
		else{
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName4+"='"+sales+"' and "+fieldName3+"='"+trade+"' and "+fieldName5+"='"+fieldValue5+"' and "+condition+" "+queue+"";
		}

		}
		
			rs=dba.executeQuery(sql);
		}catch (Exception ex) {
			ex.printStackTrace();
			}

		return rs;
		}

	public int intRowCount() {
		try{
					dbb=new nseer_db(dbase);
					sql1 = sql;
					intRowCount=0;
					rs1=dbb.executeQuery(sql1);
					if(rs1.last()){
					intRowCount=rs1.getRow();
					}
			try {
											dbb.close();
						} catch (Exception ex) {
							ex.printStackTrace();
							}
		}
				catch (Exception ex){
					ex.printStackTrace();
				}
		return intRowCount;
	}

	public void close() {
		try {
				dba.close();
						} catch (Exception ex) {
							ex.printStackTrace();
							}
	}

	public double sumTotal(String fName) {
		try{
					this.fieldName=fName;
						sql2 = sql;
					dbb=new nseer_db(dbase);
					rs2=dbb.executeQuery(sql2);
					tradeTotal=0;
					while(rs2.next()){
					tradeTotal+=rs2.getDouble(fieldName);
					}
					try {
													dbb.close();
						} catch (Exception ex) {ex.printStackTrace();}
		}
				catch (Exception ex){ex.printStackTrace();}
		return tradeTotal;
	}

	public int intTotal(String fName) {
		try{
					this.fieldName=fName;
					dbb=new nseer_db(dbase);
					sql4 = sql;
					backTimeTotal=0;
					rs4=dbb.executeQuery(sql4);
					while(rs4.next()){
					backTimeTotal += rs4.getInt(fieldName);
				}
												dbb.close();
		}
				catch (Exception ex){
					ex.printStackTrace();
					}
		return backTimeTotal;
	}

}