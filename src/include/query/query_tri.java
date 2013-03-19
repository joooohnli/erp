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

public class query_tri {
	//查询条件信息
  private String dbase="";
  private String tableName="";
  private String timea="";
  private String timeb="";
  private String idNumber="";
  private String keyword="";

  private String fieldName1="";
  private String fieldName2="";
  private String fieldName3="";

  private String realname="";
  private String condition="";
  private String queue="";
  private String tagq="";

  private String sql="";
  private String sql1="";
  private String sql2="";
  private String sql3="";
  private String sql4="";
  private String sql5="";
  private String sql6="";
  private String sql7="";
  private nseer_db dba=null;
  private ResultSet rs=null;
  private ResultSet rs1=null;
  private ResultSet rs2=null;
  private ResultSet rs3=null;
  private ResultSet rs4=null;
  private ResultSet rs5=null;
  private ResultSet rs6=null;
  private ResultSet rs7=null;

  private int intValue=0;
  private double doubleValue=0.0d;

	public ResultSet queryDB(String dbase,String tName,String uTimea,String uTimeb,String uIdNumber,String uKeyword,String fName1,String fName2,String fName3,String uCondition,String uQueue) {
		this.dbase=dbase;
		this.tableName=tName;
		this.timea=uTimea;
		this.timeb=uTimeb;
		this.idNumber=uIdNumber;
		this.keyword=uKeyword;

		this.fieldName1=fName1;
		this.fieldName2=fName2;
		this.fieldName3=fName3;

		this.condition=uCondition;
		this.queue=uQueue;
		nseer_db db=new nseer_db(dbase);
		dba=new nseer_db(dbase);
		try{
		/*sql7="select * from user where realname='"+realname+"'";
		rs7=dbb.executeQuery(sql7);
		if(rs7.next()){
		tagq=rs7.getString("tagq");
		area1=rs7.getString("first_kind_name");
		area2=rs7.getString("second_kind_name");
		area3=rs7.getString("third_kind_name");
	}
				try {
						if(!dbb.closeConn());
						} catch (Exception ex) {}
		if(tagq.equals("1")) sales=realname;
		if(tagq.equals("2")) {
			marketarea=area1;
			trade=area2;
			fieldValue5=area3;
		}*/
		sql7="select * from "+tableName+"";
		ResultSet rs7=db.executeQuery(sql7);
		ResultSetMetaData rsmd = rs7.getMetaData();
		int number = rsmd.getColumnCount();

		if(timea.equals("")&&timeb.equals("")&&idNumber.equals("")&&keyword.equals("")){
			sql="select distinct apply_ID,designer,register,register_time,remark,check_tag from "+tableName+" where "+condition+" "+queue+"";
		}
		else if(!idNumber.equals("")){
			sql="select * from "+tableName+" where "+fieldName2+"='"+idNumber+"'&&"+condition+" "+queue+"";
	}else{
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"'&&"+condition+" "+queue+"";
		}
			rs=dba.executeQuery(sql);
		db.close();
		}catch (Exception ex) {
			ex.printStackTrace();
		}

		return rs;
		}

	public int intValue() {
		try{
					nseer_db db=new nseer_db(dbase);
					sql1 = sql;
					intValue=0;
					rs1=db.executeQuery(sql1);
					if(rs1.last()){
					intValue=rs1.getRow();
					}
				db.close();
		}catch (Exception ex){
					ex.printStackTrace();
				}
		return intValue;
	}

	public void close() {
	dba.close();
	}

}