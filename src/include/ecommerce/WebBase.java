/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.ecommerce;

import include.nseer_db.nseer_db;

import java.sql.ResultSet;

public class WebBase{

private nseer_db db;
private String name,title,attachment1,attachment2,advertisement1,advertisement2,content,copyright,webmaster_email,home_page,common_page,describe1,describe2;

public WebBase(String dbname,String unit){
	try{
		db = new nseer_db(dbname);
		String sql="select * from ecommerce_web_base where unit_id='"+unit+"'";

		ResultSet rs=db.executeQuery(sql);
		if(rs.next()){
			name=rs.getString("name");
			title=rs.getString("title");
			advertisement1=rs.getString("advertisement1");
			advertisement2=rs.getString("advertisement2");
			attachment1=rs.getString("attachment1");
			attachment2=rs.getString("attachment2");
			content=rs.getString("content");
			copyright=rs.getString("copyright");
			webmaster_email=rs.getString("webmaster_email");
			home_page=rs.getString("home_page");
			common_page=rs.getString("common_page");
			describe1=rs.getString("describe1");
			describe2=rs.getString("describe2");
		}else{
			name="";
			title="";
			advertisement1="";
			advertisement2="";
			attachment1="";
			attachment2="";
			content="";
			copyright="";
			webmaster_email="";
			home_page="";
			common_page="";
			describe1="";
			describe2="";
		}
		db.close();
	}catch(Exception ex){
		ex.printStackTrace();
	}
}

public String getName(){
	return this.name;
}

public void close(){
		db.close();
	}

public String getAttachment1() {
	return attachment1;
}

public String getAttachment2() {
	return attachment2;
}

public String getContent() {
	return content;
}

public String getCopyright() {
	return copyright;
}

public nseer_db getDb() {
	return db;
}

public String getDescribe1() {
	return describe1;
}

public String getDescribe2() {
	return describe2;
}

public String getHomePage() {
	return home_page;
}

public String getCommonPage() {
	return common_page;
}

public String getTitle() {
	return title;
}

public String getAdvertisement1() {
	return advertisement1;
}

public String getAdvertisement2() {
	return advertisement2;
}

public String getWebmaster_email() {
	return webmaster_email;
}

}