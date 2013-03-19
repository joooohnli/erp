/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.excel_export;

import java.sql.*;

public class excel {
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
  private String sql7="";
  private ResultSet rs7=null;


	public String query(String dbase,String tName,String uTimea,String uTimeb,String uMarketarea,String uSales,String uTrade,String uValue,String fName1,String fName2,String fName3,String fName4,String fName5,String uCondition,String uQueue,String rName) {
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

		try{

		if(!timeb.equals("")) timeb=timeb.substring(0,10)+" 23:59:59";
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

		}catch (Exception ex) {}

		return sql;
		}

}