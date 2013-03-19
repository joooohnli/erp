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


public class excel_three {
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
  private String sql7="";

	public String query(String dbase,String tName,String uTimea,String uTimeb,String uIdNumber,String uKeyword,String fName1,String fName2,String[] fName3,String uCondition,String uQueue) {
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
		//nseerdb db=new nseerdb(dbase);
		//nseerdb dbb=new nseerdb("security");
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
		}
		sql7="select * from "+tableName+"";
		ResultSet rs7=db.executeQuery(sql7);
		ResultSetMetaData rsmd = rs7.getMetaData();
		int number = rsmd.getColumnCount();*/

		if(!timeb.equals("")) timeb=timeb.substring(0,10)+" 23:59:59";
		if(timea.equals("")&&timeb.equals("")&&idNumber.equals("")&&keyword.equals("")){
			sql="select * from "+tableName+" where "+condition+" "+queue+"";
		}
		else if(!idNumber.equals("")&&keyword.equals("")&&timea.equals("")&&timeb.equals("")){
			sql="select * from "+tableName+" where "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+">='"+timea+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&timeb.equals("")){
			String key="";
			int m=0;
			for(int i=0;i<fieldName3.length-1;i++){
				key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
				m++;
			}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where ("+fieldName1+"<='"+timeb+"' and "+fieldName1+">='"+timea+"') and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
					sql="select * from "+tableName+" where ("+fieldName2+"='"+idNumber+"' and "+fieldName1+">='"+timea+"') and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where ("+fieldName2+"='"+idNumber+"' and "+fieldName1+"<='"+timeb+"') and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&timeb.equals("")){
			String key="";
						int m=0;
						for(int i=0;i<fieldName3.length-1;i++){
							key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
							m++;
						}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where "+fieldName2+"='"+idNumber+"' and ("+key+") and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
					sql="select * from "+tableName+" where "+fieldName1+"<='"+timeb+"' and "+fieldName1+">='"+timea+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}else if(!idNumber.equals("")&&!keyword.equals("")&&!timea.equals("")&&!timeb.equals("")){
			String key="";
									int m=0;
									for(int i=0;i<fieldName3.length-1;i++){
										key=key+fieldName3[i]+" like "+"'%"+keyword+"%'"+" or ";
										m++;
									}
			key=key+fieldName3[m]+" like "+"'%"+keyword+"%'";
					sql="select * from "+tableName+" where ("+key+") and "+fieldName1+">='"+timea+"' and "+fieldName1+"<='"+timeb+"' and "+fieldName2+"='"+idNumber+"' and "+condition+" "+queue+"";
		}
		//

		}catch (Exception ex) {}

		return sql;
		}

}