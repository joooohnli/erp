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

public class querya {
	//查询条件信息
  private String dbase="";
  private String tableName="";
  private String timea="";
  private String timeb="";
  private String marketarea="";
  private String sales="";
  private String trade="";
  private String trade1="";
  private String trade2="";
  private String trade3="";
  private String trade4="";
  private String trade5="";
  private String fieldName="";
  private String fieldName1="";
  private String fieldName2="";
  private String fieldName3="";
  private String fieldName4="";
  private String realname="";
  private String condition="";
  private String queue="";
  private String tagq="";
  private String area="";
  private String sql="";
  private String sql1="";
  private String sql2="";
  private String sql3="";
  private String sql4="";
  private String sql5="";
  private String sql6="";
  private String sql7="";
  private String sql8="";
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
  private ResultSet rs8=null;
  private int intRowCount=0;
  private double tradeTotal=0.0d;
  private double profitTotal=0.0d;
  private int backTimeTotal=0;
  private double bonus=0.0d;
  private double receipt=0.0d;


	public ResultSet queryDB(String dbase,String tName,String uTimea,String uTimeb,String uMarketarea,String uSales,String uTrade,String fName1,String fName2,String fName3,String fName4,String uCondition,String uQueue,String rName) {
		this.dbase=dbase;
		this.tableName=tName;
		this.timea=uTimea;
		this.timeb=uTimeb;
		this.marketarea=uMarketarea;
		this.sales=uSales;
		this.trade=uTrade;
		this.fieldName1=fName1;
		this.fieldName2=fName2;
		this.fieldName3=fName3;
		this.fieldName4=fName4;
		this.condition=uCondition;
		this.queue=uQueue;
		this.realname=rName;
		dba=new nseer_db(dbase);
		dbb=new nseer_db(dbase);
		try{
		sql8="select * from editor where realname='"+realname+"'";
		rs8=dbb.executeQuery(sql8);
		if(rs8.next()){
		tagq=rs8.getString("tagq");
		area=rs8.getString("marketarea");
	}
						dbb.close();
		if(tagq.equals("1")) sales=realname;
		if(tagq.equals("2")) marketarea=area;
		if(!trade.equals("")){
		sql6="select * from customer where customername='"+trade+"'";
		ResultSet rs6=dbb.executeQuery(sql6);
		if(rs6.next()){
		trade1=rs6.getString("customername1");
		trade2=rs6.getString("customername2");
		trade3=rs6.getString("customername3");
		trade4=rs6.getString("customername4");
		trade5=rs6.getString("customername5");
		}
				dbb.close();
		}

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
			sql="select * from "+tableName+" where ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
			sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
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
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}

		else if(!timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+marketarea+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(sales.equals("")||sales==null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(timea.equals("")&&!timeb.equals("")&&marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&!trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
		}
		else if(!timea.equals("")&&timeb.equals("")&&!marketarea.equals("")&&(!sales.equals("")&&sales!=null)&&trade.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+marketarea+"' and "+fieldName4+"='"+sales+"' and "+condition+" "+queue+"";
		}
		else{
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+fieldName4+"='"+sales+"' and ("+fieldName3+"='"+trade+"' or "+fieldName3+"='"+trade1+"' or "+fieldName3+"='"+trade2+"' or "+fieldName3+"='"+trade3+"' or "+fieldName3+"='"+trade4+"' or "+fieldName3+"='"+trade5+"') and "+condition+" "+queue+"";
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
					rs1=dbb.executeQuery(sql1);
					intRowCount=0;
					if(rs1.last()){
					intRowCount=rs1.getRow();
					}
				dbb.close();
		}
				catch (Exception ex){
					ex.printStackTrace();
				}
		return intRowCount;
	}


	public void close() {
	dba.close();
	}

	public double sumTotal(String fName) {
		try{
					this.fieldName=fName;
					dbb=new nseer_db(dbase);
					sql2 = sql;
					rs2=dbb.executeQuery(sql2);
					tradeTotal=0;
					while(rs2.next()){
					tradeTotal += rs2.getDouble(fieldName);
					}
				dbb.close();
		}
				catch (Exception ex){
					ex.printStackTrace();
				}
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