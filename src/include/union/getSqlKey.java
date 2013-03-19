/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.union;


public class getSqlKey {
	//查询条件信息
  private String dbase="";
  private String tableName="";
  private String timea="";
  private String timeb="";
  private String idNumber="";
  private String keyword="";
  private String fieldName="";
  private String fieldName1="";
  private String fieldName2="";
  private String[] fieldName3=new String[1000];

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
  private double tradeTotal=0.0d;
  private int intValue=0;
  private double doubleValue=0.0d;

	public String query(String dbase,String tName,String uKeyword,String[] fName3,String uCondition,String uQueue) {
		this.dbase=dbase;
		this.tableName=tName;
		this.keyword=uKeyword;

		this.fieldName3=fName3;

		this.condition=uCondition;
		this.queue=uQueue;
		try{
			String key="";
			int m=0;
			for(int i=0;i<fieldName3.length-1;i++){
				key=key+tableName+"."+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
				m++;
			}
			key=key+tableName+"."+fieldName3[m]+" like "+"'%"+keyword+"%'";
			if(!key.equals("")){
			sql="select * from "+tableName+" where ("+key+") and "+condition+" "+queue+"";
			}else{
			sql="select * from "+tableName+" where "+condition+" "+queue+"";
			}

		}catch (Exception ex) {
			ex.printStackTrace();
			}

		return sql;
		}
}