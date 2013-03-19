/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.ajax;

import java.sql.*;
import java.util.*;
import include.nseer_db.*;
import include.get_name_from_ID.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ajax_businessComment{
private String ab;
private String aa;
private String mo;
private String path="";
private String value="";
private ServletContext context;
private HttpSession session;
private String unit_db_name;

public void setPath(HttpServletRequest request){
	session=request.getSession();
	context=session.getServletContext();
	String path1=context.getRealPath("/"); 
StringTokenizer tokenTO1 = new StringTokenizer(path1,"\\");
while (tokenTO1.hasMoreTokens()) {
	path=path+tokenTO1.nextToken()+"/";
	unit_db_name=(String)session.getAttribute("unit_db_name");
}
}

public String getDbName(){
	return this.unit_db_name;
}

public String ajax_businessComment(String database,String base,String table_name,String field_name,String field_name1){
try {//database 文件路径，base 您正在做的业务是 table_name 表名 field_name 字段名 field_name1 字段名)
nseer_db db=null;
db=new nseer_db(unit_db_name);
getNameFromID dd=new getNameFromID();
String data=database.substring(0);
String main_kind_name="";
String first_kind_name="";
String second_kind_name="";
String third_kind_name="";
String filename="";
String filetype="";
StringTokenizer tokenTO = new StringTokenizer(data,"/");
int tokencount=tokenTO.countTokens();
switch(tokencount){
case 3:
			while (tokenTO.hasMoreTokens()) {
				main_kind_name = tokenTO.nextToken();
				first_kind_name = tokenTO.nextToken();
				filename = tokenTO.nextToken();
			}
			break;
case 4:
			while (tokenTO.hasMoreTokens()) {
				main_kind_name = tokenTO.nextToken();
				first_kind_name = tokenTO.nextToken();
				second_kind_name = tokenTO.nextToken();
				filename = tokenTO.nextToken();
			}
}
tokenTO = new StringTokenizer(filename,".");
while (tokenTO.hasMoreTokens()) {
				filename = tokenTO.nextToken();
				filetype = tokenTO.nextToken();
			}
String group_name=main_kind_name+"Tree";
int location=data.indexOf("/");
String mod=data.substring(0,location);
String main=dd.getNameFromID((String)session.getAttribute("unit_db_name"),table_name,field_name,mod,field_name1);
String table=mod+"_tree";
switch(tokencount){
case 3:
if(filename.indexOf("_")!=-1){			
mo="/"+main_kind_name+"/"+first_kind_name+"/"+filename.substring(0,filename.indexOf("_"));
}else{
mo="/"+main_kind_name+"/"+first_kind_name+"/"+filename;
}
			break;
case 4:
if(filename.indexOf("_")!=-1){
mo="/"+main_kind_name+"/"+first_kind_name+"/"+second_kind_name+"/"+filename.substring(0,filename.indexOf("_"));
}else{
mo="/"+main_kind_name+"/"+first_kind_name+"/"+second_kind_name+"/"+filename;
}
}
ResultSet rs=db.executeQuery("select * from "+table+" t where "+
       "(t.mainurl REGEXP '[.][.][/][.][.]"+mo+"[^a-zA-Z].*'"+
       " or t.secondurl REGEXP '[.][.][/][.][.]"+mo+"[^a-zA-Z].*'"+
       " or t.thirdurl REGEXP '[.][.][/][.][.]"+mo+"[^a-zA-Z].*'"+
       " or t.fourthurl REGEXP '[.][.][/][.][.]"+mo+"[^a-zA-Z].*')");
while(rs.next()){
String a=rs.getString("main");
String b=rs.getString("secondary");
String c=rs.getString("third");
if(b.equals(""))
{ab=getLang("erp",base)+getLang(group_name,main)+"--"+getLang(group_name,a);
}
else if(c.equals(""))
{ab=base+a;
ab=getLang("erp",base)+getLang(group_name,main)+"--"+getLang(group_name,a)+"--"+getLang(group_name,b);
}else{
ab=getLang("erp",base)+getLang(group_name,main)+"--"+getLang(group_name,a)+"--"+getLang(group_name,b)+"--"+getLang(group_name,c);
}
}
} catch(Exception e) {
	e.printStackTrace();
}
	 return ab;
}

public String getLang(String tablename,String column){
		String unit_db_name="ondemand1";	
    try{
	String type="";
		type=(String)session.getAttribute("language");
	type="multilanguage_"+tablename+"_"+type;
	Hashtable tt=(Hashtable)context.getAttribute(type);
	value=(String)tt.get(column);
	if (value==null){
		nseer_db db=new nseer_db(unit_db_name);
		value=column;
		tt.put(column,column);
		context.setAttribute(type,tt);
		String sql22="select * from document_multilanguage where tablename='"+tablename+"' and name='"+column+"'";
		ResultSet rs22=db.executeQuery(sql22);
		if(!rs22.next()){
		String sql1="insert into document_multilanguage(tablename,name)values('"+tablename+"','"+column+"')";
		db.executeUpdate(sql1);
		}
		db.close();
	}
}catch(Exception r){
	r.printStackTrace();
}	
	return value;	
	}

public String getLang(ServletContext application,String column){
	nseer_db db=new nseer_db(unit_db_name);
	Hashtable tt=(Hashtable)application.getAttribute("multilanguage_words");
	String value=(String)tt.get(column);
if (value==null){
		String sql1="insert into document_multilanguage(tablename,name)values('tree','"+column+"')";
		db.executeUpdate(sql1);		
		value=column;
		}
		db.close();
	return value;	
	}
}